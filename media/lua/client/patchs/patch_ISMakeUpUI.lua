require "ISUI/ISMakeUpUI"

local oldOnApplyMakeUp = ISMakeUpUI.onApplyMakeUp

function ISMakeUpUI:onApplyMakeUp()
    -- changed makeup items to `Drainable` in items script.
    if self.item and instanceof(self.item, "Drainable") then
        oldOnApplyMakeUp(self)
        self.item:Use()
        if not self.item or self.item:getUsedDelta() < self.item:getUseDelta() then
            self:close()
        end
    end
	
end