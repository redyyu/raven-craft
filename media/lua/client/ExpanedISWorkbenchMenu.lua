require 'BuildingObjects/ISUI/ISBuildMenu'
require 'Blacksmith/ISUI/ISBlacksmithMenu'

local ISBuildBenchMenu = {}

local function predicateNotBroken(item)
    return not item:isBroken()
end


local function predicateDigGrave(item)
    return not item:isBroken() and item:hasTag("DigGrave")
end


local function requireHammer(playerInv, option)
    if not playerInv:containsTagEvalRecurse("Hammer", predicateNotBroken) and not ISBuildMenu.cheat then
        option.onSelect = nil
        option.notAvailable = true
    end
end


local WorkBench = {}


WorkBench.onStoneFurnace = function(worldobjects, playerNum)
    -- Object name will be 'StoneFurnace'
    local furnace = ISBSFurnace:new("Stone Furnace", "crafted_01_42", "crafted_01_43")
    furnace.modData["xp:Woodwork"] = 30
    furnace.craftingBank = "Hammering"
    furnace.modData["need:Base.Stone"]= 30
    furnace.player = playerNum
    furnace.completionSound = "BuildFenceGravelbag"
    furnace.maxTime = 1200
    getCell():setDrag(furnace, playerNum)
end


WorkBench.onAnvil = function(worldobjects, playerNum)
    -- Object name will be 'Anvil' recipe NearItem is work.
    local anvil = ISAnvil:new("Anvil", getSpecificPlayer(playerNum), "crafted_01_19", "crafted_01_19")
    anvil.modData["xp:Woodwork"] = 30
    anvil.craftingBank = "Hammering"
    anvil.modData["use:Base.IronIngot"]= 500
    anvil.modData["need:Base.Log"]= 1
    anvil.player = playerNum
    anvil.maxTime = 600
    anvil.completionSound = "BuildMetalStructureMedium"
    getCell():setDrag(anvil, playerNum)
end


WorkBench.onWaterWell = function(worldobjects, playerNum, shovel)
    local well = ISWaterWell:new("Well", playerNum, shovel, "camping_01_16")
    well.modData["xp:Woodwork"] = 30
    well.modData["need:Base.Plank"] = 4
    well.modData["need:Base.Nails"] = 12
    well.modData["need:Base.Stone"] = 25
    well.modData["need:Base.MetalPipe"] = 1
    well.modData["need:Base.MetalBar"] = 1
    well.modData["need:Base.Rope"] = 1
    well.modData["need:Base.BucketEmpty"] = 1
    well.craftingBank = "DigFurrowWithShovel"
    well.actionAnim = "DigShovel"
    well.player = playerNum
    well.maxTime = 1200
    well.completionSound = "BuildFenceGravelbag"
    getCell():setDrag(well, playerNum)
end


WorkBench.doBuildFurnaceMenu = function (workbenchMenu, playerNum)
    local playerObj = getSpecificPlayer(playerNum)
    local playerInv = playerObj:getInventory()

    -- StoneFurnace --
    local spriteName = "crafted_01_42" -- "crafted_01_16"
    local itemName = getText("ContextMenu_STONE_FURNACE")
    local furnaceOption = workbenchMenu:addOption(itemName, worldobjects, WorkBench.onStoneFurnace, playerNum)

    local tooltip = ISBuildMenu.canBuild(0,0,0,0,0,6, furnaceOption, playerNum)
    -- ISBuildMenu.canBuild(plankNb, nailsNb, hingeNb, doorknobNb, baredWireNb, carpentrySkill, option, player)
    tooltip:setName(itemName)
    tooltip.description = getText("Tooltip_CRAFT_STONEFURNACEDESC") .. tooltip.description
    tooltip:setTexture(spriteName)

    requireHammer(playerInv, furnaceOption)
    
    local stoneCount = playerInv:getCountTypeRecurse("Base.Stone")
    if stoneCount >= 30 then
        tooltip.description = tooltip.description .. " <LINE> " .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.Stone") .. " " .. stoneCount .. "/30"
    else
        tooltip.description = tooltip.description .. " <LINE> " .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.Stone") .. " " .. stoneCount .. "/30"
        if not ISBuildMenu.cheat then
            furnaceOption.onSelect = nil
            furnaceOption.notAvailable = true
        end
    end

    return furnaceOption

