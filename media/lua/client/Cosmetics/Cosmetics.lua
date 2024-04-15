

local Cosm = {}

Cosm.onUsePerfume = function(perfume_item, playerObj)
    local playerInv = playerObj:getInventory()
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, perfume_item)
    ISTimedActionQueue.add(ISPerfumeAction:new(playerObj, perfume_item))
end


Cosm.onFillInventoryObjectContextMenu = function(playerNum, context, items)
    local playerObj = getSpecificPlayer(playerNum)

    local items = ISInventoryPane.getActualItems(items)
    local perfume_type = playerObj:isFemale() and "Perfume" or "Cologne"
    local perfume_item = nil

    for _, item in ipairs(items) do
        if instanceof(item, "Drainable") and item:getType() == perfume_type then
            perfume_item = item
        end
    end

    if perfume_item then
        context:addOptionOnTop(getText("ContextMenu_Use_Item", perfume_item:getDisplayName()), 
                               perfume_item, Cosm.onUsePerfume, playerObj)
    end
    
end


Events.OnFillInventoryObjectContextMenu.Add(Cosm.onFillInventoryObjectContextMenu)
