function OnTake_CureInjection(food, player, percent)
	local bodyDamage = player:getBodyDamage();
	if bodyDamage:IsInfected() and bodyDamage:getInfectionLevel() > 0 then
		if bodyDamage:getInfectionLevel() <= 25 then
			ExecCureInjection(bodyDamage, 1.0);
		else
			ExecCureInjection(bodyDamage, (bodyDamage:getInfectionLevel() - 25) / 200);
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


function ExecCureInjection(bodyDamage, chance_percent)
	local cure_chance = SandboxVars.RavenCraft.CureChance;
	if cure_chance * chance_percent > ZombRand(1, 100) then
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