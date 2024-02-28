--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"
require "CrossbowTypes"

ISReloadCrossbowAction = ISBaseTimedAction:derive("ISReloadCrossbowAction");

function ISReloadCrossbowAction:isValid()
	return true
end

function ISReloadCrossbowAction:update()
end

ISReloadCrossbowAction.canRack = function(weapon)
	if not weapon:getMagazineType() and not weapon:getAmmoType() then
		return false
	end
	if weapon:isJammed() then
		return true
	end
	if weapon:haveChamber() and weapon:isRoundChambered() then
		return true
	end
	if weapon:haveChamber() and not weapon:isRoundChambered() and weapon:getMagazineType() and weapon:getCurrentAmmoCount() > 0 then
		return true
	end
	if not weapon:haveChamber() and weapon:getCurrentAmmoCount() > 0 then
		return true
	end
	if not weapon:getMagazineType() and weapon:getCurrentAmmoCount() >= weapon:getAmmoPerShoot() then
		return true;
	end
	return false;
end

function ISReloadCrossbowAction:start()
	-- Setup IsPerformingAction & the current anim we want (check in AnimSets LoadHandgun.xml for example)
	self:setActionAnim(CharacterActionAnims.Reload);
	self.character:setVariable("WeaponReloadType", self.gun:getWeaponReloadType())
	local forceStop = true;
	
	if self.gun:getName() ~= "Crossbow (String Snapped)" then
		-- we asked to rack, we gonna remove bullets if one is chambered or load one is no one is chambered
		if self.rack then
			if ISReloadCrossbowAction.canRack(self.gun) then
				-- chamber gun will need to be racked to remove bullet, otherwise we play the unload anim
				if self.gun:haveChamber() then
					self.character:setVariable("isRacking", true);
				else
					self.character:setVariable("isUnloading", true);
				end
				forceStop = false;
			end
		else
			-- if can't have more bullets, we don't do anything, this doesn't apply for magazine-type guns (you'll still remove the current clip)
			if self.gun:getCurrentAmmoCount() >= self.gun:getMaxAmmo() and not self.gun:getMagazineType() then
				self:forceStop();
				return;
			end
			-- clip inside, pressing R will remove it, other wise we load another
			if not self.gun:isContainsClip() then
				-- can't load bullet into a jammed gun, clip works tho
				if self.gun:isJammed() and not self.gun:getMagazineType() then
					self:forceStop();
					return;
				end
				self.character:setVariable("isLoading", true);
			else
				self.character:setVariable("isUnloading", true);
			end
			forceStop = false;
		end
	end
	
	if forceStop then
		self:forceStop();
		return;
	end
	
	self:initVars();

	-- no magazine or bullets were found
	if not self.rack and not self.magazine and not self.bullets and not self.gun:isContainsClip() then
		self:forceStop();
	end
end

-- Check if we have empty magazine than can be filled up for the weapon we're holding when pressing R
ISReloadCrossbowAction.checkMagazines = function(player, gun)
	if gun:isContainsClip() or gun:getBestMagazine(player) then
		return false;
	end
	-- check if we have an empty magazine for the current gun
	if gun:getMagazineType() then
		local mags = player:getInventory():getItemsFromType(gun:getMagazineType())
		if not mags:isEmpty() then
			ISTimedActionQueue.add(ISLoadBulletsInMagazine:new(player, mags:get(0), mags:get(0):getMaxAmmo()));
			return true;
		end
	end
	return false;
end

-- This is used by other timed actions.
function ISReloadCrossbowAction.setReloadSpeed(character, rack)
	local baseReloadSpeed = 0.6;
	if rack then
		-- reloading skill has less impact on racking, panic does nothing
		baseReloadSpeed = baseReloadSpeed + (character:getPerkLevel(Perks.Reloading) * 0.03);
	else
		baseReloadSpeed = baseReloadSpeed + (character:getPerkLevel(Perks.Reloading) * 0.07);
		baseReloadSpeed = baseReloadSpeed - (character:getMoodles():getMoodleLevel(MoodleType.Panic) * 0.05);
	end
	character:setVariable("ReloadSpeed", baseReloadSpeed);
end

-- Add some vars we gonna use, either magazine or the bullets
-- also decide the reload speed
function ISReloadCrossbowAction:initVars()
	ISReloadCrossbowAction.setReloadSpeed(self.character, self.rack)
	-- no need to get ammo if we only rack
	if self.rack then return; end
	-- Get the best magazine (the one with the most bullets)
	if self.gun:getMagazineType() and not self.magazine then
		self.magazine = self.gun:getBestMagazine(self.character);
	elseif self.gun:getAmmoType() then
		local bullets = self.character:getInventory():getItemsFromType(self.gun:getAmmoType());
		if bullets and not bullets:isEmpty() then
			self.bullets = bullets;
		end
	end
