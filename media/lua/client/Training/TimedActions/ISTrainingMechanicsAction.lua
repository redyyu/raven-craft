require "TimedActions/ISBaseTimedAction"

ISTrainingMechanicsAction = ISBaseTimedAction:derive("ISTrainingMechanicsAction")

function ISTrainingMechanicsAction:isValid()
    return self.clothing and 
       self.clothing:getFabricType() == "Cotton" and
       self.inventory:contains(self.clothing) and
       self.inventory:contains(self.needle)
end

function ISTrainingMechanicsAction:update()
    self.clothing:setJobDelta(self:getJobDelta())
end

-- function ISTrainingMechanicsAction:create()
--     ISBaseTimedAction.create(self)
--     self.action:setUseProgressBar(false)
-- end

function ISTrainingMechanicsAction:start()
	self:setActionAnim(CharacterActionAnims.Craft);
end

function ISTrainingMechanicsAction:stop()
    self.clothing:setJobDelta(0.0)
    ISBaseTimedAction.stop(self)
end

-- function ISTrainingMechanicsAction:waitToStart()
    
-- end

function ISTrainingMechanicsAction:perform()
    local thread = self.inventory:getFirstTypeRecurse("Thread")
    local fabric = self.inventory:getFirstTypeRecurse("RippedSheets")
    
    self.clothing:setJobDelta(0.0)

    if thread and fabric then
        local part_idx = ZombRand(0, self.clothing:getCoveredParts():size() - 1)
        local part = self.clothing:getCoveredParts():get(part_idx)
        local patch = self.clothing:getPatchType(part)
        if patch then
            -- remove patch if have

            if ZombRand(100) < chanceToGetPatchBack(self.character) then -- chance to get the patch back
                local fabricType = ClothingPatchFabricType.fromIndex(patch:getFabricType())
                local item = InventoryItemFactory.CreateItem(ClothingRecipesDefinitions["FabricType"][fabricType:getType()].material)
                self.character:getInventory():addItem(item)
                self.character:getXp():AddXP(Perks.Tailoring, 3)
            end
            self.character:getXp():AddXP(Perks.Tailoring, 1)
            self.clothing:removePatch(part)
        else
            -- add patch if don't have
            self.clothing:addPatch(self.character, part, fabric)
            self.character:getInventory():Remove(fabric)
            thread:Use()

            self.character:getXp():AddXP(Perks.Tailoring, ZombRand(1, 3))
        end
        
        self:resetJobDelta()
    else
        self.action:stopTimedActionAnim()
        self.action:setLoopedAction(false)
        -- needed to remove from queue / start next.
        ISBaseTimedAction.perform(self)
    end
end

function ISTrainingMechanicsAction:new(character, vehicle, screwdriver, wrench, lug_wrench, jack)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.inventory = character:getInventory()
    o.maxTime = 150 - (character:getPerkLevel(Perks.Mechanics) * 6)
	if o.character:isTimedActionInstant() then o.maxTime = 1 end
    o.stopOnWalk = true
    o.stopOnRun = true
    o.vehicle = vehicle
    o.parts = parts
    o.screwdriver = screwdriver
    o.wrench = wrench
    o.lug_wrench = lug_wrench
    o.jack = jack
    o.loopedAction = false
    return o
end
