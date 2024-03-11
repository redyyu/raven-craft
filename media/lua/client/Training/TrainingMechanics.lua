

local PARTS_ORDERS = {
    -- Front
    ["Battery"] = {
        skill = 0,
    }, 
    ["Radio"] = {
        skill = 0,
    },  
    ["HeadlightLeft"] = {
        skill = 0,
    },  
    ["HeadlightRight"] = {
        skill = 0,
    },  

    ["EngineDoor"] = {
        skill = 3,
    }, 
    ["Windshield"] = {
        skill = 5,
    }, 
    
    -- Left
    ["SeatFrontLeft"] = {
        skill = 1,
    }, 
    ["TireFrontLeft"] = {
        skill = 1,
        children = {
            ["BrakeFrontLeft"] = {
                skill = 3,
            }, 
            ["SuspensionFrontLeft"] = {
                skill = 3,
            }, 
        }
    }, 
    
    ["WindowFrontLeft"] = {
        skill = 3,
        children = {
            ["DoorFrontLeft"] = {
                skill = 4,
            },
        }
    }, 
    
    
    ["SeatMiddleLeft"] = {
        skill = 1,
    }, 
    ["WindowMiddleLeft"] = {
        skill = 3,
    }, 
    ["DoorMiddleLeft"] = {
        skill = 4,
    }, 
    
    ["SeatRearLeft"] = {
        skill = 1,
    }, 
    ["TireRearLeft"] = {
        skill = 1,
        children = {
            ["BrakeRearLeft"] = {
                skill = 3,
            }, 
            ["SuspensionRearLeft"] = {
                skill = 3,
            }, 
        }
    }, 
    
    ["WindowRearLeft"] = {
        skill = 3,
        children = {
            ["DoorRearLeft"] = {
                skill = 4,
            }, 
        }
    }, 
    
    
    -- Rear
    ["GasTank"] = {
        skill = 5,
    }, 
    ["WindshieldRear"] = {
        skill = 5,
    }, 
    ["TrunkDoor"] = {
        skill = 3,
    }, 
    ["DoorRear"] = {
        skill = 4,
    }, 
    ["Muffler"] = {
        skill = 4,
    }, 
    ["HeadlightRearRight"] = {
        skill = 0,
    }, 
    ["HeadlightRearLeft"] = {
        skill = 0,
    }, 

    -- Right
    ["SeatRearRight"] = {
        skill = 1,
    }, 
    ["TireRearRight"] = {
        skill = 1,
        children = {
            ["BrakeRearRight"] = {
                skill = 3,
            }, 
            ["SuspensionRearRight"] = {
                skill = 3,
            }, 
        }
    }, 
    
    ["WindowRearRight"] = {
        skill = 3,
        children = {
            ["DoorRearRight"] = {
                skill = 4,
            }, 
        }
    }, 
    
    ["SeatMiddleRight"] = {
        skill = 1,
    }, 
    ["WindowMiddleRight"] = {
        skill = 3,
    }, 
    ["DoorMiddleRight"] = {
        skill = 4,
    }, 

    ["SeatFrontRight"] = {
        skill = 1,
    }, 
    ["TireFrontRight"] = {
        skill = 1,
        children = {
            ["BrakeFrontRight"] = {
                skill = 3,
            }, 
            ["SuspensionFrontRight"] = {
                skill = 3,
            }, 
        }
    }, 
    
    ["WindowFrontRight"] = {
        skill = 3,
        children = {
            ["DoorFrontRight"] = {
                skill = 4,
            }, 
        }
    }, 
    
    
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


local function checkPrekLevelReached(playerObj, perks_str)
    if perks_str and perks_str ~= "" then
        for _, prek_str in ipairs(perks_str:split(";")) do
            local name, lv = VehicleUtils.split(prek_str, ":")
            if playerObj:getPerkLevel(Perks.FromString(name)) < tonumber(lv) then
                -- playerObj:Say(getText("IGUI_PlayerText_Require_level", lv))
                return false
            end
        end
    end
    return true
end


local function preparePart(partTable, playerObj, screwdriver, wrench, lug_wrench, jack)
    if not checkPrekLevelReached(playerObj, partTable.skills) then
        return false
    end

    if partTable.recipes and not playerObj:isRecipeKnown(partTable.recipes) then
        playerObj:Say(getText("IGUI_PlayerText_Unknow_Recipe_For_Vehicle"))
        return false
    end

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
        else
            return false
        end
    end

    return true
end


local function installVehiclePart(part_name, playerObj, vehicle, screwdriver, wrench, lug_wrench, jack)
    local part = vehicle:getPartById(part_name)
    if not part then 
        return
    end

    local playerInv = playerObj:getInventory()
    local item = nil
    for i=0, part:getItemType():size() - 1 do
        local item_type = part:getItemType():get(i)
        item = playerInv:getFirstTypeRecurse(item_type)
        if item then
            break
        end
    end

    if not item then 
        return
    end

    local partTable = part:getTable('install')
    local area = partTable.area or part:getArea()
    ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, part:getVehicle(), area))

    local prepared_part = preparePart(partTable, playerObj, screwdriver, wrench, lug_wrench, jack) 
    if not prepared_part then
        return
    end
    local time = tonumber(partTable.time) or 50
    ISTimedActionQueue.add(ISInstallVehiclePart:new(playerObj, part, item, time))
end


local function uninstallVehiclePart(part_name, playerObj, vehicle, screwdriver, wrench, lug_wrench, jack)
    local part = vehicle:getPartById(part_name)
    if not part or not part:getInventoryItem() then 
        return
    end

    local partTable = part:getTable('uninstall')
    local area = partTable.area or part:getArea()
    ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, part:getVehicle(), area))

    local prepared_part = preparePart(partTable, playerObj, screwdriver, wrench, lug_wrench, jack) 
    if not prepared_part then
        return
    end
    local time = tonumber(partTable.time) or 50
    ISTimedActionQueue.add(ISUninstallVehiclePart:new(playerObj, part, time))
end


local function onTrainingMechanics(playerObj, vehicle, screwdriver, wrench, lug_wrench, jack)
    
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, screwdriver)
    local player_perk_lv = playerObj:getPerkLevel(Perks.Mechanics) or 0
    for part_name, process in pairs(PARTS_ORDERS) do
        if player_perk_lv >= process.skill then
            uninstallVehiclePart(part_name, playerObj, vehicle, screwdriver, wrench, lug_wrench, jack)
            if process.children then
                for child_part_name, child_process in pairs(process.children) do
                    if player_perk_lv >= child_process.skill then
                        uninstallVehiclePart(child_part_name, playerObj, vehicle, screwdriver, wrench, lug_wrench, jack)
                        installVehiclePart(child_part_name, playerObj, vehicle, screwdriver, wrench, lug_wrench, jack)
                    end
                end
            end
            installVehiclePart(part_name, playerObj, vehicle, screwdriver, wrench, lug_wrench, jack)
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