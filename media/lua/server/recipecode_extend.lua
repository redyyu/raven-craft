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


-- set the age of the food to the can, you need to cook it to have a 2-3 months preservation
function Recipe.OnCreate.CannedFood(items, result, player)
    -- OVERRIDE the vanilla CannedFood code. because it is Bugging.
    -- While for items, there is chance find another food with no expire age, ex. Sugar, Salt.
    -- Event the source food is founnd, it's still will replace after next loop.
    -- skip all Spice, and take lower OffAgeMax as source food.

    local food = nil;
    for i=0,items:size() - 1 do
        if instanceof(items:get(i), "Food") then
            if not items:get(i):isSpice() then
                -- print(items:get(i):getType());
                if not food or (food:getOffAgeMax() < items:get(i):getOffAgeMax()) then
                    food = items:get(i);
                    -- print("got food with age " .. food:getAge())
                end
            end
        end
    end

    -- print("new jared food age " .. food:getAge() .. " and max age " .. food:getOffAgeMax());
    if food then
        result:setAge(food:getAge());
        result:setOffAgeMax(food:getOffAgeMax());
        result:setOffAge(food:getOffAge());
    end
end


function Recipe.OnTest.IsNotRottenFood(item)
    if instanceof(item, "Food") then
        return item:getAge() < item:getOffAgeMax();
    end
    return true
end


function Recipe.OnCreate.PickleFoodMeat(items, result, player)
    local total_calories = 0;
    local total_carbohydrates = 0;
    local total_lipids = 0;
    local total_proteins = 0;
    local total_weight = 0;
    local total_actual_weight = 0;
    local total_hunger = 0;
    local total_boredom = 0;
    local total_unhappy = 0;
    local total_thirst = 0;
    local poison_power = 0;

    for i=0,items:size() - 1 do
        local tmp = items:get(i);
        if instanceof(tmp, "Food") then
            total_calories = total_calories + tmp:getCalories() * 0.75;
            total_lipids = total_lipids + tmp:getLipids() * 0.5;
            total_proteins = total_proteins + tmp:getProteins() * 0.75;
            total_carbohydrates = total_carbohydrates + tmp:getCarbohydrates() * 0.75;
            -- total_weight = total_weight + tmp:getActualWeight();
            total_hunger = total_hunger + tmp:getHungerChange() * 0.5;
            -- total_thirst = total_thirst + tmp:getThirstChangeUnmodified();
            total_boredom = total_boredom + tmp:getBoredomChangeUnmodified();
            total_unhappy = total_unhappy + tmp:getUnhappyChangeUnmodified();

            if tmp:getPoisonPower() > poison_power then
                poison_power = poison_power + tmp:getPoisonPower();
            elseif tmp:isRotten() then
                poison_power = poison_power + round(tmp:getHungerChange()/2*-100);
            end
        end
    end

    if poison_power > 0 then
        result:setName(getText("Tooltip_FOOD_WASTED_MEAT"));
        result:setCustomName(true);
        result:setUseForPoison(total_hunger);
        result:setPoisonPower(poison_power);
        result:setPoisonDetectionLevel(5);
        result:setOffAgeMax(1000000);
        total_calories = total_calories / 10;
        total_carbohydrates = total_carbohydrates / 10;
        total_lipids = total_lipids / 10;
        total_proteins = total_proteins / 10;
        total_hunger = total_hunger / 10;
        total_thirst = math.max(total_thirst * 2, 0.5);
        total_unhappy = math.max(total_unhappy * 2, 0.5);
        total_boredom = math.max(total_boredom * 2, 50);
    else
        total_unhappy = 0;
        total_boredom = 0;
    end

    total_calories = math.max(total_calories, 0);
    total_lipids = math.max(total_lipids, 0);
    total_proteins = math.max(total_proteins, 0);
    total_carbohydrates = math.max(total_carbohydrates, 0);
    -- total_weight = math.max(total_weight, 0.1);
    total_hunger = math.min(total_hunger, -0.01);

    result:setAge(0);
    result:setCalories(total_calories);
    result:setLipids(total_lipids);
    result:setProteins(total_proteins);
    result:setCarbohydrates(total_carbohydrates);
    result:setActualWeight(total_weight);
    -- result:setWeight(total_weight);
    result:setHungChange(total_hunger);
    result:setThirstChange(0.75);
    result:setBoredomChange(total_boredom or total_unhappy);
    result:setUnhappyChange(total_unhappy);
