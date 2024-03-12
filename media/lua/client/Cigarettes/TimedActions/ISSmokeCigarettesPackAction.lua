require "TimedActions/ISBaseTimedAction"

ISSmokeCigarettesPackAction = ISBaseTimedAction:derive("ISSmokeCigarettesPackAction")


function ISSmokeCigarettesPackAction:isValid()
    return self.cigarettes_pack and self.cigarettes_pack:getUsedDelta() > 0.0
end

function ISSmokeCigarettesPackAction:update()
    self.cigarettes_pack:setJobDelta(self:getJobDelta())
end

-- function ISSmokeCigarettesPackAction:create()
--     ISBaseTimedAction.create(self)
--     self.action:setUseProgressBar(false)
-- end

function ISSmokeCigarettesPackAction:start()
	self:setActionAnim(CharacterActionAnims.InsertBullets);
end

function ISSmokeCigarettesPackAction:stop()
    self.cigarettes_pack:setJobDelta(0.0)
    ISBaseTimedAction.stop(self)
end

-- function ISSmokeCigarettesPackAction:waitToStart()
    
-- end

function ISSmokeCigarettesPackAction:perform()
	local cigarettes = InventoryItemFactory.CreateItem("Base.Cigarettes")
    self.character:getInventory():AddItem(cigarettes)
    self.cigarettes_pack:Use()
	self.cigarettes_pack:setJobDelta(0.0)

    if isRequireInHandOrInventory(self.character, self.cigarettes_pack) then
        ISInventoryPaneContextMenu.eatItem(cigarettes, 1, self.character:getPlayerNum())
    end

	ISBaseTimedAction.perform(self)
end

function ISSmokeCigarettesPackAction:new(character, cigarettes_pack)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.maxTime = 10
    o.stopOnWalk = false
    o.stopOnRun = false
	o.cigarettes_pack = cigarettes_pack
    return o
end
