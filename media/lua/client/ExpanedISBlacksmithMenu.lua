require 'Blacksmith/ISUI/ISBlacksmithMenu'


local function onMetalDoor(worldobjects, player)
    local fence = ISWoodenDoor:new("fixtures_doors_01_52", "fixtures_doors_01_53", "fixtures_doors_01_54", "fixtures_doors_01_55")
    fence.name = "Metal Door"
    fence.firstItem = "BlowTorch"
    fence.secondItem = "WeldingMask"
    fence.craftingBank = "BlowTorch"
    fence.noNeedHammer = true
    fence.actionAnim = "BlowTorchMid"
    fence.canBarricade = true
    fence.modData["xp:MetalWelding"] = 25
    fence.modData["need:Base.SheetMetal"]= 2
    fence.modData["need:Base.Hinge"]= 2
    fence.modData["need:Base.ScrapMetal"]= 2
    fence.modData["need:Base.Hinge"]= 2
    fence.modData["use:Base.BlowTorch"] = 6
    fence.modData["use:Base.WeldingRods"] = 3  -- must be half of Torch use.
    fence.completionSound = "BuildMetalStructureSmallScrap"
    fence.player = player
    getCell():setDrag(fence, player)
end


local function onGarageDoor(worldobjects, player)
    local door = ISGarageDoor:renew("walls_garage_02_", 0)
    door.name = "Rolling Garage Door"
    door.firstItem = "BlowTorch"
    door.secondItem = "WeldingMask"
    door.craftingBank = "BlowTorch"
    door.noNeedHammer = true
    door.actionAnim = "BlowTorchMid"
    door.canBarricade = false
    door.modData["xp:MetalWelding"] = 10
    door.modData["need:Base.SheetMetal"] = 8
    door.modData["need:Base.ScrapMetal"]= 2
    door.modData["need:Base.Hinge"]= 2
    door.modData["use:Base.Wire"] = 5  -- Wire must be `use:`(1 wire has 5 unit) because it is by unit. not `need"`.
    door.modData["use:Base.BlowTorch"] = 10
    door.modData["use:Base.WeldingRods"] = 5  -- must be half of Torch use.
    door.completionSound = "BuildMetalStructureSmallScrap"
    door.player = player
    door.ignoreNorth = true
    getCell():setDrag(door, player)
end


local function onMetalGrateFloor(worldobjects, player)
    local floor = ISWoodenFloor:new("industry_01_39", "industry_01_39")
    floor.name = "Metal Grate Floor"
    floor.firstItem = "BlowTorch"
    floor.secondItem = "WeldingMask"
    floor.noNeedHammer = true
    floor.craftingBank = "BlowTorch"
    floor.actionAnim = "BlowTorchFloor"
    floor.hoppable = true
    floor.isThumpable = false
    floor.canBarricade = false
    floor.modData["xp:MetalWelding"] = 5
    floor.modData["need:Base.ScrapMetal"]= 4
    floor.modData["use:Base.Wire"] = 2  -- Wire must be `use:` because it is by unit. not `need"`.
    floor.modData["use:Base.BlowTorch"] = 4
    floor.modData["use:Base.WeldingRods"] = 2  -- must be half of Torch use.
    floor.completionSound = "BuildMetalStructureSmallWiredFence"
    floor.player = player
    getCell():setDrag(floor, player)
end

local function onMetalBarGrateFloor(worldobjects, player)
    local floor = ISWoodenFloor:new("industry_01_37", "industry_01_38")
    floor.name = "Metal Bar Grate Floor"
    floor.firstItem = "BlowTorch"
    floor.secondItem = "WeldingMask"
    floor.noNeedHammer = true
    floor.craftingBank = "BlowTorch"
    floor.actionAnim = "BlowTorchFloor"
    floor.hoppable = true
    floor.isThumpable = false
    floor.canBarricade = false
    floor.modData["xp:MetalWelding"] = 5
    floor.modData["need:Base.SmallSheetMetal"]= 2
    floor.modData["need:Base.ScrapMetal"]= 4
    floor.modData["use:Base.Wire"] = 2  -- Wire must be `use:` because it is by unit. not `need"`.
    floor.modData["use:Base.BlowTorch"] = 4
    floor.modData["use:Base.WeldingRods"] = 2  -- must be half of Torch use.
    floor.completionSound = "BuildMetalStructureLargeWiredFence"
    floor.player = player
    getCell():setDrag(floor, player)
