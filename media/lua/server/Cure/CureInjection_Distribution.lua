require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"
require "utils"

local loot_chance = SandboxVars.RavenCraft.LootChance;
local loot_chance_percent = loot_chance / 100;

local ITEMS_WEIGHT = {
    [".CureInjection"]= 2 * loot_chance_percent,
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
		if loot_chance >= ZombRand(1, 100) then
			inv:AddItems(PACKAGE_NAME..".CureInjection", 1);
		end
	end
end

Events.OnZombieDead.Add(CheckCureInjectionZombieDrops);