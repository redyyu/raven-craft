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
insertDistTable(ProceduralDistributions.list["GunStoreShelf"], ITEMS_WEIGHT, 3)
insertDistTable(ProceduralDistributions.list["GunStoreCounter"], ITEMS_WEIGHT, 5)
insertDistTable(ProceduralDistributions.list["GunStoreDisplayCase"], ITEMS_WEIGHT, 5)
insertDistTable(ProceduralDistributions.list["GunStoreMagazineRack"], ITEMS_WEIGHT, 0.1)

insertDistTable(ProceduralDistributions.list["GarageFirearms"], ITEMS_WEIGHT, 0.5);
insertDistTable(ProceduralDistributions.list["GunStoreAmmunition"], ITEMS_WEIGHT, 0.2);
insertDistTable(ProceduralDistributions.list["SafehouseArmor"], ITEMS_WEIGHT, 4);
insertDistTable(ProceduralDistributions.list["SafehouseTraps"], ITEMS_WEIGHT, 2);

insertDistTable(ProceduralDistributions.list["JanitorTools"], ITEMS_WEIGHT, 5);

-- Add items for Police Storage
insertDistTable(ProceduralDistributions.list["PoliceLockers"], ITEMS_WEIGHT, 0.5)
insertDistTable(ProceduralDistributions.list["PoliceStorageGuns"], ITEMS_WEIGHT, 0.5)
insertDistTable(ProceduralDistributions.list["PawnShopGuns"], ITEMS_WEIGHT, 2)
insertDistTable(ProceduralDistributions.list["PawnShopGunsSpecial"], ITEMS_WEIGHT, 4)

-- Very rare in crates, locker and metal shelves
insertDistTable(ProceduralDistributions.list["CrateTools"], ITEMS_WEIGHT, 0.05)
insertDistTable(ProceduralDistributions.list["ShelfGeneric"], ITEMS_WEIGHT, 0.05)
insertDistTable(ProceduralDistributions.list["MechanicShelfMisc"], ITEMS_WEIGHT, 0.05)
insertDistTable(ProceduralDistributions.list["CrateRandomJunk"], ITEMS_WEIGHT, 0.05)
insertDistTable(ProceduralDistributions.list["SurvivalGear"], ITEMS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["FirearmWeapons"], ITEMS_WEIGHT, 1);

-- Some where else
insertDistTable(SuburbsDistributions["all"]["postbox"], ITEMS_WEIGHT, 0.01)
insertDistTable(SuburbsDistributions["all"]["sidetable"], ITEMS_WEIGHT, 0.01)

insertDistTable(SuburbsDistributions["SurvivorCache1"]["SurvivorCrate"], ITEMS_WEIGHT, 0.5)
insertDistTable(SuburbsDistributions["SurvivorCache2"]["SurvivorCrate"], ITEMS_WEIGHT, 0.5)
insertDistTable(VehicleDistributions["SurvivalistTruckBed"], ITEMS_WEIGHT, 0.5)
insertDistTable(VehicleDistributions["SurvivalistGlovebox"], ITEMS_WEIGHT, 0.5)


-- for hand made silencers
insertDistTable(SuburbsDistributions["all"]["postbox"], ITEMS_HM_WEIGHT, 0.01)
insertDistTable(SuburbsDistributions["all"]["sidetable"], ITEMS_HM_WEIGHT, 0.01)


insertDistTable(SuburbsDistributions["SurvivorCache1"]["SurvivorCrate"], ITEMS_HM_WEIGHT, 4)
insertDistTable(SuburbsDistributions["SurvivorCache2"]["SurvivorCrate"], ITEMS_HM_WEIGHT, 4)
insertDistTable(VehicleDistributions["SurvivalistTruckBed"], ITEMS_WEIGHT, 2)
insertDistTable(VehicleDistributions["SurvivalistGlovebox"], ITEMS_WEIGHT, 2)
insertDistTable(ProceduralDistributions.list["JanitorTools"], ITEMS_WEIGHT, 4);