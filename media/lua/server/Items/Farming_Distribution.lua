require "Items/ProceduralDistributions"
require "Items/SuburbsDistributions"
require "Vehicles/VehicleDistributions"
require "utils"


local loot_chance = SandboxVars.RavenCraft.LootChance;
local loot_chance_percent = loot_chance / 100;

local ITEMS_WEIGHT = {
    [".CornBagSeed"] = 2 * loot_chance_percent,
    [".PeanutsBagSeed"] = 2 * loot_chance_percent,
    [".WheatBagSeed"] = 2 * loot_chance_percent,
    [".ZucchiniBagSeed"] = 2 * loot_chance_percent,
    [".PumpkinBagSeed"] = 2 * loot_chance_percent,
    [".WatermelonBagSeed"] = 2 * loot_chance_percent,
    [".OnionBagSeed"] = 2 * loot_chance_percent,
    [".LettuceBagSeed"] = 2 * loot_chance_percent,
    [".LeekBagSeed"] = 2 * loot_chance_percent,
    [".EggplantBagSeed"] = 2 * loot_chance_percent,
    [".EdamameBagSeed"] = 2 * loot_chance_percent,
    [".DaikonBagSeed"] = 2 * loot_chance_percent,
    [".PepperJalapenoBagSeed"] = 2 * loot_chance_percent,
    [".PepperHabaneroBagSeed"] = 2 * loot_chance_percent,
    [".BellPepperBagSeed"] = 2 * loot_chance_percent,
}

insertDistTable(ProceduralDistributions.list["CrateFarming"], ITEMS_WEIGHT, 8);
insertDistTable(ProceduralDistributions.list["GardenStoreMisc"], ITEMS_WEIGHT, 20);
insertDistTable(ProceduralDistributions.list["GigamartFarming"], ITEMS_WEIGHT, 8);
insertDistTable(ProceduralDistributions.list["Homesteading"], ITEMS_WEIGHT, 20);
insertDistTable(ProceduralDistributions.list["ToolStoreFarming"], ITEMS_WEIGHT, 8);

insertDistTable(VehicleDistributions["FarmerGloveBox"], ITEMS_WEIGHT, 8);
insertDistTable(VehicleDistributions["FarmerTruckBed"], ITEMS_WEIGHT, 8);


-- SackProduce

insertDistTable(ProceduralDistributions.list["GroceryStorageCrate1"], ".SackProduce_Wheat", 0.1)
insertDistTable(ProceduralDistributions.list["GroceryStorageCrate2"], ".SackProduce_Wheat", 4)
insertDistTable(ProceduralDistributions.list["GroceryStorageCrate3"], ".SackProduce_Wheat", 10)
insertDistTable(ProceduralDistributions.list["ProduceStorageCorn"], ".SackProduce_Wheat", 5)
insertDistTable(ProceduralDistributions.list["ProduceStorageLettuce"], ".SackProduce_Wheat", 5)
insertDistTable(ProceduralDistributions.list["ProduceStorageOnions"], ".SackProduce_Wheat", 5)
insertDistTable(ProceduralDistributions.list["ProduceStoragePotatoes"], ".SackProduce_Wheat", 5)
insertDistTable(ProceduralDistributions.list["CrateFarming"], ".SackProduce_Wheat", 2)


-- SuburbsDistributions
insertDistTable(SuburbsDistributions.all.Outfit_Farmer, ITEMS_WEIGHT, 8)
insertDistTable(SuburbsDistributions.SeedBag, ITEMS_WEIGHT, 20)

