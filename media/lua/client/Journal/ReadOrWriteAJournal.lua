require "TimedActions/ISReadABook"
require "SurvivalPerks"

SurvivalJournal = {}

SurvivalJournal.canWrite = function(recipe, player)
    return not player:HasTrait("Illiterate")
end 


SurvivalJournal.onWrite = function(items, result, player)
    local baseMultiplier = SandboxVars.RavenCraft.SurvivalJournalMultiplierBase
    local journalData = {
        ['pid'] = player:getSteamID(),
        ['numPages'] = 0,
        ['readPages'] = 0,
        ['Perks'] = {},
        ['AlreadyReadBook'] = {},
        ['KnownRecipes'] = {},
    }

    for i = 0 , player:getAlreadyReadBook():size() -1 do
        table.insert(journalData['AlreadyReadBook'], player:getAlreadyReadBook():get(i))
        journalData['numPages'] = journalData['numPages'] + 1
    end

    for j = 0 , player:getKnownRecipes():size() -1 do
        table.insert(journalData['KnownRecipes'], player:getKnownRecipes():get(j))
        journalData['numPages'] = journalData['numPages'] + 1
    end

    if isDebugEnabled() then
        print('Write RCJournal ---------------->>')
        print(journalData['AlreadyReadBook'])
        print(journalData['KnownRecipes'])
        player:getAlreadyReadBook():clear()
        player:getKnownRecipes():clear()
    end

    for k, v in pairs(SurvivalPerks) do
        local perks_lv = player:getPerkLevel(v)
        local perks_multiplier = perks_lv * baseMultiplier
        journalData['Perks'][k] = {
            ['maxLevel'] = perks_lv,
            ['maxMultiplier'] = perks_multiplier,
        }
        journalData['numPages'] = journalData['numPages'] + perks_multiplier
        if isDebugEnabled() then
            print('Write Multiplier: '.. k ..' x'.. perks_multiplier .. ' MaxLv: '..perks_lv)
            player:getXp():getMultiplierMap():remove(v)
        end
    end

    result:getModData()['RCJournal'] = journalData
    
    local journal_name = getText('IGUI_SURVIVAL_JOURNAL_SOMEONE_S', player:getDescriptor():getSurname())

    result:setBookName(journal_name)
    result:setName(journal_name)
    result:setCustomName(true)
    -- result:addPage(0, info) -- not working

    -- SurvivalJournal.setTooltip(result)
    
end


SurvivalJournal.read = function(player, journal)
    if isDebugEnabled() then
        print('Read RCJournal ---------------->>')
    end

    local journalData = journal:getModData()['RCJournal']
    
    

    

    if journalData['AlreadyReadBook'] then
        for _, book in ipairs(journalData['AlreadyReadBook']) do
            if not player:getAlreadyReadBook():contains(book) then
                if isDebugEnabled() then
                    print('Add Read Book: '.. book)
                end
                player:getAlreadyReadBook():add(book)
                -- player:ReadLiterature(book) -- is for magazine, and book must be object not str.
            end
        end
    end
    
    if journalData['KnownRecipes'] then
        for _, recipe in ipairs(journalData['KnownRecipes']) do
            if not player:isRecipeKnown(recipe) then
                if isDebugEnabled() then
                    print('Add Recipe: '.. recipe)
                end
                player:getKnownRecipes():add(recipe)
            end
        end
    end

end


SurvivalJournal.getDetail = function(journal)
    local info = ''

    local journalData = journal:getModData()['RCJournal']

    if journalData then
        info = info .. getText('IGUI_SURVIVAL_JOURNAL_PAGES', journalData['numPages']..' / '..journalData['readPages']) .. '\n'
        info = info .. getText('IGUI_SURVIVAL_JOURNAL_READ_BOOKS') .. #journalData['AlreadyReadBook'] .. '\n'
        info = info .. getText('IGUI_SURVIVAL_JOURNAL_KNOWN_RECIPES') .. #journalData['KnownRecipes'] .. '\n'

        for k, v in pairs(journalData['Perks']) do
            if v.maxLevel > 0 or isDebugEnabled() then
                info = info .. getText('IGUI_perks_'..k) .. '  Lv'.. v.maxLevel .. '  (x' .. v.maxMultiplier .. ') \n'
            end
        end
    end

    return info
end

SurvivalJournal.setTooltip = function(journal)
    local info = SurvivalJournal.getDetail(journal)
    if info then
        journal:setTooltip(info)
    end
end


SurvivalJournal.onRead = function(player, journal)
    if journal:getContainer() == nil then
		return
	end
    local journalData = journal:getModData()['RCJournal']
    if journalDatap['pid'] ~= player:getSteamID() then
        player:Say(getText("IGUI_PlayerText_DontGet"))
    else
	    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, journal)
	    -- read
	    ISTimedActionQueue.add(ISReadAJournal:new(playerObj, journal))
    end
end



SurvivalJournal.doBuildReadMenu = function(player, context, items)
    local playerObj = getSpecificPlayer(player)

    local items = ISInventoryPane.getActualItems(items)
    local journal = nil

    for _, item in ipairs(items) do
        if item:getFullType() == getPackageItemType('.SurvivalJournal') then
            journal = item
        end
    end

    if journal and not character:HasTrait("Illiterate") then
        context:removeOptionByName(getText("ContextMenu_Read"))
        option = context:addOptionOnTop(getText("ContextMenu_READ_JOURNAL"), playerObj, SurvivalJournal.onRead, journal)
    end
end

Events.OnFillInventoryObjectContextMenu.Add(SurvivalJournal.doBuildReadMenu);

