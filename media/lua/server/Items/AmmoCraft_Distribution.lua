require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"
require "utils"

local ITEMS_WEIGHT = {
    [".AmmoMakerMag"]=1,
    [".38SpecialBulletsMold"]=0.8,
    [".9mmBulletsMold"]=0.8,
    [".45AutoBulletsMold"]=0.8,
    [".44MagnumBulletsMold"]=0.6,
    [".ShotgunShellsMold"]=0.6,
    [".223BulletsMold"]=0.6,
    [".308BulletsMold"]=0.6,
    [".556mmBulletsMold"]=0.4,
}

local rate_default = 1;
local rate_survivor = 10;
local rate_firearm = 3;
local rate_army = 2.5;
local rate_janitor = 2;
local rate_police = 1.5;
local rate_mac = 1;
local rate_metal = 1;


utils.insertDistribution(VehicleDistributions["GloveBox"], ITEMS_WEIGHT, 0.1);

----------------------------

utils.insertDistribution(SuburbsDistributions["SurvivorCache1"]["SurvivorCrate"], ITEMS_WEIGHT, rate_survivor);
utils.insertDistribution(SuburbsDistributions["SurvivorCache2"]["SurvivorCrate"], ITEMS_WEIGHT, rate_survivor);
utils.insertDistribution(VehicleDistributions["SurvivalistTruckBed"], ITEMS_WEIGHT, rate_survivor);
utils.insertDistribution(VehicleDistributions["SurvivalistGlovebox"], ITEMS_WEIGHT, rate_survivor);
utils.insertDistribution(ProceduralDistributions.list["SurvivalGear"], ITEMS_WEIGHT, rate_survivor);


----------------------------

utils.insertDistribution(ProceduralDistributions.list["GarageFirearms"], ITEMS_WEIGHT, rate_firearm);
utils.insertDistribution(ProceduralDistributions.list["GunStoreAmmunition"], ITEMS_WEIGHT, rate_firearm);
utils.insertDistribution(ProceduralDistributions.list["GunStoreCounter"], ITEMS_WEIGHT, rate_firearm);
utils.insertDistribution(ProceduralDistributions.list["GunStoreShelf"], ITEMS_WEIGHT, rate_firearm);
utils.insertDistribution(ProceduralDistributions.list["Hunter"], ITEMS_WEIGHT, rate_firearm);
utils.insertDistribution(ProceduralDistributions.list["SafehouseArmor"], ITEMS_WEIGHT, rate_firearm);
utils.insertDistribution(ProceduralDistributions.list["SafehouseTraps"], ITEMS_WEIGHT, rate_firearm);

----------------------------

utils.insertDistribution(ProceduralDistributions.list["ArmySurplusMisc"], ITEMS_WEIGHT, rate_army);
utils.insertDistribution(ProceduralDistributions.list["ArmySurplusTools"], ITEMS_WEIGHT, rate_army);
utils.insertDistribution(ProceduralDistributions.list["ArmyHangarTools"], ITEMS_WEIGHT, rate_army);
utils.insertDistribution(ProceduralDistributions.list["ArmyStorageAmmunition"], ITEMS_WEIGHT, rate_army);
utils.insertDistribution(ProceduralDistributions.list["ArmyStorageGuns"], ITEMS_WEIGHT, rate_army);
utils.insertDistribution(ProceduralDistributions.list["ArmySurplusBackpacks"], ITEMS_WEIGHT, rate_army);
utils.insertDistribution(ProceduralDistributions.list["ArmyHangarOutfit"], ITEMS_WEIGHT, rate_army);
utils.insertDistribution(ProceduralDistributions.list["ArmyStorageOutfit"], ITEMS_WEIGHT, rate_army);

----------------------------

utils.insertDistribution(ProceduralDistributions.list["PoliceStorageAmmunition"], ITEMS_WEIGHT, rate_police);
utils.insertDistribution(ProceduralDistributions.list["PoliceStorageGuns"], ITEMS_WEIGHT, rate_police);
utils.insertDistribution(ProceduralDistributions.list["PrisonGuardLockers"], ITEMS_WEIGHT, rate_police);
utils.insertDistribution(ProceduralDistributions.list["PoliceLockers"], ITEMS_WEIGHT, rate_police);
utils.insertDistribution(ProceduralDistributions.list["PawnShopGuns"], ITEMS_WEIGHT, rate_police);
utils.insertDistribution(ProceduralDistributions.list["PawnShopGunsSpecial"], ITEMS_WEIGHT, rate_police);
----------------------------

