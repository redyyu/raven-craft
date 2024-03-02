
require "recipecode"

-- check player is in somewhere have electricity
function Recipe.OnCanPerform.haveElectricity(recipe, playerObj)
    return isSquarePowered(playerObj:getCurrentSquare())
end

function Recipe.OnCanPerform.NearFurnaceFire(recipe, playerObj)
    local furnaceFireObjectNames = {
        ["StoneFurnace"] = true, 
        ["Fire"] = true, -- "Fire" includes campfires, etc.
        -- ["Campfire"] = true,  No need this, check the fire on campfire only.
        -- ["Stove"] = true, 
        -- ["Barbecue"] = true, 
        -- ["Fireplace"] = true, 
    }

    local max_distance = 1
    local curr_square = playerObj:getCurrentSquare()
    local object_tables = {}
 
    for x=curr_square:getX()-max_distance, curr_square:getX()+max_distance do
        for y=curr_square:getY()-max_distance, curr_square:getY()+max_distance do
            local gs = getCell():getGridSquare(x, y, curr_square:getZ());
            if gs then
                local gs_objects = gs:getObjects()
                for j=0, gs_objects:size()-1 do
                    local obj = gs_objects:get(j)
                    local obj_name = obj:getObjectName()
                    if furnaceFireObjectNames[obj_name] then
                        table.insert(object_tables, obj)
                    end
                end
            end
        end
    end

    for i=1, #object_tables do
        local o = object_tables[i]
        -- Is the fire still alive? Includes campfires, etc. (IsoFire)
        if (o.getLife ~= nil and o:getLife() > 0) or (o.getLightRadius ~= nil and o:getLightRadius() > 1) then
            return true
        end
        
        -- Is the fire started? (BSFurnace --> ObjectName: "StoneFurnace")
        if o.isFireStarted ~= nil and o:isFireStarted() == true then
            return true
        end

        -- -- Is the fire lit? (IsoFireplace, IsoBarbecue)
        -- if o.isLit ~= nil and o:isLit() == true then
        --     return true; -- The player is close enough to a working cooking util and can see it; return true.
        -- end
        
        -- -- Is the cooking util turned on? (IsoStove)
        -- if o.Activated ~= nil and o:Activated() == true then
        --     return true; -- The player is close enough to a working cooking util and can see it; return true.
        -- end

    end

    return false
end


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


function Recipe.OnCreate.AssembleArmorSuit(items, result, player)
    local condition_ratio = 1;
    local dirtyness = 0;
    local bloodlevel = 0;
    local wetness = 0
    
    local suitPartMap = {}
    local coveredParts = result:getCoveredParts()
    for i=0, coveredParts:size() - 1 do
        suitPartMap[coveredParts:get(i)] = true
    end
    
    for i=0, items:size() - 1 do
        local item = items:get(i)
        if item:IsClothing() then
            local cr = item:getCondition() / item:getConditionMax()
            if condition_ratio > cr then
                condition_ratio = cr
            end

            local drt = item:getDirtyness()
            if drt > dirtyness then
                dirtyness = drt
            end

            local bld = item:getBloodLevel()
            if bld > bloodlevel then
                bloodlevel = bld
            end

            local wet = item:getWetness()
            if wet > wetness then
                wetness = wet
            end

            local item_parts = item:getCoveredParts()
            for i=0, item_parts:size() - 1 do
                local p = item_parts:get(i)
                if suitPartMap[p] and item:getVisual():getHole(p) > 0 then
                    result:getVisual():setHole(p)
                end
            end
        end
    end
    
    result:setCondition(math.floor(result:getConditionMax() * condition_ratio))
    result:setDirtyness(dirtyness)
    result:setWetness(wetness)
    result:setBloodLevel(bloodlevel)
end


