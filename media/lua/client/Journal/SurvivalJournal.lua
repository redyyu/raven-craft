require "TimedActions/ISReadABook"
require "Journal/SurvivalPerks"

SurvivalJournal = {}  -- DO NOT `local`, need it somewhere else.

SurvivalJournal.canWrite = function(recipe, playerObj)
    return not playerObj:HasTrait("Illiterate")
end 


SurvivalJournal.onWrite = function(items, result, playerObj)
    local journalData = {
        ['id'] = tostring(result:getID()),
        ['pid'] = playerObj:getSteamID(),
        ['numPages'] = 0,
        ['Perks'] = {},
        ['AlreadyReadBook'] = {},
        ['KnownRecipes'] = {},
    }

    for i = 0 , playerObj:getAlreadyReadBook():size() -1 do
        table.insert(journalData['AlreadyReadBook'], playerObj:getAlreadyReadBook():get(i))
        journalData['numPages'] = journalData['numPages'] + 1
    end

    for j = 0 , playerObj:getKnownRecipes():size() -1 do
        table.insert(journalData['KnownRecipes'], playerObj:getKnownRecipes():get(j))
        journalData['numPages'] = journalData['numPages'] + 1
    end

    if isDebugEnabled() then
        RC.debugNoise({
            journalData['AlreadyReadBook'],
            journalData['KnownRecipes'],
        }, 'Write RCJournal')
        playerObj:getAlreadyReadBook():clear()
        playerObj:getKnownRecipes():clear()
    end

    local modifier = SandboxVars.RavenCraft.SurvivalJournalMultiplierModifier
    for k, v in pairs(SurvivalPerks) do
        local perks_lv = playerObj:getPerkLevel(v)
        local perks_multiplier = perks_lv * modifier
        journalData['Perks'][k] = {
            ['maxLevel'] = perks_lv,
            ['maxMultiplier'] = perks_multiplier,
        }
        journalData['numPages'] = journalData['numPages'] + perks_multiplier
        if isDebugEnabled() then
            print('Write Multiplier: '.. k ..' x'.. perks_multiplier .. ' MaxLv: '..perks_lv)
            playerObj:getXp():getMultiplierMap():remove(v)
        end
    end

    result:getModData()['RCJournal'] = journalData
    SurvivalJournal.setReaded(playerObj, journalData['id'], 0)
    
    local journal_name = getText('IGUI_SURVIVAL_JOURNAL_SOMEONE_S', playerObj:getDescriptor():getSurname())

    result:setBookName(journal_name)
    result:setName(journal_name)
    result:setCustomName(true)
    -- result:addPage(0, info) -- not working

    -- SurvivalJournal.setTooltip(result)
end


SurvivalJournal.ensureReadedTable = function(playerObj)
    if not playerObj:getModData()['RCJournal'] then
        playerObj:getModData()['RCJournal'] = {}
    elseif not playerObj:getModData()['RCJournal']['readed'] then
        playerObj:getModData()['RCJournal']['readed'] = {}
    end
end

SurvivalJournal.getReadedTable = function(playerObj)
    SurvivalJournal.ensureReadedTable(playerObj)
    return playerObj:getModData()['RCJournal']['readed']
end


SurvivalJournal.getReaded = function(playerObj, journa_id)
    SurvivalJournal.ensureReadedTable(playerObj)
    local readPages = 0
    local readed_table = playerObj:getModData()['RCJournal']['readed']
    if readed_table and journa_id then
        readPages = readed_table[journa_id] or 0
    end
    return readPages
end


SurvivalJournal.setReaded = function(playerObj, journal_id, num)
    SurvivalJournal.ensureReadedTable(playerObj)
    local readed_table = playerObj:getModData()['RCJournal']['readed']
    if readed_table and journal_id then
        playerObj:getModData()['RCJournal']['readed'][journa_id] = num
    end
    return num
end


SurvivalJournal.getDetail = function(journal)
    local info = ''

    local journalData = journal:getModData()['RCJournal']

    if journalData and journalData['numPages'] > 0 then
        local numPages = journalData['numPages'] or 0
        local readPages = SurvivalJournal.getReaded(getPlayer(), journalData['id'])
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


SurvivalJournal.onRead = function(playerObj, journal)
    if journal:getContainer() == nil then
		return
	end
    local journalData = journal:getModData()['RCJournal'] or {}
    local self_read_only = SandboxVars.RavenCraft.SurvivalJournalSelfReadOnly
    local readPages = SurvivalJournal.getReaded(playerObj, journalData['id'])

    if journalData['pid'] ~= playerObj:getSteamID() and self_read_only then
        playerObj:Say(getText("IGUI_PlayerText_DontGet"))
    else
        -- if readPages >= journalData['numPages'] then
        --     playerObj:Say(getText("IGUI_PlayerText_BookObsolete"))
        --     playerObj:Say(getText("IGUI_PlayerText_ReReadBook"))
        --     SurvivalJournal.setReaded(playerObj, journalData['id'], 0)
        -- end
        if readPages < journalData['numPages'] then
            ISInventoryPaneContextMenu.transferIfNeeded(playerObj, journal)
            -- read
            playerObj:reportEvent("EventSitOnGround")
            local readed_data = SurvivalJournal.getReadedTable(playerObj)
            ISTimedActionQueue.add(ISReadAJournal:new(playerObj, journal, journalData, readed_data))
        else
            playerObj:Say(getText("IGUI_PlayerText_BookObsolete"))
        end
    end
end



SurvivalJournal.onFillInventoryObjectContextMenu = function(playerNum, context, items)
    local playerObj = getSpecificPlayer(playerNum)

    local items = ISInventoryPane.getActualItems(items)
    local journal = nil

    for _, item in ipairs(items) do
        if item:getFullType() == RC.getPackageItemType('.SurvivalJournal') then
            journal = item
        end
    end

    if journal then
        local journalData = journal:getModData()['RCJournal']
        context:removeOptionByName(getText("ContextMenu_Read"))
        if not playerObj:HasTrait("Illiterate") and journalData and journalData['numPages'] > 0 then
            context:addOptionOnTop(getText("ContextMenu_READ_JOURNAL"), playerObj, SurvivalJournal.onRead, journal)
        end
    end
end


Events.OnFillInventoryObjectContextMenu.Add(SurvivalJournal.onFillInventoryObjectContextMenu)
