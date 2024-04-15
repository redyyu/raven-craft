
local PtDty = {}

PtDty.onTransferToWashMachine = function(playerObj, washerContainer, items)
    local inventory = washerContainer
    if type(items) ~= "table" then
        items = {items}
    end
    for _, item in ipairs(items) do
        if not washerContainer:contains(item) and washerContainer:hasRoomFor(playerObj, item) then
            ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, item:getContainer(), washerContainer))
        end
	end
end


PtDty.onFillWorldObjectContextMenu = function(playerNum, context, worldobjects, test)
    local playerObj = getSpecificPlayer(playerNum)
    local playerInv = playerObj:getInventory()

    local clothingWasherOrDryer = nil
    for _, obj in ipairs(worldobjects) do
        if instanceof(obj, "IsoClothingDryer") or 
           instanceof(obj, "IsoClothingWasher") or 
           instanceof(obj, "IsoCombinationWasherDryer") then
            clothingWasherOrDryer = obj
        end
    end

    if not clothingWasherOrDryer then return end

    local container = clothingWasherOrDryer:getContainer()

    -- Transfer dirty clothes to washer.
    if container then
        local clothes = playerInv:getItemsFromCategory("Clothing")
        local dirty_clothes = {}
        local blood_clothes = {}
        for i=0, clothes:size() - 1 do
            local clothing = clothes:get(i)
            if clothing:getDirtyness() > 1 or clothing:getBloodLevel() > 1 then
                table.insert(dirty_clothes, clothing)
            end
            if clothing:getBloodLevel() > 1 then
                table.insert(blood_clothes, clothing)
            end
        end

        if #dirty_clothes > 0 then
            local washer_name = RC.getMoveableDisplayName(clothingWasherOrDryer)
            local washerOption = context:addOptionOnTop(getText("ContextMenu_Put_Washer", washer_name))
            local washerMenu = ISContextMenu:getNew(context)
            -- local waterRemaining = clothingWasherOrDryer:getWaterAmount()
            context:addSubMenu(washerOption, washerMenu)
            
            -- local totalWaterRequired = 0
            -- local totalBloodWaterRequired = 0

            for _, _clothing in ipairs(dirty_clothes) do
                -- local waterRequired = ISWashClothing.GetRequiredWater(_clothing)
                local bloodLevel =  math.ceil(_clothing:getBloodLevel())
                local dirtyness = math.ceil(_clothing:getDirtyness())
				local tooltip = ISWorldObjectContextMenu.addToolTip()
                local option = washerMenu:addOption(_clothing:getDisplayName(), playerObj, PtDty.onTransferToWashMachine, container, _clothing)
                -- local _water_remain = math.min(waterRemaining, waterRequired)
                -- tooltip.description = getText("ContextMenu_WaterName") .. ": " .. tostring(_water_remain) .. " / " .. tostring(waterRequired)
                -- tooltip.description = tooltip.description .. " <LINE> " .. getText("Tooltip_clothing_bloody") .. ": " .. bloodLevel .. " / 100"
                if bloodLevel > 0 then
                    tooltip.description = getText("Tooltip_clothing_bloody") .. ": " .. bloodLevel .. " / 100"
                end
                tooltip.description = tooltip.description .. " <LINE> " .. getText("Tooltip_clothing_dirty") .. ": " .. dirtyness .. " / 100"
                option.toolTip = tooltip
				-- if (waterRemaining < waterRequired) then
				-- 	option.notAvailable = true
				-- end
                -- totalWaterRequired = totalWaterRequired + waterRequired
                -- if bloodLevel > 0 then
                --     totalBloodWaterRequired = totalBloodWaterRequired + waterRequired
                -- end
            end
            
            if #blood_clothes > 0 then
                local bloodOpt = washerMenu:addOptionOnTop(getText("ContextMenu_All_Blooded_Clothes"), 
                                                           playerObj, PtDty.onTransferToWashMachine, container, blood_clothes)
                -- local bloodtip = ISWorldObjectContextMenu.addToolTip()
                -- local blood_water_remain = math.min(waterRemaining, totalBloodWaterRequired)
                -- bloodtip.description = getText("ContextMenu_WaterName") .. ": " .. tostring(blood_water_remain) .. " / " .. tostring(totalBloodWaterRequired)
                -- bloodOpt.toolTip = bloodtip
				-- if (waterRemaining < totalBloodWaterRequired) then
				-- 	bloodOpt.notAvailable = true
				-- end
            end
            
            local allOpt = washerMenu:addOptionOnTop(getText("ContextMenu_All_Dirty_Clothes"), playerObj, PtDty.onTransferToWashMachine, container, dirty_clothes)
            -- local alltip = ISWorldObjectContextMenu.addToolTip()
            -- local total_water_remain = math.min(waterRemaining, totalWaterRequired)
            -- alltip.description = getText("ContextMenu_WaterName") .. ": " .. tostring(total_water_remain) .. " / " .. tostring(totalWaterRequired)
            -- allOpt.toolTip = alltip
            -- if (waterRemaining < totalWaterRequired) then
            --     allOpt.notAvailable = true
            -- end
        end
    end

 end


 Events.OnFillWorldObjectContextMenu.Add(PtDty.onFillWorldObjectContextMenu)
 