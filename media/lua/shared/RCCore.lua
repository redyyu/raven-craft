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
    return modifier
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


RC.printSandboxOptions = function(table_name, option_name)
    local sandboxOpt = getSandboxOptions()
    print('====================== Sandbox Options ======================')
    for i=1, sandboxOpt:getNumOptions() do
		local option = sandboxOpt:getOptionByIndex(i-1)
        if table_name == nil or table_name == option:getTableName() then
            print("Table: " .. tostring(option:getTableName()))
            if option_name == nil or option_name == option_name then
		        print("Option: " .. tostring(option:getName()) .." = " .. tostring(option:getValue()))
            end
        end
	end
    print('============================================================')
end


RC.modifySandboxOption = function(option_name, option_value)
    local sandboxOpt = getSandboxOptions()
    for i=1, sandboxOpt:getNumOptions() do
		local option = sandboxOpt:getOptionByIndex(i-1)
        if option:getName() == option_name then
            sandboxOpt:set(option_name, option_value)
            local cat = option:getTableName()
            local var = option:getShortName()
            local val = option:getValue()
            if cat then
                SandboxVars[cat][var] = val
            else
                SandboxVars[var] = val
            end
            print("WARNING: Better to reload game after Sandbox Option has been changed, some option might be loaded before modified.")
            return
        end
	end
end


RC.getMoveableDisplayName = function(obj)
    if not obj then return nil end
    if not obj:getSprite() then return nil end
    local props = obj:getSprite():getProperties()
    if props:Is("CustomName") then
        local name = props:Val("CustomName")
        if props:Is("GroupName") then
            name = props:Val("GroupName") .. " " .. name
        end
        return Translator.getMoveableDisplayName(name)
    end
    return nil
end


RC.findSquaresRadius = function(currSquare, radius, predicateCall, param1, param2, param3, param4, param5, param6)
    local squares = {}
    local doneSquares = {}
    local minX = math.floor(currSquare:getX() - radius)
    local maxX = math.ceil(currSquare:getX() + radius)
    local minY = math.floor(currSquare:getY() - radius)
    local maxY = math.ceil(currSquare:getY() + radius)
    for y = minY, maxY do
        for x = minX, maxX do
            local square = getCell():getGridSquare(x, y, currSquare:getZ())
            if square and not doneSquares[square] then
                doneSquares[square] = true
                if type(predicateCall) == 'function' then
                    if predicateCall(square, currSquare, param1, param2, param3, param4, param5, param6) then
                        table.insert(squares, square)
                    end
                else
                    table.insert(squares, square)
                end
            end
        end
    end
    return squares
end


RC.pickVehicle = function(playerNum)
    local playerObj = getSpecificPlayer(playerNum)
    if JoypadState.players[playerNum+1] then
        local px = playerObj:getX()
        local py = playerObj:getY()
        local pz = playerObj:getZ()
        local sqs = {}
        sqs[1] = getCell():getGridSquare(px, py, pz)
        local dir = playerObj:getDir()
        if (dir == IsoDirections.N) then 
            sqs[2] = getCell():getGridSquare(px-1, py-1, pz)
            sqs[3] = getCell():getGridSquare(px, py-1, pz)
            sqs[4] = getCell():getGridSquare(px+1, py-1, pz)
        elseif (dir == IsoDirections.NE) then 
            sqs[2] = getCell():getGridSquare(px, py-1, pz)
            sqs[3] = getCell():getGridSquare(px+1, py-1, pz)
            sqs[4] = getCell():getGridSquare(px+1, py, pz);
        elseif (dir == IsoDirections.E) then 
            sqs[2] = getCell():getGridSquare(px+1, py-1, pz)
            sqs[3] = getCell():getGridSquare(px+1, py, pz)
            sqs[4] = getCell():getGridSquare(px+1, py+1, pz)
        elseif (dir == IsoDirections.SE) then 
            sqs[2] = getCell():getGridSquare(px+1, py, pz)
            sqs[3] = getCell():getGridSquare(px+1, py+1, pz)
            sqs[4] = getCell():getGridSquare(px, py+1, pz)
        elseif (dir == IsoDirections.S) then 
            sqs[2] = getCell():getGridSquare(px+1, py+1, pz)
            sqs[3] = getCell():getGridSquare(px, py+1, pz)
            sqs[4] = getCell():getGridSquare(px-1, py+1, pz)
        elseif (dir == IsoDirections.SW) then 
            sqs[2] = getCell():getGridSquare(px, py+1, pz)
            sqs[3] = getCell():getGridSquare(px-1, py+1, pz)
            sqs[4] = getCell():getGridSquare(px-1, py, pz)
        elseif (dir == IsoDirections.W) then 
            sqs[2] = getCell():getGridSquare(px-1, py+1, pz)
            sqs[3] = getCell():getGridSquare(px-1, py, pz)
            sqs[4] = getCell():getGridSquare(px-1, py-1, pz)
        elseif (dir == IsoDirections.NW) then 
            sqs[2] = getCell():getGridSquare(px-1, py, pz)
            sqs[3] = getCell():getGridSquare(px-1, py-1, pz)
            sqs[4] = getCell():getGridSquare(px, py-1, pz)
        end
        
        for _, sq in ipairs(sqs) do
            local vehicle = sq:getVehicleContainer()
            if vehicle then
                return vehicle
            end
        end
        return
    end
    
    return IsoObjectPicker.Instance:PickVehicle(getMouseXScaled(), getMouseYScaled())
end


RC.addNewSprite = function(spriteTextureName, properties)
    local spr = IsoSpriteManager.instance:getSprite(spriteTextureName)
    if spr then
        return false
    end
    spr = IsoSpriteManager.instance:AddSprite(spriteTextureName)
    spr:setName(spriteTextureName)
    local props = spr:getProperties()
    if type(properties) == 'table' and props then
        for k, v in pairs(properties) do
            if k == 'flag' then
                props:Set(v)
            else
                props:Set(tostring(k), tostring(v))
            end
        end
    end
    return spr
end


RC.tableIndexOf = function(tableList, val)
    if type(tableList) ~= 'table' or #tableList <= 0 then
        return nil
    end

    for idx, v in ipairs(tableList) do
        if v == val then
            return idx
        end
    end
    return nil
end


RC.debugNoise = function(contents, name)
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


enum = function (tbl)
    local length = #tbl
    for i = 1, length do
        local v = tbl[i]
        tbl[v] = i
    end

    return tbl
end