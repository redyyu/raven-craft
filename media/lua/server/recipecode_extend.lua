
require "recipecode"

-- check player is in somewhere have electricity
function Recipe.OnCanPerform.haveElectricity(recipe, playerObj)
    return RC.isSquarePowered(playerObj:getCurrentSquare())
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
    local mintenance_lv = player:getPerkLevel(Perks.Maintenance) or 0
    -- this is rand twice, lower broken chance when high perks lv.
    -- local condition_percent = ZombRand(0, mintenance_lv) / 10
    -- local condition = math.floor(result:getConditionMax() * condition_percent) + ZombRand(0, mintenance_lv)
    
    -- chance to damage the source item
    local sample_item = nil
    for i=0, items:size() - 1 do
        local item = items:get(i)
        if item:getFullType() == result:getFullType() then
            sample_item = item
        end
    end

    if sample_item and ZombRand(0, mintenance_lv) < 1 then
        local sample_condition = sample_item:getCondition()
        if sample_condition > 1 then
            sample_item:setCondition(sample_condition - 1)
        else
            sample_item:setCondition(0)
        end
    end

    -- rand once, higher a bit broken chance when hight perks lv.
    local modifier = ZombRand(0, mintenance_lv)
    local condition = math.floor(result:getConditionMax() * modifier / 10  + modifier / 2)

    if condition > result:getConditionMax() then
        condition = result:getConditionMax()
    end
    if condition < 0 then
        condition = 0
    end
    result:setCondition(condition)
end


function Recipe.OnCreate.RemainFirstItemCondition(items, result, player)
    if not result:getCondition() then return end

    local fixs = 1  -- getHaveBeenRepaired starts with 1
    local condition = result:getCondition()
    if items:size() > 0 then
        local item = items:get(0)
        local src_condition = item:getCondition() or 0
        if condition > src_condition then
            condition = src_condition
        end
        if item:getHaveBeenRepaired() > fixs then
            fixs = item:getHaveBeenRepaired()
        end
    end
    result:setCondition(condition)
    result:setHaveBeenRepaired(fixs)
end


function Recipe.OnCreate.AssembleArmorSuit(items, result, player)
    local condition_ratio = 1
    local dirtyness = 0
    -- local bloodlevel = 0
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

            -- local bld = item:getBloodLevel()
            -- if bld > bloodlevel then
            --     bloodlevel = bld
            -- end

            local wet = item:getWetness()
            if wet > wetness then
                wetness = wet
            end

            local item_parts = item:getCoveredParts()
            for i=0, item_parts:size() - 1 do
                local p = item_parts:get(i)
                if suitPartMap[p] then 
                    if item:getVisual():getHole(p) > 0 then
                        result:getVisual():setHole(p)
                    end
                    if item:getVisual():getBlood(p) > 0 then
                        result:getVisual():setBlood(p, item:getVisual():getBlood(p))
                    end
                end
            end
        end
    end
    
    result:synchWithVisual()
    result:setCondition(math.floor(result:getConditionMax() * condition_ratio))
    result:setDirtyness(dirtyness)
    result:setWetness(wetness)
    -- result:setBloodLevel(bloodlevel)
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
            if item:getFullType() == RC.getPackageItemType(".SuitPads") then
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
        local item_type = RC.getPackageItemType(n)
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
            result_item:synchWithVisual()
        end
    end
end


