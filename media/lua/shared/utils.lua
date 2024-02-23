local PACKAGE_NAME = "RavenCraft";

insertDistTable = function(table_obj, group_or_key, weight)

    if weight == nil and weight ~= 0 then  -- could be 0, but 0 == nil
        weight = 1
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
