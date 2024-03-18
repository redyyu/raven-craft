require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"


local ITEMS_WEIGHT = {
    [".AmmoMakerMag"] = 1.6,
    [".38SpecialBulletsMold"] = 0.8,
    [".9mmBulletsMold"] = 0.8,
    [".45AutoBulletsMold"] = 0.8,
    [".44MagnumBulletsMold"] = 0.6,
    [".ShotgunShellsMold"] = 0.6,
    [".223BulletsMold"] = 0.6,
    [".308BulletsMold"] = 0.6,
    [".556BulletsMold"] = 0.4,
}


RC.insertDistTable(VehicleDistributions["GloveBox"], ITEMS_WEIGHT, 0.1);

----------------------------

RC.insertDistTable(SuburbsDistributions["SurvivorCache1"]["SurvivorCrate"], ITEMS_WEIGHT, 3);
RC.insertDistTable(SuburbsDistributions["SurvivorCache2"]["SurvivorCrate"], ITEMS_WEIGHT, 3);
RC.insertDistTable(VehicleDistributions["SurvivalistTruckBed"], ITEMS_WEIGHT, 2);
RC.insertDistTable(VehicleDistributions["SurvivalistGlovebox"], ITEMS_WEIGHT, 4);
RC.insertDistTable(ProceduralDistributions.list["SurvivalGear"], ITEMS_WEIGHT, 4);


----------------------------

RC.insertDistTable(ProceduralDistributions.list["GarageFirearms"], ITEMS_WEIGHT, 1);
RC.insertDistTable(ProceduralDistributions.list["GunStoreAmmunition"], ITEMS_WEIGHT, 1);
RC.insertDistTable(ProceduralDistributions.list["GunStoreCounter"], ITEMS_WEIGHT, 0.5);
RC.insertDistTable(ProceduralDistributions.list["GunStoreShelf"], ITEMS_WEIGHT, 0.5);
RC.insertDistTable(ProceduralDistributions.list["Hunter"], ITEMS_WEIGHT, 2);
RC.insertDistTable(ProceduralDistributions.list["SafehouseArmor"], ITEMS_WEIGHT, 6);
RC.insertDistTable(ProceduralDistributions.list["SafehouseTraps"], ITEMS_WEIGHT, 6);

----------------------------

RC.insertDistTable(ProceduralDistributions.list["ArmySurplusMisc"], ITEMS_WEIGHT, 2);
RC.insertDistTable(ProceduralDistributions.list["ArmySurplusTools"], ITEMS_WEIGHT, 4);
RC.insertDistTable(ProceduralDistributions.list["ArmyHangarTools"], ITEMS_WEIGHT, 4);
RC.insertDistTable(ProceduralDistributions.list["ArmyStorageAmmunition"], ITEMS_WEIGHT, 3);
RC.insertDistTable(ProceduralDistributions.list["ArmyStorageGuns"], ITEMS_WEIGHT, 3);
RC.insertDistTable(ProceduralDistributions.list["ArmySurplusBackpacks"], ITEMS_WEIGHT, 2);
RC.insertDistTable(ProceduralDistributions.list["ArmyHangarOutfit"], ITEMS_WEIGHT, 2);
RC.insertDistTable(ProceduralDistributions.list["ArmyStorageOutfit"], ITEMS_WEIGHT, 2);

----------------------------

RC.insertDistTable(ProceduralDistributions.list["PoliceStorageAmmunition"], ITEMS_WEIGHT, 1);
RC.insertDistTable(ProceduralDistributions.list["PoliceStorageGuns"], ITEMS_WEIGHT, 1.5);
RC.insertDistTable(ProceduralDistributions.list["PrisonGuardLockers"], ITEMS_WEIGHT, 1);
RC.insertDistTable(ProceduralDistributions.list["PoliceLockers"], ITEMS_WEIGHT, 0.2);
RC.insertDistTable(ProceduralDistributions.list["PawnShopGuns"], ITEMS_WEIGHT, 3);
RC.insertDistTable(ProceduralDistributions.list["PawnShopGunsSpecial"], ITEMS_WEIGHT, 2.5);
----------------------------