end


function Recipe.OnGiveXP.Training(recipe, ingredients, result, player)
    local training_type = result:getType();
    local perks_type = nil;
    local xp_gain = 0;

    if training_type == 'BookFirstAid1' then
        perks_type = Perks.Doctor;
        xp_gain = 10;
    elseif training_type == 'BookFirstAid2' then
        perks_type = Perks.Doctor;
        xp_gain = 20;
    elseif training_type == 'BookFirstAid3' then
        perks_type = Perks.Doctor;
        xp_gain = 30;
    elseif training_type == 'BookTailoring1' then
        perks_type = Perks.Tailoring;
        xp_gain = 10;
    elseif training_type == 'BookTailoring2' then
        perks_type = Perks.Tailoring;
        xp_gain = 20;
    elseif training_type == 'BookTailoring3' then
        perks_type = Perks.Tailoring;
        xp_gain = 30;
    elseif training_type == 'BookMechanic1' then
        perks_type = Perks.Mechanics;
        xp_gain = 10;
    elseif training_type == 'BookMechanic2' then
        perks_type = Perks.Mechanics;
        xp_gain = 20;
    elseif training_type == 'BookMechanic3' then
        perks_type = Perks.Mechanics;
        xp_gain = 30;
    end
    if perks_type then
        if player:getPerkLevel(perks_type) >= 6 then
            xp_gain = xp_gain / 10;
        end
        if xp_gain > 0 then
            player:getXp():AddXP(perks_type, xp_gain);
        end
    end
end


function Recipe.OnGiveXP.TrainingMeleeWeapon(recipe, ingredients, result, player)
    local training_Categories = result:getCategories();
    local perks_type = nil;
    local item = nil;
    local preks_level = 0;
    local xp_gain = 1;
    local condition = 0;

    if training_Categories:contains("Axe") then
        perks_type = Perks.Axe;
    elseif training_Categories:contains("SmallBlade") then
        perks_type = Perks.SmallBlade;
    elseif training_Categories:contains("LongBlade") then
        perks_type = Perks.LongBlade;
    elseif training_Categories:contains("SmallBlunt") then
        perks_type = Perks.SmallBlunt;
    elseif training_Categories:contains("Blunt") then
        perks_type = Perks.Blunt;
    elseif training_Categories:contains("Spear") then
        perks_type = Perks.Spear;
    end

    for i=1,ingredients:size() do
        item = ingredients:get(i-1);
        if item:getType() == result:getType() then
            condition = item:getCondition() - 1;
        end
    end
    
    if condition < 0 then
        condition = 0;
    end
    result:setCondition(condition);

    if perks_type then
        preks_level = player:getPerkLevel(perks_type);
        if preks_level <= 2 then
            xp_gain = (preks_level + 1) * 10;
        else
            xp_gain = 1;
        end
        print(xp_gain);
        player:getXp():AddXP(perks_type, xp_gain);
    end

end


-- function Recipe.GetItemTypes.Fertilizer(scriptItems)
--     local allScriptItems = getScriptManager():getAllItems()
--     for i=1,allScriptItems:size() do
--         local scriptItem = allScriptItems:get(i-1)
--         if scriptItem:getName() == 'Fertilizer' or scriptItem:getName() == 'CompostBag' then
--             scriptItems:add(scriptItem)
--         end
--     end
-- end
