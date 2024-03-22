require "Items/ProceduralDistributions"
require "Items/SuburbsDistributions"
require "Vehicles/VehicleDistributions"


local SHOES_WEIGHT = {
    ["Shoes_BootsTINT"] = 1,
    ["Shoes_FancyBoots"] = 1,
}

RC.insertDistTable(ProceduralDistributions.list["BandMerchShelves"], SHOES_WEIGHT, 6)
RC.insertDistTable(ProceduralDistributions.list["BandPracticeClothing"], SHOES_WEIGHT, 6)
RC.insertDistTable(ProceduralDistributions.list["ClosetShelfGeneric"], SHOES_WEIGHT, 0.5)
RC.insertDistTable(ProceduralDistributions.list["ClothingStorageFootwear"], SHOES_WEIGHT, 6)
RC.insertDistTable(ProceduralDistributions.list["ClothingStoresBoots"], SHOES_WEIGHT, 10)
RC.insertDistTable(ProceduralDistributions.list["CrateFootwearRandom"], SHOES_WEIGHT, 10)
RC.insertDistTable(ProceduralDistributions.list["CrateRandomJunk"], SHOES_WEIGHT, 0.2)
RC.insertDistTable(ProceduralDistributions.list["FactoryLockers"], SHOES_WEIGHT, 4)

RC.insertDistTable(VehicleDistributions["ClothingTruckBed"], SHOES_WEIGHT, 0.6)


local CORSET_WEIGHT = {
    [".Corset_Pink"] = 2,
    [".Corset_BodysuitBlack"] = 2,
    [".Corset_BodysuitRed"] = 2,
    [".Corset_BodysuitPink"] = 2,
    [".Corset_BodysuitTINT"] = 2,
    [".Corset_ToplessBodysuitTINT"] = 1,
    [".Corset_ToplessTINT"] = 1,
}

RC.insertDistTable(ProceduralDistributions.list["ClothingStoresUnderwearWoman"], CORSET_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["LingerieStoreAccessories"], CORSET_WEIGHT, 8)
RC.insertDistTable(ProceduralDistributions.list["StripClubDressers"], CORSET_WEIGHT, 2)
RC.insertDistTable(ProceduralDistributions.list["WardrobeWoman"], CORSET_WEIGHT, 0.2)
RC.insertDistTable(ProceduralDistributions.list["WardrobeWomanClassy"], CORSET_WEIGHT, 0.2)
