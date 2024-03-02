require "Items/Distributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"


local ITEMS_WEIGHT = {
    ["Webbing"] = 1,
    ["ChestRig"]= 2,
	["Flashlight_Military"] = 1,
	["Canteen"] = 1,
	["Canteenfull"] = 0.25,
}

local POLICE_ITEMS_WEIGHT = {
    ["Webbing_Black"] = 1,
    ["ChestRig_Black"]= 2,
	["Flashlight_Military"] = 2,
	["Canteen"] = 2,
	["Canteenfull"] = 0.5,
}

local ARMY_ITEMS_WEIGHT = {
    ["Webbing_Military"] = 1,
    ["ChestRig_Military"] = 2,
	["Flashlight_Military"] = 2,
	["Canteen"] = 2,
	["Canteenfull"] = 0.5,
}


if ProceduralDistributions.list.DrugLabGuns then 
    insertDistTable(ProceduralDistributions.list.DrugLabGuns, ITEMS_WEIGHT, 1)
end

insertDistTable(ProceduralDistributions.list.FirearmWeapons, ITEMS_WEIGHT, 1)
insertDistTable(ProceduralDistributions.list.GarageFirearms, ITEMS_WEIGHT, 0.5)
insertDistTable(ProceduralDistributions.list.GunStoreShelf, ITEMS_WEIGHT, 0.5)
insertDistTable(ProceduralDistributions.list.PawnShopGunsSpecial, ITEMS_WEIGHT, 1)
insertDistTable(ProceduralDistributions.list.PlankStashGun, ITEMS_WEIGHT, 1)
insertDistTable(ProceduralDistributions.list.WardrobeRedneck, ITEMS_WEIGHT, 1)

insertDistTable(SuburbsDistributions.Bag_WeaponBag, ITEMS_WEIGHT, 2)
insertDistTable(SuburbsDistributions.Bag_SurvivorBag, ITEMS_WEIGHT, 15)
insertDistTable(SuburbsDistributions.Bag_ALICEpack, ITEMS_WEIGHT, 15)
insertDistTable(SuburbsDistributions.SurvivorCache1.SurvivorCrate, ITEMS_WEIGHT, 0.5)
insertDistTable(SuburbsDistributions.SurvivorCache2.SurvivorCrate, ITEMS_WEIGHT, 0.5)

insertDistTable(VehicleDistributions.SurvivalistTruckBed, ITEMS_WEIGHT, 1)
insertDistTable(VehicleDistributions.GloveBox, ITEMS_WEIGHT, 0.01)

insertDistTable(ProceduralDistributions.list.PoliceStorageOutfit, POLICE_ITEMS_WEIGHT, 1)
insertDistTable(VehicleDistributions.Police.TruckBed, POLICE_ITEMS_WEIGHT, 0.5)

insertDistTable(ProceduralDistributions.list.ArmySurplusMisc, ARMY_ITEMS_WEIGHT, 1)
insertDistTable(ProceduralDistributions.list.ArmyStorageOutfit, ARMY_ITEMS_WEIGHT, 1)
insertDistTable(ProceduralDistributions.list.LockerArmyBedroom, ARMY_ITEMS_WEIGHT, 0.5)

insertDistTable(SuburbsDistributions.Bag_ALICEpack_Army, ARMY_ITEMS_WEIGHT, 25)


insertDistTable(ProceduralDistributions.list["CampingStoreGear"], 'Canteen', 0.5)
insertDistTable(ProceduralDistributions.list["CampingStoreGear"], 'Canteenfull', 0.5)
