require "TimedActions/ISBaseTimedAction"

ISTailoringTrainingAction = ISBaseTimedAction:derive("ISTailoringTrainingAction")


local chanceToGetPatchBack = function(character)
	local baseChance = 10
	baseChance = baseChance + (character:getPerkLevel(Perks.Tailoring) * 5)
	return baseChance
end

function ISTailoringTrainingAction:isValid()
    return self.clothing and 
       self.clothing:getFabricType() == "Cotton" and
       self.inventory:contains(self.clothing) and
       self.inventory:contains(self.needle)
end

function ISTailoringTrainingAction:update()
    self.clothing:setJobDelta(self:getJobDelta())
end

-- function ISTailoringTrainingAction:create()
--     ISBaseTimedAction.create(self)
--     self.action:setUseProgressBar(false)
-- end

function ISTailoringTrainingAction:start()
	self:setActionAnim(CharacterActionAnims.Craft);
end

function ISTailoringTrainingAction:stop()
    self.clothing:setJobDelta(0.0)
    ISBaseTimedAction.stop(self)
end



function ISTailoringTrainingAction:perform()
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

function ISTailoringTrainingAction:new(character, clothing, needle)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.inventory = character:getInventory()
    o.maxTime = 150 - (character:getPerkLevel(Perks.Tailoring) * 6)
	if o.character:isTimedActionInstant() then o.maxTime = 1 end
    o.stopOnWalk = true
    o.stopOnRun = true
    o.clothing = clothing
    o.parts = parts
    o.needle = needle
    o.loopedAction = true
    return o
end




