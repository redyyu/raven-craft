require "BuildingObjects/ISMoveableCursor.lua"

local oldIsValid = ISMoveableCursor.isValid

function ISMoveableCursor:isValid(_square)
    local is_valid = oldIsValid(self, _square)
    if _square:isSolid() or _square:isSolidTrans() then
        local has_stackable = false
        for i=0, _square:getSpecialObjects():size()-1 do
            local obj = _square:getSpecialObjects():get(i)
            local spr = obj:getSprite()
            if spr and spr:getProperties() and spr:getProperties():Is("IsStackable") then
                has_stackable = true
            end
        end

        if not has_stackable then
            self.colorMod = ISMoveableCursor.invalidColor
            return false
        end
    end

    return is_valid
end