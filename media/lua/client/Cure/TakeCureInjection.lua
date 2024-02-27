function OnTake_CureInjection(food, player, percent)
	local bodyDamage = player:getBodyDamage();
	if bodyDamage:IsInfected() and bodyDamage:getInfectionLevel() > 0 then
		if bodyDamage:getInfectionLevel() <= 25 then
			ExecCureInjection(player, bodyDamage, 1.0);
		else
			ExecCureInjection(player, bodyDamage, (bodyDamage:getInfectionLevel() - 25) / 100);
		end
	end

	-- whatever cure or not, fake infected anyway.
	if not bodyDamage:IsInfected() then
		bodyDamage:setIsFakeInfected(true);
	end

	-- whatever cure or not, change to very bad condition anyway.
	local player_stats = player:getStats();
	player_stats:setPanic(100);
	bodyDamage:setUnhappynessLevel(100);
	player_stats:setHunger(1.0);
	player_stats:setThirst(1.0);
	player_stats:setFatigue(1.0);
	player_stats:setStress(1.0);
end


function ExecCureInjection(character, bodyDamage, chance_modified)
	local rand = ZombRand(1, 100)
	local cure_chance = SandboxVars.RavenCraft.CureChance;
	if character:getTraits():contains("Lucky") then
		cure_chance = cure_chance * 1.5
	elseif character:getTraits():contains("Unlucky") then
		cure_chance = cure_chance * 0.75
	end
	if cure_chance * chance_modified > rand then
		print('Cured ---------------------->')
		bodyDamage:setInfected(false);
		bodyDamage:setInfectionMortalityDuration(-1);
		bodyDamage:setInfectionTime(-1);
		bodyDamage:setInfectionLevel(0);
		local bodyParts = bodyDamage:getBodyParts();
		for i=bodyParts:size()-1, 0, -1  do
			local bodyPart = bodyParts:get(i);
			bodyPart:SetInfected(false);
		end
	end
end