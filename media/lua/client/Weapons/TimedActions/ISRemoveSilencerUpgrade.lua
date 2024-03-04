require "TimedActions/ISBaseTimedAction"

ISRemoveSilencerUpgrade = ISBaseTimedAction:derive("ISRemoveSilencerUpgrade");

function ISRemoveSilencerUpgrade:isValid()
    if not self.character:getInventory():contains(self.weapon) then return false end
    return self.weapon:getWeaponPart(self.part:getPartType()) == self.part
end

function ISRemoveSilencerUpgrade:update()
    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISRemoveSilencerUpgrade:start()
end

function ISRemoveSilencerUpgrade:stop()
    ISBaseTimedAction.stop(self);
end

function ISRemoveSilencerUpgrade:perform()
    self.weapon:detachWeaponPart(self.part)
    self.character:getInventory():AddItem(self.part);
    self.character:resetEquippedHandsModels();
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISRemoveSilencerUpgrade:new(character, weapon, part, time)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character;
    o.weapon = weapon;
    o.part = part;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    o.maxTime = time;
    return o;
end
