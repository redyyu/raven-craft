
containerTiles = {
    -- Red Mobile Tool Cabinet
    ['location_business_machinery_01_32'] = {
        ContainerCapacity = '40',
    },
    ['location_business_machinery_01_33'] = {
        ContainerCapacity = '40',
    },
    ['location_business_machinery_01_34'] = {
        ContainerCapacity = '40',
    },
    ['location_business_machinery_01_35'] = {
        ContainerCapacity = '40',
    },

    -- sliver trash bin
    ['trashcontainers_01_16'] = {
        ContainerCapacity = '15',
    },

    -- big green trash bin
    ['trashcontainers_01_17'] = {
        ContainerCapacity = '20',
    },

    -- gray trash bin
    ['trashcontainers_01_18'] = {
        ContainerCapacity = '15',
    },
    ['trashcontainers_01_19'] = {
        ContainerCapacity = '15',
    },

    -- Fossoil Garbage
    ['location_shop_fossoil_01_32'] = {
        ContainerCapacity = '15',
    },
    ['location_shop_fossoil_01_33'] = {
        ContainerCapacity = '15',
    },

    -- park trash bin
    ['trashcontainers_01_21'] = {
        ContainerCapacity = '15',
    },

    -- Unable to change FreezerCapacity, it is keep failback to 20 as default.
    -- Build-in Trailer Fridge
    -- ['location_trailer_02_10'] = {
    --     ContainerCapacity = '25',
    --     FreezerCapacity = '25'
    -- },
    -- ['location_trailer_02_11'] = {
    --     ContainerCapacity = '25',
    --     FreezerCapacity = '25'
    -- },
    -- ['location_trailer_02_16'] = {
    --     ContainerCapacity = '25',
    --     FreezerCapacity = '25'
    -- },
    -- ['location_trailer_02_17'] = {
    --     ContainerCapacity = '25',
    --     FreezerCapacity = '25'
    -- },
}

local Tilmgr = {}

Tilmgr.onLoadedTileDefinitions = function(manager)
    -- only effect when the tile has been discovered. not work for the others already discovered on map.
    for k, v in pairs(containerTiles) do
        local props = manager:getSprite(k):getProperties()
        for key, val in pairs(v) do
            props:Set(key, val)
        end
        -- local names = props:getPropertyNames()
        -- print('------------------------PropertyNames----------------------------->>>')
        -- for i=0, names:size() - 1 do
        --     print(names:get(i), props:Val(names:get(i)))
        -- end
    end

end

Events.OnLoadedTileDefinitions.Add(Tilmgr.onLoadedTileDefinitions)