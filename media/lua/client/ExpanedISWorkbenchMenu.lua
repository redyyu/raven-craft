require 'BuildingObjects/ISUI/ISBuildMenu'

local ISBuildBenchMenu = {};

local function predicateNotBroken(item)
	return not item:isBroken()
end


local function countMaterial(playerInv, type)
    local count = playerInv:getCountTypeRecurse(type)
    if ISBlacksmithMenu.groundItemCounts[type] then
        count = count + ISBlacksmithMenu.groundItemCounts[type]
    end
    return count
end


local function countUses(playerObj, item_type, amount)
    local count = 0;
    local containers = ISInventoryPaneContextMenu.getContainers(playerObj)
    for i=1,containers:size() do
        local container = containers:get(i-1)
        for j=1,container:getItems():size() do
            local item = container:getItems():get(j-1);
            if item:getType() == item_type then
                count = count + item:getUsedDelta() / item:getUseDelta();
                if count >= amount then
                    return round(count ,0);
                end
            end
        end
    end
    return count;
end


local function onStoneFurnace(worldobjects, player)
    local furniture = ISBSFurnace:new("Stone Furnace", "crafted_01_42", "crafted_01_43");
    furniture.firstItem = "Hammer";  -- DO NOT set it without check item in inventory. It will break ISBuildingObject.lua.
    furniture.craftingBank = "Hammering";
    furniture.modData["need:Base.Stone"]= 30;
    furniture.player = player;
    furniture.completionSound = "BuildFenceGravelbag";
    getCell():setDrag(furniture, player);
end


local function onAnvil(worldobjects, player)
    local furniture = ISAnvil:new("Anvil", getSpecificPlayer(player), "crafted_01_19", "crafted_01_19");
    furniture.firstItem = "Hammer";
    furniture.craftingBank = "Hammering";
    furniture.modData["use:Base.IronIngot"]= 500;
    furniture.player = player;
    furniture.completionSound = "BuildMetalStructureMedium";
    getCell():setDrag(furniture, player);
end


local function onWaterWell(worldobjects, player)
	local well = ISWaterWell:new("Well", "camping_01_16");
    local playerObj = getSpecificPlayer(player);
	local playerInv = playerObj:getInventory();
	local sortof_shovel = playerInv:getFirstTagEvalRecurse("DigGrave", predicateNotBroken);

	floor.firstItem = sortof_shovel:getType();
	well.modData["xp:Woodwork"] = 200;
	well.modData["need:Base.Plank"] = 4;
	well.modData["need:Base.Nails"] = 12;
	well.modData["need:Base.Stone"] = 30;
	well.modData["need:Base.MetalPipe"] = 1;
	well.modData["need:Base.Rope"] = 1;
	well.modData["need:Base.BucketEmpty"] = 1;
	well.player = player;
	well.completionSound = "BuildFenceGravelbag";
	getCell():setDrag(well, player);
end


