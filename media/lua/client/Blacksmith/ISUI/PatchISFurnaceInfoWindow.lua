require 'Blacksmith/ISUI/ISFurnaceInfoWindow'

-- fix missing translation for setName --

function ISFurnaceInfoWindow:setObject(object)
	self.object = object
	self.panel:setName(getText("ContextMenu_STONE_FURNACE"))
	self.panel:setTexture(object:getTextureName())
	self.fuel = object:getFuelAmount()
    self.fireStartedBool = object:isFireStarted();
    if self.fireStartedBool then
        self.fireStarted = getText("UI_Yes");
    else
        self.fireStarted = getText("UI_No");
    end
    self.heat = object:getHeat();
	self.panel.description = getText("IGUI_FUEL_AMOUNT", luautils.round(self.fuel,2)) .. " <LINE> " .. getText("IGUI_FIRE_STARTED") .. ": " .. self.fireStarted .. " <LINE> " .. getText("IGUI_HEAT") .. ": " .. luautils.round(self.heat,2) .. "%";
    if self.heat < 25 then
        self.panel.description = self.panel.description .. " <LINE> " .. getText("IGUI_FURNACE_BELLOWS")
    end
end
