
local Cigar = {}

Cigar.onSmokeCigarettesPack = function(playerObj, cigarettes_pack)
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, cigarettes_pack)
    ISTimedActionQueue.add(ISSmokeCigarettesPackAction:new(playerObj, cigarettes_pack))
end


Cigar.onRefillCigarettesPack = function(playerObj, cigarettes_pack, cigarettes)
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, cigarettes_pack)
    ISTimedActionQueue.add(ISRefillCigarettesPackAction:new(playerObj, cigarettes_pack, cigarettes))
end


Cigar.onFillInventoryObjectContextMenu(player, context, items)
    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()
    local items = ISInventoryPane.getActualItems(items)

    -- Smoke
    local cigarettes_pack = nil
    for _, item in ipairs(items) do
        if instanceof(item, "Drainable") and item:getFullType() == 'Base.CigarettesPack' then
            cigarettes_pack = item
        end
	end

    if cigarettes_pack then
        context:addOptionOnTop(getText("ContextMenu_Smoke_CigarettesPack"), 
                                       playerObj, Cigar.onSmokeCigarettesPack, cigarettes_pack)
    end

    -- Refill
    local refill_cigarettes_pack = nil
    for _, item in ipairs(items) do
        if instanceof(item, "Drainable") and item:getFullType() == 'Base.CigarettesPack' and item:getUsedDelta() < 1.0 then
            refill_cigarettes_pack = item
            break
        end
	end
    
    if refill_cigarettes_pack then
        local cigarettes = playerInv:getAllType("Base.Cigarettes")
        if cigarettes:size() > 0 then
            context:addOption(getText("ContextMenu_Refill_CigarettesPack"), 
                                      playerObj, Cigar.onRefillCigarettesPack, refill_cigarettes_pack, cigarettes)
        end
    end
end


Events.OnFillInventoryObjectContextMenu.Add(Cigar.onFillInventoryObjectContextMenu)