local function buildBenchMenu(workbenchMenu, option, player)
    local playerObj = getSpecificPlayer(player);
    local playerInv = playerObj:getInventory();

    local furnaceOption = {};
    local anvilOption = {};
    local wellOption = {};

    -- StoneFurnace --
    local sprite = {};
    sprite.sprite = "crafted_01_16";

    local itemName = getText("ContextMenu_STONE_FURNACE");
    furnaceOption = workbenchMenu:addOption(itemName, worldobjects, onStoneFurnace, player);
    local toolTip = ISBuildMenu.canBuild(0,0,0,0,0,6, furnaceOption, player);
	-- ISBuildMenu.canBuild(plankNb, nailsNb, hingeNb, doorknobNb, baredWireNb, carpentrySkill, option, player)
	toolTip:setName(itemName);
	toolTip.description = getText("Tooltip_CRAFT_STONEFURNACEDESC") .. toolTip.description;
	toolTip:setTexture(sprite.sprite);

    local resourceCount = countMaterial(playerInv, "Base.Stone")
    if resourceCount >= 30 then
        toolTip.description = toolTip.description .. " <LINE> " .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.Stone") .. " " .. resourceCount .. "/30" ;
    else
        toolTip.description = toolTip.description .. " <LINE> " .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.Stone") .. " " .. resourceCount .. "/30" ;
        if not ISBuildMenu.cheat then
            furnaceOption.onSelect = nil;
            furnaceOption.notAvailable = true;
        end
    end


    -- Anvil --
    local sprite = {};
    sprite.sprite = "crafted_01_19";

    local itemName = getText("ContextMenu_ANVIL");
    anvilOption = workbenchMenu:addOption(itemName, worldobjects, onAnvil, player);
    local toolTip = ISBuildMenu.canBuild(0,0,0,0,0,6, anvilOption, player);
	-- ISBuildMenu.canBuild(plankNb, nailsNb, hingeNb, doorknobNb, baredWireNb, carpentrySkill, option, player)
	toolTip:setName(itemName);
	toolTip.description = getText("Tooltip_CRAFT_ANVILDESC") .. toolTip.description;
	toolTip:setTexture(sprite.sprite);
    
    local metalCount = countUses(playerObj, "IronIngot", 500);
	local logCount = countMaterial(playerInv, "Base.Log")
    local canBeCrafted = true;

    -- if not playerInv:containsTagEvalRecurse("Hammer", predicateNotBroken) then
    --     toolTip.description = toolTip.description .. " <LINE> " .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.Hammer") .. " 0/1" ;
    --     canBeCrafted = false;
    -- else
    --     toolTip.description = toolTip.description .. " <LINE> " .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.Hammer") .. " 1/1" ;
    -- end

    if not playerInv:contains("Log") then
        toolTip.description = toolTip.description .. " <LINE> " .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.Log") .. " 0/1" ;
        canBeCrafted = false;
    else
        toolTip.description = toolTip.description .. " <LINE> " .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.Log") .. " 1/1" ;
    end

    if metalCount < 500 then
        toolTip.description = toolTip.description .. " <LINE> " .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.IronIngot") .. " " .. metalCount .. " /500 Unit";
        canBeCrafted = false;
    else
        toolTip.description = toolTip.description .. " <LINE> " .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.IronIngot") .. " " .. metalCount .. " /500 Unit";
    end

    if not canBeCrafted and not ISBuildMenu.cheat then
        anvilOption.onSelect = nil;
        anvilOption.notAvailable = true;
    end


    -- Water Well --
    local sprite = {};
    sprite.sprite = "camping_01_16";

    local itemName = getText("ContextMenu_WATER_WELL");
    wellOption = workbenchMenu:addOption(itemName, worldobjects, onWaterWell, player);
    local toolTip = ISBuildMenu.canBuild(4,12,0,0,0,6, wellOption, player);
	-- ISBuildMenu.canBuild(plankNb, nailsNb, hingeNb, doorknobNb, baredWireNb, carpentrySkill, option, player)
	toolTip:setName(itemName);
	toolTip.description = getText("Tooltip_CRAFT_WATERWELLDESC") .. toolTip.description;
	toolTip:setTexture(sprite.sprite);

	local stoneCount = countMaterial(playerInv, "Base.Stone")
    local ropeCount = countMaterial(playerInv, "Base.Rope")
    local bucketCount = countMaterial(playerInv, "Base.BucketEmpty")
	local pipeCount = countMaterial(playerInv, "Base.MetalPipe")

	-- ISBuildMenu.requireHammer(wellOption);

	-- if playerInv:containsTagEvalRecurse("Hammer", predicateNotBroken) then
	-- 	toolTip.description = toolTip.description .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.Hammer") .. " 1/1 <LINE> ";
	-- else
	-- 	toolTip.description = toolTip.description .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.Hammer") .. " 0/1 <LINE> ";
	-- 	if not ISBuildMenu.cheat then
	-- 		wellOption.onSelect = nil;
    --     	wellOption.notAvailable = true;
	-- 	end
	-- end

	if playerInv:containsTagEvalRecurse("DigGrave", predicateNotBroken) then
		toolTip.description = toolTip.description .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.Shovel") .. " 1/1 <LINE> ";
	else
		toolTip.description = toolTip.description .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.Shovel") .. " 0/1 <LINE> ";
		if not ISBuildMenu.cheat then
			wellOption.onSelect = nil;
        	wellOption.notAvailable = true;
		end
	end
	
    if stoneCount >= 30 then
        toolTip.description = toolTip.description .. " <LINE> " .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.Stone") .. " " .. stoneCount .. "/30" ;
    else
        toolTip.description = toolTip.description .. " <LINE> " .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.Stone") .. " " .. stoneCount .. "/30" ;
        if not ISBuildMenu.cheat then
            wellOption.onSelect = nil;
            wellOption.notAvailable = true;
        end
    end
	if ropeCount >= 2 then
        toolTip.description = toolTip.description .. " <LINE> " .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.Rope") .. " " .. ropeCount .. "/2" ;
    else
        toolTip.description = toolTip.description .. " <LINE> " .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.Rope") .. " " .. ropeCount .. "/2" ;
        if not ISBuildMenu.cheat then
            wellOption.onSelect = nil;
            wellOption.notAvailable = true;
        end
    end
	if pipeCount >= 2 then
        toolTip.description = toolTip.description .. " <LINE> " .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.MetalPipe") .. " " .. pipeCount .. "/2" ;
    else
        toolTip.description = toolTip.description .. " <LINE> " .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.MetalPipe") .. " " .. pipeCount .. "/2" ;
        if not ISBuildMenu.cheat then
            wellOption.onSelect = nil;
            wellOption.notAvailable = true;
        end
    end
	if bucketCount >= 1 then
        toolTip.description = toolTip.description .. " <LINE> " .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.BucketEmpty") .. " " .. bucketCount .. "/1" ;
    else
        toolTip.description = toolTip.description .. " <LINE> " .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.BucketEmpty") .. " " .. bucketCount .. "/1" ;
        if not ISBuildMenu.cheat then
            wellOption.onSelect = nil;
            wellOption.notAvailable = true;
        end
    end


    -- Parent menu --
	if furnaceOption.notAvailable and anvilOption.notAvailable and wellOption.notAvailable then
		option.notAvailable = true;
	end

