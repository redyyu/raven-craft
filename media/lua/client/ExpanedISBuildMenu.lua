require 'BuildingObjects/ISUI/ISBuildMenu'

Events.OnFillWorldObjectContextMenu.Remove(ISBuildMenu.doBuildMenu)

local oldDoBuild = ISBuildMenu.doBuildMenu


local function predicateNotBroken(item)
	return not item:isBroken()
end


local function countConcerteUses(player)
	local playerObj = getSpecificPlayer(player);
	local playerInv = playerObj:getInventory();

	local groundItems = buildUtil.getMaterialOnGround(playerObj:getCurrentSquare())
    local groundItemUses = buildUtil.getMaterialOnGroundUses(groundItems)

	local concreteUses = playerInv:getUsesTypeRecurse("Base.BucketConcreteFull")
    if groundItemUses["Base.BucketConcreteFull"] then
        concreteUses = concreteUses + groundItemUses["Base.BucketConcreteFull"]
    end
	return concreteUses
end


local function onOuthouseDoor(worldobjects, player)
	-- sprite, northsprite, openSprite, openNorthSprite
	local door = ISWoodenDoor:new("fixtures_bathroom_02_32", "fixtures_bathroom_02_33", "fixtures_bathroom_02_34", "fixtures_bathroom_02_35");
	door.modData["xp:Woodwork"] = 3;
	door.modData["need:Base.Plank"] = 4;
	door.modData["need:Base.Nails"] = 4;
	door.modData["need:Base.Hinge"] = 2;
	door.modData["need:Base.Doorknob"] = 1;
	door.player = player
	getCell():setDrag(door, player);
end


local function onHighFenceGate(worldobjects, player)
	-- sprite, northsprite, openSprite, openNorthSprite
	local gate = ISWoodenDoor:new("fixtures_doors_fences_01_12", "fixtures_doors_fences_01_13", "fixtures_doors_fences_01_14", "fixtures_doors_fences_01_15");
	gate.modData["xp:Woodwork"] = 5;
	gate.modData["need:Base.Plank"] = 6;
	gate.modData["need:Base.Nails"] = 6;
	gate.modData["need:Base.Hinge"] = 2;
	gate.modData["need:Base.Doorknob"] = 1;
	gate.dontNeedFrame = true;
	gate.canBarricade = false;
	gate.player = player
	getCell():setDrag(gate, player);
end

local function onFenceGate(worldobjects, player)
	-- sprite, northsprite, openSprite, openNorthSprite
	local gate = ISWoodenDoor:new("fixtures_doors_fences_01_4", "fixtures_doors_fences_01_5", "fixtures_doors_fences_01_6", "fixtures_doors_fences_01_7");
	gate.modData["xp:Woodwork"] = 3;
	gate.modData["need:Base.Plank"] = 4;
	gate.modData["need:Base.Nails"] = 4;
	gate.modData["need:Base.Hinge"] = 2;
	gate.modData["need:Base.Doorknob"] = 1;
	gate.dontNeedFrame = true;
	gate.canBarricade = false;
	gate.player = player
	getCell():setDrag(gate, player);
end


local function onDogHouse(worldobjects, player)
	local dogHouse = ISSimpleFurniture:new("DogHouse", "location_farm_accesories_01_8", "location_farm_accesories_01_9", "location_farm_accesories_01_10", "location_farm_accesories_01_11");
	dogHouse.modData["xp:Woodwork"] = 6;
	dogHouse.modData["need:Base.Plank"] = 5;
	dogHouse.modData["need:Base.Nails"] = 5;
	dogHouse.player = player
	dogHouse.maxTime = 110;
	getCell():setDrag(dogHouse, player);
end


local function onConcreteFloor(worldobjects, player)
	local floor = ISWoodenFloor:new("floors_exterior_street_01_17", "blends_street_01_101");
	floor.modData["xp:Woodwork"] = 1;
	floor.modData["use:BucketConcreteFull"] = 1;
	floor.canBarricade = true;
	floor.noNeedHammer = true;
	-- floor.craftingBank = "Shoveling";
	floor.craftingBank = "MakePlaster";
	floor.actionAnim = "DigTrowel";
	floor.player = player
	getCell():setDrag(floor, player);
end



