require 'Blacksmith/ISUI/ISBlacksmithMenu'

Events.OnFillWorldObjectContextMenu.Remove(ISBlacksmithMenu.doBuildMenu)

local oldDoBuild = ISBlacksmithMenu.doBuildMenu


local function onMetalDoor(worldobjects, player)
    local fence = ISWoodenDoor:new("fixtures_doors_01_52","fixtures_doors_01_53", "fixtures_doors_01_54", "fixtures_doors_01_55");
    fence.name = "Metal Door";
    fence.firstItem = "BlowTorch";
    fence.secondItem = "WeldingMask";
    fence.craftingBank = "BlowTorch";
    fence.noNeedHammer = true;
    fence.actionAnim = "BlowTorchMid";
    fence.canBarricade = true;
    fence.modData["xp:MetalWelding"] = 25;
    fence.modData["need:Base.SheetMetal"]= 2;
    fence.modData["need:Base.Hinge"]= 2;
    fence.modData["need:Base.ScrapMetal"]= 2;
    fence.modData["need:Base.Hinge"]= 2;
    fence.modData["use:Base.BlowTorch"] = 6;
    fence.modData["use:Base.WeldingRods"] = 3;  -- must be half of Torch use.
    fence.completionSound = "BuildMetalStructureSmallScrap";
    fence.player = player
    getCell():setDrag(fence, player);
end


local function onGarageDoor(worldobjects, player)
    local door =  ISGarageDoor:renew("walls_garage_02_", 0)
    door.name = "Rolling Garage Door";
    door.firstItem = "BlowTorch";
    door.secondItem = "WeldingMask";
    door.craftingBank = "BlowTorch";
    door.noNeedHammer = true;
    door.actionAnim = "BlowTorchMid";
    door.canBarricade = false;
    door.modData["xp:MetalWelding"] = 10;
    door.modData["need:Base.SheetMetal"] = 8;
    door.modData["need:Base.ScrapMetal"]= 2;
    door.modData["need:Base.Hinge"]= 2;
    door.modData["use:Base.Wire"] = 5;  -- Wire must be `use:`(1 wire has 5 unit) because it is by unit. not `need"`.
    door.modData["use:Base.BlowTorch"] = 10;
    door.modData["use:Base.WeldingRods"] = 5;  -- must be half of Torch use.
    door.completionSound = "BuildMetalStructureSmallScrap";
    door.player = player
    door.ignoreNorth = true;
    getCell():setDrag(door, player);
end


local function onMetalGrateFloor(worldobjects, player)
    local floor =  ISWoodenFloor:new("industry_01_39", "industry_01_39")
    floor.name = "Metal Grate Floor";
    floor.firstItem = "BlowTorch";
    floor.secondItem = "WeldingMask";
    floor.noNeedHammer = true;
    floor.craftingBank = "BlowTorch";
    floor.actionAnim = "BlowTorchFloor";
    floor.hoppable = true;
    floor.isThumpable = false;
    floor.canBarricade = false;
    floor.modData["xp:MetalWelding"] = 5;
    floor.modData["need:Base.ScrapMetal"]= 4;
    floor.modData["use:Base.Wire"] = 2;  -- Wire must be `use:` because it is by unit. not `need"`.
    floor.modData["use:Base.BlowTorch"] = 4;
    floor.modData["use:Base.WeldingRods"] = 2;  -- must be half of Torch use.
    floor.completionSound = "BuildMetalStructureSmallWiredFence";
    floor.player = player
    getCell():setDrag(floor, player);
end

local function onMetalBarGrateFloor(worldobjects, player)
    local floor =  ISWoodenFloor:new("industry_01_37", "industry_01_38")
    floor.name = "Metal Bar Grate Floor";
    floor.firstItem = "BlowTorch";
    floor.secondItem = "WeldingMask";
    floor.noNeedHammer = true;
    floor.craftingBank = "BlowTorch";
    floor.actionAnim = "BlowTorchFloor";
    floor.hoppable = true;
    floor.isThumpable = false;
    floor.canBarricade = false;
    floor.modData["xp:MetalWelding"] = 5;
    floor.modData["need:Base.SmallSheetMetal"]= 2;
    floor.modData["need:Base.ScrapMetal"]= 4;
    floor.modData["use:Base.Wire"] = 2;  -- Wire must be `use:` because it is by unit. not `need"`.
    floor.modData["use:Base.BlowTorch"] = 4;
    floor.modData["use:Base.WeldingRods"] = 2;  -- must be half of Torch use.
    floor.completionSound = "BuildMetalStructureLargeWiredFence";
    floor.player = player
    getCell():setDrag(floor, player);
