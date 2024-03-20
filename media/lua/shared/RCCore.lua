PACKAGE_NAME = "RavenCraft";

RC = {}

RC.Txt = {}
RC.Txt.ghs = " <RGB:" .. getCore():getGoodHighlitedColor():getR() .. "," .. getCore():getGoodHighlitedColor():getG() .. "," .. getCore():getGoodHighlitedColor():getB() .. "> "
RC.Txt.bhs = " <RGB:" .. getCore():getBadHighlitedColor():getR() .. "," .. getCore():getBadHighlitedColor():getG() .. "," .. getCore():getBadHighlitedColor():getB() .. "> "


RC.getPackageName = function()
    return PACKAGE_NAME
end

RC.getPackageItemType = function(item_name)
    if item_name:find(".", 1, true) == 1 then
        item_name = PACKAGE_NAME..item_name
    end
    return item_name
end



RC.getLootChance = function(character)
    local modifier = 1
    if character then
        if character:getTraits():contains("Lucky") then
            modifier = modifier * 1.25
        elseif character:getTraits():contains("Unlucky") then
            modifier = modifier * 0.75
        end
    end
    local loot_chance = SandboxVars.RavenCraft.LootChance
    return loot_chance / 100 * modifier
end


RC.predicateLootChance = function(character, rand, rand_2)
    if rand == nil then
        rand = ZombRand(1, 100)
    end
    if rand_2 == nil then
        rand_2 = ZombRand(1, 100)
    end
    if character then
        rand = rand * RC.getLootChance(character)
    end
    
    return rand > rand_2
end


RC.insertDistTable = function(table_obj, group_or_key, weight)

    if weight == nil and weight ~= 0 then  -- could be 0, but 0 == nil
        weight = 1
    end
    local loot_chance = SandboxVars.RavenCraft.LootChance
    weight = weight * loot_chance / 100
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


RC.isBeforeElecShut = function()
    return (SandboxVars.ElecShutModifier < 0 or GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier)
end


RC.isSquarePowered = function(square)
    return RC.isBeforeElecShut() or square:haveElectricity()
end


RC.isRequireInHandOrInventory = function(character, item)
    local required_items = item:getRequireInHandOrInventory()
    for i=0, required_items:size() - 1 do
        if character:getInventory():containsTypeRecurse(required_items:get(i)) then
            return true
        end
    end
    return false
end


enum = function (tbl)
    local length = #tbl
    for i = 1, length do
        local v = tbl[i]
        tbl[v] = i
    end

    return tbl
end


printDebug = function(contents, name)
    if isDebugEnabled() then
        if name == true or name == nil then
            name = "isDebug Print"
        elseif type(name) ~= 'string' then
            name = false
        end

        if type(contents) ~= 'table' then
            contents = {contents}
        end

        if name then
            print("=========================== ".. name .." ===========================")
        end
        for _, x in ipairs(contents) do
            print(x)
        end
        if name then
            print("======================( "..(#contents).." )=========================")
        end
    end
end