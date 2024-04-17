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
    local flow_pos = luaObject:getWaterFlowPos()
    local ditches = {}

    for _, pos in ipairs(flow_pos) do
        if pos then
            local luaDitch = self:getLuaObjectAt(pos.x, pos.y, pos.z)
            if luaObject:isFlowable(luaDitch) then
                table.insert(ditches, luaDitch)
            end
        end
    end

    if #ditches > 0 then
        local water_modifier = 0
        for _, rel_ditch in ipairs(ditches) do
            if luaObject.waterAmount > rel_ditch.waterAmount and rel_ditch.waterAmount < rel_ditch.waterMax then
                if luaObject:haveWaterToFlow() then
                    water_modifier = math.max(- 1 * ISWaterDitch.waterFlowScale, rel_ditch.waterAmount - luaObject.waterAmount)
                end
            elseif luaObject.waterAmount < rel_ditch.waterAmount and luaObject.waterAmount < luaObject.waterMax then
                if rel_ditch:haveWaterToFlow() then
                    water_modifier = math.min(1 * ISWaterDitch.waterFlowScale, rel_ditch.waterAmount - luaObject.waterAmount)
                end
            end
        end
        print("===================== Water Way =======================")
        print(water_modifier, '  ', #ditches)
        return water_modifier
    end

    return 0
end


function SWaterDitchSystem:checkRiver(luaObject)
    if not luaObject.riverCount then
        return 0
    end
    if luaObject.waterAmount < luaObject.waterMax and luaObject.riverCount > 0 then
        return luaObject.riverCount * ISWaterDitch.waterFlowScale
    end
    return 0
end


function SWaterDitchSystem:checkRainOrSnow(luaObject)
    if not luaObject.exterior then return end

    local isRainingOrSnowing = RainManager.isRaining() or getClimateManager():isSnowing()

    if isRainingOrSnowing and luaObject.waterAmount < luaObject.waterMax then
        local waterScale = ISWaterDitch.waterScale
        if not RainManager.isRaining() and getClimateManager():isSnowing() then
            waterScale = waterScale * 0.25
        end
        return 1 * ISWaterDitch.waterScale
    end
    return 0
end


function SWaterDitchSystem:checkPlant(luaObject)
    if not luaObject:isPool() or not luaObject:haveWaterToFlow() or not luaObject.adjacentPos then
        return 0
    end

    local plants = {}
    local waterConsume = 0
    for k, pos in pairs(luaObject.adjacentPos) do
        local plan = SFarmingSystem.instance:getLuaObjectAt(pos.x, pos.y, pos.z)
        if plan and plan.state ~= "plow" and plan:isAlive() then
            local waterNeed = plan.waterNeeded or 50
            if plan.waterLvl < waterNeed then
                plan.waterLvl = math.min(plan.waterLvl + 1, waterNeed)
                plan.lastWaterHour = SFarmingSystem.instance.hoursElapsed
                plan:addIcon()
		        plan:checkStat()
		        plan:saveData()
                waterConsume = waterConsume - 1
            end
        end
    end
    return waterConsume
end


function SWaterDitchSystem:checkUpdating()
    for i=1, self:getLuaObjectCount() do
        local luaObject = self:getLuaObjectByIndex(i)
        local square = luaObject:getSquare()
        if square then
            -- make sure it's not build roof.
            luaObject.exterior = square:isOutside()
        end
        
        local water_amount_modifier = self:checkRainOrSnow(luaObject)
        water_amount_modifier = water_amount_modifier + self:checkRiver(luaObject)
        water_amount_modifier = water_amount_modifier + self:checkWaterway(luaObject)
        water_amount_modifier = water_amount_modifier + self:checkPlant(luaObject)
        
        luaObject.waterAmount = math.max(0, math.min(luaObject.waterMax, luaObject.waterAmount + water_amount_modifier))
        luaObject.taintedWater = true
        local isoObject = luaObject:getIsoObject()
        if isoObject then -- object might have been destroyed or too faraway.
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


