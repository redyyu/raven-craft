
local containerTiles = {
    -- Red Mobile Tool Cabinet
    ['location_business_machinery_01_32'] = '40',
    ['location_business_machinery_01_33'] = '40',
    ['location_business_machinery_01_34'] = '40',
    ['location_business_machinery_01_35'] = '40',

    -- sliver trash bin
    ['trashcontainers_01_16'] = '15',

    -- big green trash bin
    ['trashcontainers_01_17'] = '20',

    -- gray trash bin
    ['trashcontainers_01_18'] = '15',
    ['trashcontainers_01_19'] = '15',

    -- park trash bin
    ['trashcontainers_01_21'] = '15',
}

setContainerTiles = function(manager)
    -- only effect when the tile has been discovered. not work for the others already discovered on map.
    for k, v in pairs(containerTiles) do
        local props = manager:getSprite(k):getProperties()
        props:Set('ContainerCapacity', v)
        -- local names = props:getPropertyNames()
        -- print('------------------------PropertyNames----------------------------->>>')
        -- for i=0, names:size() - 1 do
        --     print(props:Val(names:get(i)))
        -- end
    end

end

Events.OnLoadedTileDefinitions.Add(setContainerTiles)