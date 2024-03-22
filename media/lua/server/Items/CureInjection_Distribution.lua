require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"


local ITEMS_WEIGHT = {
    [".CureInjection"]= 1,
}


RC.insertDistTable(ProceduralDistributions.list["MedicalStorageDrugs"], ITEMS_WEIGHT, 0.05)
RC.insertDistTable(ProceduralDistributions.list["MedicalClinicDrugs"], ITEMS_WEIGHT, 0.05)
RC.insertDistTable(ProceduralDistributions.list["ArmyStorageMedical"], ITEMS_WEIGHT, 25)

RC.insertDistTable(SuburbsDistributions.all.Outfit_Doctor, ITEMS_WEIGHT, 0.5)

SuburbsDistributions.all.Outfit_HazardSuit = {
	rolls = 1,
	items = {
		"FirstAidKit", 5,
		"Gloves_Surgical", 5,
		"Pistol1", 15,
		"Pistol2", 15,
		"Pistol3", 10,
		RC.getPackageItemType(".CureInjection"), 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	}
}

-- NO NEED those, already put in distributions
-- -- Zombie Drops
-- function CheckCureInjectionZombieDrops(zombie)
-- 	if not zombie:getOutfitName() then return false end
-- 	local outfit = tostring(zombie:getOutfitName())
-- 	if outfit == "HazardSuit" then
-- 		local inv = zombie:getInventory()
-- 		if RC.predicateLootChance(getPlayer(), ZombRand(1, 25)) then
-- 			inv:AddItems(RC.getPackageItemType(".CureInjection"), 1)
-- 		end
-- 	end
-- end

-- Events.OnZombieDead.Add(CheckCureInjectionZombieDrops)