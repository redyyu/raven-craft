require "TimedActions/ISBaseTimedAction"

ISPerfumeAction = ISBaseTimedAction:derive("ISPerfumeAction")


function ISPerfumeAction:isValid()
    return self.item and self.item:getUsedDelta() > 0.0
end

function ISPerfumeAction:update()
    self.item:setJobDelta(self:getJobDelta())
end


function ISPerfumeAction:start()
	self:setActionAnim(CharacterActionAnims.Drink)
    self:setOverrideHandModels(self.item, nil)
end

function ISPerfumeAction:stop()
    self.item:setJobDelta(0.0)
    ISBaseTimedAction.stop(self)
end


function ISPerfumeAction:perform()
    local body_damage = self.character:getBodyDamage()
    local body_stats = self.character:getStats()
    local survived_days = GameTime:getInstance():getNightsSurvived()
    local last_perfume_day = self.character:getModData().lastPerfumeDay or -1  -- frist survived_days is 0.
    local days = survived_days - last_perfume_day
    
    RC.debugNoise({
        'Survived Days: '..survived_days,
        'Last Perfume Day: '..last_perfume_day,
    }, '"Perfume')

    days = 5
    if days >= 1 then
        RC.debugNoise({
            'Unhappy Before: '..body_damage:getUnhappynessLevel(),
            'Boredom Before: '..body_damage:getBoredomLevel(),
            'Stress Before: '..body_stats:getStress(),
        }, '"Perfume')

        local unhappy_level = math.max(body_damage:getUnhappynessLevel() - self.effective / 2, 0)
        body_damage:setUnhappynessLevel(unhappy_level)

        local boredom_level = math.max(body_damage:getBoredomLevel() - self.effective, 0)
        body_damage:setBoredomLevel(boredom_level)

        local unhappy_level = math.max(body_damage:getUnhappynessLevel() - self.effective / 2, 0)
        body_damage:setUnhappynessLevel(unhappy_level)

        local stress = math.max(body_stats:getStress() - self.effective / 100, 0)
        body_stats:setStress(stress)

        self.character:getModData().lastPerfumeDay = survived_days

        RC.debugNoise({
            'Unhappy After: '..body_damage:getUnhappynessLevel(),
            'Boredom After: '..body_damage:getBoredomLevel(),
            'Stress After: '..body_stats:getStress(),
        }, '"Perfume')
    end

    self.item:Use()
	self.item:setJobDelta(0.0)

    ISBaseTimedAction.perform(self) 
end


function ISPerfumeAction:new(character, perfume, effective)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.maxTime = 50
    o.stopOnWalk = false
    o.stopOnRun = false
	o.item = perfume
    o.effective = effective or 15
    -- lower effective if character is dirty.
    o.effective = math.max(o.effective - ISWashYourself.GetRequiredWater(character), 1)
    return o
end