end


WorkBench.doBuildAnvilMenu = function(workbenchMenu, playerNum)
    local playerObj = getSpecificPlayer(playerNum)
    local playerInv = playerObj:getInventory()

    -- Anvil --
    local spriteName = "crafted_01_19"

    local itemName = getText("ContextMenu_ANVIL")
    anvilOption = workbenchMenu:addOption(itemName, worldobjects, WorkBench.onAnvil, playerNum)
    local tooltip = ISBuildMenu.canBuild(0,0,0,0,0,6, anvilOption, playerNum)
    -- ISBuildMenu.canBuild(plankNb, nailsNb, hingeNb, doorknobNb, baredWireNb, carpentrySkill, option, player)
    tooltip:setName(itemName)
    tooltip.description = getText("Tooltip_CRAFT_ANVILDESC") .. tooltip.description
    tooltip:setTexture(spriteName)
    
    local metalCount = playerInv:getUsesTypeRecurse("Base.IronIngot")
    local logCount = playerInv:getCountTypeRecurse("Base.Log")

    requireHammer(playerInv, anvilOption)

    if logCount >= 1 then
        tooltip.description = tooltip.description .. " <LINE> " .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.Log") .. " 1/1"
    else
        tooltip.description = tooltip.description .. " <LINE> " .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.Log") .. " 0/1"
        if not ISBuildMenu.cheat then
            anvilOption.onSelect = nil
            anvilOption.notAvailable = true
        end
    end

    if metalCount >= 500 then
        tooltip.description = tooltip.description .. " <LINE> " .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.IronIngot") .. " " .. metalCount .. " /500 Unit"
    else
        tooltip.description = tooltip.description .. " <LINE> " .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.IronIngot") .. " " .. metalCount .. " /500 Unit"
        if not ISBuildMenu.cheat then
            anvilOption.onSelect = nil
            anvilOption.notAvailable = true
        end
    end

    return anvilOption
end


