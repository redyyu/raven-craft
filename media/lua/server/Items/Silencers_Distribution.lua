require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"


local ITEMS_WEIGHT = {
    ["SilencerPistol"] = 1,
    ["SilencerRifle"] = 0.5,
}

local ITEMS_HM_WEIGHT = {
    ["SilencerPipe"] = 1,
    ["SilencerBottle"] = 1.5,
}

-- Add items for Gun Store locker
RC.insertDistTable(ProceduralDistributions.list["GunStoreShelf"], ITEMS_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["GunStoreCounter"], ITEMS_WEIGHT, 5)
RC.insertDistTable(ProceduralDistributions.list["GunStoreDisplayCase"], ITEMS_WEIGHT, 5)
RC.insertDistTable(ProceduralDistributions.list["GunStoreMagazineRack"], ITEMS_WEIGHT, 0.1)

RC.insertDistTable(ProceduralDistributions.list["GarageFirearms"], ITEMS_WEIGHT, 0.5);
RC.insertDistTable(ProceduralDistributions.list["GunStoreAmmunition"], ITEMS_WEIGHT, 0.2);
RC.insertDistTable(ProceduralDistributions.list["SafehouseArmor"], ITEMS_WEIGHT, 4);
RC.insertDistTable(ProceduralDistributions.list["SafehouseTraps"], ITEMS_WEIGHT, 2);

RC.insertDistTable(ProceduralDistributions.list["JanitorTools"], ITEMS_WEIGHT, 5);

-- Add items for Police Storage
RC.insertDistTable(ProceduralDistributions.list["PoliceLockers"], ITEMS_WEIGHT, 0.5)
RC.insertDistTable(ProceduralDistributions.list["PoliceStorageGuns"], ITEMS_WEIGHT, 0.5)
RC.insertDistTable(ProceduralDistributions.list["PawnShopGuns"], ITEMS_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["PawnShopGunsSpecial"], ITEMS_WEIGHT, 4)

-- Very rare in crates, locker and metal shelves
RC.insertDistTable(ProceduralDistributions.list["CrateTools"], ITEMS_WEIGHT, 0.05)
RC.insertDistTable(ProceduralDistributions.list["ShelfGeneric"], ITEMS_WEIGHT, 0.05)
RC.insertDistTable(ProceduralDistributions.list["MechanicShelfMisc"], ITEMS_WEIGHT, 0.05)
RC.insertDistTable(ProceduralDistributions.list["CrateRandomJunk"], ITEMS_WEIGHT, 0.05)
RC.insertDistTable(ProceduralDistributions.list["SurvivalGear"], ITEMS_WEIGHT, 1);
RC.insertDistTable(ProceduralDistributions.list["FirearmWeapons"], ITEMS_WEIGHT, 1);

-- Some where else
RC.insertDistTable(SuburbsDistributions["all"]["postbox"], ITEMS_WEIGHT, 0.01)
RC.insertDistTable(SuburbsDistributions["all"]["sidetable"], ITEMS_WEIGHT, 0.01)

RC.insertDistTable(SuburbsDistributions["SurvivorCache1"]["SurvivorCrate"], ITEMS_WEIGHT, 0.5)
RC.insertDistTable(SuburbsDistributions["SurvivorCache2"]["SurvivorCrate"], ITEMS_WEIGHT, 0.5)
RC.insertDistTable(VehicleDistributions["SurvivalistTruckBed"], ITEMS_WEIGHT, 0.5)
RC.insertDistTable(VehicleDistributions["SurvivalistGlovebox"], ITEMS_WEIGHT, 0.5)


-- for hand made silencers
RC.insertDistTable(SuburbsDistributions["all"]["postbox"], ITEMS_HM_WEIGHT, 0.01)
RC.insertDistTable(SuburbsDistributions["all"]["sidetable"], ITEMS_HM_WEIGHT, 0.01)


RC.insertDistTable(SuburbsDistributions["SurvivorCache1"]["SurvivorCrate"], ITEMS_HM_WEIGHT, 4)
RC.insertDistTable(SuburbsDistributions["SurvivorCache2"]["SurvivorCrate"], ITEMS_HM_WEIGHT, 4)
RC.insertDistTable(VehicleDistributions["SurvivalistTruckBed"], ITEMS_WEIGHT, 2)
RC.insertDistTable(VehicleDistributions["SurvivalistGlovebox"], ITEMS_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["JanitorTools"], ITEMS_WEIGHT, 4);