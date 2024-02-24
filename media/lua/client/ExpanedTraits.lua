-- inspired by `Workshop ID: 2920089312`, `Mod ID: MaintenanceImprovesRepair`
-- Very nice coding style. 
-- Unfortunately, the author's name is not found.

local oldDoTraits = BaseGameCharacterDetails.DoTraits

function ExpanedDoTraits()
    handy:addXPBoost(Perks.SmallBlunt, 1)
    oldDoTraits()
end

Events.OnGameBoot.Add(ExpanedDoTraits);
