require "Items/Distributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"


local ITEMS_WEIGHT = {
    ["Webbing"] = 1,
    ["ChestRig"]= 1,
	["Flashlight_Military"] = 1,
	["Canteen"] = 1,
	["Canteenfull"] = 0.25,
}

local POLICE_ITEMS_WEIGHT = {
    ["Webbing"] = 1.5,
    ["ChestRig"]= 1.5,
	["Flashlight_Military"] = 1.5,
	["Canteen"] = 1.5,
	["Canteenfull"] = 0.5,
}

local ARMY_ITEMS_WEIGHT = {
    ["Webbing"] = 2,
    ["ChestRig"] = 2,
	["Flashlight_Military"] = 2,
	["Canteen"] = 2,
	["Canteenfull"] = 0.75,
}


if ProceduralDistributions.list.DrugLabGuns then 
    RC.insertDistTable(ProceduralDistributions.list.DrugLabGuns, ITEMS_WEIGHT, 0.5)
end

RC.insertDistTable(ProceduralDistributions.list.FirearmWeapons, ITEMS_WEIGHT, 0.5)
RC.insertDistTable(ProceduralDistributions.list.GarageFirearms, ITEMS_WEIGHT, 0.25)
RC.insertDistTable(ProceduralDistributions.list.GunStoreShelf, ITEMS_WEIGHT, 0.25)
RC.insertDistTable(ProceduralDistributions.list.PawnShopGunsSpecial, ITEMS_WEIGHT, 0.5)
RC.insertDistTable(ProceduralDistributions.list.PlankStashGun, ITEMS_WEIGHT, 0.5)
RC.insertDistTable(ProceduralDistributions.list.WardrobeRedneck, ITEMS_WEIGHT, 0.5)

RC.insertDistTable(SuburbsDistributions.Bag_WeaponBag, ITEMS_WEIGHT, 1)
RC.insertDistTable(SuburbsDistributions.Bag_SurvivorBag, ITEMS_WEIGHT, 5)
RC.insertDistTable(SuburbsDistributions.Bag_ALICEpack, ITEMS_WEIGHT, 5)
RC.insertDistTable(SuburbsDistributions.SurvivorCache1.SurvivorCrate, ITEMS_WEIGHT, 0.25)
RC.insertDistTable(SuburbsDistributions.SurvivorCache2.SurvivorCrate, ITEMS_WEIGHT, 0.25)

RC.insertDistTable(VehicleDistributions.SurvivalistTruckBed, ITEMS_WEIGHT, 2)
RC.insertDistTable(VehicleDistributions.GloveBox, ITEMS_WEIGHT, 0.01)

RC.insertDistTable(ProceduralDistributions.list.PoliceStorageOutfit, POLICE_ITEMS_WEIGHT, 1)
RC.insertDistTable(VehicleDistributions.Police.TruckBed, POLICE_ITEMS_WEIGHT, 1)

RC.insertDistTable(ProceduralDistributions.list.ArmySurplusMisc, ARMY_ITEMS_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list.ArmyStorageOutfit, ARMY_ITEMS_WEIGHT, 1)
RC.insertDistTable(ProceduralDistributions.list.LockerArmyBedroom, ARMY_ITEMS_WEIGHT, 0.5)

RC.insertDistTable(SuburbsDistributions.Bag_ALICEpack_Army, ARMY_ITEMS_WEIGHT, 10)


RC.insertDistTable(ProceduralDistributions.list["CampingStoreGear"], 'Canteen', 1)
RC.insertDistTable(ProceduralDistributions.list["CampingStoreGear"], 'Canteenfull', 1)
