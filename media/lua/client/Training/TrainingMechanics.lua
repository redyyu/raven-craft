

local PARTS_ORDERS = {
    -- Front
    ["Battery"] = true,
    ["Radio"] = true,
    ["HeadlightLeft"] = true,
    ["HeadlightRight"] = true,
    ["EngineDoor"] = true,
    ["Windshield"] = true,
    
    -- Left
    ["TireFrontLeft"] = {
        "BrakeFrontLeft", "SuspensionFrontLeft",
    },
    ["WindowFrontLeft"] = {
        "DoorFrontLeft",
    },
    ["SeatFrontLeft"] = true,
    
    ["WindowMiddleLeft"] = true,
    ["DoorMiddleLeft"] = true,
    ["SeatMiddleLeft"] = true,
    
    ["TireRearLeft"] = {
        "BrakeRearLeft", "SuspensionRearLeft",
    }, 
    ["WindowRearLeft"] = {
        "DoorRearLeft",
    },
    ["SeatRearLeft"] = true,

    -- Rear
    ["GasTank"] = true,
    ["WindshieldRear"] = true,
    ["TrunkDoor"] = true,
    ["DoorRear"] = true,
    ["Muffler"] = true,
    ["HeadlightRearRight"] = true,
    ["HeadlightRearLeft"] = true, 

    -- Right
    ["TireRearRight"] = {
        "BrakeRearRight", "SuspensionRearRight", 
    },
    ["WindowRearRight"] = {
        "DoorRearRight",
    },
    ["SeatRearRight"] = true, 
    
    ["WindowMiddleRight"] = true, 
    ["DoorMiddleRight"] = true,
    ["SeatMiddleRight"] = true, 

    ["TireFrontRight"] = {
        "BrakeFrontRight", "SuspensionFrontRight",
    }, 
    ["WindowFrontRight"] = {
        "DoorFrontRight"
    },
    ["SeatFrontRight"] = true, 

}



local function getUnknowRecipeVehicleType(playerObj, vehicle)
    -- vehicle:getVehicleType() might not get the type,
    -- seems its only work for Vehicle Script.
    -- lua {
    --    create = Vehicles.Create.Engine,
    --    update = Vehicles.Update.Engine,
    --    checkEngine = Vehicles.CheckEngine.Engine,
    -- }
 
    local vehicle_type = vehicle:getScript():getMechanicType()
    if vehicle_type == 1 and not playerObj:isRecipeKnown("Basic Mechanics") then
        return "Basic_Mechanics"
    elseif vehicle_type == 2 and not playerObj:isRecipeKnown("Intermediate Mechanics") then
        return "Intermediate_Mechanics"
    elseif vehicle_type == 3 and not playerObj:isRecipeKnown("Advanced Mechanics") then
        return "Advanced_Mechanics"
    end
    return nil
end


local function isPrekQualified(playerObj, partTable)
    if not partTable then
        return false
    end

    if partTable.skills and partTable.skills ~= "" then
        for _, prek_str in ipairs(partTable.skills:split(";")) do
            local name, lv = VehicleUtils.split(prek_str, ":")

            if playerObj:getPerkLevel(Perks.FromString(name)) < tonumber(lv) then
                -- playerObj:Say(getText("IGUI_PlayerText_Require_level", lv))
                return false
            end
        end
    end
    return true
end


local function equipToolsForPart(partTable, playerObj, screwdriver, wrench, lug_wrench, jack)
    if not partTable or not partTable.items then return end

    for _, itm in ipairs(partTable.items) do
        local is_priamry = nil
        local hand_item = nil
        local equip_item = nil
        if itm.type == screwdriver:getType() or itm.type == screwdriver:getFullType() then
            equip_item = screwdriver
        elseif itm.type == wrench:getType() or itm.type == wrench:getFullType() then
            equip_item = wrench
        elseif itm.type == lug_wrench:getType() or itm.type == lug_wrench:getFullType() then
            equip_item = lug_wrench
        elseif itm.type == jack:getType() or itm.type == jack:getFullType() then
            equip_item = jack
        end
        if itm.equip == 'primary' then
            is_priamry = true
            hand_item = playerObj:getPrimaryHandItem()
        else
            is_priamry = false
            hand_item = playerObj:getSecondaryHandItem()
        end

        if equip_item then
            ISWorldObjectContextMenu.equip(playerObj, hand_item, equip_item, is_priamry)
        end
    end
