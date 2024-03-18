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

    ISBaseTimedAction.perform(self) 
    -- `perform` must before the `eatItem`, because in `ISEatFoodAction` have `isValidStart()`
    -- it will check MoodleLevel of Eaten, when character is too full, will stop the queue,
    -- but `isValidStart()` only trigger when a queue action onComplete, it's not trigger by first action.
    --[[ ** in `ISEatFoodAction` **
        function ISEatFoodAction:isValidStart()
	        return self.character:getMoodles():getMoodleLevel(MoodleType.FoodEaten) < 3 or self.character:getNutrition():getCalories() < 1000
        end
    ]]--
    --[[ ** in `ISTimedActionQueue` **
        function ISTimedActionQueue:onCompleted(action)
            self:removeFromQueue(action)

            self.current = self.queue[1]

            if self.current then
                if self.current:isValidStart() then
                    self.current:begin()
                else
                    print('bugged action, cleared queue ', self.current.Type or "???")
                    self:resetQueue()
                    return
                end
            end
        end
    ]]--

    if RC.isRequireInHandOrInventory(self.character, self.cigarettes_pack) then
        -- NO NEED this, `perform` before add new action to queue by `eatItem` is good enough.
        -- ISTimedActionQueue:resetQueue()
        ISInventoryPaneContextMenu.eatItem(cigarettes, 1, self.character:getPlayerNum())
    end
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