function Recipe.OnCreate.DisassembleArmorSuit(items, result, player)
    local condition_ratio = 1
    local dirtyness = 0
    local bloodlevel = 0
    local wetness = 0
    local suit_clothing = nil
    for i=0, items:size() - 1 do
        local item = items:get(i)
        if item:IsClothing() then
            local cr = item:getCondition() / item:getConditionMax()
            if condition_ratio > cr then
                condition_ratio = cr
            end

            local drt = item:getDirtyness()
            if drt > dirtyness then
                dirtyness = drt
            end

            local bld = item:getBloodLevel()
            if bld > bloodlevel then
                bloodlevel = bld
            end

            local wet = item:getWetness()
            if wet > wetness then
                wetness = wet
            end
            if item:getFullType() == getPackageItemType(".SuitPads") then
                suit_clothing = item
            end
        end
    end

    local holesMap = {}
    if suit_clothing then
        local coveredParts = suit_clothing:getCoveredParts()
        for i=0, coveredParts:size() - 1 do
            local part = coveredParts:get(i)
            holesMap[part] = suit_clothing:getVisual():getHole(part)
        end
    end

    local itemtbl = {".ElbowPads", ".KneePads", ".ShoulderPads", ".HandPads", ".NeckPads"}
    local result_item = nil

    for _, n in ipairs(itemtbl) do
        local item_type = getPackageItemType(n)
        if item_type ~= result:getFullType() then
            result_item = player:getInventory():AddItem(item_type)
        else
            result_item = result
        end
        if result_item then
            result_item:setCondition(math.floor(result_item:getConditionMax() * condition_ratio))
            result_item:setDirtyness(dirtyness)
            result_item:setWetness(wetness)
            result_item:setBloodLevel(bloodlevel)
            local parts = result_item:getCoveredParts()
            for i=0, parts:size() - 1 do
                local p = parts:get(i)
                if holesMap[p] > 0 then
                    result_item:getVisual():setHole(p)
                end
            end
        end
    end

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


-- function Recipe.OnTest.PaintBucketWater(item)
--     if item:getType() ==  "WaterPaintbucket" then
--         return item:getUsedDelta() >= 0.8;
--     end
--     return true
-- end


function Recipe.OnTest.IsNotRottenFood(item)
    if instanceof(item, "Food") then
        return item:getAge() < item:getOffAgeMax()
    end
    return true
end


function Recipe.OnTest.IsFullWaterBottle(item)
    if item:getType() == "WaterBottleFull" then
        return item:getUsedDelta() >= 1
    end
    return true
end


function Recipe.OnTest.isNoHolesInClothes(item)
    if instanceof(item, "Clothing") then
        return item:getHolesNumber() <= 0
    end
    return true
end


function Recipe.OnCreate.PickleFoodMeat(items, result, player)
    local total_calories = 0
    local total_carbohydrates = 0
    local total_lipids = 0
    local total_proteins = 0
    local total_weight = 0
    local total_actual_weight = 0
    local total_hunger = 0
    local total_boredom = 0
    local total_unhappy = 0
    local total_thirst = 0
    local poison_power = 0

    for i=0,items:size() - 1 do
        local tmp = items:get(i);
        if instanceof(tmp, "Food") then
            total_calories = total_calories + tmp:getCalories() * 0.75
            total_lipids = total_lipids + tmp:getLipids() * 0.5
            total_proteins = total_proteins + tmp:getProteins() * 0.75
            total_carbohydrates = total_carbohydrates + tmp:getCarbohydrates() * 0.75
            -- total_weight = total_weight + tmp:getActualWeight();
            total_hunger = total_hunger + tmp:getHungerChange() * 0.5
            -- total_thirst = total_thirst + tmp:getThirstChangeUnmodified()
            total_boredom = total_boredom + tmp:getBoredomChangeUnmodified()
            total_unhappy = total_unhappy + tmp:getUnhappyChangeUnmodified()

            if tmp:getPoisonPower() > poison_power then
                poison_power = poison_power + tmp:getPoisonPower()
            elseif tmp:isRotten() then
                poison_power = poison_power + round(tmp:getHungerChange()/2*-100)
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


function Recipe.OnGiveXP.WoodWork10(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Woodwork, 10);
end

function Recipe.OnGiveXP.WoodWork15(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Woodwork, 15);
end

function Recipe.OnGiveXP.WoodWork20(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Woodwork, 15);
end

function Recipe.OnGiveXP.WoodWork25(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Woodwork, 25);
end

function Recipe.OnGiveXP.Reloading5(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Reloading, 5);
end

function Recipe.OnGiveXP.Reloading10(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Reloading, 10);
end

function Recipe.OnGiveXP.Reloading15(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Reloading, 15);
end



-- function Recipe.OnGiveXP.Training(recipe, ingredients, result, player)
--     local training_type = result:getType();
--     local perks_type = nil;
--     local xp_gain = 0;

--     if training_type == 'BookFirstAid1' then
--         perks_type = Perks.Doctor;
--         xp_gain = 10;
--     elseif training_type == 'BookFirstAid2' then
--         perks_type = Perks.Doctor;
--         xp_gain = 20;
--     elseif training_type == 'BookFirstAid3' then
--         perks_type = Perks.Doctor;
--         xp_gain = 30;
--     elseif training_type == 'BookFirstAid4' then
--         perks_type = Perks.Doctor;
--         xp_gain = 40;
--     elseif training_type == 'BookFirstAid5' then
--         perks_type = Perks.Doctor;
--         xp_gain = 50;

