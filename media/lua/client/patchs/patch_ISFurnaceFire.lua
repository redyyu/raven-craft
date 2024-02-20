--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "Blacksmith/TimedActions/ISStopFurnaceFire"
require "Blacksmith/TimedActions/ISFurnaceLightFromKindle"
require "Blacksmith/TimedActions/ISFurnaceLightFromLiterature"
require "Blacksmith/TimedActions/ISFurnaceLightFromPetrol"
require "TimedActions/ISBaseTimedAction"

local lit_sprite = "crafted_01_43";
-- local unlit_sprite = "crafted_01_42"

-- DO NOT use setSprite to furnace, because the furnace here is JavaObject,
-- IS NOT a lua ISBSFurnace Object !! 
-- it will make the square unblocked, which mean is player `CanPassThrough` after light up,
-- even put out the fire, the square still unblocked. becaue the sprite is changed.
-- check the JavaObject document, use setOverlaySprite, with transparent attribute to fix.


function ISStopFurnaceFire:perform()
    if self.furnace then
        -- self.furnace:setSprite(unlit_sprite)
        self.furnace:setOverlaySprite(lit_sprite, 0.0, 0.0, 0.0, 0.0, true)
    end
    ISBaseTimedAction.perform(self);
    self.furnace:setFireStarted(false);
end


function ISFurnaceLightFromKindle:perform()
	if self.furnace then
        -- self.furnace:setSprite(lit_sprite)
        self.furnace:setOverlaySprite(lit_sprite, true)
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
        -- self.furnace:setSprite(lit_sprite)
        self.furnace:setOverlaySprite(lit_sprite, true)
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
        -- self.furnace:setSprite(lit_sprite)
        self.furnace:setOverlaySprite(lit_sprite, true)
    end
    self.petrol:getContainer():setDrawDirty(true);
    self.petrol:setJobDelta(0.0);
    self.furnace:setFireStarted(true);
	ISBaseTimedAction.perform(self);
end