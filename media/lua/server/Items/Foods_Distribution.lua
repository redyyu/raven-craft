require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"


local SEASONING_WEIGHT = {
    [".BoxOfSalt"] = 6,
    ["Salt"] = 2,
}

local POP_BEER_WEIGHT = {
    ["BeerCan"] = 2,
    ["BeerBottle"] = 2,
    [".PopPack"] = 2,
    [".Pop2Pack"] = 2,
    [".Pop3Pack"] = 2,
    [".PopBottlePack"] = 2,
    [".BeerPack"] = 2,
    [".BeerBottlePack"] = 2,
    [".WaterBottlePack"] = 2,
}

local ALCOHOL_WEIGHT = {
    [".WhiskeyBottledPack"] = 2,
    [".WineBottledPack"] = 2,
    [".Wine2BottledPack"] = 2,
}


-- Seasoing

insertDistTable(ProceduralDistributions.list["BurgerKitchenButcher"], SEASONING_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["FishChipsKitchenButcher"], SEASONING_WEIGHT, 4);
insertDistTable(ProceduralDistributions.list["ItalianKitchenButcher"], SEASONING_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["JaysKitchenButcher"], SEASONING_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["KitchenDryFood"], SEASONING_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["MexicanKitchenButcher"], SEASONING_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["SeafoodKitchenButcher"], SEASONING_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["StoreKitchenButcher"], SEASONING_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["WesternKitchenButcher"], SEASONING_WEIGHT, 2);

insertDistTable(ProceduralDistributions.list["StoreShelfSpices"], SEASONING_WEIGHT, 5);


-- Drinks
insertDistTable(ProceduralDistributions.list["FridgeBottles"], POP_BEER_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["GigamartBottles"], POP_BEER_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["StoreShelfSnacks"], POP_BEER_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["KitchenBottles"], POP_BEER_WEIGHT, 1);
insertDistTable(VehicleDistributions.Spiffo["TruckBed"], POP_BEER_WEIGHT, 1)

insertDistTable(ProceduralDistributions.list["GigamartBottles"], ALCOHOL_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["StoreShelfSnacks"], ALCOHOL_WEIGHT, 2);