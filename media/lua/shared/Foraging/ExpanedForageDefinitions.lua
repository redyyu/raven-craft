require "Foraging/forageSystem"

local ForagingExpaned = {}

local ForagingDefs = {}

ForagingDefs.Corest = {
    categories = {"Clothing"},
    skill = 2,
    xp = 5,
    zones = {
        Vegitation  = 1,
        TrailerPark = 2,
        TownZone = 2,
        Nav = 2,
    },
    spawnFuncs = {doClothingItemSpawn},
    items = {
        getPackageItemType(".Corset_BodysuitBlack"),
        getPackageItemType(".Corset_BodysuitRed"),
        getPackageItemType(".Corset_BodysuitTINT"),
        getPackageItemType(".Corset_TeddiesBodysuitTINT"),
        getPackageItemType(".Corset_TeddiesTINT"),
    }
}

ForagingExpaned.onAddForageDefs = function ()
    
    for k, v in pairs(ForagingDefs) do

        for _, itemFullType in ipairs(v.items) do
            forageSystem.addItemDef({
                type = itemFullType,
                skill = v.skill,
                xp = v.xp,
                categories = v.categories,
                zones = v.zones,
                spawnFuncs = v.spawnFuncs or {doGenericItemSpawn},
                forceOutside = v.forceOutside or false,
                canBeAboveFloor = v.canBeAboveFloor or true,
                itemSizeModifier = v.itemSizeModifier or 0.5,
                isItemOverrideSize = v.isItemOverrideSize or true,
            })
        end

    end

end


Events.onAddForageDefs.Add(ForagingExpaned.onAddForageDefs)
