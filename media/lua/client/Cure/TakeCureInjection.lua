function OnTake_CureInjection(food, player, percent)
	local bodyDamage = player:getBodyDamage()
	local cured = false
	if bodyDamage:IsInfected() and bodyDamage:getInfectionLevel() > 0 then
		if bodyDamage:getInfectionLevel() <= 25 then
			cured = ExecCureInjection(player, bodyDamage, 1.0);
		else
			cured = ExecCureInjection(player, bodyDamage, (75 - bodyDamage:getInfectionLevel()) / 100);
		end
	end

	-- whatever cure or not, fake infected anyway.
	if not bodyDamage:IsInfected() then
		bodyDamage:setIsFakeInfected(true);
	end

	-- whatever cure or not, change to very bad condition anyway.
	local player_stats = player:getStats()
	player_stats:setPanic(100)
	bodyDamage:setUnhappynessLevel(100)
	player_stats:setFatigue(1.0)
	player_stats:setStress(1.0)

	local cure_chance = SandboxVars.RavenCraft.CureChance;

	if cured or ZombRand(1, 100) > cure_chance then
		-- more stats showing up when cured.
		-- chance can be fake cured base on CureChance option in MOD sandbox settings.
		player_stats:setHunger(1.0)
		player_stats:setThirst(1.0)
		player_stats:setEndurance(0.1)
	end

end


function ExecCureInjection(character, bodyDamage, modifier)
	local rand = ZombRand(1, 100)
	local cure_chance = SandboxVars.RavenCraft.CureChance;
	if character:getTraits():contains("Lucky") then
		cure_chance = cure_chance * 1.5
	elseif character:getTraits():contains("Unlucky") then
		cure_chance = cure_chance * 0.75
	end

	local modified_cure_chance = cure_chance * modifier
	if isDebugEnabled() then
		print('---------------------- CureInjection ----------------------')
		print('Chance of Cure: '..modified_cure_chance..' / '..cure_chance)
		print('Chance modified by: '..modifier)
		print('Must be than: '..rand)
		print('is Cured: '..(modified_cure_chance > rand and 'yes' or 'no'))
		print('-----------------------------------------------------------')
	end
	if modified_cure_chance > rand then
		bodyDamage:setInfected(false);
		bodyDamage:setInfectionMortalityDuration(-1);
		bodyDamage:setInfectionTime(-1);
		bodyDamage:setInfectionLevel(0);
		local bodyParts = bodyDamage:getBodyParts();
		for i=bodyParts:size()-1, 0, -1  do
			local bodyPart = bodyParts:get(i);
			bodyPart:SetInfected(false);
		end
		return true
	end
	return false
end