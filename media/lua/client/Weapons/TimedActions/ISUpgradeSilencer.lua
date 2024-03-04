require "TimedActions/ISBaseTimedAction"

ISUpgradeSilencer = ISBaseTimedAction:derive("ISUpgradeSilencer");

function ISUpgradeSilencer:isValid()
    if self.weapon:getWeaponPart(self.part:getPartType()) then return false end
    return self.character:getInventory():contains(self.part);
end

function ISUpgradeSilencer:update()
    self.weapon:setJobDelta(self:getJobDelta());
    self.part:setJobDelta(self:getJobDelta());

    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISUpgradeSilencer:start()
    self.weapon:setJobType(getText("ContextMenu_Add_Weapon_Upgrade"));
    self.weapon:setJobDelta(0.0);
    self.part:setJobType(getText("ContextMenu_Add_Weapon_Upgrade"));
    self.part:setJobDelta(0.0);
end

function ISUpgradeSilencer:stop()
    ISBaseTimedAction.stop(self);
    self.weapon:setJobDelta(0.0);
    self.part:setJobDelta(0.0);
end

function ISUpgradeSilencer:perform()
    self.weapon:setJobDelta(0.0);
    self.part:setJobDelta(0.0);
    self.weapon:attachWeaponPart(self.part)
    self.character:getInventory():Remove(self.part);
    self.character:setSecondaryHandItem(nil);
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISUpgradeSilencer:new(character, weapon, part, time)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character;
    o.weapon = weapon;
    o.part = part;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    o.maxTime = time;
    if character:isTimedActionInstant() then
        o.maxTime = 1;
    end
    return o;
end