end


local function onMetalDrum(worldobjects, player)
    local barrel = ISMetalDrum:new(player, "crafted_01_24");
    barrel.name = "MetalDrum";  -- careful the name, some function require matched name. ex. contextMenu
    barrel.firstItem = "BlowTorch";
    barrel.secondItem = "WeldingMask";
    barrel.craftingBank = "BlowTorch";
    barrel.actionAnim = "BlowTorchMid";
    barrel.modData["xp:MetalWelding"] = 5;
    barrel.modData["use:Base.BlowTorch"] = 6;
    barrel.modData["use:Base.WeldingRods"] = 3;  -- must be half of Torch use.
    barrel.modData["need:Base.SheetMetal"] = 4;
    barrel.modData["need:Base.ScrapMetal"] = 6;
    barrel.player = player;
    barrel.completionSound = "BuildMetalStructureMedium";
    getCell():setDrag(barrel, player);
end


local function buildExpanedsMenu(subMenu, option, player)
    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()

    local metalDoorOption = {};
    local garageDoorOption = {};
    if playerObj:getKnownRecipes():contains("Make Metal Fences") or ISBuildMenu.cheat then
        local sprite = {};
        sprite.sprite = "fixtures_doors_01_52";
        local itemName = getText("ContextMenu_METAL_DOOR");
        local metalDoorOption = subMenu:addOption(itemName, worldobjects, onMetalDoor, player)
        local toolTip = ISBlacksmithMenu.addToolTip(metalDoorOption, itemName, sprite.sprite)
        toolTip.description = getText("Tooltip_CRAFT_METALDOORDESC") .. toolTip.description;

        local canCraft = ISBlacksmithMenu.checkMetalWeldingFurnitures(0, 0, 2, 2, 2, 8, 4, playerObj, toolTip, 0, 0)
        -- checkMetalWeldingFurnitures(metalPipes, smallMetalSheet, metalSheet, hinge, scrapMetal, torchUse, skill, player, toolTip, metalBar, wire)

        if not canCraft then metalDoorOption.notAvailable = true; end

        local sprite = {};
        sprite.sprite = "walls_garage_02_1";
        local itemName = getText("ContextMenu_GARAGE_DOOR");
        garageDoorOption = subMenu:addOption(itemName, worldobjects, onGarageDoor, player);
        local toolTip = ISBlacksmithMenu.addToolTip(garageDoorOption, itemName, sprite.sprite)
        toolTip.description = getText("Tooltip_CRAFT_GARAGEDOORDESC") .. toolTip.description;

        local canCraft = ISBlacksmithMenu.checkMetalWeldingFurnitures(6, 0, 8, 2, 2, 10, 8, playerObj, toolTip, 0, 5)
        -- checkMetalWeldingFurnitures(metalPipes, smallMetalSheet, metalSheet, hinge, scrapMetal, torchUse, skill, player, toolTip, metalBar, wire)

        if not canCraft then garageDoorOption.notAvailable = true; end

    else
        garageDoorOption.notAvailable = not(ISBuildMenu.cheat);
        metalDoorOption.notAvailable = not(ISBuildMenu.cheat);
    end

    local metalGrateOption = {};
    local metalBarGrateOption = {};
    if playerObj:getKnownRecipes():contains("Make Metal Roof") or ISBuildMenu.cheat then
        -- Warehouse Floor --
        local sprite = {};
        sprite.sprite = "industry_01_39";
        local itemName = getText("ContextMenu_METAL_GRATE");
        metalGrateOption = subMenu:addOption(itemName, worldobjects, onMetalGrateFloor, player);
        local toolTip = ISBlacksmithMenu.addToolTip(metalGrateOption, itemName, sprite.sprite)
        toolTip.description = getText("Tooltip_CRAFT_METALGRATEDESC") .. toolTip.description;

        local canCraft = ISBlacksmithMenu.checkMetalWeldingFurnitures(0, 0, 0, 0, 4, 4, 8, playerObj, toolTip, 0, 2)
        -- checkMetalWeldingFurnitures(metalPipes, smallMetalSheet, metalSheet, hinge, scrapMetal, torchUse, skill, player, toolTip, metalBar, wire)

        if not canCraft then metalGrateOption.notAvailable = true; end

        -- Enhanced Warehouse Floor --
        local sprite = {};
        sprite.sprite = "industry_01_37";
        local itemName = getText("ContextMenu_METAL_BAR_GRATE");
        metalBarGrateOption = subMenu:addOption(itemName, worldobjects, onMetalBarGrateFloor, player);
        local toolTip = ISBlacksmithMenu.addToolTip(metalBarGrateOption, itemName, sprite.sprite)
        toolTip.description = getText("Tooltip_CRAFT_METALBARGRATEDESC") .. toolTip.description;

        local canCraft = ISBlacksmithMenu.checkMetalWeldingFurnitures(0, 2, 0, 0, 4, 4, 8, playerObj, toolTip, 0, 2)
        -- checkMetalWeldingFurnitures(metalPipes, smallMetalSheet, metalSheet, hinge, scrapMetal, torchUse, skill, player, toolTip, metalBar, wire)

        if not canCraft then metalBarGrateOption.notAvailable = true; end

    else
        metalGrateOption.notAvailable = not(ISBuildMenu.cheat);
        metalBarGrateOption.notAvailable = not(ISBuildMenu.cheat);
    end

    local drumOption = {};
    if playerObj:isRecipeKnown("Make Metal Containers") or ISBuildMenu.cheat then
        -- Metal Drum --
        local sprite = {};
        sprite.sprite = "crafted_01_24";

        local itemName = getText("ContextMenu_METAL_DRUM");
        -- local barrelName = getText("ContextMenu_METAL_BARREL");
        drumOption = subMenu:addOption(itemName, worldobjects, onMetalDrum, player);
        local toolTip = ISBlacksmithMenu.addToolTip(drumOption, itemName, sprite.sprite)
        toolTip.description = getText("Tooltip_CRAFT_METALDRUMDESC") .. toolTip.description;
        
        local canCraft = ISBlacksmithMenu.checkMetalWeldingFurnitures(0, 0, 4, 0, 6, 6, 8, playerObj, toolTip, 0, 0)
        -- checkMetalWeldingFurnitures(metalPipes, smallMetalSheet, metalSheet, hinge, scrapMetal, torchUse, skill, player, toolTip, metalBar, wire)

        if not canCraft then drumOption.notAvailable = true; end
    else
        drumOption.notAvailable = not(ISBuildMenu.cheat);
    end

    -- Parent menu --
	if metalDoorOption.notAvailable and garageDoorOption.notAvailable and metalGrateOption.notAvailable and metalBarGrateOption.notAvailable and drumOption.notAvailable then
		option.notAvailable = true;
	end

end


ISBlacksmithMenu.doBuildMenu = function(player, context, worldobjects, test)
    if test and ISWorldObjectContextMenu.Test then return true end

    if getCore():getGameMode()=="LastStand" then
        return;
    end

    if test then return ISWorldObjectContextMenu.setTest() end

    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()
    
    if playerObj:getVehicle() then return; end

    local oldaddSubMenu = ISContextMenu.addSubMenu
    local menu = nil
    ISContextMenu.addSubMenu = function(self, option, submenu)
        menu = menu ~= nil and menu or option == context:getOptionFromName(getText("ContextMenu_MetalWelding")) and submenu
        return oldaddSubMenu(self, option, submenu)
    end
    local ret = {oldDoBuild(player, context, worldobjects, test)}
    ISContextMenu.addSubMenu = oldaddSubMenu


    if menu then
        local expandsOption = menu:addOption(getText("ContextMenu_EXPANDS"), worldobjects, nil);
        local subMenuExpands = menu:getNew(menu);
        context:addSubMenu(expandsOption, subMenuExpands);
        buildExpanedsMenu(subMenuExpands, expandsOption, player);
    end

    return unpack(ret)

end


Events.OnFillWorldObjectContextMenu.Add(ISBlacksmithMenu.doBuildMenu)