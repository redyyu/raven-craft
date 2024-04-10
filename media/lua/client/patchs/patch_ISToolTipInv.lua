--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "ISUI/ISToolTipInv"
require "Journal/SurvivalJournal"

local old_ISToolTipInv_render = ISToolTipInv.render

function ISToolTipInv:render()
	if not self.item then return false end

	if self.item:getFullType() == RC.getPackageItemType('.SurvivalJournal') then
		SurvivalJournal.setTooltip(self.item)
	end

	old_ISToolTipInv_render(self)

end
