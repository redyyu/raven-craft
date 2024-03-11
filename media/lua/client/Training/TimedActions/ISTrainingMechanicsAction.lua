require "TimedActions/ISBaseTimedAction"

ISTrainingMechanicsAction = ISBaseTimedAction:derive("ISTrainingMechanicsAction")


function ISTrainingMechanicsAction:getTablePart()
    if self.part then
        if self.is_install then
            return part:getTable('install')
        else
            return part:getTable('uninstall')
        end
    end
    return nil
end

function ISTrainingMechanicsAction:checkPrekLevelReached()
    if not self.part or not self.partTable then
        return false
    end

    if self.partTable.skills and self.partTable.skills ~= "" then
        for _, prek_str in ipairs(perks_str:split(";")) do
            local name, lv = VehicleUtils.split(prek_str, ":")
            if self.character:getPerkLevel(Perks.FromString(name)) < tonumber(lv) then
                return false
            end
        end
    end
    return true
end


function ISTrainingMechanicsAction:preparePart()
    if not self.partTable or not self:checkPrekLevelReached() then
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
    return self.clothing and 
       self.clothing:getFabricType() == "Cotton" and
       self.inventory:contains(self.clothing) and
       self.inventory:contains(self.needle)
end

function ISTrainingMechanicsAction:update()
    self.clothing:setJobDelta(self:getJobDelta())
end

function ISTrainingMechanicsAction:create()
    ISBaseTimedAction.create(self)
    self.action:setUseProgressBar(false)
end

function ISTrainingMechanicsAction:waitToStart()
    local area = 'Engine'
    if self.partTable then
        area = self.partTable.area or self.part:getArea()
    elseif self.part then
        area = self.part:getArea()
    end
    ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(self.character, part:getVehicle(), area))
end

function ISTrainingMechanicsAction:perform()
    if self.part and self.partTable and self.part:getInventoryItem() then
        if self.is_install then
            local playerInv = self.character:getInventory()
            local item = nil
            for i=0, self.part:getItemType():size() - 1 do
                local item_type = self.part:getItemType():get(i)
                item = playerInv:getFirstTypeRecurse(item_type)
                if item then
                    break
                end
            end

            if not item then 
                return
            end
            
            local prepared_part = self:preparePart() 
            if not prepared_part then
                return
            end
            local time = tonumber(self.partTable.time) or 50
            ISTimedActionQueue.add(ISInstallVehiclePart:new(self.character, self.part, item, time))
            if isDebugEnabled() then
                print('Install: '.. part_name ..' with '.. item:getDisplayName()) 
            end
        else
            local prepared_part = self:preparePart() 
            if not prepared_part then
                return
            end
            local time = tonumber(self.partTable.time) or 50
            ISTimedActionQueue.add(ISUninstallVehiclePart:new(self.character, self.part, time))

            if isDebugEnabled() then
                print('Uninstall: '.. part_name) 
            end
        end
    end
    ISBaseTimedAction.perform(self)
end

function ISTrainingMechanicsAction:new(character, vehicle, part_name, is_install, screwdriver, wrench, lug_wrench, jack)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.inventory = character:getInventory()
    o.maxTime = 0
    o.stopOnWalk = true
    o.stopOnRun = true
    o.vehicle = vehicle
    o.parts = parts
    o.screwdriver = screwdriver
    o.wrench = wrench
    o.lug_wrench = lug_wrench
    o.jack = jack
    o.part = vehicle:getPartById(part_name)
    o.partTable = self:getTablePart()
    o.is_install = is_install
    o.loopedAction = false
    return o
end
