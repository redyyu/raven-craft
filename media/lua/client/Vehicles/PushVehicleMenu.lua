require "Vehicles/ISUI/VehicleMenu"
require "luautils";


-- Add the Push options to the outside vehicle menu
-- Requires at least 3 str to consider it and then scale based on vehicle weight
--

local posVector = Vector3f.new();

--- func desc
---@param player IsoPlayer
---@param vehicle IsoVehicle
local onPushVehicle = function(playerObj, vehicle, pushDir)
    local halfLen = vehicle:getScript():getPhysicsChassisShape():z()/2;
    local halfWidth = vehicle:getScript():getPhysicsChassisShape():x()/2;
    local x, z = 0, 0;

    -- switch (self.pushDir) {
    local pushAction = {
        ['Front'] = function() 
            z, x = halfLen, 0; end,
        ['Rear'] = function()
            z, x = -halfLen, 0; end,

        ['LeftFront'] = function()
            z, x = halfLen*0.7, halfWidth; end,
        ['LeftRear'] = function()
            z, x = -halfLen*0.7, halfWidth; end,

        ['RightFront'] = function()
            z, x = halfLen*0.7, -halfWidth; end,
        ['RightRear'] = function()
            z, x = -halfLen*0.7, -halfWidth; end,
    };
    
    pushAction[pushDir]();
    -- }

    local vPos = vehicle:getWorldPos(x, 0 ,z, posVector);

    -- Queue up the movement action
    local action = ISPathFindAction:pathToLocationF(playerObj, vPos:x(), vPos:y(), vPos:z());
	action:setOnFail(ISVehicleMenu.onPushVehiclePathFail, playerObj);
	ISTimedActionQueue.add(action);

    -- Queue up unequipping any hand items
    local equipped = playerObj:getPrimaryHandItem();
    if equipped ~= nil then
        ISTimedActionQueue.add(ISUnequipAction:new(playerObj, equipped, 5));
    end

    -- Then shove the vehicle
    ISTimedActionQueue.add(ISPushVehicleAction:new(playerObj, vehicle, pushDir));
end

function ISVehicleMenu.onPushVehiclePathFail(playerObj) 
    playerObj:Say(getText("IGUI_PLAYER_TEXT_CANT_REACH_VEHICLE"));
end

ISVehicleMenu.newToolTip = function()
	local toolTip = ISToolTip:new();
	toolTip:initialise();
	toolTip:setVisible(false);
	return toolTip;
end

ISVehicleMenu.canPush = function(player, vehicle, context, strReq)
    local toolTip = ISVehicleMenu:newToolTip();
    context.toolTip = toolTip;

    local result = true;

    local playerStr = player:getPerkLevel(Perks.Strength);

    -- TODO: Tweak StrReq variable based on vehicle weight
    -- minStr + |mass / 1000|
    -- a 1000kg car == str 4
    -- a 3000kg car == str 6
    local vehicleWeight = vehicle:getMass();
    strReq = strReq + math.floor(vehicleWeight / 800);
    if playerStr >= strReq then
        toolTip.description = " <RGB:0,1,0>" .. getText("IGUI_perks_Strength") .. ":" .. playerStr .. "/" .. strReq .. " <LINE>";
        return toolTip;
    else
        toolTip.description = " <RGB:1,0,0>" .. getText("IGUI_perks_Strength") .. ":" .. playerStr .. "/" .. strReq .. " <LINE>";
        context.notAvailable = true;
        result = false;
    end

    return result;
end

local function addPushVehicleMenu(playerObj, context, vehicle)
    local minimumStr = 3;
    local pushOption = context:addOption(getText("ContextMenu_PUSH_VEHICLE"), nil, nil);
    
    -- Only draw the submenu if they meet the strength requirements
    -- Otherwise show the menu item but red with a tooltip
    if ISVehicleMenu.canPush(playerObj, vehicle, pushOption, minimumStr) then
        local subMenuMain = context:getNew(context);
        context:addSubMenu(pushOption, subMenuMain);

        local leftOption = subMenuMain:addOption(getText("ContextMenu_PUSH_VEHICLE_FROMLEFT"));
        local subMenuLeft = context:getNew(context);

        context:addSubMenu(leftOption, subMenuLeft)
        subMenuLeft:addOption(getText("ContextMenu_PUSH_VEHICLE_FROMFRONT"), playerObj, onPushVehicle, vehicle, 'LeftFront')
        subMenuLeft:addOption(getText("ContextMenu_PUSH_VEHICLE_FROMREAR"), playerObj, onPushVehicle, vehicle, 'LeftRear')

        local rightOption = subMenuMain:addOption(getText("ContextMenu_PUSH_VEHICLE_FROMRIGHT"))
        local subMenuRight = context:getNew(context)
        context:addSubMenu(rightOption, subMenuRight)
        subMenuRight:addOption(getText("ContextMenu_PUSH_VEHICLE_FROMFRONT"), playerObj, onPushVehicle, vehicle, 'RightFront')
        subMenuRight:addOption(getText("ContextMenu_PUSH_VEHICLE_FROMREAR"), playerObj, onPushVehicle, vehicle, 'RightRear')

        subMenuMain:addOption(getText("ContextMenu_PUSH_VEHICLE_FROMFRONT"), playerObj, onPushVehicle, vehicle, 'Front')
        subMenuMain:addOption(getText("ContextMenu_PUSH_VEHICLE_FROMREAR"), playerObj, onPushVehicle, vehicle, 'Rear')
    end
end


-- Wrap the original function
local defaultMenuOutsideVehicle = nil;
if not defaultMenuOutsideVehicle then
    defaultMenuOutsideVehicle = ISVehicleMenu.FillMenuOutsideVehicle
end
    
-- Override the original function
ISVehicleMenu.FillMenuOutsideVehicle = function(playerObj, context, vehicle, test)
    defaultMenuOutsideVehicle(playerObj, context, vehicle, test);
    addPushVehicleMenu(getSpecificPlayer(playerObj), context, vehicle)
end