end


local function installVehiclePart(part, playerObj, vehicle, screwdriver, wrench, lug_wrench, jack)
    ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, vehicle, part:getArea()))
    equipToolsForPart(part:getTable('install'), playerObj, screwdriver, wrench, lug_wrench, jack)
    ISTimedActionQueue.add(
        ISTrainingMechanicsAction:new(playerObj, part, true, screwdriver, wrench, lug_wrench, jack))
end


local function uninstallVehiclePart(part, playerObj, vehicle, screwdriver, wrench, lug_wrench, jack)
    ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, vehicle, part:getArea()))
    equipToolsForPart(part:getTable('uninstall'), playerObj, screwdriver, wrench, lug_wrench, jack)
    ISTimedActionQueue.add(
        ISTrainingMechanicsAction:new(playerObj, part, false, screwdriver, wrench, lug_wrench, jack))

end


local function onTrainingMechanics(playerObj, vehicle, screwdriver, wrench, lug_wrench, jack)
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, screwdriver)
    local player_perk_lv = playerObj:getPerkLevel(Perks.Mechanics) or 0
    for part_name, process in pairs(PARTS_ORDERS) do
        local part = vehicle:getPartById(part_name)
        if part then
            local part_install_table = part:getTable('install')
            local part_uninstall_table = part:getTable('uninstall')
            
            if isPrekQualified(playerObj, part_uninstall_table) then
                uninstallVehiclePart(part, playerObj, vehicle, screwdriver, wrench, lug_wrench, jack)
            end
            if type(process) == 'table' then
                for _, child_part_name in ipairs(process) do
                    local child_part = vehicle:getPartById(child_part_name)
                    if child_part then
                        local child_part_install_table = child_part:getTable('install')
                        local child_part_uninstall_table = child_part:getTable('uninstall')
                        if isPrekQualified(playerObj, child_part_uninstall_table) then
                            uninstallVehiclePart(child_part, playerObj, vehicle, screwdriver, wrench, lug_wrench, jack)
                        end
                        if isPrekQualified(playerObj, child_part_install_table) then
                            installVehiclePart(child_part, playerObj, vehicle, screwdriver, wrench, lug_wrench, jack)
                        end
                    end
                end
            end
            if isPrekQualified(playerObj, part_uninstall_table) then
                installVehiclePart(part, playerObj, vehicle, screwdriver, wrench, lug_wrench, jack)
            end
        end
    end

end


local function doTrainingMechanicsMenu(playerObj, context, vehicle, test)
    local playerInv = playerObj:getInventory()
    
    local unknow_recipe = getUnknowRecipeVehicleType(playerObj, vehicle)
    local door_locked = vehicle:isAnyDoorLocked()

    local screwdriver = playerInv:getFirstTypeRecurse("Screwdriver")
    local wrench = playerInv:getFirstTypeRecurse("Wrench")
    local lug_wrench = playerInv:getFirstTypeRecurse("LugWrench")
    local jack = playerInv:getFirstTypeRecurse("Jack")

    local toolTip = ISToolTip:new()
    toolTip:initialise()

    option = context:addOption(getText("ContextMenu_TRAIN_MECHANICS"), playerObj, onTrainingMechanics, vehicle, screwdriver, wrench, lug_wrench, jack)
    option.toolTip = toolTip

    toolTip:setName(getText("ContextMenu_TRAIN_MECHANICS"))

    if not unknow_recipe and not door_locked and screwdriver and wrench and lug_wrench and jack then
        toolTip.description = getText("Tooltip_TRAINING_READY_FOR") .." <LINE><LINE> "
        toolTip.description = toolTip.description .. TextColor.ghs .. getText("Tooltip_Item_Screwdriver") .." <LINE> "
        toolTip.description = toolTip.description .. TextColor.ghs .. getText("Tooltip_Item_Wrench") .." <LINE> "
        toolTip.description = toolTip.description .. TextColor.ghs .. getText("Tooltip_Item_LugWrench") .. "<LINE> "
        toolTip.description = toolTip.description .. TextColor.ghs .. getText("Tooltip_Item_Jack") .. "<LINE> "
    else
        option.notAvailable = true
        toolTip.description = TextColor.bhs .. getText("Tooltip_TRAINING_NO_ITEMS_FOR") .." <LINE><LINE> "
        
        if unknow_recipe then
            local recipe_name = getText("Tooltip_Recipe"..unknow_recipe)
            toolTip.description = toolTip.description .. TextColor.bhs .. getText("Tooltip_TRAINING_NEED_LEARN", recipe_name) .." <LINE> "
        end

        if door_locked then
            toolTip.description = toolTip.description .. TextColor.bhs .. getText("Tooltip_ONE_OF_DOOR_IS_LOCKED") .." <LINE> "
        end

        if not screwdriver then
            toolTip.description = toolTip.description .. TextColor.bhs .. getText("Tooltip_Item_Screwdriver") .."  0/1 <LINE> "
        end
        if not wrench then
            toolTip.description = toolTip.description .. TextColor.bhs .. getText("Tooltip_Item_Wrench") .."  0/1 unit <LINE> "
        end
        if not lug_wrench then
            toolTip.description = toolTip.description .. TextColor.bhs .. getText("Tooltip_Item_LugWrench") .. "  0/1 <LINE> "
        end
        if not jack then
            toolTip.description = toolTip.description .. TextColor.bhs .. getText("Tooltip_Item_Jack") .. "  0/1 <LINE> "
        end
    end
