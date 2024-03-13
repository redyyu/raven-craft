require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"


local ITEMS_WEIGHT = {
    [".CureInjection"]= 2,
}


insertDistTable(ProceduralDistributions.list["MedicalStorageDrugs"], ITEMS_WEIGHT, 0.05);
insertDistTable(ProceduralDistributions.list["MedicalClinicDrugs"], ITEMS_WEIGHT, 0.05);
insertDistTable(ProceduralDistributions.list["ArmyStorageMedical"], ITEMS_WEIGHT, 20);


-- Zombie Drops
function CheckCureInjectionZombieDrops(zombie)
	if not zombie:getOutfitName() then return false end
	local outfit = tostring(zombie:getOutfitName());
	if outfit == "HazardSuit" then
		local inv = zombie:getInventory();
		if predicateLootChance(getPlayer(), ZombRand(1, 25)) then
			inv:AddItems(getPackageItemType(".CureInjection"), 1);
		end
	end
end

Events.OnZombieDead.Add(CheckCureInjectionZombieDrops);