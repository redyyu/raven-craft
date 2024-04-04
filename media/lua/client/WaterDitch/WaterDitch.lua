
local function predicateDigGrave(item)
    return not item:isBroken() and item:hasTag("DigGrave")
end

local Ditch = {}

Ditch.isCloseEnough = function(playerObj, ditch)
    return ditch:getSquare():getBuilding() == playerObj:getBuilding() and 
           playerObj:DistToSquared(ditch:getX() + 0.5, ditch:getY() + 0.5) < 2 * 2
end

Ditch.onDigDitch = function(worldobjects, playerNum, shovel)
    local bo = ISWaterDitch:new(playerNum, "rc_natural_ditch_0", shovel)
	bo.player = playerNum
	getCell():setDrag(bo, bo.player)
end


Ditch.onFillWorldObjectContextMenu = function(playerNum, context, worldobjects)
    local playerObj = getSpecificPlayer(playerNum)
    local playerInv = playerObj:getInventory()

    local ditch
    for _, v in ipairs(worldobjects) do
        if CWaterDitchSystem.instance:isValidIsoObject(v) then
            ditch = v
            break
        end
    end

    if ditch then
        if Ditch.isCloseEnough(playerObj, ditch) then
            local option = context:addOptionOnTop(getText("ContextMenu_Water_Ditch"), worldobjects, nil)
            local tooltip = ISWorldObjectContextMenu.addToolTip()
            tooltip:setName(getText("ContextMenu_Water_Ditch"))
            local tx = getTextManager():MeasureStringX(tooltip.font, getText("ContextMenu_WaterName") .. ":") + 20
            tooltip.description = string.format("%s: <SETX:%d> %d / %d", getText("ContextMenu_WaterName"), tx, ditch:getWaterAmount(), ditch:getWaterMax())
            if ditch:isTaintedWater() and getSandboxOptions():getOptionByName("EnableTaintedWaterText"):getValue() then
                tooltip.description = tooltip.description .. " <BR> <RGB:1,0.5,0.5> " .. getText("Tooltip_item_TaintedWater")
            end
            tooltip.maxLineWidth = 512
            option.toolTip = tooltip
        end
        return false
    else
        local shovel = playerInv:getFirstEvalRecurse(predicateDigGrave)
        if (JoypadState.players[playerNum+1] or ISWaterDitch.canDigHere(worldobjects)) and not playerObj:getVehicle() and shovel then
            context:addOptionOnTop(getText("ContextMenu_DigDitch"), worldobjects, Ditch.onDigDitch, playerNum, shovel)
        end
    end
end

Events.OnFillWorldObjectContextMenu.Add(Ditch.onFillWorldObjectContextMenu)