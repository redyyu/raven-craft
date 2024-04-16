require "Farming/BuildingObjects/farmingPlot.lua"

local oldIsValid = farmingPlot.isValid

function farmingPlot:isValid(square)
    local is_valid = oldIsValid(self, square)
    return is_valid and not square:Is('BlocksPlacement')
end