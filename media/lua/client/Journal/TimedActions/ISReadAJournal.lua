--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"
require "Journal/SurvivalPerks"

ISReadAJournal = ISBaseTimedAction:derive("ISReadAJournal");

ISReadAJournal.checkMultiplier = function(journalData)
    if journalData['Perks'] then
        for k, v in pairs(journalData['Perks']) do
            -- apply the multiplier to the skill
            local perk = SurvivalPerks[k]
            local readPercent = (self.item:getAlreadyReadPages() / self.item:getNumberOfPages()) * 100
            if readPercent > 100 then
                readPercent = 100;
            end
            -- apply the multiplier to the skill
            local multiplier = (math.floor(readPercent/10) * (v.maxMultiplier/10))
            if multiplier > self.character:getXp():getMultiplier(perk) and self.character:getPerkLevel(perk) < v.maxLevel then
                if isDebugEnabled() then
                    print('Multiplier: '..multiplier)
                    print('MaxLevel: '..v.maxLevel)
                    print('CurrentLevel: '..self.character:getPerkLevel(perk))
                    print('Boost: '.. k)
                end
                self.character:getXp():addXpMultiplier(perk, multiplier, 1, v.maxLevel);
            end
        end
    end
end


function ISReadAJournal:isValid()
    local vehicle = self.character:getVehicle()
    if vehicle and vehicle:isDriver(self.character) then
        return not vehicle:isEngineRunning() or vehicle:getSpeed2D() == 0
    end
    return self.character:getInventory():contains(self.item) and ((self.item:getNumberOfPages() > 0 and self.item:getAlreadyReadPages() <= self.item:getNumberOfPages()) or self.item:getNumberOfPages() < 0);
end

function ISReadAJournal:update()
    self.pageTimer = self.pageTimer + getGameTime():getMultiplier();
    self.item:setJobDelta(self:getJobDelta());

    local journalData = self.item:getModData()['RCJournal']

    if journalData['numPages'] > 0 then
        journalData['readPages'] = math.floor(journalData['numPages'] * self:getJobDelta())
        if journalData['readPages'] > journalData['numPages'] then
            journalData['readPages'] = journalData['numPages']
        end
    end

    if SkillBook[self.item:getSkillTrained()] then
        if self.character:HasTrait("Illiterate") then
            if self.pageTimer >= 200 then
                self.pageTimer = 0;
                local txtRandom = ZombRand(3);
                if txtRandom == 0 then
                    self.character:Say(getText("IGUI_PlayerText_DontGet"))
                elseif txtRandom == 1 then
                    self.character:Say(getText("IGUI_PlayerText_TooComplicated"))
                else
                    self.character:Say(getText("IGUI_PlayerText_DontUnderstand"))
                end
                if journalData['numPages'] > 0 then
                    journalData['readPages'] = 0 
                    self:forceStop()
                end
            end
        elseif journalData['readPages'] >= journalData['numPages'] then
            if self.pageTimer >= 200 then
                self.pageTimer = 0;
                local txtRandom = ZombRand(2);
                if txtRandom == 0 then
                    self.character:Say(getText("IGUI_PlayerText_KnowSkill"))
                else
                    self.character:Say(getText("IGUI_PlayerText_BookObsolete"))
                end
            end
        else
            ISReadAJournal.checkMultiplier(journalData);
        end
    end

    -- Playing with longer day length reduces the effectiveness of morale-boosting
    -- literature, like Comic Book.
    local bodyDamage = self.character:getBodyDamage()
    local stats = self.character:getStats()
    if self.stats and (self.item:getBoredomChange() < 0.0) then
        if bodyDamage:getBoredomLevel() > self.stats.boredom then
            bodyDamage:setBoredomLevel(self.stats.boredom)
        end
    end
    if self.stats and (self.item:getUnhappyChange() < 0.0) then
        if bodyDamage:getUnhappynessLevel() > self.stats.unhappyness then
            bodyDamage:setUnhappynessLevel(self.stats.unhappyness)
        end
    end
    if self.stats and (self.item:getStressChange() < 0.0) then
        if stats:getStress() > self.stats.stress then
            stats:setStress(self.stats.stress)
        end
    end
