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

insertDistTable(VehicleDistributions["GloveBox"], ITEMS_WEIGHT, 0.01);
insertDistTable(VehicleDistributions["PoliceGloveBox"], ITEMS_WEIGHT, 6);
insertDistTable(VehicleDistributions["PoliceTruckBed"], ITEMS_WEIGHT, 6);

----------------------------

insertDistTable(SuburbsDistributions["SurvivorCache1"]["SurvivorCrate"], ITEMS_WEIGHT, 12);
insertDistTable(SuburbsDistributions["SurvivorCache2"]["SurvivorCrate"], ITEMS_WEIGHT, 12);
insertDistTable(VehicleDistributions["SurvivalistTruckBed"], ITEMS_WEIGHT, 10);
insertDistTable(VehicleDistributions["SurvivalistGlovebox"], ITEMS_WEIGHT, 6);
insertDistTable(ProceduralDistributions.list["SurvivalGear"], ITEMS_WEIGHT, 12);


----------------------------

insertDistTable(ProceduralDistributions.list["GarageFirearms"], ITEMS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["GunStoreAmmunition"], ITEMS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["GunStoreCounter"], ITEMS_WEIGHT, 0.2);
insertDistTable(ProceduralDistributions.list["GunStoreShelf"], ITEMS_WEIGHT, 0.2);
insertDistTable(ProceduralDistributions.list["Hunter"], ITEMS_WEIGHT, 0.1);
insertDistTable(ProceduralDistributions.list["SafehouseArmor"], ITEMS_WEIGHT, 20);
insertDistTable(ProceduralDistributions.list["SafehouseTraps"], ITEMS_WEIGHT, 10);

----------------------------

insertDistTable(ProceduralDistributions.list["ArmySurplusMisc"], ITEMS_WEIGHT, 6);
insertDistTable(ProceduralDistributions.list["ArmySurplusTools"], ITEMS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["ArmyHangarTools"], ITEMS_WEIGHT, 0.5);
insertDistTable(ProceduralDistributions.list["ArmyStorageAmmunition"], ITEMS_WEIGHT, 0.5);
insertDistTable(ProceduralDistributions.list["ArmyStorageGuns"], ITEMS_WEIGHT, 0.5);
insertDistTable(ProceduralDistributions.list["ArmySurplusBackpacks"], ITEMS_WEIGHT, 6);
insertDistTable(ProceduralDistributions.list["ArmyHangarOutfit"], ITEMS_WEIGHT, 20);
insertDistTable(ProceduralDistributions.list["ArmyStorageOutfit"], ITEMS_WEIGHT, 20);

----------------------------

insertDistTable(ProceduralDistributions.list["PoliceStorageAmmunition"], ITEMS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["PoliceStorageGuns"], ITEMS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["PrisonGuardLockers"], ITEMS_WEIGHT, 12);
insertDistTable(ProceduralDistributions.list["PoliceLockers"], ITEMS_WEIGHT, 12);
insertDistTable(ProceduralDistributions.list["PoliceStorageOutfit"], ITEMS_WEIGHT, 20);

insertDistTable(ProceduralDistributions.list["PawnShopGuns"], ITEMS_WEIGHT, 0.2);
insertDistTable(ProceduralDistributions.list["PawnShopGunsSpecial"], ITEMS_WEIGHT, 0.2);
----------------------------

insertDistTable(ProceduralDistributions.list["JanitorTools"], ITEMS_WEIGHT, 0.5);

----------------------------

insertDistTable(SuburbsDistributions["all"]["postbox"], ITEMS_WEIGHT, 0.01);
insertDistTable(SuburbsDistributions["all"]["sidetable"], ITEMS_WEIGHT, 0.01);


--- Literatures ---
insertDistTable(ProceduralDistributions.list["BookstoreMisc"], LITERATURES_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["BookstoreBooks"], LITERATURES_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["CrateBooks"], LITERATURES_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["CampingStoreBooks"], LITERATURES_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["CrateMagazines"], LITERATURES_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["Hunter"], LITERATURES_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["LibraryBooks"], LITERATURES_WEIGHT, 4);
insertDistTable(ProceduralDistributions.list["LivingRoomShelf"], LITERATURES_WEIGHT, 0.1);
insertDistTable(ProceduralDistributions.list["LivingRoomShelfNoTapes"], LITERATURES_WEIGHT, 0.1);
insertDistTable(ProceduralDistributions.list["LivingRoomSideTable"], LITERATURES_WEIGHT, 0.1);
insertDistTable(ProceduralDistributions.list["LivingRoomSideTableNoRemote"], LITERATURES_WEIGHT, 0.1);
insertDistTable(ProceduralDistributions.list["MagazineRackMixed"], LITERATURES_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["PostOfficeMagazines"], LITERATURES_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["ShelfGeneric"], LITERATURES_WEIGHT, 0.5);
insertDistTable(ProceduralDistributions.list["PlankStashMagazine"], LITERATURES_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["ToolStoreBooks"], LITERATURES_WEIGHT, 6);
insertDistTable(ProceduralDistributions.list["ToolStoreCarpentry"], LITERATURES_WEIGHT, 6);