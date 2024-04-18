require "TimedActions/ISBaseTimedAction"

ISFillDirtDitchAction = ISBaseTimedAction:derive("ISFillDirtDitchAction")


function ISFillDirtDitchAction:isValid()
    local uses = self.inventory:getUsesTypeRecurse("Dirtbag")
    print("========================", uses, "/", self.dirt_uses)
    return self.shovel and not self.shovel:isBroken() and uses >= self.dirt_uses
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
    -- local dirt_bags = self.inventory:getAllTypeRecurse("Dirtbag")
    -- local remaining = self.dirt_uses
    -- for i=0, dirt_bags:size() - 1 do
    --     local item = dirt_bags:get(i)
    --     if item:getDrainableUsesInt() > 0 then
    --         remaining = remaining - buildUtil.useDrainable(item, remaining)
    --         if remaining <= 0 then
    --             break
    --         end
    --     end
    -- end
    local dirt_bag = self.inventory:getFirstTypeRecurse("Dirtbag")
    dirt_bag:Use()

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

    -- add dirty fill under ditch layer from beginning.
    local dirty_fill = IsoObject.new(square, ISWaterDitch.dirtFillSprite, ISWaterDitch.dirtFillName)
    square:AddTileObject(dirty_fill)
    -- I guess spriteName and objectName to ModData is for keep it when reload game.
    dirty_fill:getModData().spriteName = ISWaterDitch.dirtFillSprite
    dirty_fill:getModData().objectName = ISWaterDitch.dirtFillName
    
    square:RecalcProperties()
    square:RecalcAllWithNeighbours(true)

    self.shovel:setJobDelta(0.0)
    ISBaseTimedAction.perform(self) 
end

function ISFillDirtDitchAction:new(character, ditch, shovel, dirt_uses)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.inventory = character:getInventory()
    o.ditch = ditch
    o.dirt_uses = dirt_uses or 1
    o.maxTime = 200
    o.stopOnWalk = true
    o.stopOnRun = true
    o.shovel = shovel
    return o
end