-- In Vanilla, recipe with Cigarettes = 20, will cause result x20 (800),
-- but Cigarettes=1 will only get 1. thats because item `Cigarettes` is count 20,
-- when use AddItems /AddItem with String type name will effect by the count. I guess.
--[[ 
   (in DOCS https://pzwiki.net/wiki/Scripts_guide/Item_Script_Parameters/Count)
   Count:
   Determines how many items of this type will appear when spawning/crafting this type of item.
--]]
-- try DO NOT override the item script `Count`, otherwise will effect numbers when distribution.
function Recipe.OnCreate.OpenCigarettesPack(items, result, player)
   if result:getFullType() == "Base.Cigarettes" then
        for i=0, items:size() -1 do
            local item = items:get(i)
            if item:getType() == 'CigarettesPack' then
                -- In Recipoe `Result: Cigarettes,`
                -- result have only 1 Cigarettes

                -- AddItem or AddItems with String name will trigger the `Count`
                -- player:getInventory():AddItem("Base.Cigarettes")
                -- -- addItem for Cigarettes, now will be 21,
                -- player:getInventory():RemoveOneOf("Base.Cigarettes")
                -- -- remove one of it, now will be 20.
                    
                -- local count = math.floor(item:getUsedDelta() / item:getUseDelta() + 0.5)
                -- round is defined in luautils.
                local count = round(item:getUsedDelta() / item:getUseDelta())

                for j=1, count - 1 do -- remember recipe will create one.
                    local cigarettes = InventoryItemFactory.CreateItem("Base.Cigarettes")
                    -- AddItem with InventoryItem will be fine.  AddItems will not
                    player:getInventory():AddItem(cigarettes)
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


function Recipe.OnCreate.ExtraResultBuyMetalValue(items, result, player)
    local item_count = 0
    local result_metal_value = result:getMetalValue() or 0
    for i=0, items:size() - 1 do
        local item = items:get(i)
        if item:getMetalValue() > 0 then
           item_count = result_metal_value / item:getMetalValue()
        end
    end
    item_count = item_count - 1  -- result have one.
    if item_count > 0 then
        player:getInventory():AddItems(result:getFullType(), item_count)
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



function Recipe.OnCreate.RestoreBagItemsOnly(items, resultItem)

    local result_inventory = resultItem:getInventory()
    local transform_stack = {}

    for i = 0, (items:size()-1) do 
        local item = items:get(i); 
        if instanceof(item, "InventoryContainer") then
            local bag_inventory = item:getInventory()
            local bag_items = bag_inventory:getItems()
            if bag_items then
                for j = 0, (bag_items:size()-1) do
                    print(j)
                    local itm = bag_items:get(j)
                    if itm then
                        table.insert(transform_stack, itm)
                    end 
                end
            end
        end
    end

    for _, v in ipairs(transform_stack) do
		result_inventory:AddItem(v)
	end

end


function Recipe.OnCreate.RestoreBagItemsWithTexture(items, resultItem, player)
    
    local texture

    Recipe.OnCreate.RestoreBagItemsOnly(items, resultItem, player)

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


-- NOT PRINT Backpacks anymore.
-- function Recipe.OnCreate.printArmyPackToBlack(items, resultItem, player)
--     Recipe.OnCreate.RestoreBagItemsOnly(items, resultItem, player)

--     resultItem:getVisual():setTextureChoice(1)
--     resultItem:synchWithVisual()
-- end

-- function Recipe.OnCreate.printArmyPackToArmy(items, resultItem, player)
--     Recipe.OnCreate.RestoreBagItemsOnly(items, resultItem, player)

--     resultItem:getVisual():setTextureChoice(0)
--     resultItem:synchWithVisual()
-- end

function Recipe.OnTest.IsBagCanReinforce(item)
    if instanceof(item, "InventoryContainer") then
        return item:getInventory():getItems():size() < 1 and not item:isEquipped()
    end
    return true
end


function Recipe.OnTest.IsEmptyBag(item)
    if instanceof(item, "InventoryContainer") then
        return item:getInventory():getItems():size() < 1
    end
    return true
end


-- DO NOT change the value, unless know what doing.
-- Gatherpowder for each bullet is calculated with Gunpowder usage when craft.
local AMMO_TYPE = {
    ["Bullets9mm"] = 0.02,
    ["Bullets38"] = 0.02,
    ["ShotgunShells"] = 0.05,
    ["308Bullets"] = 0.02,
    ["223Bullets"] = 0.02,
    ["556Bullets"] = 0.03,
    ["Bullets44"] = 0.05,
    ["Bullets45"] = 0.02,
}

local function getNoFullGunpowder(player)
    local gunpowders = player:getInventory():getItemsFromFullType('Base.GunPowder')
    for i=0, gunpowders:size() -1 do
        local gp = gunpowders:get(i)
        if gp:getUsedDelta() < 1.0 then
            return gp
        end
    end
    return nil
end

function Recipe.OnCreate.GatherGunpowder(items, resultItem, player)
    local powderDelta = 0.0
    for i = 0, (items:size()-1) do 
        local item = items:get(i)
        if AMMO_TYPE[item:getType()] then 
            powderDelta = powderDelta + AMMO_TYPE[item:getType()]
            break
        end
    end
    
    local reloading_lv = player:getPerkLevel(Perks.Reloading) or 0
    local gather_percent = 0.5 + 0.5 * (reloading_lv / 10)
    powderDelta = math.floor(powderDelta * gather_percent * 1000) / 1000

    RC.printDebug({
        'PowderDelta: '.. powderDelta,
        'Reloading Lv: '.. reloading_lv .. "  Gather: ".. gather_percent
    }, 'GatherGunpowder')

    local gunpowder = getNoFullGunpowder(player)
    if gunpowder then
        local cal_delta = powderDelta + gunpowder:getUsedDelta()
        if cal_delta > 1.0 then
            powderDelta = cal_delta - 1.0
            gunpowder:setUsedDelta(1.0)
        else
            powderDelta = cal_delta
            player:getInventory():Remove(gunpowder)
        end
    end
    
    resultItem:setUsedDelta(powderDelta)
end


function Recipe.OnGiveXP.GatherGunpowder(recipe, ingredients, result, player)
    local reloading_lv = player:getPerkLevel(Perks.Reloading)
    if ZombRand(reloading_lv) == 0 then
        RC.printDebug('Reloading XP +1', 'GatherGunpowder')
        player:getXp():AddXP(Perks.Reloading, 1)
    end
end

function Recipe.OnCreate.CopyTintForClothing(items, resultItem, player)
    local srcItem = nil
    for i = 0, (items:size()-1) do 
        local item = items:get(i)
        if instanceof(item, "Clothing") then
            srcItem = item
            break
        end
    end

    if srcItem then
        local visual = srcItem:getVisual()
        local newVisual = resultItem:getVisual()
        newVisual:setTint(visual:getTint(srcItem:getClothingItem()))
        newVisual:setBaseTexture(visual:getBaseTexture())
        newVisual:setTextureChoice(visual:getTextureChoice())
        newVisual:setDecal(visual:getDecal(srcItem:getClothingItem()))
        -- if newItem:IsInventoryContainer() and srcItem:IsInventoryContainer() then
        --     newItem:getItemContainer():setItems(srcItem:getItemContainer():getItems())
        --     -- Handle renamed bag
        --     if srcItem:getName() ~= srcItem:getScriptItem():getDisplayName() then
        --         newItem:setName(srcItem:getName())
        --     end
        -- end
        -- newItem:setDirtyness(item:getDirtyness())
        --    newItem:setTexture(item:getTexture())
        resultItem:setColor(srcItem:getColor())
        resultItem:synchWithVisual()
    end

end


function Recipe.OnTest.IsNotEquipped(item)
    return not item:isEquipped()
end


function Recipe.OnTest.IsNotFullPack(item)
    if instanceof(item, "Drainable") or instanceof(item, "DrainableComboItem") then
        return item:getUsedDelta() < 1
    end
    return true
end



-- NO NEED this, change back to recipe script.
-- Mix Vegetables

local MIXABLE_VEGE_TYPES = {
    "Potato", "Carrots", "Lettuce", "Tomato", "Broccoli",
    "Cabbage", "Corn", "Zucchini", "Edamame", "Eggplant",
    "BellPepper", "PepperHabanero", "PepperJalapeno", "Lettuce",
    "Daikon", "RedRadish",
}

-- function Recipe.OnCanPerform.haveMixableVegetables(recipe, playerObj)
--     local playerInv = playerObj:getInventory()
--     local total_hunger_change = 0.01 -- in recipe already have 1.
--     for _, vege_type in ipairs(MIXABLE_VEGE_TYPES) do
--         local vege_items = playerInv:getAllTypeRecurse(vege_type)
--         for i=0, vege_items:size() -1 do
--             local vege = vege_items:get(i)
--             if instanceof(vege, 'Food') then
--                 if vege:getHungerChange() > -0.05 and not vege:isRotten() then  -- HungerChange is negative number.
--                     total_hunger_change = total_hunger_change + vege:getHungerChange()
--                 end
--             end
--         end
--         if total_hunger_change <= -0.10 then  -- HungerChange is negative number.
--             return true
--         end
--     end
--     return false
-- end


-- function Recipe.OnCreate.mixVegetables(items, result, playerObj)
--     local playerInv = playerObj:getInventory()
--     local total_hunger_change = 0.01 -- in recipe already have 1.
--     local food_age = nil
--     for _, vege_type in ipairs(MIXABLE_VEGE_TYPES) do
--         local vege_items = playerInv:getAllTypeRecurse(vege_type)
--         for i=0, vege_items:size() -1 do
--             local vege = vege_items:get(i)
--             if instanceof(vege, 'Food') then
--                 if vege:getHungerChange() > -0.05 and not vege:isRotten() then -- HungerChange is negative number.
--                     total_hunger_change = total_hunger_change + vege:getHungerChange()
--                     vege:Use() 
--                     -- use `:Use` to consume the vegetable, not `:Remove()`, 
--                     -- seems that need much more coding to make it safe to remove.

--                     -- NO NEED age, it will be rotten when food is old,
--                     -- because mix vegetables has short age for rotten.
--                     -- if not food_age or vege:getAge() > food_age then
--                     --     food_age = vege:getAge()
--                     -- end
--                 end
--                 if total_hunger_change <= -0.20 then -- HungerChange is negative number.
--                     break
--                 end
--             end
--         end

--         if total_hunger_change <= -0.20 then -- HungerChange is negative number.
--             break
--         end
--     end
--      -- make sure HungerChange is not 0 and < 20.
--     total_hunger_change = math.min(-0.001, math.max(total_hunger_change, -0.20))

--     result:setAge(0.5) -- make it fresh
--     result:setHungChange(total_hunger_change)
-- end