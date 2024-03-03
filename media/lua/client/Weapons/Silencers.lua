
local SilencedMap = {
    ['Base.SilencerPistol'] = {
        sound = 'silenced_shot',
        volume = 0.2,
        radius = 0.2,
    },
    ['Base.SilencerRifle'] = {
        sound = 'silenced_shot',
        volume = 0.4,
        radius = 0.3,
    },
    ['Base.SilencerPipe'] = {
        sound = 'metal_silenced_shot',
        volume = 0.6,
        radius = 0.5,
    },
    ['Base.SilencerBottle'] = {
        sound = 'crafted_silenced_shot',
        volume = 0.8,
        radius = 0.8,
    },
}


-- Silencer handler
local silencerOnEquipPrimary = function(character, inventoryItem)
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

local silencerOnEquipPrimaryOnStart = function()
    local player = getPlayer()
    silencerOnEquipPrimary(player, player:getPrimaryHandItem())
end

Events.OnEquipPrimary.Add(silencerOnEquipPrimary)
Events.OnGameStart.Add(silencerOnEquipPrimaryOnStart)