--     elseif training_type == 'BookTailoring1' then
--         perks_type = Perks.Tailoring;
--         xp_gain = 10;
--     elseif training_type == 'BookTailoring2' then
--         perks_type = Perks.Tailoring;
--         xp_gain = 20;
--     elseif training_type == 'BookTailoring3' then
--         perks_type = Perks.Tailoring;
--         xp_gain = 30;
--     elseif training_type == 'BookTailoring4' then
--         perks_type = Perks.Tailoring;
--         xp_gain = 40;
--     elseif training_type == 'BookTailoring5' then
--         perks_type = Perks.Tailoring;
--         xp_gain = 50;
--     end

--     if perks_type and xp_gain ~= 0 then
--         player:getXp():AddXP(perks_type, xp_gain);
--     end
-- end


-- function Recipe.OnGiveXP.TrainingMeleeWeapon(recipe, ingredients, result, player)
--     local training_Categories = result:getCategories();
--     local perks_type = nil;
--     local item = nil;
--     local preks_level = 0;
--     local xp_gain = 1;
--     local condition = 0;

--     if training_Categories:contains("Axe") then
--         perks_type = Perks.Axe;
--     elseif training_Categories:contains("SmallBlade") then
--         perks_type = Perks.SmallBlade;
--     elseif training_Categories:contains("LongBlade") then
--         perks_type = Perks.LongBlade;
--     elseif training_Categories:contains("SmallBlunt") then
--         perks_type = Perks.SmallBlunt;
--     elseif training_Categories:contains("Blunt") then
--         perks_type = Perks.Blunt;
--     elseif training_Categories:contains("Spear") then
--         perks_type = Perks.Spear;
--     end

--     for i=1,ingredients:size() do
--         item = ingredients:get(i-1);
--         if item:getType() == result:getType() then
--             condition = item:getCondition() - 1;
--         end
--     end
    
--     if condition < 0 then
--         condition = 0;
--     end
--     result:setCondition(condition);

--     if perks_type then
--         preks_level = player:getPerkLevel(perks_type);
--         if preks_level <= 3 then
--             xp_gain = (preks_level + 1) * 10 * 2;
--         else
--             xp_gain = 1;
--         end
--         player:getXp():AddXP(perks_type, xp_gain);
--     end

--     for i = 1, 6 do
--         player:getInventory():AddItem("Base.UnusableWood");
--     end
-- end


-- function Recipe.GetItemTypes.Fertilizer(scriptItems)
--     local allScriptItems = getScriptManager():getAllItems()
--     for i=1,allScriptItems:size() do
--         local scriptItem = allScriptItems:get(i-1)
--         if scriptItem:getName() == 'Fertilizer' or scriptItem:getName() == 'CompostBag' then
--             scriptItems:add(scriptItem)
--         end
--     end
-- end


-- require "TimedActions/ISAttachItemHotbar"


function Recipe.OnCreate.RestoreBagItemsOnly(items, resultItem)

    local newbag_inventory = resultItem:getInventory()

    for i = 0, (items:size()-1) do 
        local item = items:get(i); 
        if instanceof(item, "InventoryContainer") then 
            local bag_inventory = item:getInventory()
            local bag_items = bag_inventory:getItems()
            for j = 0, (bag_items:size()-1) do
                bag_inventory:Remove(v)
                newbag_inventory:AddItem(v)
            end
        end
    end

end


function Recipe.OnCreate.RestoreBagItemsWithTexture(items, resultItem, player)
    
    local texture;

    Recipe.OnCreate.RestoreBagItemsOnly(items, resultItem, player);

    for i = 0, (items:size()-1) do 
        local item = items:get(i)
        if instanceof(item, "InventoryContainer") then 
            texture = item:getTexture()
            break
        end
    end
    if texture then
        resultItem:setTexture(texture);
    end
end


function Recipe.OnCreate.printArmyPackToBlack(items, resultItem, player)
    Recipe.OnCreate.RestoreBagItemsOnly(items, resultItem, player);

    resultItem:getVisual():setTextureChoice(1);
end

function Recipe.OnTest.IsNotBlackArmyPack(item)
    if instanceof(item, "InventoryContainer") and item:getType() == 'Bag_ALICEpack_Army' then
        return item:getVisual():getTextureChoice() ~= 1 
    end
    return true
end


function Recipe.OnTest.IsEmptyBag(item)
    if instanceof(item, "InventoryContainer") then
        return item:getInventory():getItems():size() < 1;
    end
    return true
end


function Recipe.OnTest.IsNotEquippedBag(item)
    if instanceof(item, "InventoryContainer") then
        return not item:isEquipped();
    end
    return true
end