require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"


local ITEMS_WEIGHT = {
    [".ArmorPadsMakerMag"] = 0.1,
    [".ElbowPads"] = 1,
    [".KneePads"] = 1,
    [".ShoulderPads"] = 1,
    [".HandPads"] = 1,
    [".NeckPads"] = 1,
    [".Hat_TacticalMask_TINT"] = 0.5,
    [".Hat_TacticalMask_CatTINT"] = 0.5,
    [".Hat_TacticalMask_Carbon"] = 0.25,
    [".Hat_TacticalMask_Jason"] = 0.25,
    [".Hat_TacticalMask_Spider"] = 0.25,
    [".Hat_TacticalMask_Punisher"] = 0.25,
}

local LITERATURES_WEIGHT = {
    [".ArmorPadsMakerMag"] = 2,
}

RC.insertDistTable(VehicleDistributions["GloveBox"], ITEMS_WEIGHT, 0.01);
RC.insertDistTable(VehicleDistributions["PoliceGloveBox"], ITEMS_WEIGHT, 6);
RC.insertDistTable(VehicleDistributions["PoliceTruckBed"], ITEMS_WEIGHT, 6);

----------------------------

RC.insertDistTable(SuburbsDistributions["SurvivorCache1"]["SurvivorCrate"], ITEMS_WEIGHT, 12);
RC.insertDistTable(SuburbsDistributions["SurvivorCache2"]["SurvivorCrate"], ITEMS_WEIGHT, 12);
RC.insertDistTable(VehicleDistributions["SurvivalistTruckBed"], ITEMS_WEIGHT, 10);
RC.insertDistTable(VehicleDistributions["SurvivalistGlovebox"], ITEMS_WEIGHT, 6);
RC.insertDistTable(ProceduralDistributions.list["SurvivalGear"], ITEMS_WEIGHT, 12);


----------------------------

RC.insertDistTable(ProceduralDistributions.list["GarageFirearms"], ITEMS_WEIGHT, 1);
RC.insertDistTable(ProceduralDistributions.list["GunStoreAmmunition"], ITEMS_WEIGHT, 1);
RC.insertDistTable(ProceduralDistributions.list["GunStoreCounter"], ITEMS_WEIGHT, 0.2);
RC.insertDistTable(ProceduralDistributions.list["GunStoreShelf"], ITEMS_WEIGHT, 0.2);
RC.insertDistTable(ProceduralDistributions.list["Hunter"], ITEMS_WEIGHT, 0.1);
RC.insertDistTable(ProceduralDistributions.list["SafehouseArmor"], ITEMS_WEIGHT, 20);
RC.insertDistTable(ProceduralDistributions.list["SafehouseTraps"], ITEMS_WEIGHT, 10);

----------------------------

RC.insertDistTable(ProceduralDistributions.list["ArmySurplusMisc"], ITEMS_WEIGHT, 6);
RC.insertDistTable(ProceduralDistributions.list["ArmySurplusTools"], ITEMS_WEIGHT, 1);
RC.insertDistTable(ProceduralDistributions.list["ArmyHangarTools"], ITEMS_WEIGHT, 0.5);
RC.insertDistTable(ProceduralDistributions.list["ArmyStorageAmmunition"], ITEMS_WEIGHT, 0.5);
RC.insertDistTable(ProceduralDistributions.list["ArmyStorageGuns"], ITEMS_WEIGHT, 0.5);
RC.insertDistTable(ProceduralDistributions.list["ArmySurplusBackpacks"], ITEMS_WEIGHT, 6);
RC.insertDistTable(ProceduralDistributions.list["ArmyHangarOutfit"], ITEMS_WEIGHT, 20);
RC.insertDistTable(ProceduralDistributions.list["ArmyStorageOutfit"], ITEMS_WEIGHT, 20);

----------------------------

RC.insertDistTable(ProceduralDistributions.list["PoliceStorageAmmunition"], ITEMS_WEIGHT, 1);
RC.insertDistTable(ProceduralDistributions.list["PoliceStorageGuns"], ITEMS_WEIGHT, 1);
RC.insertDistTable(ProceduralDistributions.list["PrisonGuardLockers"], ITEMS_WEIGHT, 12);
RC.insertDistTable(ProceduralDistributions.list["PoliceLockers"], ITEMS_WEIGHT, 12);
RC.insertDistTable(ProceduralDistributions.list["PoliceStorageOutfit"], ITEMS_WEIGHT, 20);

RC.insertDistTable(ProceduralDistributions.list["PawnShopGuns"], ITEMS_WEIGHT, 0.2);
RC.insertDistTable(ProceduralDistributions.list["PawnShopGunsSpecial"], ITEMS_WEIGHT, 0.2);
----------------------------

RC.insertDistTable(ProceduralDistributions.list["JanitorTools"], ITEMS_WEIGHT, 0.5);

----------------------------

RC.insertDistTable(SuburbsDistributions["all"]["postbox"], ITEMS_WEIGHT, 0.01);
RC.insertDistTable(SuburbsDistributions["all"]["sidetable"], ITEMS_WEIGHT, 0.01);


--- Literatures ---
RC.insertDistTable(ProceduralDistributions.list["BookstoreMisc"], LITERATURES_WEIGHT, 3);
RC.insertDistTable(ProceduralDistributions.list["BookstoreBooks"], LITERATURES_WEIGHT, 3);
RC.insertDistTable(ProceduralDistributions.list["CrateBooks"], LITERATURES_WEIGHT, 3);
RC.insertDistTable(ProceduralDistributions.list["CampingStoreBooks"], LITERATURES_WEIGHT, 2);
RC.insertDistTable(ProceduralDistributions.list["CrateMagazines"], LITERATURES_WEIGHT, 2);
RC.insertDistTable(ProceduralDistributions.list["Hunter"], LITERATURES_WEIGHT, 2);
RC.insertDistTable(ProceduralDistributions.list["LibraryBooks"], LITERATURES_WEIGHT, 4);
RC.insertDistTable(ProceduralDistributions.list["LivingRoomShelf"], LITERATURES_WEIGHT, 0.1);
RC.insertDistTable(ProceduralDistributions.list["LivingRoomShelfNoTapes"], LITERATURES_WEIGHT, 0.1);
RC.insertDistTable(ProceduralDistributions.list["LivingRoomSideTable"], LITERATURES_WEIGHT, 0.1);
RC.insertDistTable(ProceduralDistributions.list["LivingRoomSideTableNoRemote"], LITERATURES_WEIGHT, 0.1);
RC.insertDistTable(ProceduralDistributions.list["MagazineRackMixed"], LITERATURES_WEIGHT, 3);
RC.insertDistTable(ProceduralDistributions.list["PostOfficeMagazines"], LITERATURES_WEIGHT, 1);
RC.insertDistTable(ProceduralDistributions.list["ShelfGeneric"], LITERATURES_WEIGHT, 0.5);
RC.insertDistTable(ProceduralDistributions.list["PlankStashMagazine"], LITERATURES_WEIGHT, 3);
RC.insertDistTable(ProceduralDistributions.list["ToolStoreBooks"], LITERATURES_WEIGHT, 6);
RC.insertDistTable(ProceduralDistributions.list["ToolStoreCarpentry"], LITERATURES_WEIGHT, 6);