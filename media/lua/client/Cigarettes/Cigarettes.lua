
local function onSmokeCigarettesPack(playerObj, cigarettes_pack)
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, cigarettes_pack)
    ISTimedActionQueue.add(ISSmokeCigarettesPackAction:new(playerObj, cigarettes_pack))
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
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, cigarettes_pack)
    ISTimedActionQueue.add(ISRefillCigarettesPackAction:new(playerObj, cigarettes_pack, cigarettes))
end


local function doRefillCigarettesPackMenu(player, context, items)
    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()

    local items = ISInventoryPane.getActualItems(items)
    local cigarettes_pack = nil

    for _, item in ipairs(items) do
        if instanceof(item, "Drainable") and item:getFullType() == 'Base.CigarettesPack' and item:getUsedDelta() < 1.0 then
            cigarettes_pack = item
            break
        end
	end
    if cigarettes_pack then
        local cigarettes = playerInv:getAllType("Base.Cigarettes")
        if cigarettes:size() > 0 then
            option = context:addOption(getText("ContextMenu_Refill_CigarettesPack"), playerObj, onRefillCigarettesPack, cigarettes_pack, cigarettes)
        end
    end
 end


Events.OnFillInventoryObjectContextMenu.Add(doRefillCigarettesPackMenu)
Events.OnFillInventoryObjectContextMenu.Add(doCigarettesPackMenu)