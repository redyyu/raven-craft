-- get the weapon, lower its condition according to Maintenance perk level
function Recipe.OnCreate.CraftWeapon(items, result, player)
    local conditionMax = player:getPerkLevel(Perks.Maintenance);
    conditionMax = ZombRand(0, conditionMax * 2);
    if conditionMax > result:getConditionMax() then
        conditionMax = result:getConditionMax();
    end
    if conditionMax < 0 then
        conditionMax = 0;
    end
    result:setCondition(conditionMax)
end
