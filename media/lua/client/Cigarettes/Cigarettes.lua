
local function onSmokeCigarettesPack(playerObj, cigarettes_pack)
    local cigarettes = InventoryItemFactory.CreateItem("Base.Cigarettes")
    playerObj:getInventory():AddItem(cigarettes)
    ISInventoryPaneContextMenu.eatItem(cigarettes, 1, playerObj:getPlayerNum())
    cigarettes_pack:Use()
end


local function doCigarettesPackMenu(player, context, items)
    local playerObj = getSpecificPlayer(player)

    local items = ISInventoryPane.getActualItems(items)
    local cigarettes_pack = nil

    for _, item in ipairs(items) do
        if instanceof(item, "Drainable") and item:getFullType() == 'Base.CigarettesPack' then
            cigarettes_pack = item
        end
	end

    if cigarettes_pack then
        context:addOption(getText("ContextMenu_Smoke"), playerObj, onSmokeCigarettesPack, cigarettes_pack)
    end
end


local function onRefillCigarettesPack(playerObj, cigarettes_pack, cigarettes)
    local playerInv = playerObj:getInventory()
    local refill_count = (1.0 - cigarettes_pack:getUsedDelta()) / cigarettes_pack:getUseDelta()
    if refill_count > cigarettes:size() then
        refill_count = cigarettes:size()
    end
    for i=0, refill_count -1 do
        playerInv:Remove(cigarettes:get(i))
    end
    local refilled_delta = math.min(refill_count * cigarettes_pack:getUseDelta(), 1.0)
    cigarettes_pack:setUsedDelta(cigarettes_pack:getUsedDelta() + refilled_delta)
end


local function doRefillCigarettesPackMenu(player, context, items)
    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()

    local items = ISInventoryPane.getActualItems(items)
    local cigarettes_pack = nil

    for _, item in ipairs(items) do
        if instanceof(item, "Drainable") and item:getFullType() == 'Base.CigarettesPack' then
            cigarettes_pack = item
            break
        end
	end
    local cigarettes = playerInv:getAllType("Base.Cigarettes")
    if cigarettes_pack and cigarettes:size() > 0 then
        option = context:addOption(getText("ContextMenu_Refill_CigarettesPack"), playerObj, onRefillCigarettesPack, cigarettes_pack, cigarettes)
    end
 end


Events.OnFillInventoryObjectContextMenu.Add(doRefillCigarettesPackMenu)
Events.OnFillInventoryObjectContextMenu.Add(doCigarettesPackMenu)