require "Items/ProceduralDistributions"
require "Items/SuburbsDistributions"
require "Vehicles/VehicleDistributions"
require "RCCore"


local ITEMS_WEIGHT = {
    [".CornBagSeed"] = 2,
    [".PeanutsBagSeed"] = 2,
    [".WheatBagSeed"] = 2,
    [".ZucchiniBagSeed"] = 2,
    [".PumpkinBagSeed"] = 2,
    [".WatermelonBagSeed"] = 2,
    [".OnionBagSeed"] = 2,
    [".LettuceBagSeed"] = 2,
    [".LeekBagSeed"] = 2,
    [".EggplantBagSeed"] = 2,
    [".EdamameBagSeed"] = 2,
    [".DaikonBagSeed"] = 2,
    [".PepperJalapenoBagSeed"] = 2,
    [".PepperHabaneroBagSeed"] = 2,
    [".BellPepperBagSeed"] = 2,
    [".AppleBagSeed"] = 2,
    [".BananaBagSeed"] = 2,
    [".GrapefruitBagSeed"] = 2,
    [".GrapesBagSeed"] = 2,
    [".LemonBagSeed"] = 2,
    [".OrangeBagSeed"] = 2,
    [".PeachSeedBagSeed"] = 2,
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

