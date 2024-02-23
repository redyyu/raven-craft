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

insertDistTable(VehicleDistributions["GloveBox"], LITERATURES_WEIGHT, 0.1);

insertDistTable(VehicleDistributions["SurvivalistGlovebox"], LITERATURES_WEIGHT, 6);
insertDistTable(VehicleDistributions["SurvivalistTruckBed"], LITERATURES_WEIGHT, 6);
insertDistTable(ProceduralDistributions.list["SurvivalGear"], LITERATURES_WEIGHT, 6);


insertDistTable(ProceduralDistributions.list["BookstoreMisc"], LITERATURES_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["BookstoreBooks"], LITERATURES_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["CrateBooks"], LITERATURES_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["CampingStoreBooks"], LITERATURES_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["CrateMagazines"], LITERATURES_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["Hunter"], LITERATURES_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["LibraryBooks"], LITERATURES_WEIGHT, 4);
insertDistTable(ProceduralDistributions.list["LivingRoomShelf"], LITERATURES_WEIGHT, 0.1);
insertDistTable(ProceduralDistributions.list["LivingRoomShelfNoTapes"], LITERATURES_WEIGHT, 0.1);
insertDistTable(ProceduralDistributions.list["LivingRoomSideTable"], LITERATURES_WEIGHT, 0.1);
insertDistTable(ProceduralDistributions.list["LivingRoomSideTableNoRemote"], LITERATURES_WEIGHT, 0.1);
insertDistTable(ProceduralDistributions.list["MagazineRackMixed"], LITERATURES_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["PostOfficeMagazines"], LITERATURES_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["ShelfGeneric"], LITERATURES_WEIGHT, 0.5);
insertDistTable(ProceduralDistributions.list["PlankStashMagazine"], LITERATURES_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["ToolStoreBooks"], LITERATURES_WEIGHT, 6);
insertDistTable(ProceduralDistributions.list["ToolStoreCarpentry"], LITERATURES_WEIGHT, 6);


insertDistTable(SuburbsDistributions["all"]["postbox"], LITERATURES_WEIGHT, 0.01);
insertDistTable(SuburbsDistributions["all"]["sidetable"], LITERATURES_WEIGHT, 0.01);


--- Items ---

insertDistTable(SuburbsDistributions["SurvivorCache1"]["SurvivorCrate"], ITEMS_WEIGHT, 3);
insertDistTable(SuburbsDistributions["SurvivorCache2"]["SurvivorCrate"], ITEMS_WEIGHT, 3);
insertDistTable(VehicleDistributions["SurvivalistTruckBed"], ITEMS_WEIGHT, 2);
insertDistTable(VehicleDistributions["SurvivalistGlovebox"], ITEMS_WEIGHT, 4);

insertDistTable(ProceduralDistributions.list["SurvivalGear"], ITEMS_WEIGHT, 4);
insertDistTable(ProceduralDistributions.list["Hunter"], ITEMS_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["CampingStoreBackpacks"], ITEMS_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["CampingStoreGear"], ITEMS_WEIGHT, 0.5);
insertDistTable(ProceduralDistributions.list["FirearmWeapons"], ITEMS_WEIGHT, 1);

insertDistTable(ProceduralDistributions.list["GarageFirearms"], ITEMS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["GunStoreAmmunition"], ITEMS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["GunStoreCounter"], ITEMS_WEIGHT, 0.2);
insertDistTable(ProceduralDistributions.list["GunStoreShelf"], ITEMS_WEIGHT, 0.2);
insertDistTable(ProceduralDistributions.list["Hunter"], ITEMS_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["SafehouseArmor"], ITEMS_WEIGHT, 20);
insertDistTable(ProceduralDistributions.list["SafehouseTraps"], ITEMS_WEIGHT, 10);

----------------------------

insertDistTable(ProceduralDistributions.list["PawnShopGuns"], ITEMS_WEIGHT, 2.5);
insertDistTable(ProceduralDistributions.list["PawnShopGunsSpecial"], ITEMS_WEIGHT, 1.5);
----------------------------

insertDistTable(ProceduralDistributions.list["JanitorTools"], ITEMS_WEIGHT, 0.5);