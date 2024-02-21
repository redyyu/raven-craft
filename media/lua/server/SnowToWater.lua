if isClient() then return end

require "MetalDrum/SMetalDrumGlobalObject.lua"
require "RainBarrel/SRainBarrelSystem.lua"


local EXCHANGE_RATE = 0.25;


-- Gather Snow for Metal Drum

function SMetalDrumGlobalObject:update()
    local isSnowing = getClimateManager():isSnowing();

    if RainManager.isRaining() or isSnowing then
        self.waterMax = self.waterMax or ISMetalDrum.waterMax
        if self.waterAmount < self.waterMax then
            local square = self:getSquare()
            if square then self.exterior = square:isOutside() end
            if self.exterior then
                if not self.haveLogs and not self.haveCharcoal then
                    if isSnowing then 
                        self.waterAmount = math.min(self.waterMax, self.waterAmount + (ISMetalDrum.waterScale * EXCHANGE_RATE))
                    else
                       self.waterAmount = math.min(self.waterMax, self.waterAmount + 1 * ISMetalDrum.waterScale)
                    end
                    self.taintedWater = true
                    local isoObject = self:getIsoObject()
                    if isoObject then -- object might have been destroyed
                        self:noise('added rain to barrel at '..self.x..","..self.y..","..self.z..' waterAmount='..self.waterAmount)
                        isoObject:setTaintedWater(true)
                        isoObject:setWaterAmount(self.waterAmount)
                        isoObject:transmitModData()
                    end
                end
            end
        end
    end

    if self.haveLogs and self.isLit then
        if not self.charcoalTick then
            self.charcoalTick = 1
        else
            self.charcoalTick = self.charcoalTick + 1
        end
        self:noise('charcoal update ' .. self.charcoalTick)
        if self.charcoalTick == 12 then
            self.haveLogs = false
            self.isLit = false
            self.haveCharcoal = true
            self.charcoalTick = nil
            if self.LightSource then
                -- FIXME: won't be synced in multiplayer
                getCell():removeLamppost(self.LightSource)
            end
        end
        self:changeSprite()
        self:setModData()
    end
end


-- Gather the Snow for RainBarrel

function SRainBarrelSystem:checkSnow()
	if not getClimateManager():isSnowing() then return end
	for i=1,self:getLuaObjectCount() do
		local luaObject = self:getLuaObjectByIndex(i)
		if luaObject.waterAmount < luaObject.waterMax then
			local square = luaObject:getSquare()
			if square then
				luaObject.exterior = square:isOutside()
			end
			if luaObject.exterior then
				luaObject.waterAmount = math.min(luaObject.waterMax, luaObject.waterAmount + (RainCollectorBarrel.waterScale * EXCHANGE_RATE))
                -- snow water is precent of what should be with rain
				luaObject.taintedWater = true
				local isoObject = luaObject:getIsoObject()
				if isoObject then -- object might have been destroyed
					self:noise('added Snow to barrel at '..luaObject.x..","..luaObject.y..","..luaObject.z..' waterAmount='..luaObject.waterAmount)
					isoObject:setTaintedWater(true)
					isoObject:setWaterAmount(luaObject.waterAmount)
					isoObject:transmitModData()
				end
			end
		end
	end
end

-- every 10 minutes we check if it's raining, to fill our water barrel
local function EveryTenMinutesForSnow()
	SRainBarrelSystem.instance:checkSnow()
	-- SRainBarrelSystem.instance:checkRain()  comment it out otherwise might cast twice.
end

-- every 10 minutes we check if it's raining, to fill our water barrel
Events.EveryTenMinutes.Add(EveryTenMinutesForSnow)