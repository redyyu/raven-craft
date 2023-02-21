--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction/ISStopFurnaceFire"
require "TimedActions/ISBaseTimedAction/ISFurnaceLightFromKindle"
require "TimedActions/ISBaseTimedAction/ISFurnaceLightFromLiterature"
require "TimedActions/ISBaseTimedAction/ISFurnaceLightFromPetrol"

local SPRITES = {
    fire_lit = "crafted_01_27",
    fire_unlit = "crafted_01_26",
    
}

local ISStopFurnaceFireStop = ISStopFurnaceFire:stop;
function ISStopFurnaceFire:stop()
	ISStopFurnaceFireStop();
    local isoObject = self:getIsoObject();
	isoObject:setSprite(SPRITES.fire_unlit);
    isoObject:transmitUpdatedSpriteToClients();
end

local ISFurnaceLightFromKindleStart = ISFurnaceLightFromKindle:start
function ISFurnaceLightFromKindle:start()
	ISFurnaceLightFromKindleStart();
    local isoObject = self:getIsoObject();
	isoObject:setSprite(SPRITES.fire_lit);
    isoObject:transmitUpdatedSpriteToClients();
end

local ISFurnaceLightFromLiteratureStart = ISFurnaceLightFromLiterature:start
function ISFurnaceLightFromLiterature:start()
	ISFurnaceLightFromLiteratureStart();
    local isoObject = self:getIsoObject();
	isoObject:setSprite(SPRITES.fire_lit);
    isoObject:transmitUpdatedSpriteToClients();
end

local ISFurnaceLightFromPetrolStart = ISFurnaceLightFromPetrol:start
function ISFurnaceLightFromPetrol:start()
	ISFurnaceLightFromPetrolStart();
    local isoObject = self:getIsoObject();
	isoObject:setSprite(SPRITES.fire_lit);
    isoObject:transmitUpdatedSpriteToClients();
end