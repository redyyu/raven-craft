require "Items/ProceduralDistributions"
require "Items/SuburbsDistributions"
require "Vehicles/VehicleDistributions"
require "RCCore"


local ITEMS_WEIGHT = {
    [".CornBagSeed"] = 1,
    [".PeanutsBagSeed"] = 1,
    [".WheatBagSeed"] = 1,
    [".ZucchiniBagSeed"] = 1,
    [".PumpkinBagSeed"] = 1,
    [".WatermelonBagSeed"] = 1,
    [".OnionBagSeed"] = 1,
    [".LettuceBagSeed"] = 1,
    [".LeekBagSeed"] = 1,
    [".EggplantBagSeed"] = 1,
    [".EdamameBagSeed"] = 1,
    [".DaikonBagSeed"] = 1,
    [".PepperJalapenoBagSeed"] = 1,
    [".PepperHabaneroBagSeed"] = 1,
    [".BellPepperBagSeed"] = 1,
    [".AppleBagSeed"] = 1,
    [".BananaBagSeed"] = 1,
    [".GrapefruitBagSeed"] = 1,
    [".GrapesBagSeed"] = 1,
    [".LemonBagSeed"] = 1,
    [".OrangeBagSeed"] = 1,
    [".PeachSeedBagSeed"] = 1,
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

