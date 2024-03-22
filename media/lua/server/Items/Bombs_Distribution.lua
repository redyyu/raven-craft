require "Items/ProceduralDistributions"
		
require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"


local ITEMS_WEIGHT = {
    ["PipeBomb"] = 1,
    ["NoiseTrap"] = 2,
    ["AerosolBomb"] = 1,
    ["FlameTrap"] = 1,
    ["SmokeBomb"] = 1,
    ["Molotov"] = 2,
}

RC.insertDistTable(SuburbsDistributions["SurvivorCache1"]["SurvivorCrate"], ITEMS_WEIGHT, 4)
RC.insertDistTable(SuburbsDistributions["SurvivorCache2"]["SurvivorCrate"], ITEMS_WEIGHT, 4)
RC.insertDistTable(VehicleDistributions["SurvivalistTruckBed"], ITEMS_WEIGHT, 3)
RC.insertDistTable(VehicleDistributions["SurvivalistGlovebox"], ITEMS_WEIGHT, 3)

RC.insertDistTable(ProceduralDistributions.list["PlankStashGun"], ITEMS_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list["SecurityLockers"], ITEMS_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["OfficeDeskHome"], ITEMS_WEIGHT, 0.01)
RC.insertDistTable(ProceduralDistributions.list["GasStorageMechanics"], ITEMS_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list["Locker"], ITEMS_WEIGHT, 0.1)
RC.insertDistTable(ProceduralDistributions.list["GarageFirearms"], ITEMS_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["DeskGeneric"], ITEMS_WEIGHT, 0.01)
RC.insertDistTable(ProceduralDistributions.list["BedroomDresser"], ITEMS_WEIGHT, 0.01)

RC.insertDistTable(ProceduralDistributions.list["ArmyStorageElectronics"], ITEMS_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list["ArmyStorageAmmunition"], ITEMS_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["ArmyHangarTools"], ITEMS_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["ArmySurplusMisc"], ITEMS_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["ArmySurplusTools"], ITEMS_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["ArmyHangarTools"], ITEMS_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["ArmyStorageGuns"], ITEMS_WEIGHT, 1.5)
RC.insertDistTable(ProceduralDistributions.list["ArmySurplusBackpacks"], ITEMS_WEIGHT, 2)

RC.insertDistTable(ProceduralDistributions.list["SurvivalGear"], ITEMS_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["BarCounterLiquor"], ITEMS_WEIGHT, 0.1)
RC.insertDistTable(ProceduralDistributions.list["BarCounterMisc"], ITEMS_WEIGHT, 0.1)
RC.insertDistTable(ProceduralDistributions.list["BathroomCounter"], ITEMS_WEIGHT, 0.01)
RC.insertDistTable(ProceduralDistributions.list["Chemistry"], ITEMS_WEIGHT, 5)
RC.insertDistTable(ProceduralDistributions.list["EngineerTools"], ITEMS_WEIGHT, 5)
RC.insertDistTable(ProceduralDistributions.list["ClosetShelfGeneric"], ITEMS_WEIGHT, 0.05)
RC.insertDistTable(ProceduralDistributions.list["CrateElectronics"], ITEMS_WEIGHT, 0.05)
RC.insertDistTable(ProceduralDistributions.list["DrugLabGuns"], ITEMS_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["DrugShackWeapons"], ITEMS_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["ElectronicStoreMisc"], ITEMS_WEIGHT, 0.1)
RC.insertDistTable(ProceduralDistributions.list["FactoryLockers"], ITEMS_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["SafehouseArmor"], ITEMS_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["SafehouseTraps"], ITEMS_WEIGHT, 4)
RC.insertDistTable(ProceduralDistributions.list["FirearmWeapons"], ITEMS_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["GarageFirearms"], ITEMS_WEIGHT, 3)
RC.insertDistTable(ProceduralDistributions.list["ImprovisedCrafts"], ITEMS_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list["LockerArmyBedroom"], ITEMS_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["WardrobeRedneck"], ITEMS_WEIGHT, 4)