RC.insertDistTable(ProceduralDistributions.list["JanitorTools"], ITEMS_WEIGHT, 3);

----------------------------

RC.insertDistTable(ProceduralDistributions.list["MechanicShelfTools"], ITEMS_WEIGHT, 1);
RC.insertDistTable(ProceduralDistributions.list["MechanicShelfMisc"], ITEMS_WEIGHT, 1);
RC.insertDistTable(ProceduralDistributions.list["GarageMechanics"], ITEMS_WEIGHT, 1.5);

----------------------------

RC.insertDistTable(ProceduralDistributions.list["GarageMetalwork"], ITEMS_WEIGHT, 1);

----------------------------

RC.insertDistTable(ProceduralDistributions.list["GarageTools"], ITEMS_WEIGHT, 0.5);


RC.insertDistTable(ProceduralDistributions.list["CabinetFactoryTools"], ITEMS_WEIGHT, 0.2);
RC.insertDistTable(ProceduralDistributions.list["CrateTools"], ITEMS_WEIGHT, 0.1);


------------- Magazine ---------------

RC.insertDistTable(ProceduralDistributions.list["GunStoreDisplayCase"], ".AmmoMakerMag", 6)
RC.insertDistTable(ProceduralDistributions.list["GunStoreMagazineRack"], ".AmmoMakerMag", 6)
RC.insertDistTable(ProceduralDistributions.list["BinGeneric"], ".AmmoMakerMag", 0.3)
RC.insertDistTable(ProceduralDistributions.list["BookstoreMisc"], ".AmmoMakerMag", 0.5)
RC.insertDistTable(ProceduralDistributions.list["CabinetFactoryTools"], ".AmmoMakerMag", 0.3)
RC.insertDistTable(ProceduralDistributions.list["CrateBooks"], ".AmmoMakerMag", 0.5)
RC.insertDistTable(ProceduralDistributions.list["CrateCarpentry"], ".AmmoMakerMag", 0.2)
RC.insertDistTable(ProceduralDistributions.list["CrateMagazines"], ".AmmoMakerMag", 2)
RC.insertDistTable(ProceduralDistributions.list["CrateTools"], ".AmmoMakerMag", 0.2)
RC.insertDistTable(ProceduralDistributions.list["FactoryLockers"], ".AmmoMakerMag", 0.1)

RC.insertDistTable(ProceduralDistributions.list["CampingStoreBooks"], ".AmmoMakerMag", 1)
RC.insertDistTable(ProceduralDistributions.list["LibraryBooks"], ".AmmoMakerMag", 0.5)
RC.insertDistTable(ProceduralDistributions.list["LivingRoomShelf"], ".AmmoMakerMag", 0.1)
RC.insertDistTable(ProceduralDistributions.list["LivingRoomShelfNoTapes"], ".AmmoMakerMag", 0.1)
RC.insertDistTable(ProceduralDistributions.list["LivingRoomSideTable"], ".AmmoMakerMag", 0.1)
RC.insertDistTable(ProceduralDistributions.list["LivingRoomSideTableNoRemote"], ".AmmoMakerMag", 0.1)


RC.insertDistTable(ProceduralDistributions.list["MagazineRackMixed"], ".AmmoMakerMag", 1)
RC.insertDistTable(ProceduralDistributions.list["PostOfficeMagazines"], ".AmmoMakerMag", 0.1)
RC.insertDistTable(ProceduralDistributions.list["ShelfGeneric"], ".AmmoMakerMag", 0.1)
RC.insertDistTable(ProceduralDistributions.list["ToolStoreBooks"], ".AmmoMakerMag", 0.5)
RC.insertDistTable(ProceduralDistributions.list["ToolStoreBooks"], ".AmmoMakerMag", 0.5)

RC.insertDistTable(SuburbsDistributions["all"]["postbox"], ".AmmoMakerMag", 0.01)
RC.insertDistTable(SuburbsDistributions["all"]["sidetable"], ".AmmoMakerMag", 0.01)