end


local function onMetalBarHandrail(worldobjects, player)
    local handrail = ISWoodenWall:new("fixtures_railings_01_48", "fixtures_railings_01_49", nil)
    handrail.name = "Metal Bar Handrail"
    handrail.firstItem = "BlowTorch"
    handrail.secondItem = "WeldingMask"
    handrail.noNeedHammer = true
    handrail.craftingBank = "BlowTorch"
    handrail.actionAnim = "BlowTorchFloor"
    handrail.hoppable = true
    handrail.isThumpable = false
    handrail.canBarricade = false
    handrail.modData["xp:MetalWelding"] = 5
    handrail.modData["need:Base.MetalPipe"]= 3
    handrail.modData["need:Base.ScrapMetal"]= 4
    handrail.modData["use:Base.BlowTorch"] = 4
    handrail.modData["use:Base.WeldingRods"] = 2  -- must be half of Torch use.
    handrail.completionSound = "BuildMetalStructureSmallScrap"
    handrail.player = player
    getCell():setDrag(handrail, player)
end



-- for MetalDrum

-- give up, unable to change MetalDrum sprite without using custom tiles,
-- only .pack is not enough for this things. It might change runtime, 
-- the sprite will lost while created. and it is not Moveables.
-- go with plan b, switch all Barrel to MetalDrum with out textures.
-- I don't want go with '.tiles', because it might contaminate save files.
-- on the other hands, I don't know how to make .tiles file yet.
-- the previewSprite and overlaySprite is used for hacking the color of MetalDrum
-- by setOverlaySprite, and previewSprite is used for showing on square before craft.
-- In the end, I thought it's bit boring and silly, so remove it, but keep code here.
-- (those custom sprite texture is in custom texturepacks, not sure is have or not in future)

local DRUM_SPRITES_MAP = {
    ["Moveables.crafted_01_32"] = {
        sprite = "crafted_01_24",
    },
    ["Moveables.industry_01_22"] = {
        sprite = "crafted_01_28",
    },
    ["Moveables.industry_01_23"] = {
        sprite = "crafted_01_28",
        -- previewSprite = "rc_crafted_metaldrum_preview_4",
        -- overlaySprite = "rc_crafted_metaldrum_overlay_4",
    },
    ["Moveables.location_military_generic_01_6"] = {
        sprite = "crafted_01_28",
        -- previewSprite = "rc_crafted_metaldrum_preview_0",
        -- overlaySprite = "rc_crafted_metaldrum_overlay_0",
    },
    ["Moveables.location_military_generic_01_7"] = {
        sprite = "crafted_01_28",
        -- previewSprite = "rc_crafted_metaldrum_preview_1",
        -- overlaySprite = "rc_crafted_metaldrum_overlay_1",
    },
    ["Moveables.location_military_generic_01_14"] = {
        sprite = "crafted_01_24",
        -- previewSprite = "rc_crafted_metaldrum_preview_2",
        -- overlaySprite = "rc_crafted_metaldrum_overlay_2",
    },
    ["Moveables.location_military_generic_01_15"] = {
        sprite = "crafted_01_24",
        -- previewSprite = "rc_crafted_metaldrum_preview_3",
        -- overlaySprite = "rc_crafted_metaldrum_overlay_3",
    },
}

local function getBarrelItem(playerInv)
    for k, v in pairs(DRUM_SPRITES_MAP) do
        local item = playerInv:getItemFromTypeRecurse(k)
        if item then
            return item
        end
    end
    return nil
end

local function getMetalDrumSpriteByBarrel(barrel)
    local drum_sprite = {
        sprite = 'crafted_01_24'
    }
    if barrel then
        local rel_sprite = DRUM_SPRITES_MAP[barrel:getFullType()]
        if rel_sprite then
            drum_sprite = rel_sprite
        end
    end
    return drum_sprite
end

