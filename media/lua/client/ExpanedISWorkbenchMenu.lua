require 'BuildingObjects/ISUI/ISBuildMenu'
require 'Blacksmith/ISUI/ISBlacksmithMenu'

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
                    return round(count, 0) -- round is defined in luautils
                end
            end
        end
    end
    return count;
end


local function onStoneFurnace(worldobjects, player)
    -- Object name will be 'StoneFurnace'
    local furnace = ISBSFurnace:new("Stone Furnace", "crafted_01_42", "crafted_01_43");
    -- furnace.firstItem = "Hammer";  -- DO NOT set it without check item in inventory. That will break ISBuildingObject.lua.
    -- Leave the actionAnim, seems vanilla code not finish equip item yet. 
    furnace.modData["xp:Woodwork"] = 30;
    furnace.craftingBank = "Hammering";
    furnace.modData["need:Base.Stone"]= 50;
    furnace.player = player;
    furnace.completionSound = "BuildFenceGravelbag";
    furnace.maxTime = 1200;
    getCell():setDrag(furnace, player);
end


local function onAnvil(worldobjects, player)
    -- Object name will be 'Anvil' recipe NearItem is work.
    local anvil = ISAnvil:new("Anvil", getSpecificPlayer(player), "crafted_01_19", "crafted_01_19");
    -- anvil.firstItem = "Hammer"; -- DO NOT set it without check item in inventory. That will break ISBuildingObject.lua.
    -- Leave the actionAnim, seems vanilla code not finish equip item yet. 
    anvil.modData["xp:Woodwork"] = 30;
    anvil.craftingBank = "Hammering";
    anvil.modData["use:Base.IronIngot"]= 500;
    anvil.player = player;
    anvil.maxTime = 600;
    anvil.completionSound = "BuildMetalStructureMedium";
    getCell():setDrag(anvil, player);
end


local function onWaterWell(worldobjects, player)
	local well = ISWaterWell:new("Well", "camping_01_16");
    -- local playerObj = getSpecificPlayer(player);
	-- local playerInv = playerObj:getInventory();
	-- local sortof_shovel = playerInv:getFirstTagEvalRecurse("DigGrave", predicateNotBroken);

	-- well.firstItem = sortof_shovel:getType();  -- DO NOT set it without check item in inventory. That will break ISBuildingObject.lua.
    -- Leave the actionAnim, seems vanilla code not finish equip item yet. 
	well.modData["xp:Woodwork"] = 30;
	well.modData["need:Base.Plank"] = 4;
	well.modData["need:Base.Nails"] = 12;
	well.modData["need:Base.Stone"] = 30;
	well.modData["need:Base.MetalPipe"] = 1;
	well.modData["need:Base.Rope"] = 1;
	well.modData["need:Base.BucketEmpty"] = 1;
    well.craftingBank = "DigFurrowWithShovel";
	-- well.actionAnim = "DigShovel";
	well.player = player;
    well.maxTime = 1200;
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

    if logCount < 1 then
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


local doBuildMenu = function(player, context, worldobjects, test)
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

end


Events.OnFillWorldObjectContextMenu.Add(doBuildMenu)