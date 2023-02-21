--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "Blacksmith/TimedActions/ISStopFurnaceFire"
require "Blacksmith/TimedActions/ISFurnaceLightFromKindle"
require "Blacksmith/TimedActions/ISFurnaceLightFromLiterature"
require "Blacksmith/TimedActions/ISFurnaceLightFromPetrol"
require "TimedActions/ISBaseTimedAction"

local lit_sprite = "crafted_01_43";
local unlit_sprite = "crafted_01_42"

function ISStopFurnaceFire:perform()
    if self.furnace then
        self.furnace:setSprite(unlit_sprite)
    end
    ISBaseTimedAction.perform(self);
    self.furnace:setFireStarted(false);
end


function ISFurnaceLightFromKindle:perform()
	if self.furnace then
        self.furnace:setSprite(lit_sprite)
    end
    if self.item then
		self.item:getContainer():setDrawDirty(true);
		self.item:setJobDelta(0.0);
	end
	self.plank:setJobDelta(0.0);
	ISBaseTimedAction.perform(self);
end


function ISFurnaceLightFromLiterature:perform()
    if self.furnace then
        self.furnace:setSprite(lit_sprite)
    end
    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);
	self.character:getInventory():Remove(self.item);
	self.lighter:Use();
	local fuelAmt = self.fuelAmt
	if isClient() then
		local cf = self.furnace
		local args = { x = cf.x, y = cf.y, z = cf.z, fuelAmt = fuelAmt }
	else
        self.furnace:setFireStarted(true);
	end
	ISBaseTimedAction.perform(self);
end


function ISFurnaceLightFromPetrol:perform()
    if self.furnace then
        self.furnace:setSprite(lit_sprite)
    end
    self.petrol:getContainer():setDrawDirty(true);
    self.petrol:setJobDelta(0.0);
    self.furnace:setFireStarted(true);
	ISBaseTimedAction.perform(self);
end