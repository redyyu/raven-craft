
local function onTailoringTraining(playerObj, clothing, needle)
    ISTimedActionQueue.add(ISTailoringTrainingAction:new(playerObj, clothing, needle))
end


local function doTailoringTrainingMenu(player, context, items)
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
        local thread = playerInv:getFirstTypeRecurse("Thread")
        local needle = playerInv:getFirstTypeRecurse("Needle")
        -- local count_fabric = playerInv:getCountTypeRecurse("RippedSheets")
        local has_fabric = playerInv:containsTypeRecurse("RippedSheets")

        local toolTip = ISToolTip:new()
        toolTip:initialise()

        option = context:addOption(getText("ContextMenu_TRAIN_TAILORING"), playerObj, onTailoringTraining, clothing, needle)
        option.toolTip = toolTip

        toolTip:setName(getText("ContextMenu_TRAIN_TAILORING"))
        
        if thread and needle and has_fabric then
            toolTip.description = getText("Tooltip_TRAINING_READY_FOR") .." <LINE><LINE> "
            toolTip.description = toolTip.description .. TextColor.ghs .. getText("Tooltip_Item_Needle") .." <LINE> "
            toolTip.description = toolTip.description .. TextColor.ghs .. getText("Tooltip_Item_Thread") .." <LINE> "
            toolTip.description = toolTip.description .. TextColor.ghs .. getText("Tooltip_Item_RippedSheets") .. "<LINE> "
        else
            option.notAvailable = true
            toolTip.description = TextColor.bhs .. getText("Tooltip_TRANING_NO_MATERIALS_FOR") .." <LINE><LINE> "
            
            if not needle then
                toolTip.description = toolTip.description .. TextColor.bhs .. getText("Tooltip_Item_Needle") .." 0/1 <LINE> "
            end
            if not thread then
                toolTip.description = toolTip.description .. TextColor.bhs .. getText("Tooltip_Item_Thread") .." 0/1 unit <LINE> "
            end
            if not has_fabric then
                toolTip.description = toolTip.description .. TextColor.bhs .. getText("Tooltip_Item_RippedSheets") .. " 0/1 <LINE> "
            end
        end
    end
end

Events.OnFillInventoryObjectContextMenu.Add(doTailoringTrainingMenu)