utils.insertDistribution(ProceduralDistributions.list["JanitorTools"], ITEMS_WEIGHT, rate_janitor);

----------------------------

utils.insertDistribution(ProceduralDistributions.list["MechanicShelfTools"], ITEMS_WEIGHT, rate_mac);
utils.insertDistribution(ProceduralDistributions.list["MechanicShelfMisc"], ITEMS_WEIGHT, rate_mac);
utils.insertDistribution(ProceduralDistributions.list["GarageMechanics"], ITEMS_WEIGHT, rate_mac);

----------------------------

utils.insertDistribution(ProceduralDistributions.list["GarageMetalwork"], ITEMS_WEIGHT, rate_metal);

----------------------------

utils.insertDistribution(ProceduralDistributions.list["GarageTools"], ITEMS_WEIGHT, rate_default);


utils.insertDistribution(ProceduralDistributions.list["CabinetFactoryTools"], ITEMS_WEIGHT, rate_default);
utils.insertDistribution(ProceduralDistributions.list["CrateTools"], ITEMS_WEIGHT, rate_default);


------------- Magazine ---------------

utils.insertTable(ProceduralDistributions.list["GunStoreDisplayCase"], ".AmmoMakerMag", 6)
utils.insertTable(ProceduralDistributions.list["GunStoreMagazineRack"], ".AmmoMakerMag", 6)
utils.insertTable(ProceduralDistributions.list["BinGeneric"], ".AmmoMakerMag", 0.3)
utils.insertTable(ProceduralDistributions.list["BookstoreMisc"], ".AmmoMakerMag", 0.5)
utils.insertTable(ProceduralDistributions.list["CabinetFactoryTools"], ".AmmoMakerMag", 0.3)
utils.insertTable(ProceduralDistributions.list["CrateBooks"], ".AmmoMakerMag", 0.5)
utils.insertTable(ProceduralDistributions.list["CrateCarpentry"], ".AmmoMakerMag", 0.2)
utils.insertTable(ProceduralDistributions.list["CrateMagazines"], ".AmmoMakerMag", 2)
utils.insertTable(ProceduralDistributions.list["CrateTools"], ".AmmoMakerMag", 0.2)
utils.insertTable(ProceduralDistributions.list["FactoryLockers"], ".AmmoMakerMag", 0.1)

utils.insertTable(ProceduralDistributions.list["CampingStoreBooks"], ".AmmoMakerMag", 1)
utils.insertTable(ProceduralDistributions.list["LibraryBooks"], ".AmmoMakerMag", 0.5)
utils.insertTable(ProceduralDistributions.list["LivingRoomShelf"], ".AmmoMakerMag", 0.1)
utils.insertTable(ProceduralDistributions.list["LivingRoomShelfNoTapes"], ".AmmoMakerMag", 0.1)
utils.insertTable(ProceduralDistributions.list["LivingRoomSideTable"], ".AmmoMakerMag", 0.1)
utils.insertTable(ProceduralDistributions.list["LivingRoomSideTableNoRemote"], ".AmmoMakerMag", 0.1)


utils.insertTable(ProceduralDistributions.list["MagazineRackMixed"], ".AmmoMakerMag", 1)
utils.insertTable(ProceduralDistributions.list["PostOfficeMagazines"], ".AmmoMakerMag", 0.1)
utils.insertTable(ProceduralDistributions.list["ShelfGeneric"], ".AmmoMakerMag", 0.1)
utils.insertTable(ProceduralDistributions.list["ToolStoreBooks"], ".AmmoMakerMag", 0.5)
utils.insertTable(ProceduralDistributions.list["ToolStoreBooks"], ".AmmoMakerMag", 0.5)

utils.insertTable(SuburbsDistributions["all"]["postbox"], ".AmmoMakerMag", 0.01)
utils.insertTable(SuburbsDistributions["all"]["sidetable"], ".AmmoMakerMag", 0.01)
