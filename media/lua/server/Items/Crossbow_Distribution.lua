require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"
require "utils"


local loot_chance = SandboxVars.RavenCraft.LootChance;
local loot_chance_percent = loot_chance / 100;

local LITERATURES_WEIGHT = {
    [".CrossbowMakerMag"] = 1.6 * loot_chance_percent,
}

local ITEMS_WEIGHT = {
    [".CrossbowHand"] = 1 * loot_chance_percent,
    [".CrossbowCompound"] = 1 * loot_chance_percent,
    [".CrossbowWooden"] = 1 * loot_chance_percent,
    [".CrossbowBoltBox"] = 2 * loot_chance_percent,
}


--- Literatures ---

utils.insertDistribution(VehicleDistributions["GloveBox"], LITERATURES_WEIGHT, 0.1);

utils.insertDistribution(VehicleDistributions["SurvivalistGlovebox"], LITERATURES_WEIGHT, 6);
utils.insertDistribution(VehicleDistributions["SurvivalistTruckBed"], LITERATURES_WEIGHT, 6);
utils.insertDistribution(ProceduralDistributions.list["SurvivalGear"], LITERATURES_WEIGHT, 6);


utils.insertDistribution(ProceduralDistributions.list["BookstoreMisc"], LITERATURES_WEIGHT, 3);
utils.insertDistribution(ProceduralDistributions.list["BookstoreBooks"], LITERATURES_WEIGHT, 3);
utils.insertDistribution(ProceduralDistributions.list["CrateBooks"], LITERATURES_WEIGHT, 3);
utils.insertDistribution(ProceduralDistributions.list["CampingStoreBooks"], LITERATURES_WEIGHT, 2);
utils.insertDistribution(ProceduralDistributions.list["CrateMagazines"], LITERATURES_WEIGHT, 2);
utils.insertDistribution(ProceduralDistributions.list["Hunter"], LITERATURES_WEIGHT, 2);
utils.insertDistribution(ProceduralDistributions.list["LibraryBooks"], LITERATURES_WEIGHT, 4);
utils.insertDistribution(ProceduralDistributions.list["LivingRoomShelf"], LITERATURES_WEIGHT, 0.1);
utils.insertDistribution(ProceduralDistributions.list["LivingRoomShelfNoTapes"], LITERATURES_WEIGHT, 0.1);
utils.insertDistribution(ProceduralDistributions.list["LivingRoomSideTable"], LITERATURES_WEIGHT, 0.1);
utils.insertDistribution(ProceduralDistributions.list["LivingRoomSideTableNoRemote"], LITERATURES_WEIGHT, 0.1);
utils.insertDistribution(ProceduralDistributions.list["MagazineRackMixed"], LITERATURES_WEIGHT, 3);
utils.insertDistribution(ProceduralDistributions.list["PostOfficeMagazines"], LITERATURES_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["ShelfGeneric"], LITERATURES_WEIGHT, 0.5);
utils.insertDistribution(ProceduralDistributions.list["PlankStashMagazine"], LITERATURES_WEIGHT, 3);
utils.insertDistribution(ProceduralDistributions.list["ToolStoreBooks"], LITERATURES_WEIGHT, 6);
utils.insertDistribution(ProceduralDistributions.list["ToolStoreCarpentry"], LITERATURES_WEIGHT, 6);


utils.insertDistribution(SuburbsDistributions["all"]["postbox"], LITERATURES_WEIGHT, 0.01);
utils.insertDistribution(SuburbsDistributions["all"]["sidetable"], LITERATURES_WEIGHT, 0.01);


--- Items ---

utils.insertDistribution(SuburbsDistributions["SurvivorCache1"]["SurvivorCrate"], ITEMS_WEIGHT, 3);
utils.insertDistribution(SuburbsDistributions["SurvivorCache2"]["SurvivorCrate"], ITEMS_WEIGHT, 3);
utils.insertDistribution(VehicleDistributions["SurvivalistTruckBed"], ITEMS_WEIGHT, 2);
utils.insertDistribution(VehicleDistributions["SurvivalistGlovebox"], ITEMS_WEIGHT, 4);

utils.insertDistribution(ProceduralDistributions.list["SurvivalGear"], ITEMS_WEIGHT, 4);
utils.insertDistribution(ProceduralDistributions.list["Hunter"], ITEMS_WEIGHT, 3);
utils.insertDistribution(ProceduralDistributions.list["CampingStoreBackpacks"], ITEMS_WEIGHT, 2);
utils.insertDistribution(ProceduralDistributions.list["CampingStoreGear"], ITEMS_WEIGHT, 0.5);
utils.insertDistribution(ProceduralDistributions.list["FirearmWeapons"], ITEMS_WEIGHT, 1);

utils.insertDistribution(ProceduralDistributions.list["GarageFirearms"], ITEMS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["GunStoreAmmunition"], ITEMS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["GunStoreCounter"], ITEMS_WEIGHT, 0.2);
utils.insertDistribution(ProceduralDistributions.list["GunStoreShelf"], ITEMS_WEIGHT, 0.2);
utils.insertDistribution(ProceduralDistributions.list["Hunter"], ITEMS_WEIGHT, 2);
utils.insertDistribution(ProceduralDistributions.list["SafehouseArmor"], ITEMS_WEIGHT, 20);
utils.insertDistribution(ProceduralDistributions.list["SafehouseTraps"], ITEMS_WEIGHT, 10);

----------------------------

utils.insertDistribution(ProceduralDistributions.list["PawnShopGuns"], ITEMS_WEIGHT, 2.5);
utils.insertDistribution(ProceduralDistributions.list["PawnShopGunsSpecial"], ITEMS_WEIGHT, 1.5);
----------------------------

utils.insertDistribution(ProceduralDistributions.list["JanitorTools"], ITEMS_WEIGHT, 0.5);