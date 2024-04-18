
require "Blacksmith/TimedActions/ISStopFurnaceFire"
require "Blacksmith/TimedActions/ISFurnaceLightFromKindle"
require "Blacksmith/TimedActions/ISFurnaceLightFromLiterature"
require "Blacksmith/TimedActions/ISFurnaceLightFromPetrol"
require "TimedActions/ISBaseTimedAction"


-- NOT use overlaySprites any more, because when transfer items the furnace could get dirty.
-- dirty will reset overlaySprite I guess.
-- but when switch sprite the furnace will not block movements anymore.
-- I guess that's because the BSFurnce not work properly.
-- to fix that, place a hacking base isoObject below the furnace can solved the problem.

-- maybe can listen `OnContainerUpdate` then change overlaySprite agian. I guess it work too.

local lit_sprite = "crafted_01_43"
local unlit_sprite = "crafted_01_42"


function ISStopFurnaceFire:isValid()
	return self.furnace ~= nil
end

function ISStopFurnaceFire:perform()
    self.furnace:setFireStarted(false)
    self.furnace:setSprite(unlit_sprite)
    self.furnace:transmitUpdatedSpriteToServer()
    local square = self.furnace:getSquare()
    if square then
        square:RecalcProperties()
        square:RecalcAllWithNeighbours(true)
    end
    ISBaseTimedAction.perform(self)
end


-- ISFurnaceLightFromKindle is lit from update
function ISFurnaceLightFromKindle:update()
	self.item:setJobDelta(self:getJobDelta())
	self.plank:setJobDelta(self:getJobDelta())
	local endurance = self.character:getStats():getEndurance() - 0.0001 * getGameTime():getMultiplier()
	self.character:getStats():setEndurance(endurance)
	if self:getJobDelta() < 0.2 then return end
	local randNumber = 300;
	local randBrokeNumber = 300;
	if self.isOutdoorsMan then
		randNumber = 150;
		randBrokeNumber = 450;
	end
	if ZombRand(randNumber) == 0 then
        self.furnace:setFireStarted(true)  -- lit here
        self.furnace:setSprite(lit_sprite)
        self.furnace:transmitUpdatedSpriteToServer()
	else
		-- fail ? Maybe the wood kit will broke...
		if ZombRand(randBrokeNumber) == 0 then
			self.character:getInventory():Remove(self.item)
		end
	end
end


function ISFurnaceLightFromLiterature:perform()
    self.furnace:setFireStarted(true)
    self.furnace:setSprite(lit_sprite)
    self.furnace:transmitUpdatedSpriteToServer()
    local square = self.furnace:getSquare()
    if square then
        square:RecalcProperties()
        square:RecalcAllWithNeighbours(true)
    end

    self.item:getContainer():setDrawDirty(true)
    self.item:setJobDelta(0.0)

    self.character:getInventory():Remove(self.item)
	self.lighter:Use()

	ISBaseTimedAction.perform(self)
end


function ISFurnaceLightFromPetrol:perform()
    self.furnace:setFireStarted(true)
    self.furnace:setSprite(lit_sprite)
    self.furnace:transmitUpdatedSpriteToServer()
    local square = self.furnace:getSquare()
    if square then
        square:RecalcProperties()
        square:RecalcAllWithNeighbours(true)
    end

    self.petrol:getContainer():setDrawDirty(true)
    self.petrol:setJobDelta(0.0)
    self.lighter:Use()

	ISBaseTimedAction.perform(self)
end