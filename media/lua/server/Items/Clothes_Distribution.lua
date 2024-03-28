require "Items/ProceduralDistributions"
require "Items/SuburbsDistributions"
require "Vehicles/VehicleDistributions"


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
