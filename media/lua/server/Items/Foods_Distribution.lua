require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"
require "utils"

local loot_chance = SandboxVars.RavenCraft.LootChance;
local loot_chance_percent = loot_chance / 100;

local SEASONING_WEIGHT = {
    [".BoxOfSalt"] = 6 * loot_chance_percent,
    ["Salt"] = 2 * loot_chance_percent,
}

local POP_BEER_WEIGHT = {
    ["BeerCan"] = 2 * loot_chance_percent,
    ["BeerBottle"] = 2 * loot_chance_percent,
    [".PopPack"] = 2 * loot_chance_percent,
    [".Pop2Pack"] = 2 * loot_chance_percent,
    [".Pop3Pack"] = 2 * loot_chance_percent,
    [".PopBottlePack"] = 2 * loot_chance_percent,
    [".BeerPack"] = 2 * loot_chance_percent,
    [".BeerBottlePack"] = 2 * loot_chance_percent,
    [".WaterBottlePack"] = 2 * loot_chance_percent,
}

local ALCOHOL_WEIGHT = {
    [".WhiskeyBottledPack"] = 2 * loot_chance_percent,
    [".WineBottledPack"] = 2 * loot_chance_percent,
    [".Wine2BottledPack"] = 2 * loot_chance_percent,
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