end


ISBuildBenchMenu.doBuildMenu = function(player, context, worldobjects, test)
	if test and ISWorldObjectContextMenu.Test then return true end

    if getCore():getGameMode()=="LastStand" then
        return;
    end
	
	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()

	if playerObj:getVehicle() then return; end
	
    local menuAvailable = playerInv:containsTagEvalRecurse("Hammer", predicateNotBroken) and playerObj:getKnownRecipes():contains("Craft Workbench");

	if menuAvailable or ISBuildMenu.cheat then
        local workbenchOption = context:addOption(getText("ContextMenu_WORKBENCH"), worldobjects, nil);
        local workbenchMenu = ISContextMenu:getNew(context);
        context:addSubMenu(workbenchOption, workbenchMenu);
        buildBenchMenu(workbenchMenu, workbenchOption, player);
    end


    -- Path for Vanilla --
    local furnace = nil;
    local metal_drum = nil;

    for i, v in ipairs(worldobjects) do
        -- find Stone Furnace --
        if instanceof(v, "BSFurnace") then
            furnace = v;
        end
        -- find Metal Drum --
        if CMetalDrumSystem.instance:isValidIsoObject(v) then
            metal_drum = CMetalDrumSystem.instance:getLuaObjectOnSquare(v:getSquare())
        end
    end
    
    -- fix `Put out fire` on furance not change texture. --
    if furnace and furnace:isFireStarted() then
        context:removeOptionByName(getText("ContextMenu_Put_out_fire"));
        context:addOption(getText("ContextMenu_Put_out_fire"), worldobjects, ISBuildBenchMenu.onStopFire, furnace, playerObj);
    end

    -- fix 5 Logs is too heavy. change to 2 --
    if metal_drum and not metal_drum.haveLogs and not metal_drum.haveCharcoal then
        local drumMenuOption = context:getOptionFromName(getText("ContextMenu_Metal_Drum"));
        local subDrumMenu = context:getSubMenu(drumMenuOption.subOption);

        -- subDrumMenu:removeOptionByName(getText("ContextMenu_Add_Logs"));
        local addLogOption = subDrumMenu:getOptionFromName(getText("ContextMenu_Add_Logs"));
        if addLogOption then
            local tooltip = addLogOption.toolTip;
            tooltip.description = getText("Tooltip_CHARCOAL_LOGS", 2);
            addLogOption.notAvailable = playerInv:getItemCount("Base.Log") < 2;
        end
    end

end


ISBuildBenchMenu.onStopFire = function(worldobjects, furnace, player)
    if luautils.walkAdj(player, furnace:getSquare()) then
        ISTimedActionQueue.add(ISStopFurnaceFire:new(furnace, player))
    end
end

-- ISBuildBenchMenu.onAddLogs = function(worldobjects, metalDrum, player)
--     if luautils.walkAdj(player, metalDrum:getSquare()) then
--         ISTimedActionQueue.add(ISAddLogsInDrum:new(player, metalDrum, true))
--     end
-- end


Events.OnFillWorldObjectContextMenu.Add(ISBuildBenchMenu.doBuildMenu)