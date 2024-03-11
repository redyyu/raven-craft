
local function onTrainingMechanics(playerObj, vehicle, screwdriver, wrench, lug_wrench, jack)
    -- Radio and Battery
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, screwdriver)
    local seat_front_left = vehicle:getPartById("SeatFrontLeft")
    local seat_front_right = vehicle:getPartById("SeatFrontRight")
    local seat_rear_left = vehicle:getPartById("SeatRearLeft")
    local seat_rear_right = vehicle:getPartById("SeatRearRight")

    print('---------------------onTrainingMechanics-------------------------')
    print(seat_front_left)
    print(seat_front_right)
    print(seat_rear_left)
    print(seat_rear_right)

    -- ISInventoryPaneContextMenu.transferIfNeeded(playerObj, wrench)
    -- ISInventoryPaneContextMenu.transferIfNeeded(playerObj, lug_wrench)
    -- ISInventoryPaneContextMenu.transferIfNeeded(playerObj, wrench)
    -- ISTimedActionQueue.add(ISTrainingMechanicsAction:new(playerObj, vehicle, screwdriver, wrench, lug_wrench, jack))
end


local function doTrainingMechanicsMenu(playerObj, context, vehicle, test)
    local playerInv = playerObj:getInventory()

    local screwdriver = playerInv:getFirstTypeRecurse("Screwdriver")
    local wrench = playerInv:getFirstTypeRecurse("Wrench")
    local lug_wrench = playerInv:getFirstTypeRecurse("LugWrench")
    local jack = playerInv:getFirstTypeRecurse("Jack")

    local toolTip = ISToolTip:new()
    toolTip:initialise()

    option = context:addOption(getText("ContextMenu_TRAIN_MECHANICS"), playerObj, onTrainingMechanics, vehicle, screwdriver, wrench, lug_wrench, jack)
    option.toolTip = toolTip

    toolTip:setName(getText("ContextMenu_TRAIN_MECHANICS"))
    
    if screwdriver and wrench and lug_wrench and jack then
        toolTip.description = getText("Tooltip_TRAINING_READY_FOR") .." <LINE><LINE> "
        toolTip.description = toolTip.description .. TextColor.ghs .. getText("Tooltip_Item_Screwdriver") .." <LINE> "
        toolTip.description = toolTip.description .. TextColor.ghs .. getText("Tooltip_Item_Wrench") .." <LINE> "
        toolTip.description = toolTip.description .. TextColor.ghs .. getText("Tooltip_Item_LugWrench") .. "<LINE> "
        toolTip.description = toolTip.description .. TextColor.ghs .. getText("Tooltip_Item_Jack") .. "<LINE> "
    else
        option.notAvailable = true
        toolTip.description = TextColor.bhs .. getText("Tooltip_TRANING_NO_ITEMS_FOR") .." <LINE><LINE> "
        
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