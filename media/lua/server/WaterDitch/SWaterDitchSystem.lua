--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

if isClient() then return end

require "Map/SGlobalObjectSystem"

SWaterDitchSystem = SGlobalObjectSystem:derive("SWaterDitchSystem")

function SWaterDitchSystem:new()
    local o = SGlobalObjectSystem.new(self, "waterditch")
    return o
end

function SWaterDitchSystem:initSystem()
    SGlobalObjectSystem.initSystem(self)

    -- Specify GlobalObjectSystem fields that should be saved.
    self.system:setModDataKeys({})
    
    -- Specify GlobalObject fields that should be saved.
    self.system:setObjectModDataKeys({'exterior', 'taintedWater', 'waterAmount', 'waterMax'})

end

function SWaterDitchSystem:newLuaObject(globalObject)
    return SWaterDitchGlobalObject:new(self, globalObject)
end

function SWaterDitchSystem:isValidIsoObject(isoObject)
    return instanceof(isoObject, "IsoThumpable") and isoObject:getName() == "Water Ditch"
end


function SWaterDitchSystem:checkWaterway(luaObject)
    local square = luaObject:getSquare()
    local ditchType = luaObject:getDitchType()
    local adjacentSquares = {}
    local ditches = {}

    if square and ditchType then
        luaObject.exterior = square:isOutside()
        if ditchType == "pool" then
            adjacentSquares = {
                square:getAdjacentSquare(IsoDirections.N),
                square:getAdjacentSquare(IsoDirections.S),
                square:getAdjacentSquare(IsoDirections.W),
                square:getAdjacentSquare(IsoDirections.E),
            }
        elseif ditchType == 'WE' then
            adjacentSquares = {
                square:getAdjacentSquare(IsoDirections.W),
                square:getAdjacentSquare(IsoDirections.E),
            }
        elseif ditchType == 'NS' then
            adjacentSquares = {
                square:getAdjacentSquare(IsoDirections.N),
                square:getAdjacentSquare(IsoDirections.S),
            }
        end

        for _, sq in ipairs(adjacentSquares) do
            if sq then
                local luaDitch = self:getLuaObjectAt(sq:getX(), sq:getY(), sq:getZ())
                if luaObject:isFlowable(luaDitch) then
                    table.insert(ditches, luaDitch)
                end
            end
        end

    end
    
    if #ditches > 0 then
        local water_modifier = 0
        for _, rel_ditch in ipairs(ditches) do
            if luaObject.waterAmount > rel_ditch.waterAmount and rel_ditch.waterAmount < rel_ditch.waterMax then
                if luaObject:isWaterToFlow() then
                    water_modifier = math.max(- 1 * ISWaterDitch.waterScale, rel_ditch.waterAmount - luaObject.waterAmount)
                end
            elseif luaObject.waterAmount < rel_ditch.waterAmount and luaObject.waterAmount < luaObject.waterMax then
                if rel_ditch:isWaterToFlow() then
                    water_modifier = math.min(1 * ISWaterDitch.waterScale, rel_ditch.waterAmount - luaObject.waterAmount)
                end
            end
        end
        return water_modifier
    end

    return 0
end


function SWaterDitchSystem:checkRiver(luaObject)
    if luaObject.waterAmount < luaObject.waterMax then
        local square = luaObject:getSquare()
        local count_rivier = 0

        if square then
            local riverSquares = RC.findSquaresRadius(square, 1, ISWaterDitch.isRiverSquare)
            count_rivier = #riverSquares
        end
        
        if luaObject:isPool() and count_rivier > 0 then
            return count_rivier * ISWaterDitch.waterScale
        end
    end
    return 0
end


function SWaterDitchSystem:checkRainOrSnow(luaObject)
    local isRainingOrSnowing = RainManager.isRaining() or getClimateManager():isSnowing()

    if isRainingOrSnowing and luaObject.waterAmount < luaObject.waterMax then
        local square = luaObject:getSquare()
        if square then
            luaObject.exterior = square:isOutside()
        end

        local waterScale = ISWaterDitch.waterScale
        if not RainManager.isRaining() and getClimateManager():isSnowing() then
            waterScale = waterScale * 0.25
        end

        if luaObject.exterior then
            return 1 * ISWaterDitch.waterScale
        end
    end
    return 0
