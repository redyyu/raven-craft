require "TimedActions/ISBaseTimedAction"

ISFillDirtDitchAction = ISBaseTimedAction:derive("ISFillDirtDitchAction")


function ISFillDirtDitchAction:isValid()
    local uses = self.inventory:getUsesTypeRecurse("Dirtbag")
    return self.shovel and not self.shovel:isBroken() and uses >= self.dirt_use
end

function ISFillDirtDitchAction:update()
    self.shovel:setJobDelta(self:getJobDelta())
end

function ISFillDirtDitchAction:start()
    self:setOverrideHandModels(self.shovel, nil)
    self.character:faceThisObject(self.thumpable)
    if self.shovel:getType() == "Trowel" then
        self:setActionAnim(CharacterActionAnims.DigTrowel)
        self.sound = self.character:playSound("DigFurrowWithTrowel");
    else
        self:setActionAnim(CharacterActionAnims.DigShovel)
        self.sound = self.character:playSound("DigFurrowWithShovel");
    end
end

function ISFillDirtDitchAction:stop()
    self.shovel:setJobDelta(0.0)
    if self.sound then self.character:stopOrTriggerSound(self.sound) end
    ISBaseTimedAction.stop(self)
end

function ISFillDirtDitchAction:waitToStart()
    self.character:faceThisObject(self.ditch)
    if self.sound then self.character:stopOrTriggerSound(self.sound) end
    return self.character:shouldBeTurning()
end

function ISFillDirtDitchAction:perform()
    local dirt_bag = self.inventory:getFirstTypeRecurse("Dirtbag")
    local use_count = 0
    while use_count < self.dirt_use and dirt_bag do
        dirt_bag:Use()
        use_count = use_count + 1
        if not dirt_bag then
            dirt_bag = self.inventory:getFirstTypeRecurse("Dirtbag")
        end
    end

    local square = self.ditch:getSquare()
    if isClient() then
        local sq = square
        local args = { x = sq:getX(), y = sq:getY(), z = sq:getZ(), index = self.ditch:getObjectIndex()}
        sendClientCommand(self.character, 'object', 'OnDestroyIsoThumpable', args)
    else
        square:transmitRemoveItemFromSquare(self.ditch)
    end
    
    local floor = square:getFloor()
    if not floor then
        floor = square:addFloor(ISWaterDitch.floorSprite)
    end

    square:RecalcProperties()
    square:RecalcAllWithNeighbours(true)

    self.shovel:setJobDelta(0.0)
    ISBaseTimedAction.perform(self) 
end

function ISFillDirtDitchAction:new(character, ditch, shovel, dirt_use)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.inventory = character:getInventory()
    o.ditch = ditch
    o.dirt_use = dirt_use
    o.maxTime = 200
    o.stopOnWalk = true
    o.stopOnRun = true
    o.shovel = shovel
    return o
end
