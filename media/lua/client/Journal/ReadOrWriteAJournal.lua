require "TimedActions/ISReadABook"
require "Journal/SurvivalPerks"

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


SurvivalJournal.getDetail = function(journal)
    local info = ''

    local journalData = journal:getModData()['RCJournal']

    if journalData then
        local numPages = journalData['numPages'] or 0
        local readPages = journalData['readPages'] or 0
        local numReadBooks = journalData['AlreadyReadBook'] and #journalData['AlreadyReadBook'] or 0
        local numRecipes = journalData['KnownRecipes'] and #journalData['KnownRecipes'] or 0
        local skillPerks = journalData['Perks'] and journalData['Perks'] or {}

        info = info .. getText('IGUI_SURVIVAL_JOURNAL_PAGES', readPages..' / '..numPages) .. '\n'
        info = info .. getText('IGUI_SURVIVAL_JOURNAL_READ_BOOKS') .. numReadBooks .. '\n'
        info = info .. getText('IGUI_SURVIVAL_JOURNAL_KNOWN_RECIPES') ..numRecipes .. '\n'

        for k, v in pairs(skillPerks) do
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
    local sit_on_ground_modifier = SandboxVars.RavenCraft.ReadingOnSitEffective
    local self_read_only = SandboxVars.RavenCraft.SurvivalJournalSelfReadOnly

    if journalData['pid'] ~= player:getSteamID() and self_read_only then
        player:Say(getText("IGUI_PlayerText_DontGet"))
    else
        if journalData['readPages'] >= journalData['numPages'] then
            player:Say(getText("IGUI_PlayerText_BookObsolete"))
            player:Say(getText("IGUI_PlayerText_ReReadBook"))
            journalData['readPages'] = 0
        end
	    ISInventoryPaneContextMenu.transferIfNeeded(player, journal)
	    -- read
        
        player:reportEvent("EventSitOnGround")
	    ISTimedActionQueue.add(ISReadAJournal:new(player, journal, journalData, sit_on_ground_modifier))
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

    if journal then
        local journalData = journal:getModData()['RCJournal']
        context:removeOptionByName(getText("ContextMenu_Read"))
        if not playerObj:HasTrait("Illiterate") and journalData then
            option = context:addOptionOnTop(getText("ContextMenu_READ_JOURNAL"), playerObj, SurvivalJournal.onRead, journal)
        end
    end
end

Events.OnFillInventoryObjectContextMenu.Add(SurvivalJournal.doBuildReadMenu);

