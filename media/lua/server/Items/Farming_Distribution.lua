require "Items/ProceduralDistributions"
require "Items/SuburbsDistributions"
require "Vehicles/VehicleDistributions"


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

RC.insertDistTable(ProceduralDistributions.list["CrateFarming"], ITEMS_WEIGHT, 5)
RC.insertDistTable(ProceduralDistributions.list["GardenStoreMisc"], ITEMS_WEIGHT, 10)
RC.insertDistTable(ProceduralDistributions.list["GigamartFarming"], ITEMS_WEIGHT, 5)
RC.insertDistTable(ProceduralDistributions.list["Homesteading"], ITEMS_WEIGHT, 10)
RC.insertDistTable(ProceduralDistributions.list["ToolStoreFarming"], ITEMS_WEIGHT, 5)

RC.insertDistTable(VehicleDistributions["FarmerGloveBox"], ITEMS_WEIGHT, 5)
RC.insertDistTable(VehicleDistributions["FarmerTruckBed"], ITEMS_WEIGHT, 5)


-- SackProduce

RC.insertDistTable(ProceduralDistributions.list["GroceryStorageCrate1"], ".SackProduce_Wheat", 0.1)
RC.insertDistTable(ProceduralDistributions.list["GroceryStorageCrate2"], ".SackProduce_Wheat", 2)
RC.insertDistTable(ProceduralDistributions.list["GroceryStorageCrate3"], ".SackProduce_Wheat", 5)
RC.insertDistTable(ProceduralDistributions.list["ProduceStorageCorn"], ".SackProduce_Wheat", 2.5)
RC.insertDistTable(ProceduralDistributions.list["ProduceStorageLettuce"], ".SackProduce_Wheat", 2.5)
RC.insertDistTable(ProceduralDistributions.list["ProduceStorageOnions"], ".SackProduce_Wheat", 2.5)
RC.insertDistTable(ProceduralDistributions.list["ProduceStoragePotatoes"], ".SackProduce_Wheat", 2.5)
RC.insertDistTable(ProceduralDistributions.list["CrateFarming"], ".SackProduce_Wheat", 1)


-- SuburbsDistributions
RC.insertDistTable(SuburbsDistributions.all.Outfit_Farmer, ITEMS_WEIGHT, 4)
RC.insertDistTable(SuburbsDistributions.SeedBag, ITEMS_WEIGHT, 10)

