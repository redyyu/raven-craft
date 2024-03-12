require "TimedActions/ISBaseTimedAction"

ISRefillCigarettesPackAction = ISBaseTimedAction:derive("ISRefillCigarettesPackAction")


function ISRefillCigarettesPackAction:isValid()
    return self.cigarettes_pack and self.cigarettes_pack:getUsedDelta() > 0.0
end

function ISRefillCigarettesPackAction:update()
    self.cigarettes_pack:setJobDelta(self:getJobDelta())
end

-- function ISRefillCigarettesPackAction:create()
--     ISBaseTimedAction.create(self)
--     self.action:setUseProgressBar(false)
-- end

function ISRefillCigarettesPackAction:start()
	self:setActionAnim(CharacterActionAnims.InsertBullets);
end

function ISRefillCigarettesPackAction:stop()
    self.cigarettes_pack:setJobDelta(0.0)
    ISBaseTimedAction.stop(self)
end

-- function ISRefillCigarettesPackAction:waitToStart()
    
-- end

function ISRefillCigarettesPackAction:perform()
    local refill_count = (1.0 - self.cigarettes_pack:getUsedDelta()) / self.cigarettes_pack:getUseDelta()
    if refill_count > self.cigarettes:size() then
        refill_count = self.cigarettes:size()
    end
    for i=0, refill_count -1 do
        self.character:getInventory():Remove(self.cigarettes:get(i))
    end
    local refilled_delta = math.min(refill_count * self.cigarettes_pack:getUseDelta(), 1.0)
    self.cigarettes_pack:setUsedDelta(self.cigarettes_pack:getUsedDelta() + refilled_delta)

	self.cigarettes_pack:setJobDelta(0.0)
	ISBaseTimedAction.perform(self)
end

function ISRefillCigarettesPackAction:new(character, cigarettes_pack, cigarettes)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.maxTime = 50
    o.stopOnWalk = false
    o.stopOnRun = false
	o.cigarettes_pack = cigarettes_pack
    o.cigarettes = cigarettes
    return o
end