end

function ISReloadCrossbowAction:stop()
	-- this should already be cleared from event, but who knows right?
	self.character:clearVariable("isLoading");
	self.character:clearVariable("isRacking");
	self.character:clearVariable("isUnloading");
	self.character:clearVariable("WeaponReloadType")
	
	ISBaseTimedAction.stop(self);
end

function ISReloadCrossbowAction:perform()
	ISBaseTimedAction.perform(self);
end


-- Our AnimSet trigger various event, we hook them here. Check LoadHandgun.xml for example.
function ISReloadCrossbowAction:animEvent(event, parameter)
	local crossbow_type = CrossbowTypes[self.gun:getType()]
	-- unload gun
	if event == 'unloadFinished' then
		self:unloadAmmo();
		if crossbow_type then self.gun:setWeaponSprite(crossbow_type.sprite); end
		self.character:resetEquippedHandsModels();
	end
	
	-- Loading clip is done, we're moving to racking if needed
	if event == 'loadFinished' then
		self:loadAmmo();
		
		if ZombRand(3) == 0 then
			self.character:getXp():AddXP(Perks.Reloading, 2);
		end
		if crossbow_type then self.gun:setWeaponSprite(crossbow_type.sprite_drawn); end
		self.character:resetEquippedHandsModels();
	end
	if event == 'rackBullet' then
		self:rackBullet();
	end
	if event == 'rackingFinished' then
		-- Racking is done, we can exit out timedaction
		self.character:clearVariable("isRacking");
		self:forceStop();
		if crossbow_type then self.gun:setWeaponSprite(crossbow_type.sprite); end
		self.character:resetEquippedHandsModels();
	end
	if event == 'playReloadSound' then
		if parameter == 'load' then
			if self.gun:getInsertAmmoSound() and self.gun:getCurrentAmmoCount() < self.gun:getMaxAmmo() then
				self.character:playSound(self.gun:getInsertAmmoSound());
			end
		end
		if parameter == 'rack' then
			if self.gun:getRackSound() then self.character:playSound(self.gun:getRackSound()); end
		end
		if parameter == 'unload' then
			if self.gun:getEjectAmmoSound() then self.character:playSound(self.gun:getEjectAmmoSound()); end
		end
	end
	if event == 'changeWeaponSprite' then
		if parameter and parameter ~= '' then
			if parameter ~= 'original' then
				self:setOverrideHandModels(parameter, nil)
			else
				self:setOverrideHandModels(self.gun:getWeaponSprite(), nil)
			end
		end
	end
end

-- Rack to get a bullet (from the chamber) or unjam the gun
function ISReloadCrossbowAction:rackBullet()
	if self.gun:haveChamber() then -- rack give one bullet & put another one back in the chamber
		if not self.gun:isJammed() and self.gun:isRoundChambered() then -- don't give back bullet if jammed
			local newBullet = InventoryItemFactory.CreateItem(self.gun:getAmmoType());
			self.character:getInventory():AddItem(newBullet);
		end
		self.gun:setRoundChambered(false);
		self.gun:setJammed(false);
	end
	-- rack non chamber gun give a bullet back
	if self.rack and not self.gun:haveChamber() and self.gun:getCurrentAmmoCount() > 0 then
		if not self.gun:isJammed() then -- don't give back bullet if jammed
			local newBullet = InventoryItemFactory.CreateItem(self.gun:getAmmoType());
			--if self.gun:getModData().LCBoltCondition ~= nil then newbullet.getModData().LCCondition = self.gun:getModData().LCBoltCondition; end --reportedly this was glitchy :s
			if self.gun:getModData().LCBoltCondition ~= nil then
				local a = self.gun:getModData();
				local b = a.LCBoltCondition;
				local c = newBullet.getModData();
				c.LCCondition = b;
			end
			self.character:getInventory():AddItem(newBullet);
			self.gun:setCurrentAmmoCount(self.gun:getCurrentAmmoCount() - self.gun:getAmmoPerShoot());
		end
		self.gun:setJammed(false);
	end
	if self.gun:getCurrentAmmoCount() >= self.gun:getAmmoPerShoot() and self.gun:haveChamber() then
		self.gun:setRoundChambered(true);
		self.gun:setCurrentAmmoCount(self.gun:getCurrentAmmoCount() - self.gun:getAmmoPerShoot());
	end
	local crossbow_type = CrossbowTypes[self.gun:getType()]
	if crossbow_type then self.gun:setWeaponSprite(crossbow_type.sprite); end
	self.character:resetEquippedHandsModels();
end

