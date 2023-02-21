require 'Blacksmith/ISUI/ISBlacksmithMenu'

Events.OnFillWorldObjectContextMenu.Remove(ISBlacksmithMenu.doBuildMenu)

local oldDoBuild = ISBlacksmithMenu.doBuildMenu


local function countMaterial(playerInv, type)
    local count = playerInv:getCountTypeRecurse(type)
    if ISBlacksmithMenu.groundItemCounts[type] then
        count = count + ISBlacksmithMenu.groundItemCounts[type]
    end
    return count
end

local function countUses(playerObj, amount)
    local count = 0;
    local containers = ISInventoryPaneContextMenu.getContainers(playerObj)
    for i=1,containers:size() do
        local container = containers:get(i-1)
        for j=1,container:getItems():size() do
            local item = container:getItems():get(j-1);
            if item:getType() == "IronIngot" then
                count = count + item:getUsedDelta() / item:getUseDelta();
                if count >= amount then
                    return round(count ,0);
                end
            end
        end
    end
    return count;
end


local function onMetalDoor(worldobjects, player)
    local fence = ISWoodenDoor:new("fixtures_doors_01_52","fixtures_doors_01_53", "fixtures_doors_01_54", "fixtures_doors_01_55");
    fence.name = "MetalDoor";
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
    fence.player = player
    getCell():setDrag(fence, player);
end


local function onGarageDoor(worldobjects, player)
    local door =  ISGarageDoor:renew("walls_garage_02_", 0)
    door.name = "GarageDoor";
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
    floor.name = "MetalGrateFloor";
    floor.firstItem = "BlowTorch";
    floor.secondItem = "WeldingMask";
    floor.noNeedHammer = true;
    floor.craftingBank = "BlowTorch";
    floor.actionAnim = "BlowTorchMid";
    floor.hoppable = true;
    floor.isThumpable = false;
    floor.canBarricade = false;
    floor.modData["xp:MetalWelding"] = 5;
    floor.modData["need:Base.ScrapMetal"]= 4;
    floor.modData["use:Base.Wire"] = 2;  -- Wire must be `use:` because it is by unit. not `need"`.
    floor.modData["use:Base.BlowTorch"] = 4;
    floor.modData["use:Base.WeldingRods"] = 2;  -- must be half of Torch use.
    floor.completionSound = "BuildMetalStructureSmallScrap";
    floor.player = player
    getCell():setDrag(floor, player);
end

local function onMetalBarGrateFloor(worldobjects, player)
    local floor =  ISWoodenFloor:new("industry_01_37", "industry_01_38")
    floor.name = "MetalBarGrateFloor";
    floor.firstItem = "BlowTorch";
    floor.secondItem = "WeldingMask";
    floor.noNeedHammer = true;
    floor.craftingBank = "BlowTorch";
    floor.actionAnim = "BlowTorchMid";
    floor.hoppable = true;
    floor.isThumpable = false;
    floor.canBarricade = false;
    floor.modData["xp:MetalWelding"] = 5;
    floor.modData["need:Base.SmallSheetMetal"]= 2;
    floor.modData["need:Base.ScrapMetal"]= 4;
    floor.modData["use:Base.Wire"] = 2;  -- Wire must be `use:` because it is by unit. not `need"`.
    floor.modData["use:Base.BlowTorch"] = 4;
    floor.modData["use:Base.WeldingRods"] = 2;  -- must be half of Torch use.
    floor.completionSound = "BuildMetalStructureSmallScrap";
    floor.player = player
    getCell():setDrag(floor, player);
end


-- local function onMetalDrum(worldobjects, player, source)
--   if source then
--     local sprite = findDrumTransform(source)
--     local barrel = ISMetalDrum:new(player, sprite);
--     barrel.name = "Metal Drum"
--     barrel.firstItem = "BlowTorch";
--     barrel.secondItem = "WeldingMask";
--     barrel.noNeedHammer = true;
--     barrel.craftingBank = "BlowTorch";
--     barrel.actionAnim = "BlowTorchMid";
--     barrel.modData["xp:MetalWelding"] = 5;
--     barrel.modData["use:Base.BlowTorch"] = 6;
--     barrel.modData["use:Base.WeldingRods"] = 3;  -- must be half of Torch use.
--     -- barrel.modData["need:Moveables.industry_01_23"] = 1;
    
