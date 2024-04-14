require 'BuildingObjects/ISUI/ISBuildMenu'
require 'Blacksmith/ISUI/ISBlacksmithMenu'



ISBlacksmithMenu.onAddLogs = function(worldobjects, metalDrum, playerObj, numRequired)
    local playerInv = playerObj:getInventory()
    local items = playerInv:getSomeTypeRecurse("Base.Log", numRequired)
    if items:size() < numRequired then return end

    if luautils.walkAdj(player, metalDrum:getSquare()) then
        for i=1, numRequired do
            ISWorldObjectContextMenu.transferIfNeeded(playerObj, items:get(i-1))
        end
        ISTimedActionQueue.add(ISAddLogsInDrum:new(playerObj, metalDrum, true))
    end
end


local PatchMenu = {}


PatchMenu.onFillWorldObjectContextMenu = function(player, context, worldobjects, test)
	if test and ISWorldObjectContextMenu.Test then return true end

    if getCore():getGameMode()=="LastStand" then
        return
    end
	
	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()

	if playerObj:getVehicle() then return end


    -- Path for Vanilla --
    local furnace = nil
    local metalDrumLuaObj = nil

    for i, v in ipairs(worldobjects) do
        -- find Stone Furnace --
        if instanceof(v, "BSFurnace") then
            furnace = v
        end
        -- find Metal Drum --
        if CMetalDrumSystem.instance:isValidIsoObject(v) then
            metalDrumLuaObj = CMetalDrumSystem.instance:getLuaObjectOnSquare(v:getSquare())
        end
    end
    
    -- fix `Put out fire` buggy. they forget pass playerObj to ISBlacksmithMenu.onStopFire.
    if furnace and furnace:isFireStarted() then
        context:removeOptionByName(getText("ContextMenu_Put_out_fire"))
        context:addOption(getText("ContextMenu_Put_out_fire"), worldobjects, ISBlacksmithMenu.onStopFire, furnace, playerObj)
    end

    -- fix 5 Logs is too heavy. lower the number of logs --
    if metalDrumLuaObj and not metalDrumLuaObj.haveLogs and not metalDrumLuaObj.haveCharcoal then
        local numLogs = 3
        local drumMenuOption = context:getOptionFromName(getText("ContextMenu_Metal_Drum"))
        if drumMenuOption then
            local subDrumMenu = context:getSubMenu(drumMenuOption.subOption)
            subDrumMenu:removeOptionByName(getText("ContextMenu_Add_Logs"))  -- remove old add logs option.

            local addLogsOption = subMenuDrum:addOption(getText("ContextMenu_Add_Logs"), 
                                                        worldobjects,
                                                        ISBlacksmithMenu.onAddLogs, 
                                                        metalDrumLuaObj,
                                                        playerObj,
                                                        numLogs)

            local tooltip = ISWorldObjectContextMenu.addToolTip()
            tooltip:setName(getText("ContextMenu_Add_Logs"))
            tooltip.description = getText("Tooltip_CHARCOAL_LOGS", numLogs)
            addLogsOption.toolTip = tooltip
            addLogsOption.notAvailable = playerInv:getItemCountRecurse("Base.Log") < numLogs
        end
    end

end


Events.OnFillWorldObjectContextMenu.Add(PatchMenu.onFillWorldObjectContextMenu)