local function onMetalDrum(worldobjects, player, barrel)
    local sp = getMetalDrumSpriteByBarrel(barrel)
    -- local metaldrum = ISMetalDrum:new(player, sp.sprite, sp.overlaySprite, sp.previewSprite)
    local metaldrum = ISMetalDrum:new(player, sp.sprite)
    metaldrum.name = "MetalDrum"  -- careful the name, some function require matched name. ex. contextMenu
    metaldrum.firstItem = "BlowTorch"
    metaldrum.secondItem = "WeldingMask"
    metaldrum.craftingBank = "BlowTorch"
    metaldrum.actionAnim = "BlowTorchMid"
    metaldrum.modData["xp:MetalWelding"] = 15
    metaldrum.modData["use:Base.BlowTorch"] = 4
    metaldrum.modData["use:Base.WeldingRods"] = 2  -- must be half of Torch use.
    metaldrum.modData["need:"..barrel:getFullType()] = 1
    metaldrum.player = player
    metaldrum.completionSound = "BuildMetalStructureMedium"
    getCell():setDrag(metaldrum, player)
end


local function buildExpanedsMenu(subMenu, option, player, worldobjects)
    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()

    local metalDoorOption = {}
    local garageDoorOption = {}
    if playerObj:getKnownRecipes():contains("Make Metal Fences") or ISBuildMenu.cheat then
        local thumbnail = "fixtures_doors_01_52"
        local itemName = getText("ContextMenu_METAL_DOOR")
        local metalDoorOption = subMenu:addOption(itemName, worldobjects, onMetalDoor, player)
        local toolTip = ISBlacksmithMenu.addToolTip(metalDoorOption, itemName, thumbnail)
        toolTip.description = getText("Tooltip_CRAFT_METALDOORDESC") .. toolTip.description

        local canCraft = ISBlacksmithMenu.checkMetalWeldingFurnitures(0, 0, 2, 2, 2, 8, 5, playerObj, toolTip, 0, 0)
        -- checkMetalWeldingFurnitures(metalPipes, smallMetalSheet, metalSheet, hinge, scrapMetal, torchUse, skill, player, toolTip, metalBar, wire)

        if not canCraft then metalDoorOption.notAvailable = true end

        local thumbnail = "walls_garage_02_1"
        local itemName = getText("ContextMenu_GARAGE_DOOR")
        garageDoorOption = subMenu:addOption(itemName, worldobjects, onGarageDoor, player)
        local toolTip = ISBlacksmithMenu.addToolTip(garageDoorOption, itemName, thumbnail)
        toolTip.description = getText("Tooltip_CRAFT_GARAGEDOORDESC") .. toolTip.description

        local canCraft = ISBlacksmithMenu.checkMetalWeldingFurnitures(6, 0, 8, 2, 2, 10, 8, playerObj, toolTip, 0, 5)
        -- checkMetalWeldingFurnitures(metalPipes, smallMetalSheet, metalSheet, hinge, scrapMetal, torchUse, skill, player, toolTip, metalBar, wire)

        if not canCraft then garageDoorOption.notAvailable = true end

    else
        garageDoorOption.notAvailable = not(ISBuildMenu.cheat)
        metalDoorOption.notAvailable = not(ISBuildMenu.cheat)
    end

    local metalGrateOption = {}
    local metalBarGrateOption = {}
    if playerObj:getKnownRecipes():contains("Make Metal Roof") or ISBuildMenu.cheat then
        -- Warehouse Floor --
        local thumbnail = "industry_01_39"
        local itemName = getText("ContextMenu_METAL_GRATE")
        metalGrateOption = subMenu:addOption(itemName, worldobjects, onMetalGrateFloor, player)
        local toolTip = ISBlacksmithMenu.addToolTip(metalGrateOption, itemName, thumbnail)
        toolTip.description = getText("Tooltip_CRAFT_METALGRATEDESC") .. toolTip.description

        local canCraft = ISBlacksmithMenu.checkMetalWeldingFurnitures(0, 0, 0, 0, 4, 4, 6, playerObj, toolTip, 0, 2)
        -- checkMetalWeldingFurnitures(metalPipes, smallMetalSheet, metalSheet, hinge, scrapMetal, torchUse, skill, player, toolTip, metalBar, wire)

        if not canCraft then metalGrateOption.notAvailable = true end

        -- Enhanced Warehouse Floor --
        local thumbnail = "industry_01_37"
        local itemName = getText("ContextMenu_METAL_BAR_GRATE")
        metalBarGrateOption = subMenu:addOption(itemName, worldobjects, onMetalBarGrateFloor, player)
        local toolTip = ISBlacksmithMenu.addToolTip(metalBarGrateOption, itemName, thumbnail)
        toolTip.description = getText("Tooltip_CRAFT_METALBARGRATEDESC") .. toolTip.description

        local canCraft = ISBlacksmithMenu.checkMetalWeldingFurnitures(0, 2, 0, 0, 4, 4, 6, playerObj, toolTip, 0, 2)
        -- checkMetalWeldingFurnitures(metalPipes, smallMetalSheet, metalSheet, hinge, scrapMetal, torchUse, skill, player, toolTip, metalBar, wire)

        if not canCraft then metalBarGrateOption.notAvailable = true end
    else
        metalGrateOption.notAvailable = not(ISBuildMenu.cheat)
        metalBarGrateOption.notAvailable = not(ISBuildMenu.cheat)
    end

    local metalBarRailOption = {}
    if playerObj:getKnownRecipes():contains("Make Metal Fences") or ISBuildMenu.cheat then
        -- Warehouse Handrail --
        local thumbnail = "fixtures_railings_01_48"
        local itemName = getText("ContextMenu_METAL_BAR_HANDRAIL")
        metalBarRailOption = subMenu:addOption(itemName, worldobjects, onMetalBarHandrail, player)
        local toolTip = ISBlacksmithMenu.addToolTip(metalBarRailOption, itemName, thumbnail)
        toolTip.description = getText("Tooltip_CRAFT_METALBARHANDRAILEDESC") .. toolTip.description

        local canCraft = ISBlacksmithMenu.checkMetalWeldingFurnitures(3, 0, 0, 0, 4, 4, 6, playerObj, toolTip, 0, 0)
        -- checkMetalWeldingFurnitures(metalPipes, smallMetalSheet, metalSheet, hinge, scrapMetal, torchUse, skill, player, toolTip, metalBar, wire)

        if not canCraft then metalBarRailOption.notAvailable = true end

    else
        metalBarRailOption.notAvailable = not(ISBuildMenu.cheat)
    end
    

    local drumOption = {}
    if playerObj:isRecipeKnown("Make Metal Containers") or ISBuildMenu.cheat then
        -- Metal Drum --
        local thumbnail = "crafted_01_24"

        local itemName = getText("ContextMenu_METAL_DRUM")
        local barrel = getBarrelItem(playerInv)
        
        drumOption = subMenu:addOption(itemName, worldobjects, onMetalDrum, player, barrel)
        local toolTip = ISBlacksmithMenu.addToolTip(drumOption, itemName, thumbnail)
        toolTip.description = getText("Tooltip_CRAFT_METALDRUMDESC") .. toolTip.description
        
        local canCraft = ISBlacksmithMenu.checkMetalWeldingFurnitures(0, 0, 0, 0, 0, 5, 7, playerObj, toolTip, 0, 0)
        -- checkMetalWeldingFurnitures(metalPipes, smallMetalSheet, metalSheet, hinge, scrapMetal, torchUse, skill, player, toolTip, metalBar, wire)

        if not canCraft then drumOption.notAvailable = true end

        if barrel then
            toolTip.description = toolTip.description .. " <LINE> ".. ISBuildMenu.ghs .. getText("ContextMenu_METAL_BARREL")
        else
            toolTip.description = toolTip.description .. " <LINE> ".. ISBuildMenu.bhs .. getText("ContextMenu_METAL_BARREL")
            drumOption.notAvailable = true
        end
    else
        drumOption.notAvailable = not(ISBuildMenu.cheat)
    end

    -- for parent menu --
    if metalDoorOption.notAvailable and garageDoorOption.notAvailable
       and metalGrateOption.notAvailable and metalBarGrateOption.notAvailable and metalBarRailOption.notAvailable
       and drumOption.notAvailable then
        option.notAvailable = true
    end

end


local doBuildMenu = function(player, context, worldobjects, test)
    if test and ISWorldObjectContextMenu.Test then return true end

    if getCore():getGameMode()=="LastStand" then
        return
    end

    if test then return ISWorldObjectContextMenu.setTest() end

    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()
    
    if playerObj:getVehicle() then return end

    local option = context:getOptionFromName(getText("ContextMenu_MetalWelding"))

    if option then
        local weldingMenu = context:getSubMenu(option.subOption)
        local expandsOption = weldingMenu:addOption(getText("ContextMenu_EXPANDS"), worldobjects, nil)
        local expandsMenu = ISContextMenu:getNew(weldingMenu)
        weldingMenu:addSubMenu(expandsOption, expandsMenu)
        buildExpanedsMenu(expandsMenu, expandsOption, player)
    end

end


Events.OnFillWorldObjectContextMenu.Add(doBuildMenu)