--     barrel.player = player;
--     barrel.completedSound = "BuildMetalStructureMedium";
--     getCell():setDrag(barrel, player);
--   end
-- end


local function onMetalDrum(worldobjects, player)
    local barrel = ISMetalDrum:new(player, "crafted_01_24");
    barrel.name = "MetalDrum";  -- careful the name, some function require matched name. ex. contextMenu
    -- barrel.firstItem = "BlowTorch";
    -- barrel.secondItem = "WeldingMask";
    -- barrel.craftingBank = "BlowTorch";
    -- barrel.actionAnim = "BlowTorchMid";
    barrel.modData["need:Base.MetalDrum"] = "1";
    barrel.player = player;
    barrel.completionSound = "BuildMetalStructureMedium";
    getCell():setDrag(barrel, player);
end


local function onStoneFurnace(worldobjects, player)
    local furniture = ISBSFurnace:new("Stone Furnace", "crafted_01_43", "crafted_01_42");
    furniture.modData["need:Base.Stone"]= 20;
    furniture.player = player;
    furniture.craftingBank = "BuildFenceGravelbagFoley";
    furniture.completionSound = "BuildFenceGravelbag";
    getCell():setDrag(furniture, player);
end


local function onAnvil(worldobjects, player)
    local furniture = ISAnvil:new("Anvil", getSpecificPlayer(player), "crafted_01_19", "crafted_01_19");
    furniture.modData["use:Base.IronIngot"]= 500;
    furniture.player = player;
    furniture.completionSound = "BuildMetalStructureMedium";
    getCell():setDrag(furniture, player);
end