end


local function onTrainingMechanicsMenuOutsideVehicle(player, context, worldobjects, test)
    local playerObj = getSpecificPlayer(player)
    local vehicle = playerObj:getVehicle()
    if not vehicle then
        if JoypadState.players[player+1] then
            local px = playerObj:getX()
            local py = playerObj:getY()
            local pz = playerObj:getZ()
            local sqs = {}
            sqs[1] = getCell():getGridSquare(px, py, pz)
            local dir = playerObj:getDir()
            if (dir == IsoDirections.N) then        sqs[2] = getCell():getGridSquare(px-1, py-1, pz); sqs[3] = getCell():getGridSquare(px, py-1, pz);   sqs[4] = getCell():getGridSquare(px+1, py-1, pz);
            elseif (dir == IsoDirections.NE) then   sqs[2] = getCell():getGridSquare(px, py-1, pz);   sqs[3] = getCell():getGridSquare(px+1, py-1, pz); sqs[4] = getCell():getGridSquare(px+1, py, pz);
            elseif (dir == IsoDirections.E) then    sqs[2] = getCell():getGridSquare(px+1, py-1, pz); sqs[3] = getCell():getGridSquare(px+1, py, pz);   sqs[4] = getCell():getGridSquare(px+1, py+1, pz);
            elseif (dir == IsoDirections.SE) then   sqs[2] = getCell():getGridSquare(px+1, py, pz);   sqs[3] = getCell():getGridSquare(px+1, py+1, pz); sqs[4] = getCell():getGridSquare(px, py+1, pz);
            elseif (dir == IsoDirections.S) then    sqs[2] = getCell():getGridSquare(px+1, py+1, pz); sqs[3] = getCell():getGridSquare(px, py+1, pz);   sqs[4] = getCell():getGridSquare(px-1, py+1, pz);
            elseif (dir == IsoDirections.SW) then   sqs[2] = getCell():getGridSquare(px, py+1, pz);   sqs[3] = getCell():getGridSquare(px-1, py+1, pz); sqs[4] = getCell():getGridSquare(px-1, py, pz);
            elseif (dir == IsoDirections.W) then    sqs[2] = getCell():getGridSquare(px-1, py+1, pz); sqs[3] = getCell():getGridSquare(px-1, py, pz);   sqs[4] = getCell():getGridSquare(px-1, py-1, pz);
            elseif (dir == IsoDirections.NW) then   sqs[2] = getCell():getGridSquare(px-1, py, pz);   sqs[3] = getCell():getGridSquare(px-1, py-1, pz); sqs[4] = getCell():getGridSquare(px, py-1, pz);
            end
            for _, sq in ipairs(sqs) do
                vehicle = sq:getVehicleContainer()
                if vehicle then
                    return doTrainingMechanicsMenu(playerObj, context, vehicle, test)
                end
            end
            return
        end
        
        vehicle = IsoObjectPicker.Instance:PickVehicle(getMouseXScaled(), getMouseYScaled())
        if vehicle then
            return doTrainingMechanicsMenu(playerObj, context, vehicle, test)
        end
    end
end

Events.OnFillWorldObjectContextMenu.Add(onTrainingMechanicsMenuOutsideVehicle)