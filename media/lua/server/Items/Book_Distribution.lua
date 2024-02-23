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
insertDistTable(ProceduralDistributions.list["BookstoreMisc"], BOOKS_WEIGHT, 4);
insertDistTable(ProceduralDistributions.list["BookstoreBooks"], BOOKS_WEIGHT, 4);
insertDistTable(ProceduralDistributions.list["ClassroomMisc"], BOOKS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["ClassroomShelves"], BOOKS_WEIGHT, 1);

insertDistTable(ProceduralDistributions.list["CrateBooks"], BOOKS_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["LibraryBooks"], BOOKS_WEIGHT, 4);
insertDistTable(ProceduralDistributions.list["LivingRoomShelf"], BOOKS_WEIGHT, 0.5);
insertDistTable(ProceduralDistributions.list["LivingRoomShelfNoTapes"], BOOKS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["PostOfficeBooks"], BOOKS_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["ShelfGeneric"], BOOKS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["ToolStoreBooks"], BOOKS_WEIGHT, 4);
