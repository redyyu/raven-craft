-- used to spawn underwear automatically on zeds
UnderwearDefinition = UnderwearDefinition or {};

-- base chance of having a special underwear spawning, don't want this too high as it adds new items on dead zeds everytime!
-- UnderwearDefinition.baseChance = 70;

-- outfit name
UnderwearDefinition.Female_Corset = {
    chanceToSpawn = 1, -- weighted chance, can exced 100
    gender = "female",
    top = {
        {name="Corset", chance=15},
        {name="Corset_Black", chance=15},
        {name="Corset_Red", chance=15},
        {name=getPackageItemType(".Corset_Pink"), chance=15},
        {name=getPackageItemType(".Corset_BodysuitPink"), chance=10},
        {name=getPackageItemType(".Corset_BodysuitBlack"), chance=10},
        {name=getPackageItemType(".Corset_BodysuitRed"), chance=10},
        {name=getPackageItemType(".Corset_BodysuitTINT"), chance=10},
        {name=getPackageItemType(".Corset_ToplessTINT"), chance=5},
        {name=getPackageItemType(".Corset_ToplessBodysuitTINT"), chance=5},
    },
    bottom = 'Underpants_White',
}

-- UnderwearDefinition.Female_FrillyRed = {
--     chanceToSpawn = 5,
--     gender = "female",
--     top = {
--         {name="Bra_Straps_FrillyRed", chance=50},
--         {name="Bra_Strapless_FrillyRed", chance=50},
--         {name="Corset_Red", chance=5},
--     },
--     bottom = "FrillyUnderpants_Red",
-- }
