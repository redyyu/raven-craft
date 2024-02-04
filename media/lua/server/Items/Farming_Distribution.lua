require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"
require "utils"


local loot_chance = SandboxVars.RavenCraft.LootChance;
local loot_chance_percent = loot_chance / 100;

local ITEMS_WEIGHT = {
    [".CornBagSeed"] = 2 * loot_chance_percent,
    [".PeanutsBagSeed"] = 2 * loot_chance_percent,
    [".WheatBagSeed"] = 2 * loot_chance_percent,
}

utils.insertDistribution(ProceduralDistributions.list["CrateFarming"], ITEMS_WEIGHT, 8);
utils.insertDistribution(ProceduralDistributions.list["GardenStoreMisc"], ITEMS_WEIGHT, 20);
utils.insertDistribution(ProceduralDistributions.list["GigamartFarming"], ITEMS_WEIGHT, 8);
utils.insertDistribution(ProceduralDistributions.list["Homesteading"], ITEMS_WEIGHT, 20);
utils.insertDistribution(ProceduralDistributions.list["ToolStoreFarming"], ITEMS_WEIGHT, 8);

utils.insertDistribution(VehicleDistributions["FarmerGloveBox"], ITEMS_WEIGHT, 8);
utils.insertDistribution(VehicleDistributions["FarmerTruckBed"], ITEMS_WEIGHT, 8);


-- SackProduce

utils.insertTable(ProceduralDistributions.list["GroceryStorageCrate1"], ".SackProduce_Wheat", 0.1)
utils.insertTable(ProceduralDistributions.list["GroceryStorageCrate2"], ".SackProduce_Wheat", 4)
utils.insertTable(ProceduralDistributions.list["GroceryStorageCrate3"], ".SackProduce_Wheat", 10)
utils.insertTable(ProceduralDistributions.list["ProduceStorageCorn"], ".SackProduce_Wheat", 5)
utils.insertTable(ProceduralDistributions.list["ProduceStorageLettuce"], ".SackProduce_Wheat", 5)
utils.insertTable(ProceduralDistributions.list["ProduceStorageOnions"], ".SackProduce_Wheat", 5)
utils.insertTable(ProceduralDistributions.list["ProduceStoragePotatoes"], ".SackProduce_Wheat", 5)
utils.insertTable(ProceduralDistributions.list["CrateFarming"], ".SackProduce_Wheat", 2)