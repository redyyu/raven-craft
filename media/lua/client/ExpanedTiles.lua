
local containerTiles = {
	-- Red Mobile Tool Cabinet
	'location_business_machinery_01_32',
	'location_business_machinery_01_33',
	'location_business_machinery_01_34',
	'location_business_machinery_01_35',
}

setContainerTiles = function(manager)
	local IsoFlagType, ipairs = IsoFlagType, ipairs

	-- only effect when the tile has been discovered. not work for the others already discovered on map.
	for _, name in ipairs(containerTiles) do
		local props = manager:getSprite(name):getProperties()
		props:Set('ContainerCapacity', '40')
		-- local names = props:getPropertyNames()
		-- print('------------------------PropertyNames----------------------------->>>')
		-- for i=0, names:size() - 1 do
		-- 	print(props:Val(names:get(i)))
		-- end
	end

end

Events.OnLoadedTileDefinitions.Add(setContainerTiles)