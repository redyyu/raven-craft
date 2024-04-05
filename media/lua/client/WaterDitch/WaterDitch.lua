
local function predicateDigGrave(item)
    return not item:isBroken() and item:hasTag("DigGrave")
end

local Ditch = {}

Ditch.isCloseEnough = function(playerObj, ditch)
    return ditch:getSquare():getBuilding() == playerObj:getBuilding() and 
           playerObj:DistToSquared(ditch:getX() + 0.5, ditch:getY() + 0.5) < 2 * 5
end


Ditch.onFillDirt = function(playerObj, ditch, shovel)
    if luautils.walkAdj(playerObj, ditch:getSquare()) then
        local hand_item = playerObj:getPrimaryHandItem()
        ISWorldObjectContextMenu.equip(playerObj, hand_item, shovel, true, true)
        ISTimedActionQueue.add(ISFillDirtDitchAction:new(playerObj, ditch, shovel, 4))
    end
end



Ditch.onDigDitch = function(worldobjects, playerNum, shovel, isPool)
    -- local bo = nil
    -- if isPool then
    --     bo = ISWaterDitch:new(playerNum, shovel, ISWaterDitch.variety.pool.sprites.empty)
    -- else
    --     bo = ISWaterDitch:new(playerNum, shovel, ISWaterDitch.variety.WE.sprites.empty, ISWaterDitch.variety.NS.sprites.empty)
    -- end
	-- bo.player = playerNum
	-- getCell():setDrag(bo, bo.player)
    local waterAmount = 10
    local waterMax = 100
    local modData = {}
	modData["need:Base.Plank"] = "4"
	modData["need:Base.Nails"] = "4"
	modData["need:Base.Garbagebag"] = "4"
	modData["waterAmount"] = waterAmount
	modData["waterMax"] = waterMax
    local health = 100

    local cell = getWorld():getCell()
	local north = false
    local playerObj = getSpecificPlayer(playerNum)
    local sq = playerObj:getCurrentSquare()
    local spriteName = 'rc_natural_ditch_0'
    -- 'rc_natural_ditch_0' 'carpentry_02_52'
	-- local javaObject = IsoThumpable.new(cell, sq, spriteName, north, modData)
    -- local spr = IsoSpriteManager.instance:AddSprite('rc_natural_ditch_9')
    -- spr:setName('rc_natural_ditch_9')
    local floor = sq:addFloor('blends_natural_01_64')
    -- local floor_props = floor:getProperties()
    -- floor_props:Set(IsoFlagType.solidtrans)
    -- floor_props:Set('BlocksPlacement', '')


	-- javaObject:setCanPassThrough(false)
	-- javaObject:setCanBarricade(false)
	-- javaObject:setThumpDmg(8)
	-- javaObject:setIsContainer(false)
	-- javaObject:setIsDoor(false)
	-- javaObject:setIsDoorFrame(false)
	-- javaObject:setCrossSpeed(1.0)
	-- javaObject:setBlockAllTheSquare(true)
	-- javaObject:setName("Water Ditch")
	-- javaObject:setIsDismantable(true)
	-- javaObject:setCanBePlastered(false)
	-- javaObject:setIsHoppable(false)
	-- javaObject:setIsThumpable(true)
	-- javaObject:setModData(copyTable(modData))
	-- javaObject:setMaxHealth(health)
	-- javaObject:setHealth(health)
	-- javaObject:setBreakSound("BreakObject")
	-- javaObject:setSpecialTooltip(true)
    

	-- javaObject:setWaterAmount(waterAmount)
	-- javaObject:setTaintedWater(waterAmount > 0 and sq:isOutside())

    -- javaObject:getSprite():getProperties():Set(IsoFlagType.solidtrans)
    -- javaObject:getSprite():getProperties():Set('BlocksPlacement', '')

    -- sq:AddSpecialObject(javaObject)
    

	-- javaObject:transmitCompleteItemToClients()
end


