
local Tail = {}

Tail.onTrainingTailoring = function(playerObj, clothing, needle)
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, clothing)
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, needle)
    ISTimedActionQueue.add(ISTrainingTailoringAction:new(playerObj, clothing, needle))
end


Tail.onFillInventoryObjectContextMenu(player, context, items)
    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()

    local items = ISInventoryPane.getActualItems(items)
    local clothing = nil
    for _, item in ipairs(items) do
        if instanceof(item, "Clothing") and item:getFabricType() == "Cotton" then
            clothing = item
            break
        end
	end

    if clothing then
        local needle = playerInv:getFirstTypeRecurse("Needle")
        local thread_uses = playerInv:getUsesTypeRecurse("Thread")
        local count_fabric = playerInv:getCountTypeRecurse("RippedSheets")

        local toolTip = ISToolTip:new()
        toolTip:initialise()

        local option = context:addOption(getText("ContextMenu_TRAIN_TAILORING"), playerObj, Tail.onTrainingTailoring, clothing, needle)
        option.toolTip = toolTip

        toolTip:setName(getText("ContextMenu_TRAIN_TAILORING"))
        local threadScriptItem = ScriptManager.instance:getItem("Base.Thread")
        local needleScriptItem = ScriptManager.instance:getItem("Base.Needle")
        local ripsheetScriptItem = ScriptManager.instance:getItem("Base.RippedSheets")
        if needle and thread_uses > 0 and count_fabric > 0 then
            toolTip.description = getText("Tooltip_TRAINING_READY_FOR") .." <LINE><LINE> "
        else
            option.notAvailable = true
            toolTip.description = getText("Tooltip_TRAINING_NOT_READY_FOR") .." <LINE><LINE> "
        end

        if needle then
            toolTip.description = toolTip.description .. RC.Txt.ghs .. needleScriptItem:getDisplayName() .." <LINE> "
        else
            toolTip.description = toolTip.description .. RC.Txt.bhs .. needleScriptItem:getDisplayName() .." <LINE> "
        end

        if thread_uses > 0 then
            toolTip.description = toolTip.description .. RC.Txt.ghs .. threadScriptItem:getDisplayName() .."  "..thread_uses.."/1 <LINE> "
        else
            toolTip.description = toolTip.description .. RC.Txt.bhs .. threadScriptItem:getDisplayName() .."  0/1 unit <LINE> "
        end

        if count_fabric > 0 then
            toolTip.description = toolTip.description .. RC.Txt.ghs .. ripsheetScriptItem:getDisplayName() .. "  "..count_fabric.."/1 <LINE> "
        else
            toolTip.description = toolTip.description .. RC.Txt.bhs .. ripsheetScriptItem:getDisplayName() .. "  0/1 <LINE> "
        end
    end
end

Events.OnFillInventoryObjectContextMenu.Add(Tail.onFillInventoryObjectContextMenu)