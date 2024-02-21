require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"
require "utils"


local loot_chance = SandboxVars.RavenCraft.LootChance;
local loot_chance_percent = loot_chance / 100;

local BOOKS_WEIGHT = {
    [".BookWeaponAiming1"] = 2 * loot_chance_percent,
    [".BookWeaponAiming2"] = 2 * loot_chance_percent,
    [".BookWeaponAiming3"] = 2 * loot_chance_percent,
    [".BookWeaponReloading1"] = 2 * loot_chance_percent,
}


--- Books ---
utils.insertDistribution(ProceduralDistributions.list["BookstoreMisc"], BOOKS_WEIGHT, 4);
utils.insertDistribution(ProceduralDistributions.list["BookstoreBooks"], BOOKS_WEIGHT, 4);
utils.insertDistribution(ProceduralDistributions.list["ClassroomMisc"], BOOKS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["ClassroomShelves"], BOOKS_WEIGHT, 1);

utils.insertDistribution(ProceduralDistributions.list["CrateBooks"], BOOKS_WEIGHT, 3);
utils.insertDistribution(ProceduralDistributions.list["LibraryBooks"], BOOKS_WEIGHT, 4);
utils.insertDistribution(ProceduralDistributions.list["LivingRoomShelf"], BOOKS_WEIGHT, 0.5);
utils.insertDistribution(ProceduralDistributions.list["LivingRoomShelfNoTapes"], BOOKS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["PostOfficeBooks"], BOOKS_WEIGHT, 3);
utils.insertDistribution(ProceduralDistributions.list["ShelfGeneric"], BOOKS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["ToolStoreBooks"], BOOKS_WEIGHT, 4);
