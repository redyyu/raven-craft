require "CrossbowTypes"
require "RCCore"

local function shootCrossbow(player,item)
	if item:getType() == "LargeCrossbow" then
		if item:getCondition() == 1 then
			player:resetEquippedHandsModels();
		end
	end
end

local function hitCrossbow(attacker, target, weapon,damage)
    local ammoType = weapon:getAmmoType();
 
    if ammoType ~= nil then
    	-- If ammoType is nil, it's a melee attack, do nothing

        if ammoType == PACKAGE_NAME..".CrossbowBolt" then
            -- bolt
            local modData = target:getModData();
            if modData.LCquarrels == nil then
                modData.LCquarrels = 1;
            else 
                modData.LCquarrels = modData.LCquarrels + 1;
            end
        end
    end
end


local function CrossbowOnEquiPrimary(player,item)	
	if item ~= nil then  	
		local crossbow_type = CrossbowTypes[item:getType()]
		if crossbow_type then
			if item:getCurrentAmmoCount() > 0 then
				item:setWeaponSprite(crossbow_type.sprite_drawn)
				player:resetEquippedHandsModels();
			end
		end
	end
end

local function CrossbowOnLoad()
	local player = getPlayer();	
	local item = player:getPrimaryHandItem();
	if item ~= nil then
		local crossbow_type = CrossbowTypes[item:getType()]
		if crossbow_type then
			if item:getCurrentAmmoCount() > 0 then
				item:setWeaponSprite(crossbow_type.sprite_drawn)
				player:resetEquippedHandsModels();
			end
		end
	end
	local modData = player:getModData();
end

local function CrossbowOnZombieDead(zombie)
    local modData = zombie:getModData();   
 
    if modData.LCquarrels ~= nil then
        for i = 1,modData.LCquarrels, 1
        do
            local rnd = ZombRand(1,100);
            print(rnd)
            
            local bolt
            
            if rnd <= 75 then
                bolt = zombie:getInventory():AddItem(PACKAGE_NAME..".CrossbowBolt");
            else
                bolt = zombie:getInventory():AddItem(PACKAGE_NAME..".CrossbowBoltBroken");
            end
        end
        modData.LCquarrels = 0;
    end
 
end






--------------------------------------------------------
Events.OnPressReloadButton.Remove(ISReloadWeaponAction.OnPressReloadButton);
local original_OnPressReloadButton = ISReloadWeaponAction.OnPressReloadButton
-- Called when pressing reload button when not already reloading, only called when you have an equipped weapon to reload (with available bullets or clip)
ISReloadWeaponAction.OnPressReloadButton = function(player, weapon)
	if CrossbowTypes[weapon:getType()] then
		-- If you press reloading while loading bullets, we stop and rack
		if player:getVariableBoolean("isLoading") then
			ISTimedActionQueue.clear(player);
			ISTimedActionQueue.add(ISReloadCrossbowAction:new(player, weapon, true));
		else
			-- if nothing can be loaded in we'll check to insert bullets into mags
			ISReloadCrossbowAction.checkMagazines(player, weapon)
			ISTimedActionQueue.add(ISReloadCrossbowAction:new(player, weapon, false));
		end
	else
		original_OnPressReloadButton(player, weapon);
	end
end

Hook.Attack.Remove(ISReloadWeaponAction.attackHook);
local original_attackHook = ISReloadWeaponAction.attackHook
-- can we attack?
-- need a chambered round
ISReloadWeaponAction.attackHook = function(character, chargeDelta, weapon)
	if CrossbowTypes[weapon:getType()] then
		ISTimedActionQueue.clear(character)
		if character:isAttackStarted() then return; end
		if weapon:isRanged() and not character:isDoShove() then
			if ISReloadCrossbowAction.canShoot(weapon) then
				character:playSound(weapon:getSwingSound());
				AddWorldSound(character, weapon:getSoundRadius(), weapon:getSoundVolume());
				character:DoAttack(0);
			else
				character:DoAttack(0);
				character:setRangedWeaponEmpty(true);
			end
		else
			ISTimedActionQueue.clear(character)
			if(chargeDelta == nil) then
				character:DoAttack(0);
			else
				character:DoAttack(chargeDelta);
			end
		end
	else
		original_attackHook(character, chargeDelta, weapon);
	end
end

Events.OnWeaponSwingHitPoint.Remove(ISReloadWeaponAction.onShoot);
local original_onShoot = ISReloadWeaponAction.onShoot
-- shoot shoot bang bang
-- handle ammo removal, new chamber & jam chance
ISReloadWeaponAction.onShoot = function(player, weapon)
	if not weapon:isRanged() then return; end
	local crossbow_type = CrossbowTypes[weapon:getType()]
	if crossbow_type then
		if weapon:haveChamber() then
			weapon:setRoundChambered(false);
		end
		-- remove ammo, add one to chamber if we still have some
		if weapon:getCurrentAmmoCount() >= weapon:getAmmoPerShoot() then
			if weapon:haveChamber() then
				weapon:setRoundChambered(true);
			end
			weapon:setCurrentAmmoCount(weapon:getCurrentAmmoCount() - weapon:getAmmoPerShoot())
		end
		if weapon:isRackAfterShoot() then -- shotgun need to be rack after each shot to rechamber round
			player:setVariable("RackWeapon", weapon:getWeaponReloadType());
		end
		weapon:setWeaponSprite(crossbow_type.sprite)
		player:resetEquippedHandsModels();
	else
		original_onShoot(player, weapon);
	end
end

Events.OnWeaponSwingHitPoint.Remove(ISReloadWeaponAction.OnPressRackButton);
local original_OnPressRackButton = ISReloadWeaponAction.OnPressRackButton
-- Called when pressing rack (if you rack while having a clip/bullets, we simply remove it and don't reload a new one)
ISReloadWeaponAction.OnPressRackButton = function(player, weapon)
	if CrossbowTypes[weapon:getType()] then
		-- if you press rack while loading bullets, we stop and rack
		if player:getVariableBoolean("isLoading") and not weapon:isRoundChambered() then
			ISTimedActionQueue.clear(player);
		end
		ISTimedActionQueue.add(ISReloadCrossbowAction:new(player, weapon, true));
	else
		original_OnPressRackButton(player, weapon);
	end
end

Events.OnPressReloadButton.Add(ISReloadWeaponAction.OnPressReloadButton);
Events.OnPressRackButton.Add(ISReloadWeaponAction.OnPressRackButton);
Events.OnWeaponSwingHitPoint.Add(ISReloadWeaponAction.onShoot);
Hook.Attack.Add(ISReloadWeaponAction.attackHook);
--------------------------------------------------------


Events.OnEquipPrimary.Add(CrossbowOnEquiPrimary);
Events.OnZombieDead.Add(CrossbowOnZombieDead);
Events.OnLoad.Add(CrossbowOnLoad);
Events.OnWeaponSwingHitPoint.Add(shootCrossbow);
Events.OnWeaponHitCharacter.Add(hitCrossbow);
