require 'BuildingObjects/ISUI/ISBuildMenu'
require 'Blacksmith/ISUI/ISBlacksmithMenu'



ISBlacksmithMenu.onAddLogs = function(worldobjects, metalDrum, playerObj, numRequired)
    local playerInv = playerObj:getInventory()
    local items = playerInv:getSomeTypeRecurse("Base.Log", numRequired)
    if items:size() < numRequired then return end

    if luautils.walkAdj(playerObj, metalDrum:getSquare()) then
        for i=1, numRequired do
            ISWorldObjectContextMenu.transferIfNeeded(playerObj, items:get(i-1))
        end
        ISTimedActionQueue.add(ISAddLogsInDrum:new(playerObj, metalDrum, true))
    end
end


local function removeUnexceptMenuOpts(context, optName)
    local option = context:getOptionFromName(optName)
    if option and option.subOption then
        local sub_menu = context:getSubMenu(option.subOption)
        local sub_options = sub_menu:getMenuOptionNames()
        local removes = {}
        for idx, opt in ipairs(sub_menu.options) do
            -- param2 is the item pass to menu option.
            if opt.param2 and opt.param2:isEquipped() then
                opt.name = 'DEL_' .. idx ..'_' .. opt.name
                table.insert(removes, opt.name)
                -- sub_menu.options[idx] = nil
            end
        end
        for _, rm in ipairs(removes) do
            sub_menu:removeOptionByName(rm)
        end
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
        context:insertOptionAfter(getText("ContextMenu_Furnace_Info"), getText("ContextMenu_Furnace_Put_out_fire"), 
                                  worldobjects, ISBlacksmithMenu.onStopFire, furnace, playerObj)
    end

    -- fix 5 Logs is too heavy. lower the number of logs.
    if metalDrumLuaObj and not metalDrumLuaObj.haveLogs and not metalDrumLuaObj.haveCharcoal then
        local numLogs = 3  -- when change this number, don't forget change the number in `SMetalDrumSystem:OnClientCommand` too.
        local drumMenuOption = context:getOptionFromName(getText("ContextMenu_Metal_Drum"))
        if drumMenuOption then
            local subDrumMenu = context:getSubMenu(drumMenuOption.subOption)
            subDrumMenu:removeOptionByName(getText("ContextMenu_Add_Logs"))  -- remove old add logs option.

            local addLogsOption = subDrumMenu:addOption(getText("ContextMenu_Add_Logs"), 
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

    -- fix Light StoneFurnace with equipped items.
    removeUnexceptMenuOpts(context, getText("ContextMenu_LitStoneFurnace"))
    
    -- fix Light MetalDrum with equipped items.
    removeUnexceptMenuOpts(context, getText("ContextMenu_LitDrum"))
end


Events.OnFillWorldObjectContextMenu.Add(PatchMenu.onFillWorldObjectContextMenu)