end


function ISReadAJournal:start()
    if self.startPage then
        self:setCurrentTime(self.maxTime * (self.startPage / self.item:getNumberOfPages()))
    end
    
    self.item:setJobType(getText("ContextMenu_Read") ..' '.. self.item:getName());
    self.item:setJobDelta(0.0);
    self:setAnimVariable("ReadType", "book")

    self:setActionAnim(CharacterActionAnims.Read)
    self:setOverrideHandModels(nil, self.item)
    self.character:setReading(true)
    
    self.character:reportEvent("EventRead")

    self.stats = {}
    self.stats.boredom = self.character:getBodyDamage():getBoredomLevel()
    self.stats.unhappyness = self.character:getBodyDamage():getUnhappynessLevel()
    self.stats.stress = self.character:getStats():getStress()

    self.character:playSound("OpenBook")
end

function ISReadAJournal:stop()
    self.character:setReading(false);
    self.item:setJobDelta(0.0);
    self.character:playSound("CloseBook")
    ISBaseTimedAction.stop(self);
end

function ISReadAJournal:perform()
    self.character:setReading(false);
    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);

    local journalData = self.item:getModData()['RCJournal']

    if journalData['Perks'] then
        for k, v in pairs(journalData['Perks']) do
            -- apply the multiplier to the skill
            local perk = SurvivalPerks[k]
            if v.maxMultiplier > self.character:getXp():getMultiplier(perk) and self.character:getPerkLevel(perk) < v.maxLevel then
                if isDebugEnabled() then
                    print('Multiplier: '..v.maxMultiplier)
                    print('MaxLevel: '..v.maxLevel)
                    print('CurrentLevel: '..self.character:getPerkLevel(perk))
                    print('Boost: '.. k)
                end
                self.character:getXp():addXpMultiplier(perk, v.maxMultiplier, 1, v.maxLevel);
            end
        end
    end

    if journalData['AlreadyReadBook'] then
        for _, book in ipairs(journalData['AlreadyReadBook']) do
            if not self.character:getAlreadyReadBook():contains(book) then
                if isDebugEnabled() then
                    print('Add Read Book: '.. book)
                end
                self.character:getAlreadyReadBook():add(book)
                -- self.character:ReadLiterature(book) -- is for magazine, and book must be object not str.
            end
        end
    end
    
    if journalData['KnownRecipes'] then
        for _, recipe in ipairs(journalData['KnownRecipes']) do
            if not self.character:isRecipeKnown(recipe) then
                if isDebugEnabled() then
                    print('Add Recipe: '.. recipe)
                end
                self.character:getKnownRecipes():add(recipe)
            end
        end
    end

    self.character:playSound("CloseBook")
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISReadAJournal:animEvent(event, parameter)
    if event == "PageFlip" then
        if getGameSpeed() ~= 1 then
            return
        end
        self.character:playSound("PageFlipBook")
    end
end

function ISReadAJournal:new(character, item)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.item = item
    o.stopOnWalk = true
    o.stopOnRun = true
    o.minutesPerPage = 2.0

    local journalData = item:getModData()
    local f = 1 / getGameTime():getMinutesPerDay() / 2
    local time = journalData['numPages'] * o.minutesPerPage / f

    if(character:HasTrait("FastReader")) then
        time = time * 0.7;
    end
    if(character:HasTrait("SlowReader")) then
        time = time * 1.3;
    end

    o.ignoreHandsWounds = true;
    o.maxTime = time;
    o.caloriesModifier = 0.5;
    o.pageTimer = 0;
    o.forceProgressBar = true;
    if character:isTimedActionInstant() then
        o.maxTime = 1;
    end

    return o;
end
