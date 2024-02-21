require "Items/ProceduralDistributions"
require "Items/SuburbsDistributions"
require "Vehicles/VehicleDistributions"
require "utils"


local loot_chance = SandboxVars.RavenCraft.LootChance;
local loot_chance_percent = loot_chance / 100;

local ITEMS_WEIGHT = {
    ["Shoes_BootsTINT"] = 2 * loot_chance_percent,
}

utils.insertDistribution(ProceduralDistributions.list["BandMerchShelves"], ITEMS_WEIGHT, 6);
utils.insertDistribution(ProceduralDistributions.list["BandPracticeClothing"], ITEMS_WEIGHT, 6);
utils.insertDistribution(ProceduralDistributions.list["ClosetShelfGeneric"], ITEMS_WEIGHT, 0.5);
utils.insertDistribution(ProceduralDistributions.list["ClothingStorageFootwear"], ITEMS_WEIGHT, 6);
utils.insertDistribution(ProceduralDistributions.list["ClothingStoresBoots"], ITEMS_WEIGHT, 10);
utils.insertDistribution(ProceduralDistributions.list["CrateFootwearRandom"], ITEMS_WEIGHT, 10);
utils.insertDistribution(ProceduralDistributions.list["CrateRandomJunk"], ITEMS_WEIGHT, 0.2);
utils.insertDistribution(ProceduralDistributions.list["FactoryLockers"], ITEMS_WEIGHT, 4);

utils.insertDistribution(VehicleDistributions["ClothingTruckBed"], ITEMS_WEIGHT, 0.6);