function ISReloadCrossbowAction:loadAmmo()
	
	-- we insert a new clip only if we're in the motion of loading
	if self.magazine then
		self.character:getInventory():Remove(self.magazine);
		self.gun:setCurrentAmmoCount(self.magazine:getCurrentAmmoCount());
		self.gun:setContainsClip(true);
		self.character:clearVariable("isLoading");
		-- we rack only if no round is chambered
		if not self.gun:isRoundChambered() and self.gun:getCurrentAmmoCount() >= self.gun:getAmmoPerShoot() then
			self.character:setVariable("isRacking", true);
		else
			self:forceStop();
		end
	elseif self.bullets then -- insert bullets one by one
		if not self.bullets:isEmpty() and self.gun:getCurrentAmmoCount() < self.gun:getMaxAmmo() then
			local bullet = self.bullets:get(0);
			self.bullets:remove(bullet);
			self.character:getInventory():Remove(bullet);
			self.gun:setCurrentAmmoCount(self.gun:getCurrentAmmoCount() + 1);
			self.gun:getModData().LCBoltAdded = false;
		end
		-- fully loaded or no more bullet, we rack
		if self.bullets:isEmpty() or self.gun:getCurrentAmmoCount() >= self.gun:getMaxAmmo() then
			self.character:clearVariable("isLoading");
			-- we rack only if no round is chambered
			if self.gun:haveChamber() and not self.gun:isRoundChambered() then
				self.character:setVariable("isRacking", true);
			else
				self:forceStop();
			end
		elseif self.gun:isInsertAllBulletsReload() then
			self:loadAmmo()
		end
	end
end

function ISReloadCrossbowAction:unloadAmmo()
	-- get back the magazine if there was one in the gun
	-- this is for when we unload, otherwise we gonna insert a clip/bullet
	if self.gun:isContainsClip() then
		local newMag = InventoryItemFactory.CreateItem(self.gun:getMagazineType());
		newMag:setCurrentAmmoCount(self.gun:getCurrentAmmoCount());
		self.character:getInventory():AddItem(newMag);
		self.gun:setContainsClip(false);
		self.gun:setCurrentAmmoCount(0);
		-- stop unload
		self.character:clearVariable("isUnloading");
		-- necessary to then load magazine inside guns if needed (force stop don't launch next timed action)
		local queue = ISTimedActionQueue.queues[self.character]
		queue:onCompleted(self);
		self:forceStop();
		local mags = self.character:getInventory():getItemsFromType(self.gun:getMagazineType())
		for i=0, mags:size()-1 do
			if mags:get(i) ~= newMag and mags:get(i):getCurrentAmmoCount() > 0 then
				ISTimedActionQueue.add(ISReloadCrossbowAction:new(self.character, self.gun, false, mags:get(i)));
				return;
			end
		end
		-- check to auto insert bullets & reload gun
		if ISReloadCrossbowAction.checkMagazines(self.character, self.gun) then
			ISTimedActionQueue.add(ISReloadCrossbowAction:new(self.character, self.gun, false));
			return;
		end
		-- Reload the non-empty magazine we just ejected
		if (newMag:getCurrentAmmoCount() < newMag:getMaxAmmo()) and self.character:getInventory():containsType(self.gun:getAmmoType()) then
			ISTimedActionQueue.add(ISLoadBulletsInMagazine:new(self.character, newMag, newMag:getMaxAmmo()));
			ISTimedActionQueue.add(ISReloadCrossbowAction:new(self.character, self.gun, false));
		end
	else -- only for non-chambered gun
		if not self.gun:isJammed() and self.gun:getCurrentAmmoCount() > 0 then -- don't give back bullet if jammed
			local newBullet = InventoryItemFactory.CreateItem(self.gun:getAmmoType());
			self.character:getInventory():AddItem(newBullet);
		end
		if self.gun:getCurrentAmmoCount() > 0 then
			self.gun:setCurrentAmmoCount(self.gun:getCurrentAmmoCount() - 1);
		end
		self.gun:setJammed(false);
		-- stop unload
		self.character:clearVariable("isUnloading");
		self:forceStop();
	end
end

-- if reload is true we remove our current clip if we have one & equip a new one
-- if false we simply just remove the clip or ammos we have in our gun
function ISReloadCrossbowAction:new(character, gun, rack, magazine)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.stopOnWalk = false;
	o.stopOnRun = true;
	o.rack = rack;
	o.magazine = magazine;
	o.gun = gun;
	o.maxTime = 1000; -- we don't care about time, the anim is controlling the speed/time
	o.useProgressBar = false;
	return o;
end

ISReloadCrossbowAction.canShoot = function(weapon)
	if not weapon:isJammed() and ((weapon:haveChamber() and weapon:isRoundChambered()) or (not weapon:haveChamber() and weapon:getCurrentAmmoCount() > 0)) then
		return true;
	end
	return false;
end