WorkBench.doBuildWellMenu = function(workbenchMenu, playerNum)
    local playerObj = getSpecificPlayer(playerNum)
    local playerInv = playerObj:getInventory()

    -- Water Well --
    local spriteName = "camping_01_16"
    local shovel = playerInv:getFirstEvalRecurse(predicateDigGrave)

    local itemName = getText("ContextMenu_WATER_WELL")
    wellOption = workbenchMenu:addOption(itemName, worldobjects, WorkBench.onWaterWell, playerNum, shovel)

    local tooltip = ISBuildMenu.canBuild(4,12,0,0,0,6, wellOption, playerNum)
    -- ISBuildMenu.canBuild(plankNb, nailsNb, hingeNb, doorknobNb, baredWireNb, carpentrySkill, option, player)
    tooltip:setName(itemName)
    tooltip.description = getText("Tooltip_CRAFT_WATERWELLDESC") .. tooltip.description
    tooltip:setTexture(spriteName)

    local stoneCount = playerInv:getCountTypeRecurse("Base.Stone")
    local ropeCount = playerInv:getCountTypeRecurse("Base.Rope")
    local bucketCount = playerInv:getCountTypeRecurse("Base.BucketEmpty")
    local pipeCount = playerInv:getCountTypeRecurse("Base.MetalPipe")
    local barCount = playerInv:getCountTypeRecurse("Base.MetalBar")

    if shovel then
        tooltip.description = tooltip.description .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.Shovel") .. " <LINE> "
    else
        tooltip.description = tooltip.description .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.Shovel") .. " <LINE> "
        if not ISBuildMenu.cheat then
            wellOption.onSelect = nil
            wellOption.notAvailable = true
        end
    end

    if stoneCount >= 25 then
        tooltip.description = tooltip.description .. " <LINE> " .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.Stone") .. " " .. stoneCount .. "/25"
    else
        tooltip.description = tooltip.description .. " <LINE> " .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.Stone") .. " " .. stoneCount .. "/25"
        if not ISBuildMenu.cheat then
            wellOption.onSelect = nil
            wellOption.notAvailable = true
        end
    end
    if ropeCount >= 1 then
        tooltip.description = tooltip.description .. " <LINE> " .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.Rope") .. " " .. ropeCount .. "/1"
    else
        tooltip.description = tooltip.description .. " <LINE> " .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.Rope") .. " " .. ropeCount .. "/1"
        if not ISBuildMenu.cheat then
            wellOption.onSelect = nil
            wellOption.notAvailable = true
        end
    end
    if pipeCount >= 1 then
        tooltip.description = tooltip.description .. " <LINE> " .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.MetalPipe") .. " " .. pipeCount .. "/1"
    else
        tooltip.description = tooltip.description .. " <LINE> " .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.MetalPipe") .. " " .. pipeCount .. "/1"
        if not ISBuildMenu.cheat then
            wellOption.onSelect = nil
            wellOption.notAvailable = true
        end
    end
    if barCount >= 1 then
        tooltip.description = tooltip.description .. " <LINE> " .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.MetalBar") .. " " .. barCount .. "/1"
    else
        tooltip.description = tooltip.description .. " <LINE> " .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.MetalBar") .. " " .. barCount .. "/1"
        if not ISBuildMenu.cheat then
            wellOption.onSelect = nil
            wellOption.notAvailable = true
        end
    end
    if bucketCount >= 1 then
        tooltip.description = tooltip.description .. " <LINE> " .. ISBuildMenu.ghs .. getItemNameFromFullType("Base.BucketEmpty") .. " " .. bucketCount .. "/1"
    else
        tooltip.description = tooltip.description .. " <LINE> " .. ISBuildMenu.bhs .. getItemNameFromFullType("Base.BucketEmpty") .. " " .. bucketCount .. "/1"
        if not ISBuildMenu.cheat then
            wellOption.onSelect = nil
            wellOption.notAvailable = true
        end
    end

    return wellOption
end


WorkBench.onFillWorldObjectContextMenu = function(playerNum, context, worldobjects, test)
    if test and ISWorldObjectContextMenu.Test then return true end

    if getCore():getGameMode()=="LastStand" then
        return
    end
    
    local playerObj = getSpecificPlayer(playerNum)
    local playerInv = playerObj:getInventory()

    if playerObj:getVehicle() then return end

    local option = context:getOptionFromName(getText("ContextMenu_Build"))

    if option and (playerObj:getKnownRecipes():contains("Craft Workbench") or ISBuildMenu.cheat) then
        local buildMenu = context:getSubMenu(option.subOption)
        local workbenchOption = buildMenu:addOptionOnTop(getText("ContextMenu_WORKBENCH"), worldobjects, nil)
        local workbenchMenu = ISContextMenu:getNew(context)
        buildMenu:addSubMenu(workbenchOption, workbenchMenu)
        
        local furnaceOpt = WorkBench.doBuildFurnaceMenu(workbenchMenu, playerNum)
        local anvilOpt = WorkBench.doBuildAnvilMenu(workbenchMenu, playerNum)
        local wellOpt = WorkBench.doBuildWellMenu(workbenchMenu, playerNum)

        -- Parent menu --
        if furnaceOpt.notAvailable and anvilOpt.notAvailable and wellOpt.notAvailable then
            workbenchOption.notAvailable = true
        end
    end

end


Events.OnFillWorldObjectContextMenu.Add(WorkBench.onFillWorldObjectContextMenu)