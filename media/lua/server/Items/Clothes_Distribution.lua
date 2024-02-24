require "Items/ProceduralDistributions"
require "Items/SuburbsDistributions"
require "Vehicles/VehicleDistributions"
require "RCCore"


local ITEMS_WEIGHT = {
    ["Shoes_BootsTINT"] = 2,
}

insertDistTable(ProceduralDistributions.list["BandMerchShelves"], ITEMS_WEIGHT, 6);
insertDistTable(ProceduralDistributions.list["BandPracticeClothing"], ITEMS_WEIGHT, 6);
insertDistTable(ProceduralDistributions.list["ClosetShelfGeneric"], ITEMS_WEIGHT, 0.5);
insertDistTable(ProceduralDistributions.list["ClothingStorageFootwear"], ITEMS_WEIGHT, 6);
insertDistTable(ProceduralDistributions.list["ClothingStoresBoots"], ITEMS_WEIGHT, 10);
insertDistTable(ProceduralDistributions.list["CrateFootwearRandom"], ITEMS_WEIGHT, 10);
insertDistTable(ProceduralDistributions.list["CrateRandomJunk"], ITEMS_WEIGHT, 0.2);
insertDistTable(ProceduralDistributions.list["FactoryLockers"], ITEMS_WEIGHT, 4);

insertDistTable(VehicleDistributions["ClothingTruckBed"], ITEMS_WEIGHT, 0.6);

