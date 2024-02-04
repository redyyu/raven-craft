require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"
require "utils"


local loot_chance = SandboxVars.RavenCraft.LootChance;
local loot_chance_percent = loot_chance / 100;

local LITERATURES_WEIGHT = {
    [".CraftsmenMag1"] = 2.4 * loot_chance_percent,
    [".CraftsmenMag2"] = 2 * loot_chance_percent,
    [".CraftsmenMag3"] = 1.6 * loot_chance_percent,
    [".CraftsmenMag4"] = 1.2 * loot_chance_percent,
    [".CigarettetsMag"] = 1 * loot_chance_percent,
}

local TOOLS_WEIGHT = {
    [".Tongs"] = 1.5 * loot_chance_percent,
    [".Bellows"] = 1.5 * loot_chance_percent,
}

local MATERIALS_WEIGHT = {
    [".IronIngot"] = 1 * loot_chance_percent,
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


--- Tools ---
utils.insertDistribution(SuburbsDistributions["SurvivorCache1"]["SurvivorCrate"], TOOLS_WEIGHT, 3);
utils.insertDistribution(SuburbsDistributions["SurvivorCache2"]["SurvivorCrate"], TOOLS_WEIGHT, 3);
utils.insertDistribution(VehicleDistributions["SurvivalistTruckBed"], TOOLS_WEIGHT, 2);
utils.insertDistribution(VehicleDistributions["SurvivalistGlovebox"], TOOLS_WEIGHT, 4);
utils.insertDistribution(ProceduralDistributions.list["SurvivalGear"], TOOLS_WEIGHT, 4);
utils.insertDistribution(ProceduralDistributions.list["Hunter"], TOOLS_WEIGHT, 3);
utils.insertDistribution(ProceduralDistributions.list["CrateCarpentry"], TOOLS_WEIGHT, 2);
utils.insertDistribution(ProceduralDistributions.list["CrateRandomJunk"], TOOLS_WEIGHT, 0.5);
utils.insertDistribution(ProceduralDistributions.list["CrateTools"], TOOLS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["DrugShackTools"], TOOLS_WEIGHT, 0.5);
utils.insertDistribution(ProceduralDistributions.list["DrugShackWeapons"], TOOLS_WEIGHT, 0.5);
utils.insertDistribution(ProceduralDistributions.list["FireStorageTools"], TOOLS_WEIGHT, 2);
utils.insertDistribution(ProceduralDistributions.list["ForestFireTools"], TOOLS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["GarageCarpentry"], TOOLS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["GarageTools"], TOOLS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["GigamartTools"], TOOLS_WEIGHT, 2);
utils.insertDistribution(ProceduralDistributions.list["LoggingFactoryTools"], TOOLS_WEIGHT, 0.5);
utils.insertDistribution(ProceduralDistributions.list["ToolStoreCarpentry"], TOOLS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["ToolStoreTools"], TOOLS_WEIGHT, 2);
utils.insertDistribution(ProceduralDistributions.list["CrateMechanics"], TOOLS_WEIGHT, 2);
utils.insertDistribution(ProceduralDistributions.list["CrateMetalwork"], TOOLS_WEIGHT, 4);


--- Materials ---

utils.insertDistribution(ProceduralDistributions.list["ArmyHangarTools"], MATERIALS_WEIGHT, 3);
utils.insertDistribution(ProceduralDistributions.list["BinGeneric"], MATERIALS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["CrateMechanics"], MATERIALS_WEIGHT, 3);
utils.insertDistribution(ProceduralDistributions.list["CrateMetalwork"], MATERIALS_WEIGHT, 10);
utils.insertDistribution(ProceduralDistributions.list["CrateRandomJunk"], MATERIALS_WEIGHT, 0.5);
utils.insertDistribution(ProceduralDistributions.list["DrugShackMisc"], MATERIALS_WEIGHT, 0.5);
utils.insertDistribution(ProceduralDistributions.list["GarageMetalwork"], MATERIALS_WEIGHT, 10);
utils.insertDistribution(ProceduralDistributions.list["JunkBin"], MATERIALS_WEIGHT, 0.5);
utils.insertDistribution(ProceduralDistributions.list["PlumbingSupplies"], MATERIALS_WEIGHT, 2);
utils.insertDistribution(ProceduralDistributions.list["SafehouseTraps"], MATERIALS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["ToolStoreMetalwork"], MATERIALS_WEIGHT, 6);
utils.insertDistribution(ProceduralDistributions.list["CrateTools"], MATERIALS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["GarageTools"], MATERIALS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["GigamartTools"], MATERIALS_WEIGHT, 1);