end


function SWaterDitchSystem:checkPlant(luaObject)
    local square = luaObject:getSquare()
    if not luaObject:isPool() or not luaObject:isWaterToFlow() then
        return 0
    end

    local adjacentSquares = {
        square:getAdjacentSquare(IsoDirections.N),
        square:getAdjacentSquare(IsoDirections.S),
        square:getAdjacentSquare(IsoDirections.W),
        square:getAdjacentSquare(IsoDirections.E),
        square:getAdjacentSquare(IsoDirections.NE),
        square:getAdjacentSquare(IsoDirections.NW),
        square:getAdjacentSquare(IsoDirections.SE),
        square:getAdjacentSquare(IsoDirections.SW),
    }
    local plants = {}
    local waterConsume = 0
    for _, sq in ipairs(adjacentSquares) do
        local plan = SFarmingSystem.instance:getLuaObjectOnSquare(sq)
        if plan and plan.state ~= "plow" and plan:isAlive() then
            local waterNeed = plan.waterNeeded or 50
            if plan.waterLvl < waterNeed then
                plan.waterLvl = math.min(plan.waterLvl + 1, waterNeed)
                plan.lastWaterHour = SFarmingSystem.instance.hoursElapsed
                plan:addIcon()
		        plan:checkStat()
		        plan:saveData()
                waterConsume = waterConsume + 1
            end
        end
    end
    return - waterConsume
end


function SWaterDitchSystem:checkUpdating()
    for i=1,self:getLuaObjectCount() do
        local luaObject = self:getLuaObjectByIndex(i)
        local water_amount_modifier = self:checkRainOrSnow(luaObject)
        water_amount_modifier = water_amount_modifier + self:checkRiver(luaObject)
        water_amount_modifier = water_amount_modifier + self:checkWaterway(luaObject)
        water_amount_modifier = water_amount_modifier + self:checkPlant(luaObject)
        -- TODO: isoObject and Square is not exsits when charactor is too far.
        -- make it update data by luaObject.

        luaObject.waterAmount = math.max(0, math.min(luaObject.waterMax, luaObject.waterAmount + water_amount_modifier))
        luaObject.taintedWater = true
        local isoObject = luaObject:getIsoObject()
        if isoObject then -- object might have been destroyed
            self:noise('Water Ditch at '..luaObject.x..","..luaObject.y..","..luaObject.z..' waterAmount='..luaObject.waterAmount)
            isoObject:setTaintedWater(true)
            isoObject:setWaterAmount(luaObject.waterAmount)
            isoObject:transmitModData()
        end
        
        luaObject:changeSprite()
    end
end

SGlobalObjectSystem.RegisterSystemClass(SWaterDitchSystem)

-- -- -- -- --

local noise = function(msg)
    SWaterDitchSystem.instance:noise(msg)
end

-- every 10 minutes we check if it's raining, to fill our water ditch
local function EveryTenMinutes()
    SWaterDitchSystem.instance:checkUpdating()
end

local function OnWaterAmountChange(object, prevAmount)
    if not object then return end
    local luaObject = SWaterDitchSystem.instance:getLuaObjectAt(object:getX(), object:getY(), object:getZ())
    if luaObject then
        noise('waterAmount changed to '..object:getWaterAmount()..' tainted='..tostring(object:isTaintedWater())..' at '..luaObject.x..','..luaObject.y..','..luaObject.z)
        luaObject.waterAmount = object:getWaterAmount()
        luaObject.taintedWater = object:isTaintedWater()
        luaObject:changeSprite()
    end
end



-- every 10 minutes we check if it's raining, to fill our water ditch
Events.EveryTenMinutes.Add(EveryTenMinutes)

Events.OnWaterAmountChange.Add(OnWaterAmountChange)


