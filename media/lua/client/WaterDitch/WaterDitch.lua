
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


Ditch.onDigDitch = function(playerNum, shovel, isPool)
    local bo = nil
    if isPool then
        bo = ISWaterDitch:new(playerNum, shovel, ISWaterDitch.variety.pool.sprites.empty)
    else
        bo = ISWaterDitch:new(playerNum, shovel, ISWaterDitch.variety.WE.sprites.empty, ISWaterDitch.variety.NS.sprites.empty)
    end
	bo.player = playerNum
	getCell():setDrag(bo, bo.player)
end


Ditch.onAddWater = function(playerObj, waterObject, waterItem)
	if not luautils.walkAdj(playerObj, waterObject:getSquare(), true) then return end
	if waterItem:canStoreWater() and waterItem:isWaterSource() then
		ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), waterItem, true)
		ISTimedActionQueue.add(ISAddWaterFromItemAction:new(playerObj, waterItem, waterObject))
	end
end


Ditch.doDigDitchMenu = function(playerNum, context)
    local playerObj = getSpecificPlayer(playerNum)
    local playerInv = playerObj:getInventory()
    local shovel = playerInv:getFirstEvalRecurse(predicateDigGrave)
    if shovel then
        local ditchOption = context:addOptionOnTop(getText("ContextMenu_DigDitch"))
        local ditchMenu = ISContextMenu:getNew(context)
        context:addSubMenu(ditchOption, ditchMenu)

        local optPool = ditchMenu:addOption(getText("ContextMenu_DigDitch_Pool"),  playerNum, Ditch.onDigDitch,shovel, true)
        optPool.toolTip = ISWorldObjectContextMenu.addToolTip()
        optPool.toolTip.description = getText("Tooltip_DigDitch_Pool")
        local optWaterway = ditchMenu:addOption(getText("ContextMenu_DigDitch_Waterway"), playerNum, Ditch.onDigDitch, shovel)
        optWaterway.toolTip = ISWorldObjectContextMenu.addToolTip()
        optWaterway.toolTip.description = getText("Tooltip_DigDitch_Waterway")
    end
end


Ditch.doCheckDigDitchMenu = function(playerNum, ditch, context)
    local playerObj = getSpecificPlayer(playerNum)
    local playerInv = playerObj:getInventory()
    local ditchOption = context:addOptionOnTop(getText("ContextMenu_Ditch"))
    local ditchMenu = ISContextMenu:getNew(context)
    context:addSubMenu(ditchOption, ditchMenu)

    local info_tooltip = ISWorldObjectContextMenu.addToolTip()
    info_tooltip:setName(getText("ContextMenu_Ditch"))
    local tx = getTextManager():MeasureStringX(info_tooltip.font, getText("ContextMenu_WaterName") .. ":") + 20
    info_tooltip.description = string.format("%s: <SETX:%d> %d / %d", getText("ContextMenu_WaterName"), tx, ditch:getWaterAmount(), ditch:getWaterMax())
    if ditch:isTaintedWater() and getSandboxOptions():getOptionByName("EnableTaintedWaterText"):getValue() then
        info_tooltip.description = info_tooltip.description .. " <BR> <RGB:1,0.5,0.5> " .. getText("Tooltip_item_TaintedWater")
    end
    info_tooltip.maxLineWidth = 512
    ditchOption.toolTip = info_tooltip

    local shovel = playerInv:getFirstEvalRecurse(predicateDigGrave)
    local dirt_uses = playerInv:getUsesTypeRecurse("Dirtbag")

    local optFill = ditchMenu:addOption(getText("ContextMenu_Ditch_Fill_Dirt"), playerObj, Ditch.onFillDirt, ditch, shovel)
    local fill_tooltip = ISWorldObjectContextMenu.addToolTip()
    fill_tooltip.description = getText("Tooltip_Ditch_Fill_Dirt") .. " <BR> "

    if shovel then
        fill_tooltip.description = fill_tooltip.description .. RC.Txt.ghs .. shovel:getDisplayName() .." <LINE> "
    else
        fill_tooltip.description = fill_tooltip.description .. RC.Txt.bhs .. "Shovel <LINE> "
    end

    if dirt_uses >= 4 then
        fill_tooltip.description = fill_tooltip.description .. RC.Txt.ghs .. "Dirt " .. dirt_uses .."/4 <LINE> "
    else
        fill_tooltip.description = fill_tooltip.description .. RC.Txt.bhs .. "Dirt " .. dirt_uses .."/4 <LINE> "
    end
    
    optFill.toolTip = fill_tooltip
    optFill.notAvailable = not shovel or dirt_uses < 4
end


Ditch.doAddWaterToDitchMenu = function(playerObj, ditch, context)
    local playerInv = playerObj:getInventory()

    if ditch:getWaterAmount() >= ditch:getWaterMax() then
        return
    end
    local pourOut = {}
    for i=0, playerInv:getItems():size()-1 do
        local item = playerInv:getItems():get(i)
        if item:canStoreWater() and item:isWaterSource() then
            table.insert(pourOut, item)
        end
    end

    if #pourOut > 0 then
        
        local subMenuOption = context:insertOptionAfter(getText("ContextMenu_Ditch"), getText("ContextMenu_AddWaterFromItem"))
        local subMenu = context:getNew(context)
        context:addSubMenu(subMenuOption, subMenu)
        for _,item in ipairs(pourOut) do
            local subOption = subMenu:addOption(item:getDisplayName(), playerObj, Ditch.onAddWater, ditch, item)
            if item:IsDrainable() then
                local tooltip = ISWorldObjectContextMenu.addToolTip()
                local tx = getTextManager():MeasureStringX(tooltip.font, getText("ContextMenu_WaterName") .. ":") + 20
                tooltip.description = string.format("%s: <SETX:%d> %d / %d",
                    getText("ContextMenu_WaterName"), tx, item:getDrainableUsesInt(), 1.0 / item:getUseDelta() + 0.0001)
                if item:isTaintedWater() and getSandboxOptions():getOptionByName("EnableTaintedWaterText"):getValue() then
                    tooltip.description = tooltip.description .. " <BR> <RGB:1,0.5,0.5> " .. getText("Tooltip_item_TaintedWater")
                end
                subOption.toolTip = tooltip
            end
        end
    end
end


Ditch.onFillWorldObjectContextMenu = function(playerNum, context, worldobjects)
    local playerObj = getSpecificPlayer(playerNum)
    if playerObj:getVehicle() or not playerObj:isRecipeKnown("Dig Water Ditch") then
        return
    end

    local ditch
    for _, v in ipairs(worldobjects) do
        if SWaterDitchSystem.instance:isValidIsoObject(v) then
            ditch = v
            break
        end
    end

    if ditch then
        if Ditch.isCloseEnough(playerObj, ditch) then
            Ditch.doCheckDigDitchMenu(playerNum, ditch, context)
            Ditch.doAddWaterToDitchMenu(playerObj, ditch, context)
        end
    elseif JoypadState.players[playerNum+1] or ISWaterDitch.canDigHere(worldobjects) then
        Ditch.doDigDitchMenu(playerNum, context)
    end
end

Events.OnFillWorldObjectContextMenu.Add(Ditch.onFillWorldObjectContextMenu)