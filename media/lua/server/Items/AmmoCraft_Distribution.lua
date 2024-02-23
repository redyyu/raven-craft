require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"
require "utils"

local loot_chance = SandboxVars.RavenCraft.LootChance;
local loot_chance_percent = loot_chance / 100;

local ITEMS_WEIGHT = {
    [".AmmoMakerMag"] = 1.6 * loot_chance_percent,
    [".38SpecialBulletsMold"] = 0.8 * loot_chance_percent,
    [".9mmBulletsMold"] = 0.8 * loot_chance_percent,
    [".45AutoBulletsMold"] = 0.8 * loot_chance_percent,
    [".44MagnumBulletsMold"] = 0.6 * loot_chance_percent,
    [".ShotgunShellsMold"] = 0.6 * loot_chance_percent,
    [".223BulletsMold"] = 0.6 * loot_chance_percent,
    [".308BulletsMold"] = 0.6 * loot_chance_percent,
    [".556BulletsMold"] = 0.4 * loot_chance_percent,
}


insertDistTable(VehicleDistributions["GloveBox"], ITEMS_WEIGHT, 0.1);

----------------------------

insertDistTable(SuburbsDistributions["SurvivorCache1"]["SurvivorCrate"], ITEMS_WEIGHT, 3);
insertDistTable(SuburbsDistributions["SurvivorCache2"]["SurvivorCrate"], ITEMS_WEIGHT, 3);
insertDistTable(VehicleDistributions["SurvivalistTruckBed"], ITEMS_WEIGHT, 2);
insertDistTable(VehicleDistributions["SurvivalistGlovebox"], ITEMS_WEIGHT, 4);
insertDistTable(ProceduralDistributions.list["SurvivalGear"], ITEMS_WEIGHT, 4);


----------------------------

insertDistTable(ProceduralDistributions.list["GarageFirearms"], ITEMS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["GunStoreAmmunition"], ITEMS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["GunStoreCounter"], ITEMS_WEIGHT, 0.5);
insertDistTable(ProceduralDistributions.list["GunStoreShelf"], ITEMS_WEIGHT, 0.5);
insertDistTable(ProceduralDistributions.list["Hunter"], ITEMS_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["SafehouseArmor"], ITEMS_WEIGHT, 6);
insertDistTable(ProceduralDistributions.list["SafehouseTraps"], ITEMS_WEIGHT, 6);

----------------------------

insertDistTable(ProceduralDistributions.list["ArmySurplusMisc"], ITEMS_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["ArmySurplusTools"], ITEMS_WEIGHT, 4);
insertDistTable(ProceduralDistributions.list["ArmyHangarTools"], ITEMS_WEIGHT, 4);
insertDistTable(ProceduralDistributions.list["ArmyStorageAmmunition"], ITEMS_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["ArmyStorageGuns"], ITEMS_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["ArmySurplusBackpacks"], ITEMS_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["ArmyHangarOutfit"], ITEMS_WEIGHT, 2);
insertDistTable(ProceduralDistributions.list["ArmyStorageOutfit"], ITEMS_WEIGHT, 2);

----------------------------

insertDistTable(ProceduralDistributions.list["PoliceStorageAmmunition"], ITEMS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["PoliceStorageGuns"], ITEMS_WEIGHT, 1.5);
insertDistTable(ProceduralDistributions.list["PrisonGuardLockers"], ITEMS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["PoliceLockers"], ITEMS_WEIGHT, 0.2);
insertDistTable(ProceduralDistributions.list["PawnShopGuns"], ITEMS_WEIGHT, 3);
insertDistTable(ProceduralDistributions.list["PawnShopGunsSpecial"], ITEMS_WEIGHT, 2.5);
----------------------------

insertDistTable(ProceduralDistributions.list["JanitorTools"], ITEMS_WEIGHT, 3);

----------------------------

insertDistTable(ProceduralDistributions.list["MechanicShelfTools"], ITEMS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["MechanicShelfMisc"], ITEMS_WEIGHT, 1);
insertDistTable(ProceduralDistributions.list["GarageMechanics"], ITEMS_WEIGHT, 1.5);

----------------------------

insertDistTable(ProceduralDistributions.list["GarageMetalwork"], ITEMS_WEIGHT, 1);

----------------------------

insertDistTable(ProceduralDistributions.list["GarageTools"], ITEMS_WEIGHT, 0.5);


insertDistTable(ProceduralDistributions.list["CabinetFactoryTools"], ITEMS_WEIGHT, 0.2);
insertDistTable(ProceduralDistributions.list["CrateTools"], ITEMS_WEIGHT, 0.1);


------------- Magazine ---------------

insertDistTable(ProceduralDistributions.list["GunStoreDisplayCase"], ".AmmoMakerMag", 6)
insertDistTable(ProceduralDistributions.list["GunStoreMagazineRack"], ".AmmoMakerMag", 6)
insertDistTable(ProceduralDistributions.list["BinGeneric"], ".AmmoMakerMag", 0.3)
insertDistTable(ProceduralDistributions.list["BookstoreMisc"], ".AmmoMakerMag", 0.5)
insertDistTable(ProceduralDistributions.list["CabinetFactoryTools"], ".AmmoMakerMag", 0.3)
insertDistTable(ProceduralDistributions.list["CrateBooks"], ".AmmoMakerMag", 0.5)
insertDistTable(ProceduralDistributions.list["CrateCarpentry"], ".AmmoMakerMag", 0.2)
insertDistTable(ProceduralDistributions.list["CrateMagazines"], ".AmmoMakerMag", 2)
insertDistTable(ProceduralDistributions.list["CrateTools"], ".AmmoMakerMag", 0.2)
insertDistTable(ProceduralDistributions.list["FactoryLockers"], ".AmmoMakerMag", 0.1)

insertDistTable(ProceduralDistributions.list["CampingStoreBooks"], ".AmmoMakerMag", 1)
insertDistTable(ProceduralDistributions.list["LibraryBooks"], ".AmmoMakerMag", 0.5)
insertDistTable(ProceduralDistributions.list["LivingRoomShelf"], ".AmmoMakerMag", 0.1)
insertDistTable(ProceduralDistributions.list["LivingRoomShelfNoTapes"], ".AmmoMakerMag", 0.1)
insertDistTable(ProceduralDistributions.list["LivingRoomSideTable"], ".AmmoMakerMag", 0.1)
insertDistTable(ProceduralDistributions.list["LivingRoomSideTableNoRemote"], ".AmmoMakerMag", 0.1)


insertDistTable(ProceduralDistributions.list["MagazineRackMixed"], ".AmmoMakerMag", 1)
insertDistTable(ProceduralDistributions.list["PostOfficeMagazines"], ".AmmoMakerMag", 0.1)
insertDistTable(ProceduralDistributions.list["ShelfGeneric"], ".AmmoMakerMag", 0.1)
insertDistTable(ProceduralDistributions.list["ToolStoreBooks"], ".AmmoMakerMag", 0.5)
insertDistTable(ProceduralDistributions.list["ToolStoreBooks"], ".AmmoMakerMag", 0.5)

insertDistTable(SuburbsDistributions["all"]["postbox"], ".AmmoMakerMag", 0.01)
insertDistTable(SuburbsDistributions["all"]["sidetable"], ".AmmoMakerMag", 0.01)