local function afterMetaDrumBuild(worldobjects, playerObj)
    local startFire = nil
    local lighter = nil
    local matches = nil
    local percedWood = nil
    local branch = nil
    local stick = nil
    local lightFireList = {}
    local lightDrumFromPetrol = nil;
    local lightDrumFromKindle = nil
    local lightDrumFromLiterature = nil
    local coal = nil;
    local containers = ISInventoryPaneContextMenu.getContainers(playerObj)

    for i=1, containers:size() do
        local container = containers:get(i-1)
        for j=1,container:getItems():size() do
            local item = container:getItems():get(j-1)
            local type = item:getType()
            
            if type == "Lighter" then
                lighter = item
            elseif type == "Matches" then
                matches = item
            elseif type == "PercedWood" then
                percedWood = item
            elseif type == "TreeBranch" then
                branch = item
            elseif type == "WoodenStick" then
                stick = item
            elseif type == "Coal" or type == "Charcoal" then
                coal = item
            elseif item:hasTag("StartFire") then
                startFire = item
            end

            if campingLightFireType[type] then
                if campingLightFireType[type] > 0 then
                    table.insert(lightFireList, item)
                end
            elseif campingLightFireCategory[item:getCategory()] then
                table.insert(lightFireList, item)
            end
        end
    end

    local metalDrumIsoObj = nil
    local metalDrumLuaObj = nil
    local sq;
    for i,v in ipairs(worldobjects) do
        sq = v:getSquare();
        if CMetalDrumSystem.instance:isValidIsoObject(v) then
            metalDrumIsoObj = v
            metalDrumLuaObj = CMetalDrumSystem.instance:getLuaObjectOnSquare(v:getSquare())
        end

        if percedWood and (stick or branch) and metalDrumLuaObj and metalDrumLuaObj.haveLogs and not metalDrumLuaObj.isLit and not metalDrumLuaObj.haveCharcoal and playerObj:getStats():getEndurance() > 0 then
            lightDrumFromKindle = metalDrumLuaObj
        end

        if (startFire or lighter or matches) and metalDrumLuaObj and metalDrumLuaObj.haveLogs and not metalDrumLuaObj.isLit and not metalDrumLuaObj.haveCharcoal then
            lightDrumFromLiterature = metalDrumLuaObj
        end
    end

    if lightDrumFromPetrol or lightDrumFromKindle or (lightDrumFromLiterature and #lightFireList > 0) then
        if test then return ISWorldObjectContextMenu.setTest() end
        local lightOption = context:addOption(getText("ContextMenu_LitDrum"), worldobjects, nil);
        local subMenuLight = ISContextMenu:getNew(context);
        context:addSubMenu(lightOption, subMenuLight);
        
        for i,v in pairs(lightFireList) do
            local label = v:getName()
            if lighter then
                local LitOption = subMenuLight:addOption(label..' + '..lighter:getName(), worldobjects, ISBlacksmithMenu.onLightDrumFromLiterature, player, v, lighter, lightDrumFromLiterature, coal)
                local tooltip = ISWorldObjectContextMenu.addToolTip()
                tooltip:setName(getText("ContextMenu_LitDrum"))
                tooltip.description = getText("Tooltip_Charcoal");
                LitOption.toolTip = tooltip
            end
            if matches then
                local LitOption = subMenuLight:addOption(label..' + '..matches:getName(), worldobjects, ISBlacksmithMenu.onLightDrumFromLiterature, player, v, matches, lightDrumFromLiterature, coal)
                local tooltip = ISWorldObjectContextMenu.addToolTip()
                tooltip:setName(getText("ContextMenu_LitDrum"))
                tooltip.description = getText("Tooltip_Charcoal");
                LitOption.toolTip = tooltip
            end
            if startFire then
                local LitOption = subMenuLight:addOption(label..' + '..startFire:getName(), worldobjects, ISBlacksmithMenu.onLightDrumFromLiterature, player, v, startFire, lightDrumFromLiterature, coal)
                local tooltip = ISWorldObjectContextMenu.addToolTip()
                tooltip:setName(getText("ContextMenu_LitDrum"))
                tooltip.description = getText("Tooltip_Charcoal");
                LitOption.toolTip = tooltip
            end
        end
        if lightDrumFromKindle then
            if stick then
                local LitOption = subMenuLight:addOption(percedWood:getName()..' + '..stick:getName(), worldobjects, ISBlacksmithMenu.onLightDrumFromKindle, player, percedWood, stick, lightDrumFromKindle);
                local tooltip = ISWorldObjectContextMenu.addToolTip()
                tooltip:setName(getText("ContextMenu_LitDrum"))
                tooltip.description = getText("Tooltip_Charcoal");
                LitOption.toolTip = tooltip
            elseif branch then
                local LitOption = subMenuLight:addOption(percedWood:getName()..' + '..branch:getName(), worldobjects, ISBlacksmithMenu.onLightDrumFromKindle, player, percedWood, branch, lightDrumFromKindle);
                local tooltip = ISWorldObjectContextMenu.addToolTip()
                tooltip:setName(getText("ContextMenu_LitDrum"))
                tooltip.description = getText("Tooltip_Charcoal");
                LitOption.toolTip = tooltip
            end
        end
    end

    if metalDrumLuaObj and playerObj:DistToSquared(metalDrumIsoObj:getX() + 0.5, metalDrumIsoObj:getY() + 0.5) < 2 * 2 then
        local option = context:addOption(getText("ContextMenu_Metal_Drum"), worldobjects, nil)
        local subMenuDrum = ISContextMenu:getNew(context);
        context:addSubMenu(option, subMenuDrum);
        local tooltip = ISWorldObjectContextMenu.addToolTip()
        tooltip:setName(getText("ContextMenu_Metal_Drum"))
        if metalDrumIsoObj:getWaterAmount() > 0 then
            local tx = getTextManager():MeasureStringX(tooltip.font, getText("ContextMenu_WaterName") .. ":") + 20
            --tooltip.description = getText("Water Percent ", round((metalDrumIsoObj:getWaterAmount() / metalDrumLuaObj.waterMax) * 100))
            tooltip.description = string.format("%s: <SETX:%d> %d / %d", getText("ContextMenu_WaterName"), tx, metalDrumIsoObj:getWaterAmount(), metalDrumIsoObj:getWaterMax());
        elseif metalDrumLuaObj.haveLogs and metalDrumLuaObj.isLit then
            if not metalDrumLuaObj.charcoalTick then
                tooltip.description = getText("Tooltip_Charcoal_Progression") .. " 0%";
            else
                tooltip.description = getText("Tooltip_Charcoal_Progression") .. " " .. (round((metalDrumLuaObj.charcoalTick / 12) * 100)) .. "%";
            end
        end
        if metalDrumIsoObj:getWaterAmount() > 0 or (metalDrumLuaObj.haveLogs and metalDrumLuaObj.isLit) then
            option.toolTip = tooltip
        end
        if metalDrumIsoObj:getWaterAmount() > 0 then
            subMenuDrum:addOption(getText("ContextMenu_Empty"), worldobjects, ISBlacksmithMenu.onEmptyDrum, metalDrumLuaObj, playerObj);
        else
            if not metalDrumLuaObj.haveLogs and not metalDrumLuaObj.haveCharcoal then
    --                subMenuDrum:addOption("Remove", worldobjects, ISBlacksmithMenu.onRemoveDrum, metalDrumLuaObj, playerObj);
                local addWoodOption = subMenuDrum:addOption(getText("ContextMenu_Add_Logs"), worldobjects, ISBlacksmithMenu.onAddLogs, metalDrumLuaObj, playerObj);
                local tooltip = ISWorldObjectContextMenu.addToolTip()
                tooltip:setName(getText("ContextMenu_Add_Logs"))
                tooltip.description = getText("Tooltip_Charcoal_Logs");
                addWoodOption.toolTip = tooltip
                if playerInv:getItemCount("Base.Log") < 5 then
                    addWoodOption.notAvailable = true;
                end
            else
                if metalDrumLuaObj.isLit then
                    subMenuDrum:addOption(getText("ContextMenu_Put_out_fire"), worldobjects, ISBlacksmithMenu.onPutOutFireDrum, metalDrumLuaObj, playerObj);
                elseif not metalDrumLuaObj.isLit and not metalDrumLuaObj.haveCharcoal then
    --                    subMenuDrum:addOption("Remove", worldobjects, ISBlacksmithMenu.onRemoveDrum, metalDrumLuaObj, playerObj);
                    subMenuDrum:addOption(getText("ContextMenu_Remove_Logs"), worldobjects, ISBlacksmithMenu.onRemoveLogs, metalDrumLuaObj, playerObj);
                end
            end
            if metalDrumLuaObj.haveCharcoal then
                subMenuDrum:addOption(getText("ContextMenu_RemoveCharcoal"), worldobjects, ISBlacksmithMenu.onRemoveCharcoal, metalDrumLuaObj, playerObj);
            end
        end
    end
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
    local drumOption = {};
    local furnaceOption = {};
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

        -- Metal Drum --
        local sprite = {};
        sprite.sprite = "crafted_01_24";

        local itemName = getText("ContextMenu_METAL_DRUM");
        -- local barrelName = getText("ContextMenu_METAL_BARREL");
        drumOption = subMenu:addOption(itemName, worldobjects, onMetalDrum, player);
        local toolTip = ISBlacksmithMenu.addToolTip(drumOption, itemName, sprite.sprite)
        toolTip.description = getText("Tooltip_CRAFT_METALDRUMDESC") .. toolTip.description;
        
        if not playerObj:getInventory():contains("MetalDrum") then
            toolTip.description = toolTip.description .. " <LINE> <RGB:1,0,0> " .. getItemText("Metal Drum") .. " 0/1" ;
            drumOption.notAvailable = true;
        else
            toolTip.description = toolTip.description .. " <LINE> <RGB:1,1,1> " .. getItemText("Metal Drum") .. " 1/1" ;
        end

        -- DON'T Know how to remoave moveables item from player inventory.
        -- GIVE UP TO BUILD By Metal Barrels.
        -- local source_barrel = findDrum(playerInv)  -- put it before addOption, pass the source into the callback.
        -- if not source_barrel then
        --     toolTip.description = toolTip.description .. " <LINE> " .. ISBlacksmithMenu.bhs .. barrelName .. " 0/1" ;
        --     drumOption.notAvailable = true;
        -- else
        --     toolTip.description = toolTip.description .. " <LINE> " .. ISBlacksmithMenu.ghs .. barrelName .. " 1/1" ;
        -- end


        -- StoneFurnace --
        local sprite = {};
        sprite.sprite = "crafted_01_16";

        local itemName = getText("ContextMenu_STONE_FURNACE");
        furnaceOption = subMenu:addOption(itemName, worldobjects, onStoneFurnace, player);
        local toolTip = ISBlacksmithMenu.addToolTip(furnaceOption, itemName, sprite.sprite)
        toolTip.description = getText("Tooltip_CRAFT_STONEFURNACEDESC") .. toolTip.description;
        local resourceCount = countMaterial(playerInv, "Base.Stone")
        if countMaterial(playerInv, "Base.Stone") < 50 then
        toolTip.description = toolTip.description .. " <LINE> " .. ISBlacksmithMenu.bhs .. getItemNameFromFullType("Base.Stone") .. " " .. resourceCount .. "/50" ;
        furnaceOption.notAvailable = true;
        else
        toolTip.description = toolTip.description .. " <LINE> " .. ISBlacksmithMenu.ghs .. getItemNameFromFullType("Base.Stone") .. " " .. resourceCount .. "/50" ;
        end

    else
        metalGrateOption.notAvailable = not(ISBuildMenu.cheat);
        metalBarGrateOption.notAvailable = not(ISBuildMenu.cheat);
        drumOption.notAvailable = not(ISBuildMenu.cheat);
        furnaceOption.notAvailable = not(ISBuildMenu.cheat);
    end

    -- Anvil --
    local sprite = {};
    sprite.sprite = "crafted_01_19";

    local itemName = getText("ContextMenu_ANVIL");
    local anvilOption = subMenu:addOption(itemName, worldobjects, onAnvil, player);
    local toolTip = ISBlacksmithMenu.addToolTip(anvilOption, itemName, sprite.sprite)
    toolTip.description = getText("Tooltip_CRAFT_ANVILDESC") .. toolTip.description;
    
    local canBeCrafted = playerInv:contains("Hammer") and playerInv:contains("Log");
    if not playerInv:contains("Hammer") then
        toolTip.description = toolTip.description .. " <LINE> " .. ISBlacksmithMenu.bhs .. getItemNameFromFullType("Base.Hammer") .. " 0/1" ;
        anvilOption.notAvailable = true;
    else
        toolTip.description = toolTip.description .. " <LINE> " .. ISBlacksmithMenu.ghs .. getItemNameFromFullType("Base.Hammer") .. " 1/1" ;
    end
    if not playerInv:contains("Log") then
        toolTip.description = toolTip.description .. " <LINE> " .. ISBlacksmithMenu.bhs .. getItemNameFromFullType("Base.Log") .. " 0/1" ;
        anvilOption.notAvailable = true;
    else
        toolTip.description = toolTip.description .. " <LINE> " .. ISBlacksmithMenu.ghs .. getItemNameFromFullType("Base.Log") .. " 1/1" ;
    end

    if canBeCrafted then
        local metalCount = countUses(playerObj, 500);
        if metalCount < 500 then
            toolTip.description = toolTip.description .. " <LINE> " .. ISBlacksmithMenu.bhs .. getItemNameFromFullType("Base.IronIngot") .. " " .. metalCount .. " /500 Unit";
            anvilOption.notAvailable = true;
        else
            toolTip.description = toolTip.description .. " <LINE> " .. ISBlacksmithMenu.ghs .. getItemNameFromFullType("Base.IronIngot") .. " " .. metalCount .. " /500 Unit";
        end
    else
        anvilOption.notAvailable = true;
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


    -- Path for Vanilla `Put out fire` on furance --
    local furnace = nil;
    local metalDrumIsoObj = nil;
    local metalDrumLuaObj = nil;
    for i, v in ipairs(worldobjects) do
        -- find stone furnace --
        if instanceof(v, "BSFurnace") then
            furnace = v;
        end
    end
    
    if furnace then
        context:removeOptionByName(getText("ContextMenu_Put_out_fire"));
        context:addOption(getText("ContextMenu_Put_out_fire"), worldobjects, ISBlacksmithMenu.onStopFire, furnace, playerObj);
    end

    return unpack(ret)

end


Events.OnFillWorldObjectContextMenu.Add(ISBlacksmithMenu.doBuildMenu)