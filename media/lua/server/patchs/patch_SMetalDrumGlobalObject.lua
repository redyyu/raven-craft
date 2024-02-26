--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

if isClient() then return end

require "MetalDrum/SMetalDrumGlobalObject.lua" -- for ISMetalDrum{}


local SPRITES = {
    {
        fire_lit = "crafted_01_27",
        fire_unlit = "crafted_01_26",
        water = "crafted_01_25",
        empty = "crafted_01_24",
    },
    {
        fire_lit = "crafted_01_31",
        fire_unlit = "crafted_01_30",
        water = "crafted_01_29",
        empty = "crafted_01_28"
    },
    {
        fire_lit = "rc_crafted_metaldrum_01_3",
        fire_unlit = "rc_crafted_metaldrum_01_2",
        water = "rc_crafted_metaldrum_01_1",
        empty = "rc_crafted_metaldrum_01_0",
    },
    {
        fire_lit = "rc_crafted_metaldrum_01_7",
        fire_unlit = "rc_crafted_metaldrum_01_6",
        water = "rc_crafted_metaldrum_01_5",
        empty = "rc_crafted_metaldrum_01_4",
    },
    {
        fire_lit = "rc_crafted_metaldrum_02_3",
        fire_unlit = "rc_crafted_metaldrum_02_2",
        water = "rc_crafted_metaldrum_02_1",
        empty = "rc_crafted_metaldrum_02_0",
    },
    {
        fire_lit = "rc_crafted_metaldrum_02_7",
        fire_unlit = "rc_crafted_metaldrum_02_6",
        water = "rc_crafted_metaldrum_02_5",
        empty = "rc_crafted_metaldrum_02_4",
    },
    {
        fire_lit = "rc_crafted_metaldrum_03_3",
        fire_unlit = "rc_crafted_metaldrum_03_2",
        water = "rc_crafted_metaldrum_03_1",
        empty = "rc_crafted_metaldrum_03_0",
    }
}


function SMetalDrumGlobalObject:getSprites()
    local isoObject = self:getIsoObject()
    if not isoObject then return nil end
    local sprite = isoObject:getSprite()
    if not sprite then return nil end
    local spriteName = sprite:getName()
    local failback_default = nil
    for _, sprites in ipairs(SPRITES) do
        print('----------FDSFFFSSDFFFFFFFFFFFFFFFFFFFFFFF----------------')
        print(spriteName)
        if sprites.is_default then
            failback_default = sprites
        end
        if spriteName == sprites.fire_lit or
                spriteName == sprites.fire_unlit or
                spriteName == sprites.water or
                spriteName == sprites.empty then
            print('---------AAAAAAAAAAAAAAAAAAAAAAAAAAAAA---------------')
            print(sprites.water)
            return sprites
        end
    end
    return failback_default
end
