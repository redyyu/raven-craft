require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"


local LITERATURES_WEIGHT = {
    [".CrossbowMakerMag"] = 0.8,
}

local ITEMS_WEIGHT = {
    [".CrossbowHand"] = 1,
    [".CrossbowCompound"] = 1,
    [".CrossbowWooden"] = 1,
    [".CrossbowBoltBox"] = 2,
}


--- Literatures ---

RC.insertDistTable(VehicleDistributions["GloveBox"], LITERATURES_WEIGHT, 0.1)

RC.insertDistTable(VehicleDistributions["SurvivalistGlovebox"], LITERATURES_WEIGHT, 3)
RC.insertDistTable(VehicleDistributions["SurvivalistTruckBed"], LITERATURES_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["SurvivalGear"], LITERATURES_WEIGHT, 3)


RC.insertDistTable(ProceduralDistributions.list["BookstoreMisc"], LITERATURES_WEIGHT, 1.5)
RC.insertDistTable(ProceduralDistributions.list["BookstoreBooks"], LITERATURES_WEIGHT, 1.5)
RC.insertDistTable(ProceduralDistributions.list["CrateBooks"], LITERATURES_WEIGHT, 1.5)
RC.insertDistTable(ProceduralDistributions.list["CampingStoreBooks"], LITERATURES_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list["CrateMagazines"], LITERATURES_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list["Hunter"], LITERATURES_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list["LibraryBooks"], LITERATURES_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["LivingRoomShelf"], LITERATURES_WEIGHT, 0.05)
RC.insertDistTable(ProceduralDistributions.list["LivingRoomShelfNoTapes"], LITERATURES_WEIGHT, 0.05)
RC.insertDistTable(ProceduralDistributions.list["LivingRoomSideTable"], LITERATURES_WEIGHT, 0.05)
RC.insertDistTable(ProceduralDistributions.list["LivingRoomSideTableNoRemote"], LITERATURES_WEIGHT, 0.05)
RC.insertDistTable(ProceduralDistributions.list["MagazineRackMixed"], LITERATURES_WEIGHT, 1.5)
RC.insertDistTable(ProceduralDistributions.list["PostOfficeMagazines"], LITERATURES_WEIGHT, 0.5)
RC.insertDistTable(ProceduralDistributions.list["ShelfGeneric"], LITERATURES_WEIGHT, 0.25)
RC.insertDistTable(ProceduralDistributions.list["PlankStashMagazine"], LITERATURES_WEIGHT, 1.5)
RC.insertDistTable(ProceduralDistributions.list["ToolStoreBooks"], LITERATURES_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["ToolStoreCarpentry"], LITERATURES_WEIGHT, 3)


RC.insertDistTable(SuburbsDistributions["all"]["postbox"], LITERATURES_WEIGHT, 0.01)
RC.insertDistTable(SuburbsDistributions["all"]["sidetable"], LITERATURES_WEIGHT, 0.01)


--- Items ---

RC.insertDistTable(SuburbsDistributions["SurvivorCache1"]["SurvivorCrate"], ITEMS_WEIGHT, 1)
RC.insertDistTable(SuburbsDistributions["SurvivorCache2"]["SurvivorCrate"], ITEMS_WEIGHT, 1)
RC.insertDistTable(VehicleDistributions["SurvivalistTruckBed"], ITEMS_WEIGHT, 2.5)
RC.insertDistTable(VehicleDistributions["SurvivalistGlovebox"], ITEMS_WEIGHT, 1)

RC.insertDistTable(ProceduralDistributions.list["SurvivalGear"], ITEMS_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["Hunter"], ITEMS_WEIGHT, 5)
RC.insertDistTable(ProceduralDistributions.list["CampingStoreBackpacks"], ITEMS_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list["CampingStoreGear"], ITEMS_WEIGHT, 1.5)
RC.insertDistTable(ProceduralDistributions.list["FirearmWeapons"], ITEMS_WEIGHT, 1.5)

RC.insertDistTable(ProceduralDistributions.list["GarageFirearms"], ITEMS_WEIGHT, 1.5)
RC.insertDistTable(ProceduralDistributions.list["GunStoreAmmunition"], ITEMS_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list["GunStoreCounter"], ITEMS_WEIGHT, 0.5)
RC.insertDistTable(ProceduralDistributions.list["GunStoreShelf"], ITEMS_WEIGHT, 0.5)
RC.insertDistTable(ProceduralDistributions.list["SafehouseArmor"], ITEMS_WEIGHT, 10)
RC.insertDistTable(ProceduralDistributions.list["SafehouseTraps"], ITEMS_WEIGHT, 5)

----------------------------

RC.insertDistTable(ProceduralDistributions.list["PawnShopGuns"], ITEMS_WEIGHT, 1.5)
RC.insertDistTable(ProceduralDistributions.list["PawnShopGunsSpecial"], ITEMS_WEIGHT, 1.5)
----------------------------

RC.insertDistTable(ProceduralDistributions.list["JanitorTools"], ITEMS_WEIGHT, 5)