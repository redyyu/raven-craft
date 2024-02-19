require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"
require "utils"

local loot_chance = SandboxVars.RavenCraft.LootChance;
local loot_chance_percent = loot_chance / 100;

local ITEMS_WEIGHT = {
    [".ArmorPadsMakerMag"] = 0.1 * loot_chance_percent,
    [".ElbowPads"] = 1 * loot_chance_percent,
    [".KneePads"] = 1 * loot_chance_percent,
    [".ShoulderPads"] = 1 * loot_chance_percent,
    [".HandPads"] = 1 * loot_chance_percent,
}

local LITERATURES_WEIGHT = {
    [".ArmorPadsMakerMag"] = 1 * loot_chance_percent,
}

utils.insertDistribution(VehicleDistributions["GloveBox"], ITEMS_WEIGHT, 0.01);
utils.insertDistribution(VehicleDistributions["PoliceGloveBox"], ITEMS_WEIGHT, 6);
utils.insertDistribution(VehicleDistributions["PoliceTruckBed"], ITEMS_WEIGHT, 6);

----------------------------

utils.insertDistribution(SuburbsDistributions["SurvivorCache1"]["SurvivorCrate"], ITEMS_WEIGHT, 12);
utils.insertDistribution(SuburbsDistributions["SurvivorCache2"]["SurvivorCrate"], ITEMS_WEIGHT, 12);
utils.insertDistribution(VehicleDistributions["SurvivalistTruckBed"], ITEMS_WEIGHT, 10);
utils.insertDistribution(VehicleDistributions["SurvivalistGlovebox"], ITEMS_WEIGHT, 6);
utils.insertDistribution(ProceduralDistributions.list["SurvivalGear"], ITEMS_WEIGHT, 12);


----------------------------

utils.insertDistribution(ProceduralDistributions.list["GarageFirearms"], ITEMS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["GunStoreAmmunition"], ITEMS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["GunStoreCounter"], ITEMS_WEIGHT, 0.2);
utils.insertDistribution(ProceduralDistributions.list["GunStoreShelf"], ITEMS_WEIGHT, 0.2);
utils.insertDistribution(ProceduralDistributions.list["Hunter"], ITEMS_WEIGHT, 0.1);
utils.insertDistribution(ProceduralDistributions.list["SafehouseArmor"], ITEMS_WEIGHT, 20);
utils.insertDistribution(ProceduralDistributions.list["SafehouseTraps"], ITEMS_WEIGHT, 10);

----------------------------

utils.insertDistribution(ProceduralDistributions.list["ArmySurplusMisc"], ITEMS_WEIGHT, 6);
utils.insertDistribution(ProceduralDistributions.list["ArmySurplusTools"], ITEMS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["ArmyHangarTools"], ITEMS_WEIGHT, 0.5);
utils.insertDistribution(ProceduralDistributions.list["ArmyStorageAmmunition"], ITEMS_WEIGHT, 0.5);
utils.insertDistribution(ProceduralDistributions.list["ArmyStorageGuns"], ITEMS_WEIGHT, 0.5);
utils.insertDistribution(ProceduralDistributions.list["ArmySurplusBackpacks"], ITEMS_WEIGHT, 6);
utils.insertDistribution(ProceduralDistributions.list["ArmyHangarOutfit"], ITEMS_WEIGHT, 20);
utils.insertDistribution(ProceduralDistributions.list["ArmyStorageOutfit"], ITEMS_WEIGHT, 20);

----------------------------

utils.insertDistribution(ProceduralDistributions.list["PoliceStorageAmmunition"], ITEMS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["PoliceStorageGuns"], ITEMS_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["PrisonGuardLockers"], ITEMS_WEIGHT, 12);
utils.insertDistribution(ProceduralDistributions.list["PoliceLockers"], ITEMS_WEIGHT, 12);
utils.insertDistribution(ProceduralDistributions.list["PoliceStorageOutfit"], ITEMS_WEIGHT, 20);

utils.insertDistribution(ProceduralDistributions.list["PawnShopGuns"], ITEMS_WEIGHT, 0.2);
utils.insertDistribution(ProceduralDistributions.list["PawnShopGunsSpecial"], ITEMS_WEIGHT, 0.2);
----------------------------

utils.insertDistribution(ProceduralDistributions.list["JanitorTools"], ITEMS_WEIGHT, 0.5);

----------------------------

utils.insertDistribution(SuburbsDistributions["all"]["postbox"], ITEMS_WEIGHT, 0.01);
utils.insertDistribution(SuburbsDistributions["all"]["sidetable"], ITEMS_WEIGHT, 0.01);


--- Literatures ---
utils.insertDistribution(ProceduralDistributions.list["BookstoreMisc"], LITERATURES_WEIGHT, 3);
utils.insertDistribution(ProceduralDistributions.list["BookstoreBooks"], LITERATURES_WEIGHT, 3);
utils.insertDistribution(ProceduralDistributions.list["CrateBooks"], LITERATURES_WEIGHT, 3);
utils.insertDistribution(ProceduralDistributions.list["CampingStoreBooks"], LITERATURES_WEIGHT, 2);
utils.insertDistribution(ProceduralDistributions.list["CrateMagazines"], LITERATURES_WEIGHT, 2);
utils.insertDistribution(ProceduralDistributions.list["Hunter"], LITERATURES_WEIGHT, 2);
utils.insertDistribution(ProceduralDistributions.list["LibraryBooks"], LITERATURES_WEIGHT, 4);
utils.insertDistribution(ProceduralDistributions.list["LivingRoomShelf"], LITERATURES_WEIGHT, 0.1);
utils.insertDistribution(ProceduralDistributions.list["LivingRoomShelfNoTapes"], LITERATURES_WEIGHT, 0.1);
utils.insertDistribution(ProceduralDistributions.list["LivingRoomSideTable"], LITERATURES_WEIGHT, 0.1);
utils.insertDistribution(ProceduralDistributions.list["LivingRoomSideTableNoRemote"], LITERATURES_WEIGHT, 0.1);
utils.insertDistribution(ProceduralDistributions.list["MagazineRackMixed"], LITERATURES_WEIGHT, 3);
utils.insertDistribution(ProceduralDistributions.list["PostOfficeMagazines"], LITERATURES_WEIGHT, 1);
utils.insertDistribution(ProceduralDistributions.list["ShelfGeneric"], LITERATURES_WEIGHT, 0.5);
utils.insertDistribution(ProceduralDistributions.list["PlankStashMagazine"], LITERATURES_WEIGHT, 3);
utils.insertDistribution(ProceduralDistributions.list["ToolStoreBooks"], LITERATURES_WEIGHT, 6);
utils.insertDistribution(ProceduralDistributions.list["ToolStoreCarpentry"], LITERATURES_WEIGHT, 6);