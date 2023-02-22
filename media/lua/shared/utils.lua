local MOD_NAME = "RavenCraft";

utils = {}

utils.insertTable = function(table_obj, key, weight)
    if key:find(".", 1, true) == 1 then
        key = MOD_NAME..key
    end
    
    if weight == nil and weight ~= 0 then
        weight = 1
    end

    if table_obj and table_obj.items then
        table.insert(table_obj.items, key);
        table.insert(table_obj.items, weight);
    end
end 

utils.insertDistribution = function(table_obj, ITEMS_WEIGHT, rate)
    for k, v in pairs(ITEMS_WEIGHT) do
        utils.insertTable(table_obj, k, v*rate);
    end
end

