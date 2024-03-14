
local function isSelectedItem(item, selected_items)
    for _, itm in ipairs(selected_items) do
        if item == itm then
            return true
        end
    end
    return false 
end


local function isAnyItemInInventory(items, inventory)
    if inventory then
        if type(items) ~= 'table' then
            items = {items}
        end
        for _, item in ipairs(items) do
            if item then
                return inventory:contains(item)
            end
        end
    else
        return false
    end
end


local function onTransferToContainer(playerObj, container, items)
    for _, item in ipairs(items) do
        if not container:getInventory():contains(item) then
            ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, item:getContainer(), container:getInventory()))
        end
	end
end


local function getEquippedContainers(playerObj)
    local playerInv = playerObj:getInventory()
    local containers = playerInv:getItemsFromCategory("Container")
    local equipped_containers = {}
    for i=0, containers:size() - 1  do
        local container = containers:get(i)
        -- bag:canBeEquipped() == 'Back', getBodyLocation() == 'Back' is for wear.
        if container:isEquipped() then -- 
            table.insert(equipped_containers, container)
        end
    end
    return equipped_containers
end



local function doExtraInventoryMenu(player, context, items)
    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()

    local items = ISInventoryPane.getActualItems(items)

    -- Transfer items between equipped containers

    local containers = playerInv:getItemsFromCategory("Container")
    local equipped_containers = getEquippedContainers(playerObj)
    local transfer_containers = {}

    if #equipped_containers > 0 then
        for _, container in ipairs(equipped_containers) do
            if not isSelectedItem(container, items) and not isAnyItemInInventory(items, container:getInventory()) then
                table.insert(transfer_containers, container)
            end
        end
    end

    if #transfer_containers > 0 then
        local transferOption = context:addOption(getText("ContextMenu_Transfer_to"))
        local transferMenu = ISContextMenu:getNew(context)
        context:addSubMenu(transferOption, transferMenu)

        for _, trans_to in ipairs(transfer_containers) do
            transferMenu:addOption(trans_to:getDisplayName(), playerObj, onTransferToContainer, trans_to, items)
        end
    end

 end


Events.OnFillInventoryObjectContextMenu.Add(doExtraInventoryMenu)