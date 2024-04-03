
local function predicateDigGrave(item)
    return not item:isBroken() and item:hasTag("DigGrave")
end

local Ditch = {}


Ditch.onDigDitch = function(worldobjects, playerNum, shovel)
    local bo = ISWaterDitch:new(playerNum, "rc_natural_ditch_0", shovel)
	bo.player = playerNum
	getCell():setDrag(bo, bo.player)
end


Ditch.onFillWorldObjectContextMenu = function(playerNum, context, worldobjects)
    local playerObj = getSpecificPlayer(playerNum)
    local shovel = playerInv:getFirstEvalRecurse(predicateDigGrave)
    if (JoypadState.players[playerNum+1] or ISWaterDitch.canDigHere(worldobjects)) and not playerObj:getVehicle() and shovel then
		context:addOption(getText("ContextMenu_DigDitch"), worldobjects, Ditch.onDigDitch, playerNum, shovel)
	end
end

Events.OnFillWorldObjectContextMenu.Add(Ditch.onFillWorldObjectContextMenu)