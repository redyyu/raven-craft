require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"
require "utils"

local loot_chance = SandboxVars.RavenCraft.LootChance;
local loot_chance_percent = loot_chance / 100;

local ITEMS_WEIGHT = {
    [".BoxOfSalt"] = 6 * loot_chance_percent,
    [".Salt"] = 2 * loot_chance_percent,
}


insertDistTable(ProceduralDistributions.list["BurgerKitchenButcher"], ITEMS_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["FishChipsKitchenButcher"], ITEMS_WEIGHT, 4);
insertDistTable(ProceduralDistributions.list["ItalianKitchenButcher"], ITEMS_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["JaysKitchenButcher"], ITEMS_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["KitchenDryFood"], ITEMS_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["MexicanKitchenButcher"], ITEMS_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["SeafoodKitchenButcher"], ITEMS_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["StoreKitchenButcher"], ITEMS_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["WesternKitchenButcher"], ITEMS_WEIGHT, 2);

insertDistTable(ProceduralDistributions.list["StoreShelfSpices"], ITEMS_WEIGHT, 5);
