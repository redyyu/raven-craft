require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"


local BOOKS_WEIGHT = {
    [".BookWeaponAiming"] = 1,
    [".BookWeaponReloading"] = 1,
    [".BookWeaponLongBlade"] = 1,
    [".BookWeaponSmallBlade"] = 1,
    [".BookWeaponBlunt"] = 1,
    [".BookWeaponSmallBlunt"] = 1,
    [".BookWeaponAxe"] = 1,
    [".BookWeaponSpear"] = 1,
}


--- Books ---
RC.insertDistTable(ProceduralDistributions.list["BookstoreMisc"], BOOKS_WEIGHT, 2);
RC.insertDistTable(ProceduralDistributions.list["BookstoreBooks"], BOOKS_WEIGHT, 2);
RC.insertDistTable(ProceduralDistributions.list["ClassroomMisc"], BOOKS_WEIGHT, 1);
RC.insertDistTable(ProceduralDistributions.list["ClassroomShelves"], BOOKS_WEIGHT, 1);

RC.insertDistTable(ProceduralDistributions.list["CrateBooks"], BOOKS_WEIGHT, 1);
RC.insertDistTable(ProceduralDistributions.list["LibraryBooks"], BOOKS_WEIGHT, 2);
RC.insertDistTable(ProceduralDistributions.list["LivingRoomShelf"], BOOKS_WEIGHT, 0.25);
RC.insertDistTable(ProceduralDistributions.list["LivingRoomShelfNoTapes"], BOOKS_WEIGHT, 0.5);
RC.insertDistTable(ProceduralDistributions.list["PostOfficeBooks"], BOOKS_WEIGHT, 2);
RC.insertDistTable(ProceduralDistributions.list["ShelfGeneric"], BOOKS_WEIGHT, 0.25);
RC.insertDistTable(ProceduralDistributions.list["ToolStoreBooks"], BOOKS_WEIGHT, 1);
