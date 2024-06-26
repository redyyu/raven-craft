require 'TimedActions/ISUpgradeSilencer'
require 'TimedActions/ISRemoveSilencerUpgrade'


local SilencedMap = {
    ['Base.SilencerPistol'] = {
        sound = 'SilencedShot',
        volume = 0.2,
        radius = 0.2,
    },
    ['Base.SilencerRifle'] = {
        sound = 'SilencedShot',
        volume = 0.4,
        radius = 0.3,
    },
    ['Base.SilencerPipe'] = {
        sound = 'SilencedPipeShot',
        volume = 0.6,
        radius = 0.5,
    },
    ['Base.SilencerBottle'] = {
        sound = 'SilencedBottleShot',
        volume = 0.8,
        radius = 0.8,
    },
}

local function predicateNotBroken(item)
	return not item:isBroken()
end


local Silen = {}

Silen.onUpgradeSilencer = function(weapon, part, player)
    ISInventoryPaneContextMenu.transferIfNeeded(player, weapon)
    ISInventoryPaneContextMenu.transferIfNeeded(player, part)
    ISInventoryPaneContextMenu.equipWeapon(part, false, false, player:getPlayerNum())
    ISTimedActionQueue.add(ISUnequipAction:new(player, weapon, 50))
    ISTimedActionQueue.add(ISUpgradeSilencer:new(player, weapon, part, 50))
end

Silen.onRemoveUpgradeSilencer = function(weapon, part, player)
    ISInventoryPaneContextMenu.transferIfNeeded(player, weapon)
    ISTimedActionQueue.add(ISUnequipAction:new(player, weapon, 50))
    ISTimedActionQueue.add(ISRemoveSilencerUpgrade:new(player, weapon, part, 50))
end


-- make sure activated on game start.
Silen.onGameStart = function()
    local player = getPlayer()
    Silen.onEquipPrimary(player, player:getPrimaryHandItem())
end

-- silencer handler
Silen.onEquipPrimary = function(character, inventoryItem)
    if inventoryItem ~= nil then
        local scriptItem = inventoryItem:getScriptItem()
        local sound_volumn = scriptItem:getSoundVolume()
        local round_radius = scriptItem:getSoundRadius()
        if inventoryItem:getStringItemType() == "RangedWeapon" then 
            if inventoryItem:getCanon() then
                local silenced = SilencedMap[inventoryItem:getCanon():getFullType()]
                if silenced then
                    inventoryItem:setSoundVolume(sound_volumn * silenced.volume)
                    inventoryItem:setSoundRadius(round_radius * silenced.radius)
                    inventoryItem:setSwingSound(silenced.sound)
                    return
                end
            end
            -- rest to vanilla weapons sound if no silencer
            if scriptItem:getFullName() ~= nil then
                inventoryItem:setSoundVolume(sound_volumn)
                inventoryItem:setSoundRadius(round_radius)
                inventoryItem:setSwingSound(scriptItem:getSwingSound())
            end
        end
    end
end

-- upgrade / remove with out screwdriver
Silen.onFillInventoryObjectContextMenu = function(playerNum, context, items)
    local playerObj = getSpecificPlayer(playerNum)
    local playerInv = playerObj:getInventory()

    local items = ISInventoryPane.getActualItems(items)
    local gun = nil
    
	for _, item in ipairs(items) do
		if item and instanceof(item, "HandWeapon") then
            gun = item
        end
    end

    if not gun or playerInv:containsTagEvalRecurse("Screwdriver", predicateNotBroken) then
        return
    end

    -- add parts
    local weaponParts = playerInv:getItemsFromCategory("WeaponPart")
    if weaponParts and not weaponParts:isEmpty() then
        local subMenuUp = context:getNew(context)
        local doIt = false;
        local alreadyDoneList = {}
        for i=0, weaponParts:size() - 1 do
            local part = weaponParts:get(i)
            if not alreadyDoneList[part:getName()] then
                if part:hasTag('Silencer') 
                   and part:getMountOn():contains(gun:getFullType())
                   and part:getPartType() == "Canon"
                   and not gun:getCanon() then
                    doIt = true
                    subMenuUp:addOption(weaponParts:get(i):getName(), gun, Silen.onUpgradeSilencer, part, playerObj)
                    alreadyDoneList[part:getName()] = true
                end
            end
        end
        if doIt then
            local upgradeOption = context:addOptionOnTop(getText("ContextMenu_Add_Silencer_Upgrade"), items, nil)
            context:addSubMenu(upgradeOption, subMenuUp)
        end
    end

    -- remove parts
    if gun:getCanon() and gun:getCanon():hasTag('Silencer') then
        local removeUpgradeOption = context:addOptionOnTop(getText("ContextMenu_Remove_Silencer_Upgrade"), items, nil)
        local subMenuRemove = context:getNew(context);
        context:addSubMenu(removeUpgradeOption, subMenuRemove)
        subMenuRemove:addOption(gun:getCanon():getName(), gun, Silen.onRemoveUpgradeSilencer, gun:getCanon(), playerObj)
    end
end

Events.OnEquipPrimary.Add(Silen.onEquipPrimary)
Events.OnGameStart.Add(Silen.onGameStart)
Events.OnFillInventoryObjectContextMenu.Add(Silen.onFillInventoryObjectContextMenu)