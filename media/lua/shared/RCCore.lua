PACKAGE_NAME = "RavenCraft";

local loot_chance = SandboxVars.RavenCraft.LootChance
local loot_chance_percent = loot_chance / 100


getPackageName = function()
    return PACKAGE_NAME
end

getPackageItemType = function(item_name)
    if item_name:find(".", 1, true) == 1 then
        item_name = PACKAGE_NAME..item_name
    end
    return item_name
end

getLootChance = function(character)
    local modifier = 1
    if character then
        if character:getTraits():contains("Lucky") then
            modifier = modifier * 1.25
        elseif character:getTraits():contains("Unlucky") then
            modifier = modifier * 0.75
        end
    end
    
    return loot_chance_percent * modifier
end


predicateLootChance = function(character, rand, rand_2)
    if rand == nil then
        rand = ZombRand(1, 100)
    end
    if rand_2 == nil then
        rand_2 = ZombRand(1, 100)
    end
    if character then
        if character:getTraits():contains("Lucky") then
            rand = rand * 1.25
        elseif character:getTraits():contains("Unlucky") then
            rand = rand * 0.75
        end
    end
    
    return (rand * loot_chance_percent) > rand_2
end


insertDistTable = function(table_obj, group_or_key, weight)

    if weight == nil and weight ~= 0 then  -- could be 0, but 0 == nil
        weight = 1
    end

    weight = weight * loot_chance_percent
    if isDebugEnabled() then
        print('Loot Chance: '.. tostring(weight))
    end

    if type(group_or_key) == 'string' then
        local key = group_or_key
        if key:find(".", 1, true) == 1 then
            key = PACKAGE_NAME..key
        end
        if table_obj and table_obj.items then
            table.insert(table_obj.items, key);
            table.insert(table_obj.items, weight);
        end
    else
        for k, v in pairs(group_or_key) do
            if k:find(".", 1, true) == 1 then
                k = PACKAGE_NAME..k
            end
            if table_obj and table_obj.items then
                table.insert(table_obj.items, k);
                table.insert(table_obj.items, v * weight);
            end
        end
    end
end 


isBeforeElecShut = function()
    return (SandboxVars.ElecShutModifier < 0 or GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier)
end


isSquarePowered = function(square)
    return isBeforeElecShut() or square:haveElectricity()
end


enum = function (tbl)
    local length = #tbl
    for i = 1, length do
        local v = tbl[i]
        tbl[v] = i
    end

    return tbl
end
