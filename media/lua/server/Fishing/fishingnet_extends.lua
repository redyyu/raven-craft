require "Fishing/BuildingObjects/FishingNet"

local EXTRA_FISHS = {
    ["Base.Shrimp"] = 12, 
    ["Base.Crayfish"] = 6,
    ["Base.Squid"] = 3, 
    ["Base.Lobster"] = 1,
}
local EXP_GAIN_BASE = 10

local getExpGain = function(count, modifier)
    if not modifier then
        modifier = 1
    end
    return math.floor(EXP_GAIN_BASE / modifier) * count
end


local oldCheckFishNet = fishingNet.checkTrap

fishingNet.checkTrap = function(player, trap, hours)
    local fishing_lv = player:getPerkLevel(Perks.Fishing);

    if hours > 15 and ZombRand(5) == 0 then
        return;
    end

    if hours >= 12 then
        for k, v in pairs(EXTRA_FISHS) do
            local catch_chance = ZombRand(0, fishing_lv * v)
            if RC.predicateLootChance(player, catch_chance) then
                local item_count = math.floor(ZombRand(1, v) * RC.getLootChance(player) * (fishing_lv / 10))
                if item_count then
                    player:getInventory():AddItems(k, item_count)
                    player:getXp():AddXP(Perks.Fishing, getExpGain(item_count, v))
                end
            end
        end
    end
    oldCheckFishNet(player, trap, hours)
end
