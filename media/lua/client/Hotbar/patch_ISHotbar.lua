require "Hotbar/ISHotbar"

--[[ FIX BUG: attached item's attached slot not exists in new slots.
[12-04-24 02:43:50.249] LOG  : General     , 1712861030249> -------------------------------------------------------------
attempted index: def of non-table: null.
[12-04-24 02:43:50.253] LOG  : General     , 1712861030253> -----------------------------------------
STACK TRACE
-----------------------------------------
function: refresh -- file: ISHotbar.lua line # 518 | Vanilla
function: update -- file: ISHotbar.lua line # 244 | Vanilla.
[12-04-24 02:43:50.277] ERROR: General     , 1712861030277> ExceptionLogger.logException> Exception thrown java.lang.RuntimeException: attempted index: def of non-table: null at KahluaThread.tableget line:1689..
[12-04-24 02:43:50.277] ERROR: General     , 1712861030277> DebugLogStream.printException> Stack trace:.
[12-04-24 02:43:50.278] LOG  : General     , 1712861030278> -----------------------------------------
]]--


-- redo our slots when clothing has changed
function ISHotbar:refresh()
    self.needsRefresh = false

    -- the clothingUpdate is called quite often, we check if we changed any clothing to be sure we need to refresh
    -- as it can be called also when adding blood/holes..
    local refresh = false

    if not self.wornItems then
        self.wornItems = {}
        refresh = true
    elseif self:compareWornItems() then
        refresh = true
    end
    
    if not refresh then
        return
    end

    local previousSlot = self.availableSlot
    local newSlots = {}
    local newIndex = 2
    local slotIndex = #self.availableSlot + 1

    -- always have a back attachment
    local slotDef = self:getSlotDef("Back")
    newSlots[1] = {slotType = slotDef.type, name = slotDef.name, def = slotDef}
    
    self.replacements = {}
    table.wipe(self.wornItems)
    
    -- check to add new availableSlot if we have new equipped clothing that gives some
    -- we first do this so we keep our order in hotkeys (equipping new emplacement will make them goes on last position)
    for i=0, self.chr:getWornItems():size()-1 do
        local item = self.chr:getWornItems():getItemByIndex(i)
        table.insert(self.wornItems, item)
        -- Skip bags in hands
        if item and self.chr:isHandItem(item) then
            item = nil
        end
        -- item gives some attachments
        if item and item:getAttachmentsProvided() then
            for j=0, item:getAttachmentsProvided():size()-1 do
                local slotDef = self:getSlotDef(item:getAttachmentsProvided():get(j))
                if slotDef then
                    newSlots[newIndex] = {slotType = slotDef.type, name = slotDef.name, def = slotDef}
                    newIndex = newIndex + 1
                    if not self:haveThisSlot(slotDef.type) then
                        self.availableSlot[slotIndex] = {slotType = slotDef.type, name = slotDef.name, def = slotDef, texture = item:getTexture()}
                        slotIndex = slotIndex + 1
                        self:savePosition()
                    else
                        -- This sets the slot texture after loadPosition().
                        for i2,slot in pairs(self.availableSlot) do
                            if slot.slotType == slotDef.type then
                                slot.texture = item:getTexture()
                                break
                            end
                        end
                    end
                end
            end
        end
        if item and item:getAttachmentReplacement() then -- item has a replacement
            local replacementDef = self:getSlotDefReplacement(item:getAttachmentReplacement())
            if replacementDef then
                for type, model in pairs(replacementDef.replacement) do
                    self.replacements[type] = model
                end
            end
        end
    end

    -- check if we're missing slots
    if #self.availableSlot ~= #newSlots then
        local removed = 0
        if #self.availableSlot > #newSlots then
            removed = #self.availableSlot - #newSlots
        end
        for i,v in pairs(self.availableSlot) do
            if not self:haveThisSlot(v.slotType, newSlots) then
                -- remove the attached items that was in a slot we just lost
                if self.attachedItems[i] then
                    self:removeItem(self.attachedItems[i], false)
                    self.attachedItems[i] = nil
                end
                -- we gonna check if we had an item in a slot that has a bigger index and was removed to move it
                if self.attachedItems[i + removed] then
                    self.attachedItems[i] = self.attachedItems[i + removed]
                    self.attachedItems[i]:setAttachedSlot(i)
                    self.attachedItems[i + removed] = nil
                end
                self.availableSlot[i] = nil
            end
        end
        
        self:savePosition()
    end
    
    newSlots = {}
    -- now we redo our correct order
    local currentIndex = 1
    for i,v in pairs(self.availableSlot) do
        newSlots[currentIndex] = v
        currentIndex = currentIndex + 1
    end
    
    self.availableSlot = newSlots
    
    -- FIX IS HERE
    -- item:getAttachedSlot() may not in self.availableSlot, `slot` could be nil.
    -- BUT, if multiple same item might not refresh the green dot on inventory, 
    -- until click one of it, could be backpacks not refresh. that's another story, so leave it.

    -- we re attach out items, if we added a bag for example, we need to redo the correct attachment
    for i, item in pairs(self.attachedItems) do
        local slot = self.availableSlot[item:getAttachedSlot()]  -- `slot` could be nil.
        local slotIndex = item:getAttachedSlot()

        self:removeItem(item, false) -- must removeItem after get `slot`, other wise `slot` always be nil.

        if slot then
            local slotDef = slot.def
            -- we get back what model it should be on, as it can change if we remove a replacement (have a bag + something on your back, remove bag, we need to get the original attached definition)
            
            if self.chr:getInventory():contains(item) and not item:isBroken() then
                self:attachItem(item, slotDef.attachments[item:getAttachmentType()], slotIndex, self:getSlotDef(slot.slotType), false)
            end
        end
    end
    
    local width = #self.availableSlot * self.slotWidth
    width = width + (#self.availableSlot - 1) * 2
    self:setWidth(width + 10)

    self:reloadIcons()
end