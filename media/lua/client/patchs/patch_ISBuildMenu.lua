require 'BuildingObjects/ISUI/ISBuildMenu'


local function furnaceOnStopFire(worldobjects, furnace, player)
    if luautils.walkAdj(player, furnace:getSquare()) then
        ISTimedActionQueue.add(ISStopFurnaceFire:new(furnace, player))
    end
end

-- local function onAddLogs(worldobjects, metalDrum, player)
--     if luautils.walkAdj(player, metalDrum:getSquare()) then
--         ISTimedActionQueue.add(ISAddLogsInDrum:new(player, metalDrum, true))
--     end
-- end


local PatchMenu = {};


PatchMenu.doBuildMenu = function(player, context, worldobjects, test)
	if test and ISWorldObjectContextMenu.Test then return true end

    if getCore():getGameMode()=="LastStand" then
        return;
    end
	
	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()

	if playerObj:getVehicle() then return; end


    -- Path for Vanilla --
    local furnace = nil;
    local metal_drum = nil;

    for i, v in ipairs(worldobjects) do
        -- find Stone Furnace --
        if instanceof(v, "BSFurnace") then
            furnace = v;
            print(furnace)
        end
        -- find Metal Drum --
        if CMetalDrumSystem.instance:isValidIsoObject(v) then
            metal_drum = CMetalDrumSystem.instance:getLuaObjectOnSquare(v:getSquare())
        end
    end
    
    -- fix `Put out fire` on furnace not change texture. --
    if furnace and furnace:isFireStarted() then
        context:removeOptionByName(getText("ContextMenu_Put_out_fire"));
        context:addOption(getText("ContextMenu_Put_out_fire"), worldobjects, furnaceOnStopFire, furnace, playerObj);
    end

    -- fix 5 Logs is too heavy. change to 2 --
    if metal_drum and not metal_drum.haveLogs and not metal_drum.haveCharcoal then
        local drumMenuOption = context:getOptionFromName(getText("ContextMenu_Metal_Drum"));
        if drumMenuOption then
            local subDrumMenu = context:getSubMenu(drumMenuOption.subOption);
            -- subDrumMenu:removeOptionByName(getText("ContextMenu_Add_Logs"));
            local addLogOption = subDrumMenu:getOptionFromName(getText("ContextMenu_Add_Logs"));
            if addLogOption then
                local tooltip = addLogOption.toolTip;
                tooltip.description = getText("Tooltip_CHARCOAL_LOGS", 2);
                addLogOption.notAvailable = playerInv:getItemCount("Base.Log") < 2;
            end
        end
    end

end


Events.OnFillWorldObjectContextMenu.Add(PatchMenu.doBuildMenu)