Ditch.onFillWorldObjectContextMenu = function(playerNum, context, worldobjects)
    local playerObj = getSpecificPlayer(playerNum)
    local playerInv = playerObj:getInventory()

    if playerObj:getVehicle() then return end
    
    local ditch
    for _, v in ipairs(worldobjects) do
        if CWaterDitchSystem.instance:isValidIsoObject(v) then
            ditch = v
            break
        end
    end

    if ditch then
        if Ditch.isCloseEnough(playerObj, ditch) then
            local ditchOption = context:addOptionOnTop(getText("ContextMenu_Ditch"))
            local ditchMenu = ISContextMenu:getNew(context)
            context:addSubMenu(ditchOption, ditchMenu)

            local optInfo = ditchMenu:addOption(getText("ContextMenu_Info"))
            local info_tooltip = ISWorldObjectContextMenu.addToolTip()
            info_tooltip:setName(getText("ContextMenu_Ditch"))
            local tx = getTextManager():MeasureStringX(info_tooltip.font, getText("ContextMenu_WaterName") .. ":") + 20
            info_tooltip.description = string.format("%s: <SETX:%d> %d / %d", getText("ContextMenu_WaterName"), tx, ditch:getWaterAmount(), ditch:getWaterMax())
            if ditch:isTaintedWater() and getSandboxOptions():getOptionByName("EnableTaintedWaterText"):getValue() then
                info_tooltip.description = info_tooltip.description .. " <BR> <RGB:1,0.5,0.5> " .. getText("Tooltip_item_TaintedWater")
            end
            info_tooltip.maxLineWidth = 512
            optInfo.toolTip = info_tooltip

            local shovel = playerInv:getFirstEvalRecurse(predicateDigGrave)
            local dirt_uses = playerInv:getUsesTypeRecurse("Dirtbag")

            local optFill = ditchMenu:addOption(getText("ContextMenu_Ditch_Fill_Dirt"), playerObj, Ditch.onFillDirt, ditch, shovel)
            local fill_tooltip = ISWorldObjectContextMenu.addToolTip()
            fill_tooltip.description = getText("Tooltip_Ditch_Fill_Dirt") .. " <BR> "

            if shovel then
                fill_tooltip.description = fill_tooltip.description .. RC.Txt.ghs .. shovel:getDisplayName() .." <LINE> "
            else
                fill_tooltip.description = fill_tooltip.description .. RC.Txt.bhs .. "Shovel <LINE> "
                optFill.notAvailable = true
            end

            if dirt_uses >= 4 then
                fill_tooltip.description = fill_tooltip.description .. RC.Txt.ghs .. "Dirt " .. dirt_uses .."/4 <LINE> "
            else
                fill_tooltip.description = fill_tooltip.description .. RC.Txt.bhs .. "Dirt " .. dirt_uses .."/4 <LINE> "
                optFill.notAvailable = true
            end
            
            optFill.toolTip = fill_tooltip
        end
    elseif JoypadState.players[playerNum+1] or ISWaterDitch.canDigHere(worldobjects) then
        local shovel = playerInv:getFirstEvalRecurse(predicateDigGrave)
        if shovel then
            local ditchOption = context:addOptionOnTop(getText("ContextMenu_DigDitch"))
            local ditchMenu = ISContextMenu:getNew(context)
            context:addSubMenu(ditchOption, ditchMenu)

            local optPool = ditchMenu:addOption(getText("ContextMenu_DigDitch_Pool"), worldobjects, Ditch.onDigDitch, playerNum, shovel, true)
            optPool.toolTip = ISWorldObjectContextMenu.addToolTip()
            optPool.toolTip.description = getText("Tooltip_DigDitch_Pool")
            local optWaterway = ditchMenu:addOption(getText("ContextMenu_DigDitch_Waterway"), worldobjects, Ditch.onDigDitch, playerNum, shovel)
            optWaterway.toolTip = ISWorldObjectContextMenu.addToolTip()
            optWaterway.toolTip.description = getText("Tooltip_DigDitch_Waterway")
        end
    end
end

Events.OnFillWorldObjectContextMenu.Add(Ditch.onFillWorldObjectContextMenu)