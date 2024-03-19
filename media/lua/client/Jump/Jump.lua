
Jump = {}
Jump.minZ = 0
Jump.distanceBase = 1.5
Jump.enduranceLevelThreshold = 2
Jump.heavyloadLevelThreshold = 2
Jump.inhibit = false
Jump.key = 'Shout'


Jump.getJumpDistance = function(playerObj)
    if playerObj:getMoodles():getMoodleLevel(MoodleType.Endurance) > Jump.enduranceLevelThreshold or
       playerObj:getMoodles():getMoodleLevel(MoodleType.HeavyLoad) > Jump.heavyloadLevelThreshold then
        return nil
    end
    
    local modifier = playerObj:getPerkLevel(Perks.Fitness)
    if playerObj:isRunning() then
        modifier = (modifier + playerObj:getPerkLevel(Perks.Sprinting)) / 2
    elseif playerObj:isSprinting() then
        modifier = (modifier + playerObj:getPerkLevel(Perks.Sprinting)) * 2
    else
        modifier = 0
    end

    local endurance = playerObj:getStats():getEndurance()
    local distance =  (Jump.distanceBase + modifier / 10) * endurance

    if playerObj:getTraits():contains("Obese") then
        distance = distance * 0.5
    elseif playerObj:getTraits():contains("Overweight") then
        distance = distance * 0.75
    end

    return distance
end


Jump.isValidCoordinate = function(posX, posY, posZ)
    local z = posZ
    while z >= Jump.minZ do
        if getWorld():isValidSquare(posX, posY, z) then
            return true
        end
        z = z - 1
    end
    return false
end


Jump.RelatedBodyPart = {
    BodyPartType.Torso_Lower, BodyPartType.Groin,
    BodyPartType.UpperLeg_L, BodyPartType.UpperLeg_R,
    BodyPartType.LowerLeg_L, BodyPartType.LowerLeg_R,
    BodyPartType.Foot_L, BodyPartType.Foot_R
}

Jump.isBodyDamaged = function(playerObj)
    local body_damage = playerObj:getBodyDamage()
    if body_damage then
        for _, bp_type in ipairs(Jump.RelatedBodyPart) do
            local body_part = body_damage:getBodyPart(bp_type)
            if body_part:getFractureTime() > 0.0F or 
               body_part:isDeepWounded() or 
               body_part:getStiffness() >= 50.0 then
                return true
            end
        end
    end

    return false
end


Jump.isBlocked = function(square, toSquare)
    if square:isBlockedTo(toSquare) or 
       square:testCollideSpecialObjects(toSquare) or
       toSquare:isSolidTrans() or 
       toSquare:isSolid() then
        return true
    else
        return false
    end
end


Jump.getNextSquareRecurse = function(currSquare, destSquare, direction)
    local horz_next_square = currSquare:getAdjacentSquare(direction.horizontal)
    if not direction.horzBlocked then
        direction.horzBlocked = Jump.isBlocked(currSquare, horz_next_square)
    end
    if destSquare == horz_next_square and not (direction.horzBlocked or direction.nextHorzBlocked) then
        return horz_next_square
    end
    
    local vert_next_square = currSquare:getAdjacentSquare(direction.vertical)
    if not direction.vertBlocked then
        direction.vertBlocked = Jump.isBlocked(currSquare, vert_next_square)
    end
    if destSquare == vert_next_square and not (direction.vertBlocked or direction.nextVertBlocked) then
        return vert_next_square
    end

    local next_square = nil
    if horz_next_square then
        next_square = horz_next_square:getAdjacentSquare(direction.vertical)
        if not direction.nextHorzBlocked then
            direction.nextHorzBlocked = Jump.isBlocked(horz_next_square, next_square)
        end
    elseif vert_next_square then
        next_square = vert_next_square:getAdjacentSquare(direction.horizontal)
        if not direction.nextVertBlocked then
            direction.nextVertBlocked = Jump.isBlocked(vert_next_square, next_square)
        end
    end
    
    if not next_square or (direction.horzBlocked and direction.vertBlocked) then
        return currSquare
    elseif next_square == destSquare and 
           not (direction.vertBlocked or direction.horzBlocked or direction.nextHorzBlocked or direction.nextVertBlocked) then
        return next_square
    end

    if direction.recurse_count < direction.recurse_limit then
        direction.recurse_count = direction.recurse_count + 1
        return Jump.getNextSquareRecurse(next_square, destSquare, direction)
    else
        return nil
    end
end


Jump.getDestSquare = function(playerObj, destX, destY)
    local deltaX = destX - playerObj:getX()
    local deltaY = destY - playerObj:getY()

    local direction = {
        horzBlocked = false,
        nextHorzBlocked = false,
        vertBlocked = false,
        nextVertBlocked = false,
        recurse_limit = 10,
        recurse_count = 0,
    }
    if deltaX > 0 then
        direction.horizontal = IsoDirections.E
    else
        direction.horizontal = IsoDirections.W
    end

    if deltaY > 0 then
        direction.vertical = IsoDirections.S
    else
        direction.vertical = IsoDirections.N
    end

    local dest_square = nil
    local z = playerObj:getZ()
    while z >= Jump.minZ and dest_square == nil do
        -- to_square = getCell():getGridSquare(destX, destY, z)
        -- dest_square = Jump.getNextSquareRecurse(curr_square, to_square, direction)
        dest_square = getCell():getGridSquare(destX, destY, z)
        if dest_square then
            z = Jump.minZ - 1
        else
            z = z - 1
        end
    end

    return dest_square
end


function Jump.onPlayerUpdate(playerObj)
    if not playerObj or
       not playerObj:getSquare() or 
       playerObj:getSquare():HasStairs() or -- diffclut Z with stairs.
       playerObj:getVehicle() then
        -- refused is not vaild scenes.
        return
    end

    if not playerObj:isCurrentState(IdleState.instance()) or playerObj:isbFalling() then
        if not Jump.inhibit then
            Jump.inhibit = true
        end
    end

    if Jump.inhibit then
        return
    end

    if not (playerObj:isRunning() or playerObj:isSprinting()) then
        printDebug(not (playerObj:isRunning() or playerObj:isSprinting()))
        return
    end

    
    
    --when pressing interaction key while running or sprinting
    local joypad_id = playerObj:getJoypadBind()
    
    if (isKeyPressed(getCore():getKey(Jump.key)) or isJoypadPressed(joypad_id, Joypad.LBumper)) and
        not playerObj:hasTimedActions() and 
        not Jump.isBodyDamaged(playerObj) then
        
        local distance = Jump.getJumpDistance(playerObj)

        if distance ~= nil then
            -- Credit: Tchernobill
            local orient_angle = playerObj:getAnimAngleRadians() 
            --0 = East, PI/2 = South, -PI/2=North, PI=West
            local dest_x = playerObj:getX() + math.cos(orient_angle) * distance
            local dest_y = playerObj:getY() + math.sin(orient_angle) * distance
 
            local dest_square = Jump.getDestSquare(playerObj, dest_x, dest_y)
            
            if dest_square then
                Jump.inhibit = true
                ISTimedActionQueue.clear(playerObj)
                ISTimedActionQueue.add(ISJumpToAction:new(playerObj, dest_square))
            end
        end
    end

end

Events.OnPlayerUpdate.Add(Jump.onPlayerUpdate)


Jump.onKeyStartPressed = function(key)
    if key == getCore():getKey(Jump.key) then
        Jump.inhibit = false
    end
end

Events.OnKeyStartPressed.Add(Jump.onKeyStartPressed)