--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISTakeBarrel = ISBaseTimedAction:derive("ISTakeBarrel");

function ISTakeBarrel:isValid()
	return true;
end

function ISTakeBarrel:update()
	self.character:faceThisObject(self.barrel)
end

function ISTakeBarrel:start()
end

function ISTakeBarrel:stop()
    ISBaseTimedAction.stop(self);
end

function ISTakeBarrel:perform()

	self.character:getInventory():AddItem("Base.MetalDrum");
	self.character:getInventory():setDrawDirty(true);

	if isClient() then
		sledgeDestroy(self.barrel);
	else
		self.barrel:getSquare():transmitRemoveItemFromSquare(self.barrel)
	end

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISTakeBarrel:new(character, barrel)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.barrel = barrel
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.maxTime = 100
	return o;
end