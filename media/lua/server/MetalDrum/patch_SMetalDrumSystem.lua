
if isClient() then return end


require "MetalDrum/SMetalDrumSystem.lua" -- for ISMetalDrum{}


local function getMetalDrumAt(x, y, z)
    return SMetalDrumSystem.instance:getLuaObjectAt(x, y, z)
end


function SMetalDrumSystem:OnClientCommand(command, player, args)
    local drum = getMetalDrumAt(args.x, args.y, args.z)
    if not drum then
        noise('no metaldrum found at '..args.x..','..args.y..','..args.z)
        return
    end
    if command == "addLogs" then
        for i=1, 3 do
            player:sendObjectChange('removeOneOf', { type = 'Log' })
        end
        drum:setHaveLogs(true)
        return
    end
    if command == "removeLogs" then
        player:sendObjectChange('addItemOfType', { type = 'Base.Log', count = 3 })
        drum:setHaveLogs(false)
        return
    end
    if command == "lightFire" then
        if not drum.isLit and drum.haveLogs then
            drum:setLit(true)
        end
        return
    end
    if command == "putOutFire" then
        if drum.isLit then
            drum:setLit(false)
        end
        return
    end
    if command == "removeCharcoal" then
        if drum.haveCharcoal then
            drum:setHaveCharcoal(false)
            player:sendObjectChange('addItemOfType', { type = 'Base.Charcoal', count = 3 })
        end
        return
    end
    if command == "removeWater" then
        if drum.waterAmount > 0 then
            drum.waterAmount = 0
            drum:getIsoObject():setWaterAmount(0)
            drum:getIsoObject():transmitModData()
        end
        return
    end
end

