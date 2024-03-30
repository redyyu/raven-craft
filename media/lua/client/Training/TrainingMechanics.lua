require "TimedActions/ISChangeGameSpeed"

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
    local unknow_recipe = nil
    local vehicle_type = vehicle:getScript():getMechanicType()
    if vehicle_type == 1 and not playerObj:isRecipeKnown("Basic Mechanics") then
        unknow_recipe = ScriptManager.instance:getItem("Base.MechanicMag1"):getDisplayName()

    elseif vehicle_type == 2 and not playerObj:isRecipeKnown("Intermediate Mechanics") then
        unknow_recipe = ScriptManager.instance:getItem("Base.MechanicMag2"):getDisplayName()

    elseif vehicle_type == 3 and not playerObj:isRecipeKnown("Advanced Mechanics") then
        unknow_recipe = ScriptManager.instance:getItem("Base.MechanicMag3"):getDisplayName()
    end

    return unknow_recipe
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


local Mech = {}


Mech.onTrainingMechanics = function(playerObj, vehicle, screwdriver, wrench, lug_wrench, jack)
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

    ISTimedActionQueue.add(ISChangeGameSpeed:new(playerObj, 1))
end


Mech.doTrainingMechanicsMenu = function(playerObj, context, vehicle, test)
    local playerInv = playerObj:getInventory()
    
    local unknow_recipe = getUnknowRecipeVehicleType(playerObj, vehicle)
    local door_locked = vehicle:isAnyDoorLocked()

    local screwdriver = playerInv:getFirstTypeRecurse("Screwdriver")
    local wrench = playerInv:getFirstTypeRecurse("Wrench")
    local lug_wrench = playerInv:getFirstTypeRecurse("LugWrench")
    local jack = playerInv:getFirstTypeRecurse("Jack")

    local toolTip = ISToolTip:new()
    toolTip:initialise()

    local option = context:addOption(getText("ContextMenu_TRAIN_MECHANICS"), 
                                     playerObj, Mech.onTrainingMechanics, 
                                     vehicle, screwdriver, wrench, lug_wrench, jack)
    option.toolTip = toolTip

    toolTip:setName(getText("ContextMenu_TRAIN_MECHANICS"))
    local scrdrvScriptItem = ScriptManager.instance:getItem("Base.Screwdriver")
    local wrenchScriptItem = ScriptManager.instance:getItem("Base.Wrench")
    local lugwrenchScriptItem = ScriptManager.instance:getItem("Base.LugWrench")
    local jackScriptItem = ScriptManager.instance:getItem("Base.Jack")
    if not unknow_recipe and not door_locked and screwdriver and wrench and lug_wrench and jack then
        toolTip.description = getText("Tooltip_TRAINING_READY_FOR") .." <LINE><LINE> "
    else
        option.notAvailable = true
        toolTip.description = getText("Tooltip_TRAINING_NOT_READY_FOR") .." <LINE><LINE> "
    end
    
    if unknow_recipe then
        toolTip.description = toolTip.description .. RC.Txt.bhs .. getText("Tooltip_TRAINING_NEED_LEARN", unknow_recipe) .." <LINE> "
    end

    if door_locked then
        toolTip.description = toolTip.description .. RC.Txt.bhs .. getText("Tooltip_ONE_OF_DOOR_IS_LOCKED") .." <LINE> "
    end

    if screwdriver then
        toolTip.description = toolTip.description .. RC.Txt.ghs .. scrdrvScriptItem:getDisplayName() .." <LINE> "
    else
        toolTip.description = toolTip.description .. RC.Txt.bhs .. scrdrvScriptItem:getDisplayName() .." <LINE> "
    end

    if wrench then
        toolTip.description = toolTip.description .. RC.Txt.ghs .. wrenchScriptItem:getDisplayName() .." <LINE> "
    else
        toolTip.description = toolTip.description .. RC.Txt.bhs .. wrenchScriptItem:getDisplayName() .." <LINE> "
    end
    
    if lug_wrench then
        toolTip.description = toolTip.description .. RC.Txt.ghs .. lugwrenchScriptItem:getDisplayName() .. " <LINE> "
    else
        toolTip.description = toolTip.description .. RC.Txt.bhs .. lugwrenchScriptItem:getDisplayName() .. " <LINE> "
    end

    if jack then
        toolTip.description = toolTip.description .. RC.Txt.ghs .. jackScriptItem:getDisplayName() .. " <LINE> "
    else
        toolTip.description = toolTip.description .. RC.Txt.bhs .. jackScriptItem:getDisplayName() .. " <LINE> "
    end
end


Mech.onFillWorldObjectContextMenu = function(playerNum, context, worldobjects, test)
    local playerObj = getSpecificPlayer(playerNum)
    local vehicle = playerObj:getVehicle()
    if not vehicle then
        vehicle = RC.pickVehicle(playerNum)
        if vehicle then
            return Mech.doTrainingMechanicsMenu(playerObj, context, vehicle, test)
        end
    end
end

Events.OnFillWorldObjectContextMenu.Add(Mech.onFillWorldObjectContextMenu)