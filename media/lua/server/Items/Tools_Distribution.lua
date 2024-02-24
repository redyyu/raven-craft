require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"
require "RCCore"


local LITERATURES_WEIGHT = {
    [".CraftsmenMag1"] = 2.4,
    [".CraftsmenMag2"] = 2,
    [".CraftsmenMag3"] = 1.6,
    [".CraftsmenMag4"] = 1.2,
    [".CigarettetsMag"] = 1,
}

local TOOLS_WEIGHT = {
    ["Tongs"] = 1.5,
    ["Bellows"] = 1.5,
    [".CartContainer"] = 1,
}

local MATERIALS_WEIGHT = {
    ["IronIngot"] = 1,
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


--- Tools ---
insertDistTable(SuburbsDistributions["SurvivorCache1"]["SurvivorCrate"], TOOLS_WEIGHT, 3);
insertDistTable(SuburbsDistributions["SurvivorCache2"]["SurvivorCrate"], TOOLS_WEIGHT, 3);
insertDistTable(VehicleDistributions["SurvivalistTruckBed"], TOOLS_WEIGHT, 2);
insertDistTable(VehicleDistributions["SurvivalistGlovebox"], TOOLS_WEIGHT, 4);
insertDistTable(ProceduralDistributions.list["SurvivalGear"], TOOLS_WEIGHT, 4);
insertDistTable(ProceduralDistributions.list["Hunter"], TOOLS_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["CrateCarpentry"], TOOLS_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["CrateRandomJunk"], TOOLS_WEIGHT, 0.5);
insertDistTable(ProceduralDistributions.list["CrateTools"], TOOLS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["DrugShackTools"], TOOLS_WEIGHT, 0.5);
insertDistTable(ProceduralDistributions.list["DrugShackWeapons"], TOOLS_WEIGHT, 0.5);
insertDistTable(ProceduralDistributions.list["FireStorageTools"], TOOLS_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["ForestFireTools"], TOOLS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["GarageCarpentry"], TOOLS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["GarageTools"], TOOLS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["GigamartTools"], TOOLS_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["GigamartHousewares"], TOOLS_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["LoggingFactoryTools"], TOOLS_WEIGHT, 0.5);
insertDistTable(ProceduralDistributions.list["ToolStoreCarpentry"], TOOLS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["ToolStoreTools"], TOOLS_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["ToolStoreMisc"], TOOLS_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["CrateMechanics"], TOOLS_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["CrateMetalwork"], TOOLS_WEIGHT, 4);
insertDistTable(ProceduralDistributions.list["StoreCounterBagsFancy"], TOOLS_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["JanitorTools"], TOOLS_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["ToolStoreFarming"], TOOLS_WEIGHT, 2);


--- Materials ---

insertDistTable(ProceduralDistributions.list["ArmyHangarTools"], MATERIALS_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["BinGeneric"], MATERIALS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["CrateMechanics"], MATERIALS_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["CrateMetalwork"], MATERIALS_WEIGHT, 10);
insertDistTable(ProceduralDistributions.list["CrateRandomJunk"], MATERIALS_WEIGHT, 0.5);
insertDistTable(ProceduralDistributions.list["DrugShackMisc"], MATERIALS_WEIGHT, 0.5);
insertDistTable(ProceduralDistributions.list["GarageMetalwork"], MATERIALS_WEIGHT, 10);
insertDistTable(ProceduralDistributions.list["JunkBin"], MATERIALS_WEIGHT, 0.5);
insertDistTable(ProceduralDistributions.list["PlumbingSupplies"], MATERIALS_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["SafehouseTraps"], MATERIALS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["ToolStoreMetalwork"], MATERIALS_WEIGHT, 6);
insertDistTable(ProceduralDistributions.list["CrateTools"], MATERIALS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["GarageTools"], MATERIALS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["GigamartTools"], MATERIALS_WEIGHT, 1);