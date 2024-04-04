
local function predicateDigGrave(item)
    return not item:isBroken() and item:hasTag("DigGrave")
end

local Ditch = {}

Ditch.isCloseEnough = function(playerObj, ditch)
    return ditch:getSquare():getBuilding() == playerObj:getBuilding() and 
           playerObj:DistToSquared(ditch:getX() + 0.5, ditch:getY() + 0.5) < 2 * 2
end

Ditch.onDigDitch = function(worldobjects, playerNum, shovel, isPool)
    local bo = nil
    if isPool then
        bo = ISWaterDitch:new(playerNum, shovel, ISWaterDitch.sprites.pool.empty)
    else
        bo = ISWaterDitch:new(playerNum, shovel, ISWaterDitch.sprites.WE.empty, ISWaterDitch.sprites.NS.empty)
    end
	bo.player = playerNum
	getCell():setDrag(bo, bo.player)
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
            local option = context:addOptionOnTop(getText("ContextMenu_Ditch"), worldobjects, nil)
            local tooltip = ISWorldObjectContextMenu.addToolTip()
            tooltip:setName(getText("ContextMenu_Ditch"))
            local tx = getTextManager():MeasureStringX(tooltip.font, getText("ContextMenu_WaterName") .. ":") + 20
            tooltip.description = string.format("%s: <SETX:%d> %d / %d", getText("ContextMenu_WaterName"), tx, ditch:getWaterAmount(), ditch:getWaterMax())
            if ditch:isTaintedWater() and getSandboxOptions():getOptionByName("EnableTaintedWaterText"):getValue() then
                tooltip.description = tooltip.description .. " <BR> <RGB:1,0.5,0.5> " .. getText("Tooltip_item_TaintedWater")
            end
            tooltip.maxLineWidth = 512
            option.toolTip = tooltip
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