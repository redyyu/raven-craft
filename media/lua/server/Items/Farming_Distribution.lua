require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"
require "utils"


local ITEMS_WEIGHT = {
    [".CornBagSeed"]=1,
    [".WheatBagSeed"]=1,
}

utils.insertDistribution(ProceduralDistributions.list["CrateFarming"], ITEMS_WEIGHT, 8);
utils.insertDistribution(ProceduralDistributions.list["GardenStoreMisc"], ITEMS_WEIGHT, 20);
utils.insertDistribution(ProceduralDistributions.list["GigamartFarming"], ITEMS_WEIGHT, 8);
utils.insertDistribution(ProceduralDistributions.list["Homesteading"], ITEMS_WEIGHT, 20);
utils.insertDistribution(ProceduralDistributions.list["ToolStoreFarming"], ITEMS_WEIGHT, 8);

utils.insertDistribution(VehicleDistributions["FarmerGloveBox"], ITEMS_WEIGHT, 8);
utils.insertDistribution(VehicleDistributions["FarmerTruckBed"], ITEMS_WEIGHT, 8);