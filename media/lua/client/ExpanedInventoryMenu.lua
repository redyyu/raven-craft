
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
    local is_too_havey = true
    local inventory = container:getInventory()

    for _, item in ipairs(items) do
        if not inventory:contains(item) then
            if inventory:hasRoomFor(playerObj, item) then
                ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, item:getContainer(), inventory))
                is_too_havey = false  -- will say nothing if one of the item is good for go.
            end
        end
	end
    if is_too_havey then
        playerObj:Say(getText("IGUI_PlayerText_Too_Havey"))
    end
end


local function getEquippedContainers(playerObj)
    local playerInv = playerObj:getInventory()
    local containers = playerInv:getItemsFromCategory("Container")
    local equipped_containers = {}
    for i=0, containers:size() - 1  do
        local container = containers:get(i)
        -- bag:canBeEquipped() == 'Back', getBodyLocation() == 'Back' is for wear.
        if container:getInventory():isInCharacterInventory(playerObj) and container:isEquipped() then
            table.insert(equipped_containers, container)
        end
    end
    return equipped_containers
end


local function getCurrentInventory(items)
    for _, itm in ipairs(items) do
        if itm:getContainer() then
            return itm:getContainer()
        end
    end
    return nil
end


local function doExtraInventoryMenu(player, context, items)
    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()

    local items = ISInventoryPane.getActualItems(items)
    local currInventory = getCurrentInventory(items)

    if not currInventory then return end

    -- Transfer items between equipped containers
    if currInventory:isInCharacterInventory(playerObj) then
        local containers = playerInv:getItemsFromCategory("Container")
        local equipped_containers = getEquippedContainers(playerObj)
        local transfer_containers = {}
        if #equipped_containers > 0 then
            for _, container in ipairs(equipped_containers) do
                if not isSelectedItem(container, items) and 
                not isAnyItemInInventory(items, container:getInventory()) then
                    table.insert(transfer_containers, container)
                end
            end
        end

        if #transfer_containers > 0 then
            local transferOption = context:addOption(getText("ContextMenu_Pack_to"))
            local transferMenu = ISContextMenu:getNew(context)
            context:addSubMenu(transferOption, transferMenu)

            for _, trans_to in ipairs(transfer_containers) do
                transferMenu:addOption(trans_to:getDisplayName(), playerObj, onTransferToContainer, trans_to, items)
            end
        end
    end

    -- Transfer items to ground
    
    if currInventory:getType() ~= "floor" and playerObj:getJoypadBind() == -1 and
       not currInventory:isInCharacterInventory(playerObj) and
       not ISInventoryPaneContextMenu.isAllFav(items) and
       not ISInventoryPaneContextMenu.isAllNoDropMoveable(items) then
        context:addOption(getText("ContextMenu_Grab_to_Ground"), items, ISInventoryPaneContextMenu.onDropItems, player);
    end

 end


Events.OnFillInventoryObjectContextMenu.Add(doExtraInventoryMenu)