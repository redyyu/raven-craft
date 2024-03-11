require "TimedActions/ISBaseTimedAction"

ISTrainingMechanicsAction = ISBaseTimedAction:derive("ISTrainingMechanicsAction")


function ISTrainingMechanicsAction:checkPrekLevelReached()
    if self.partTable.skills and self.partTable.skills ~= "" then
        for _, prek_str in ipairs(self.partTable.skills:split(";")) do
            local name, lv = VehicleUtils.split(prek_str, ":")
            if self.character:getPerkLevel(Perks.FromString(name)) < tonumber(lv) then
                return false
            end
        end
    end
    return true
end


function ISTrainingMechanicsAction:prepareProcessPart()
    if not self:checkPrekLevelReached() then
        return false
    end

    if self.partTable.recipes and not self.character:isRecipeKnown(self.partTable.recipes) then
        self.character:Say(getText("IGUI_PlayerText_Unknow_Recipe_For_Vehicle"))
        return false
    end

    for _, itm in ipairs(self.partTable.items) do
        local is_priamry = nil
        local hand_item = nil
        local equip_item = nil
        if itm.type == self.screwdriver:getType() or itm.type == self.screwdriver:getFullType() then
            equip_item = self.screwdriver
        elseif itm.type == self.wrench:getType() or itm.type == self.wrench:getFullType() then
            equip_item = self.wrench
        elseif itm.type == self.lug_wrench:getType() or itm.type == self.lug_wrench:getFullType() then
            equip_item = self.lug_wrench
        elseif itm.type == self.jack:getType() or itm.type == self.jack:getFullType() then
            equip_item = self.jack
        end
        if itm.equip == 'primary' then
            is_priamry = true
            hand_item = self.character:getPrimaryHandItem()
        else
            is_priamry = false
            hand_item = self.character:getSecondaryHandItem()
        end

        if equip_item then
            ISWorldObjectContextMenu.equip(self.character, hand_item, equip_item, is_priamry)
        else
            return false
        end
    end

    return true
end

function ISTrainingMechanicsAction:isValid()
    -- no vehicle or part or part InventoryItem check here
    -- this action must be do nothing and pass to next, if get something unexcpeted.
    -- DO NOT break the ISTimedActionQueue if not valid.
    return self.part and 
        self.inventory:containsRecursive(self.screwdriver) and
        self.inventory:containsRecursive(self.wrench) and
        self.inventory:containsRecursive(self.lug_wrench) and
        self.inventory:containsRecursive(self.jack)
end

function ISTrainingMechanicsAction:update()
	self.character:faceThisObject(self.vehicle)
    self.character:setMetabolicTarget(Metabolics.MediumWork);
end

function ISTrainingMechanicsAction:start()
	if self.part:getWheelIndex() ~= -1 or self.part:getId():contains("Brake") then
		self:setActionAnim("VehicleWorkOnTire")
	else
		self:setActionAnim("VehicleWorkOnMid")
	end
end

function ISTrainingMechanicsAction:stop()
    ISBaseTimedAction.stop(self)
end

function ISTrainingMechanicsAction:waitToStart()
	self.character:faceThisObject(self.vehicle)
	return self.character:shouldBeTurning()
end

-- function ISTrainingMechanicsAction:create()
--     ISBaseTimedAction.create(self)
--     self.action:setUseProgressBar(false)
-- end


function ISTrainingMechanicsAction:perform()
    local perksTable = VehicleUtils.getPerksTableForChr(self.partTable.skills, self.character)
    
    if self.is_install then
        local item = nil
        for i=0, self.part:getItemType():size() - 1 do
            local item_type = self.part:getItemType():get(i)
            item = self.inventory:getFirstTypeRecurse(item_type)
            if item then
                break
            end
        end

        if item and self:prepareProcessPart() and self.vehicle:canInstallPart(self.character, self.part) then
            self.inventory:DoRemoveItem(item)
            
            local args = { 
                vehicle = self.vehicle:getId(), 
                part = self.part:getId(),
                item = item,
                perks = perksTable,
                mechanicSkill = self.character:getPerkLevel(Perks.Mechanics)
            }
            sendClientCommand(self.character, 'vehicle', 'installPart', args)

            local pdata = getPlayerData(self.character:getPlayerNum());
            if pdata ~= nil then
                pdata.playerInventory:refreshBackpacks();
                pdata.lootInventory:refreshBackpacks();
            end
            
            if isDebugEnabled() then
                print('Install: '.. self.part:getId() ..' with '.. item:getDisplayName()) 
            end
        end
    else
        if self.part:getInventoryItem() and self:prepareProcessPart() and self.vehicle:canUninstallPart(self.character, self.part) then
	        local args = {
                    vehicle = self.vehicle:getId(), 
                    part = self.part:getId(),
					perks = perksTable,
					mechanicSkill = self.character:getPerkLevel(Perks.Mechanics),
					contentAmount = self.part:getContainerContentAmount()
             }
	        sendClientCommand(self.character, 'vehicle', 'uninstallPart', args)

            if isDebugEnabled() then
                print('Uninstall: '.. self.part:getId()) 
            end
        end
    end

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self)
end

function ISTrainingMechanicsAction:new(character, part, is_install, screwdriver, wrench, lug_wrench, jack)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.inventory = character:getInventory()
    o.stopOnWalk = true
    o.stopOnRun = true
    o.screwdriver = screwdriver
    o.wrench = wrench
    o.lug_wrench = lug_wrench
    o.jack = jack
    o.part = part
    o.vehicle = part:getVehicle()
    o.is_install = is_install
    o.loopedAction = false
    if is_install then
        o.partTable = part:getTable('install')
    else
        o.partTable = part:getTable('uninstall')
    end
    
    local time = tonumber(o.partTable.time) or 50
    o.maxTime = time - (character:getPerkLevel(Perks.Mechanics) * (time/15));
	if character:isTimedActionInstant() then
		o.maxTime = 1;
	end
    return o
end
