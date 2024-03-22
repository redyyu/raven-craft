require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"


local LITERATURES_WEIGHT = {
    [".CraftsmenMag1"] = 1.2,
    [".CraftsmenMag2"] = 1,
    [".CraftsmenMag3"] = 0.8,
    [".CraftsmenMag4"] = 0.6,
    [".CigarettetsMag"] = 0.5,
}

local TOOLS_WEIGHT = {
    ["Tongs"] = 0.75,
    ["Bellows"] = 0.75,
}

local MATERIALS_WEIGHT = {
    ["IronIngot"] = 0.5,
}


--- Literatures ---

RC.insertDistTable(VehicleDistributions["GloveBox"], LITERATURES_WEIGHT, 0.1)

RC.insertDistTable(VehicleDistributions["SurvivalistGlovebox"], LITERATURES_WEIGHT, 6)
RC.insertDistTable(VehicleDistributions["SurvivalistTruckBed"], LITERATURES_WEIGHT, 6)
RC.insertDistTable(ProceduralDistributions.list["SurvivalGear"], LITERATURES_WEIGHT, 6)


RC.insertDistTable(ProceduralDistributions.list["BookstoreMisc"], LITERATURES_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["BookstoreBooks"], LITERATURES_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["CrateBooks"], LITERATURES_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["CampingStoreBooks"], LITERATURES_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["CrateMagazines"], LITERATURES_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["Hunter"], LITERATURES_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["LibraryBooks"], LITERATURES_WEIGHT, 4)
RC.insertDistTable(ProceduralDistributions.list["LivingRoomShelf"], LITERATURES_WEIGHT, 0.1)
RC.insertDistTable(ProceduralDistributions.list["LivingRoomShelfNoTapes"], LITERATURES_WEIGHT, 0.1)
RC.insertDistTable(ProceduralDistributions.list["LivingRoomSideTable"], LITERATURES_WEIGHT, 0.1)
RC.insertDistTable(ProceduralDistributions.list["LivingRoomSideTableNoRemote"], LITERATURES_WEIGHT, 0.1)
RC.insertDistTable(ProceduralDistributions.list["MagazineRackMixed"], LITERATURES_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["PostOfficeMagazines"], LITERATURES_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list["ShelfGeneric"], LITERATURES_WEIGHT, 0.5)
RC.insertDistTable(ProceduralDistributions.list["PlankStashMagazine"], LITERATURES_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["ToolStoreBooks"], LITERATURES_WEIGHT, 6)
RC.insertDistTable(ProceduralDistributions.list["ToolStoreCarpentry"], LITERATURES_WEIGHT, 6)


RC.insertDistTable(SuburbsDistributions["all"]["postbox"], LITERATURES_WEIGHT, 0.01)
RC.insertDistTable(SuburbsDistributions["all"]["sidetable"], LITERATURES_WEIGHT, 0.01)


--- Tools ---
RC.insertDistTable(SuburbsDistributions["SurvivorCache1"]["SurvivorCrate"], TOOLS_WEIGHT, 3)
RC.insertDistTable(SuburbsDistributions["SurvivorCache2"]["SurvivorCrate"], TOOLS_WEIGHT, 3)
RC.insertDistTable(VehicleDistributions["SurvivalistTruckBed"], TOOLS_WEIGHT, 2)
RC.insertDistTable(VehicleDistributions["SurvivalistGlovebox"], TOOLS_WEIGHT, 4)
RC.insertDistTable(ProceduralDistributions.list["SurvivalGear"], TOOLS_WEIGHT, 4)
RC.insertDistTable(ProceduralDistributions.list["Hunter"], TOOLS_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["CrateCarpentry"], TOOLS_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["CrateRandomJunk"], TOOLS_WEIGHT, 0.5)
RC.insertDistTable(ProceduralDistributions.list["CrateTools"], TOOLS_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list["DrugShackTools"], TOOLS_WEIGHT, 0.5)
RC.insertDistTable(ProceduralDistributions.list["DrugShackWeapons"], TOOLS_WEIGHT, 0.5)
RC.insertDistTable(ProceduralDistributions.list["FireStorageTools"], TOOLS_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["ForestFireTools"], TOOLS_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list["GarageCarpentry"], TOOLS_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list["GarageTools"], TOOLS_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list["GigamartTools"], TOOLS_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["GigamartHousewares"], TOOLS_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["LoggingFactoryTools"], TOOLS_WEIGHT, 0.5)
RC.insertDistTable(ProceduralDistributions.list["ToolStoreCarpentry"], TOOLS_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list["ToolStoreTools"], TOOLS_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["ToolStoreMisc"], TOOLS_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["CrateMechanics"], TOOLS_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["CrateMetalwork"], TOOLS_WEIGHT, 4)
RC.insertDistTable(ProceduralDistributions.list["StoreCounterBagsFancy"], TOOLS_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["JanitorTools"], TOOLS_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["ToolStoreFarming"], TOOLS_WEIGHT, 2)


--- Materials ---

RC.insertDistTable(ProceduralDistributions.list["ArmyHangarTools"], MATERIALS_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["BinGeneric"], MATERIALS_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list["CrateMechanics"], MATERIALS_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["CrateMetalwork"], MATERIALS_WEIGHT, 10)
RC.insertDistTable(ProceduralDistributions.list["CrateRandomJunk"], MATERIALS_WEIGHT, 0.5)
RC.insertDistTable(ProceduralDistributions.list["DrugShackMisc"], MATERIALS_WEIGHT, 0.5)
RC.insertDistTable(ProceduralDistributions.list["GarageMetalwork"], MATERIALS_WEIGHT, 10)
RC.insertDistTable(ProceduralDistributions.list["JunkBin"], MATERIALS_WEIGHT, 0.5)
RC.insertDistTable(ProceduralDistributions.list["PlumbingSupplies"], MATERIALS_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["SafehouseTraps"], MATERIALS_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list["ToolStoreMetalwork"], MATERIALS_WEIGHT, 6)
RC.insertDistTable(ProceduralDistributions.list["CrateTools"], MATERIALS_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list["GarageTools"], MATERIALS_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list["GigamartTools"], MATERIALS_WEIGHT, 1)