local function buildExpanedsMenu(subMenu, option, player)
	local playerObj = getSpecificPlayer(player);
	local playerInv = playerObj:getInventory();

	-- Outhouse Door --
	local sprite = {};
	sprite.sprite = "fixtures_bathroom_02_32";
	local itemName = getText("ContextMenu_OUTHOUSE_DOOR");
	local outhouseDoorOption = subMenu:addOption(itemName, worldobjects, onOuthouseDoor, player);
	local toolTip = ISBuildMenu.canBuild(4,4,2,1,0,5, outhouseDoorOption, player);
	toolTip:setName(itemName);
	toolTip.description = getText("Tooltip_CRAFT_OUTHOUSEDOORDESC") .. toolTip.description;
	toolTip:setTexture(sprite.sprite);

	-- High Fence Gate --
	local sprite = {};
	sprite.sprite = "fixtures_doors_fences_01_12";
	local itemName = getText("ContextMenu_HIGH_FENCE_GATE");
	local highFenceGateOption = subMenu:addOption(itemName, worldobjects, onHighFenceGate, player);
	local toolTip = ISBuildMenu.canBuild(6,6,2,1,0,6, highFenceGateOption, player);
	toolTip:setName(itemName);
	toolTip.description = getText("Tooltip_CRAFT_HIGHFENCEGATEDESC") .. toolTip.description;
	toolTip:setTexture(sprite.sprite);

	-- Fence Gate --
	local sprite = {};
	sprite.sprite = "fixtures_doors_fences_01_4";
	local itemName = getText("ContextMenu_FENCE_GATE");
	local fenceGateOption = subMenu:addOption(itemName, worldobjects, onFenceGate, player);
	local toolTip = ISBuildMenu.canBuild(4,4,2,1,0,4, fenceGateOption, player);
	toolTip:setName(itemName);
	toolTip.description = getText("Tooltip_CRAFT_FENCEGATEDESC") .. toolTip.description;
	toolTip:setTexture(sprite.sprite);

	-- Dog House --
	local sprite = {};
	sprite.sprite = "location_farm_accesories_01_8";
	local itemName = getText("ContextMenu_DOG_HOUSE");
	local dogHouseOption = subMenu:addOption(itemName, worldobjects, onDogHouse, player);
	local toolTip = ISBuildMenu.canBuild(5,5,0,0,0,6, dogHouseOption, player);
	toolTip:setName(itemName);
	toolTip.description = getText("Tooltip_CRAFT_DOGHOUSEDESC") .. toolTip.description;
	toolTip:setTexture(sprite.sprite);

	-- Concrete Floor --
	local sprite = {};
	sprite.sprite = "floors_exterior_street_01_17";
	local itemName = getText("ContextMenu_CONCRETE_FLOOR");
	local conFloorOption = subMenu:addOption(itemName, worldobjects, onConcreteFloor, player);
	local toolTip = ISBuildMenu.canBuild(0,0,0,0,0,6, conFloorOption, player);
	toolTip:setName(itemName);

	if playerInv:containsTagEvalRecurse("DigPlow", predicateNotBroken) then
		toolTip.description = toolTip.description .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.Shovel") .. " 1/1 <LINE> ";
	else
		toolTip.description = toolTip.description .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.Shovel") .. " 0/1 <LINE> ";
		if not ISBuildMenu.cheat then
			conFloorOption.onSelect = nil;
        	conFloorOption.notAvailable = true;
		end
	end
	
	numConcrete = countConcerteUses(player)
	-- Each BucketConcreteFull has 4 uses.
    if numConcrete < 1 then
		toolTip.description = toolTip.description .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.BucketConcreteFull") .. " " .. numConcrete .. "/1 <LINE> ";
        if not ISBuildMenu.cheat then
            conFloorOption.onSelect = nil;
            conFloorOption.notAvailable = true;
        end
    else
		toolTip.description = toolTip.description .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.BucketConcreteFull") .. " " .. numConcrete .. "/1 <LINE> ";
    end

	toolTip.description = getText("Tooltip_CRAFT_CONCRETEFLOORDESC") .. toolTip.description;
	toolTip:setTexture(sprite.sprite);

	-- Parent menu --
	if outhouseDoorOption.notAvailable and highFenceGateOption.notAvailable and fenceGateOption.notAvailable and dogHouseOption.notAvailable and conFloorOption.notAvailable then
		option.notAvailable = true;
	end

end


ISBuildMenu.doBuildMenu = function(player, context, worldobjects, test)
	if test and ISWorldObjectContextMenu.Test then return true end

    if getCore():getGameMode()=="LastStand" then
        return;
    end
	
	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()

	if playerObj:getVehicle() then return; end
	
	local oldaddSubMenu = ISContextMenu.addSubMenu
	local menu = nil
	ISContextMenu.addSubMenu = function(self, option, submenu)
		menu = menu ~= nil and menu or option == context:getOptionFromName(getText("ContextMenu_Build")) and submenu
		return oldaddSubMenu(self, option, submenu)
	end
	local ret = {oldDoBuild(player, context, worldobjects, test)}
	ISContextMenu.addSubMenu = oldaddSubMenu

	if menu and (playerInv:containsTagEvalRecurse("Hammer", predicateNotBroken) or playerInv:containsTagEvalRecurse("DigPlow", predicateNotBroken) or ISBuildMenu.cheat) then
		local expandsOption = menu:addOption(getText("ContextMenu_EXPANDS"), worldobjects, nil);
		local subMenuExpands = menu:getNew(menu);
		context:addSubMenu(expandsOption, subMenuExpands);
		buildExpanedsMenu(subMenuExpands, expandsOption, player)
	end
	return unpack(ret)

end


Events.OnFillWorldObjectContextMenu.Add(ISBuildMenu.doBuildMenu)