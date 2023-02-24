require "Items/ProceduralDistributions"
		
require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"
require "utils"


local ITEMS_WEIGHT = {
    ["PipeBomb"]=1,
    ["NoiseTrap"]=1,
    ["AerosolBomb"]=1,
    ["FlameTrap"]=1,
    ["SmokeBomb"]=1,
    ["Molotov"]=1,
}

utils.insertDistribution(SuburbsDistributions["SurvivorCache1"]["SurvivorCrate"], ITEMS_WEIGHT, 8);
utils.insertDistribution(SuburbsDistributions["SurvivorCache2"]["SurvivorCrate"], ITEMS_WEIGHT, 8);
utils.insertDistribution(VehicleDistributions["SurvivalistTruckBed"], ITEMS_WEIGHT, 6);
utils.insertDistribution(VehicleDistributions["SurvivalistGlovebox"], ITEMS_WEIGHT, 6);

utils.insertDistribution(ProceduralDistributions.list["PlankStashGun"], ITEMS_WEIGHT, 2);
utils.insertDistribution(ProceduralDistributions.list["SecurityLockers"], ITEMS_WEIGHT, 4);
utils.insertDistribution(ProceduralDistributions.list["OfficeDeskHome"], ITEMS_WEIGHT, 0.01);
utils.insertDistribution(ProceduralDistributions.list["GasStorageMechanics"], ITEMS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["Locker"], ITEMS_WEIGHT, 0.2);
utils.insertDistribution(ProceduralDistributions.list["GarageFirearms"], ITEMS_WEIGHT, 4);
utils.insertDistribution(ProceduralDistributions.list["DeskGeneric"], ITEMS_WEIGHT, 0.01);
utils.insertDistribution(ProceduralDistributions.list["BedroomDresser"], ITEMS_WEIGHT, 0.01);

utils.insertDistribution(ProceduralDistributions.list["ArmyStorageElectronics"], ITEMS_WEIGHT, 4);
utils.insertDistribution(ProceduralDistributions.list["ArmyStorageAmmunition"], ITEMS_WEIGHT, 6);
utils.insertDistribution(ProceduralDistributions.list["ArmyHangarTools"], ITEMS_WEIGHT, 6);
utils.insertDistribution(ProceduralDistributions.list["ArmySurplusMisc"], ITEMS_WEIGHT, 4);
utils.insertDistribution(ProceduralDistributions.list["ArmySurplusTools"], ITEMS_WEIGHT, 4);
utils.insertDistribution(ProceduralDistributions.list["ArmyHangarTools"], ITEMS_WEIGHT, 4);
utils.insertDistribution(ProceduralDistributions.list["ArmyStorageGuns"], ITEMS_WEIGHT, 3);
utils.insertDistribution(ProceduralDistributions.list["ArmySurplusBackpacks"], ITEMS_WEIGHT, 4);

utils.insertDistribution(ProceduralDistributions.list["SurvivalGear"], ITEMS_WEIGHT, 6);
utils.insertDistribution(ProceduralDistributions.list["BarCounterLiquor"], ITEMS_WEIGHT, 0.1);
utils.insertDistribution(ProceduralDistributions.list["BarCounterMisc"], ITEMS_WEIGHT, 0.2);
utils.insertDistribution(ProceduralDistributions.list["BathroomCounter"], ITEMS_WEIGHT, 0.01);
utils.insertDistribution(ProceduralDistributions.list["Chemistry"], ITEMS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["EngineerTools"], ITEMS_WEIGHT, 6);
utils.insertDistribution(ProceduralDistributions.list["ClosetShelfGeneric"], ITEMS_WEIGHT, 0.1);
utils.insertDistribution(ProceduralDistributions.list["CrateElectronics"], ITEMS_WEIGHT, 0.1);
utils.insertDistribution(ProceduralDistributions.list["DrugLabGuns"], ITEMS_WEIGHT, 6);
utils.insertDistribution(ProceduralDistributions.list["DrugShackWeapons"], ITEMS_WEIGHT, 6);
utils.insertDistribution(ProceduralDistributions.list["ElectronicStoreMisc"], ITEMS_WEIGHT, 0.2);
utils.insertDistribution(ProceduralDistributions.list["FactoryLockers"], ITEMS_WEIGHT, 6);
utils.insertDistribution(ProceduralDistributions.list["SafehouseArmor"], ITEMS_WEIGHT, 4);
utils.insertDistribution(ProceduralDistributions.list["SafehouseTraps"], ITEMS_WEIGHT, 8);
utils.insertDistribution(ProceduralDistributions.list["FirearmWeapons"], ITEMS_WEIGHT, 6);
utils.insertDistribution(ProceduralDistributions.list["GarageFirearms"], ITEMS_WEIGHT, 5);
utils.insertDistribution(ProceduralDistributions.list["ImprovisedCrafts"], ITEMS_WEIGHT, 2);
utils.insertDistribution(ProceduralDistributions.list["LockerArmyBedroom"], ITEMS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["WardrobeRedneck"], ITEMS_WEIGHT, 1);
