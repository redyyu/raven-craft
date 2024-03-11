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


function ISTrainingMechanicsAction:preparePart()
    local partTable = ISTrainingMechanicsAction:getTablePart()

    if not partTable or not checkPrekLevelReached(self.character, partTable.skills) then
        return false
    end

    if partTable.recipes and not self.character:isRecipeKnown(partTable.recipes) then
        self.character:Say(getText("IGUI_PlayerText_Unknow_Recipe_For_Vehicle"))
        return false
    end

    for _, itm in ipairs(partTable.items) do
        local is_priamry = nil
        local hand_item = nil
        local equip_item = nil
        if itm.type == screwdriver:getType() or itm.type == screwdriver:getFullType() then
            equip_item = screwdriver
        elseif itm.type == wrench:getType() or itm.type == wrench:getFullType() then
            equip_item = wrench
        elseif itm.type == lug_wrench:getType() or itm.type == lug_wrench:getFullType() then
            equip_item = lug_wrench
        elseif itm.type == jack:getType() or itm.type == jack:getFullType() then
            equip_item = jack
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
    local partTable = part:getTable('install')
    local area = partTable.area or part:getArea()
    ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, part:getVehicle(), area))
end

function ISTrainingMechanicsAction:perform()
    if self.part then
    else
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
    o.is_install = is_install
    o.loopedAction = false
    return o
end
