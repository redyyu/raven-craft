local oven_icon = getTexture("media/ui/Container_Oven.png")

local function OnRefreshInventoryWindowContainers(iSInventoryPage, state)
    if state ~= 'buttonsAdded' then return end
    for _, btn in ipairs(iSInventoryPage.backpacks) do
        local iso_object = btn.inventory:getParent()
		if iso_object and instanceof(iso_object, 'BSFurnace') then
            btn:setImage(oven_icon)
        end
	end
end

Events.OnRefreshInventoryWindowContainers.Add(OnRefreshInventoryWindowContainers)