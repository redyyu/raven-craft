require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"


local SEASONING_WEIGHT = {
    [".BoxOfSalt"] = 3,
    ["Salt"] = 1,
}

local POP_BEER_WEIGHT = {
    ["BeerCan"] = 1,
    ["BeerBottle"] = 1,
    [".PopPack"] = 1,
    [".Pop2Pack"] = 1,
    [".Pop3Pack"] = 1,
    [".PopBottlePack"] = 1,
    [".BeerPack"] = 1,
    [".BeerBottlePack"] = 1,
    [".WaterBottlePack"] = 1,
}

local ALCOHOL_WEIGHT = {
    [".WhiskeyBottledPack"] = 1,
    [".WineBottledPack"] = 1,
    [".Wine2BottledPack"] = 1,
}


-- Seasoing

RC.insertDistTable(ProceduralDistributions.list["BurgerKitchenButcher"], SEASONING_WEIGHT, 2);
RC.insertDistTable(ProceduralDistributions.list["FishChipsKitchenButcher"], SEASONING_WEIGHT, 4);
RC.insertDistTable(ProceduralDistributions.list["ItalianKitchenButcher"], SEASONING_WEIGHT, 3);
RC.insertDistTable(ProceduralDistributions.list["JaysKitchenButcher"], SEASONING_WEIGHT, 2);
RC.insertDistTable(ProceduralDistributions.list["KitchenDryFood"], SEASONING_WEIGHT, 2);
RC.insertDistTable(ProceduralDistributions.list["MexicanKitchenButcher"], SEASONING_WEIGHT, 3);
RC.insertDistTable(ProceduralDistributions.list["SeafoodKitchenButcher"], SEASONING_WEIGHT, 3);
RC.insertDistTable(ProceduralDistributions.list["StoreKitchenButcher"], SEASONING_WEIGHT, 2);
RC.insertDistTable(ProceduralDistributions.list["WesternKitchenButcher"], SEASONING_WEIGHT, 2);

RC.insertDistTable(ProceduralDistributions.list["StoreShelfSpices"], SEASONING_WEIGHT, 5);


-- Drinks
RC.insertDistTable(ProceduralDistributions.list["FridgeBottles"], POP_BEER_WEIGHT, 2);
RC.insertDistTable(ProceduralDistributions.list["GigamartBottles"], POP_BEER_WEIGHT, 2);
RC.insertDistTable(ProceduralDistributions.list["StoreShelfSnacks"], POP_BEER_WEIGHT, 2);
RC.insertDistTable(ProceduralDistributions.list["KitchenBottles"], POP_BEER_WEIGHT, 1);
RC.insertDistTable(VehicleDistributions.Spiffo["TruckBed"], POP_BEER_WEIGHT, 1)

RC.insertDistTable(ProceduralDistributions.list["GigamartBottles"], ALCOHOL_WEIGHT, 2);
RC.insertDistTable(ProceduralDistributions.list["StoreShelfSnacks"], ALCOHOL_WEIGHT, 2);