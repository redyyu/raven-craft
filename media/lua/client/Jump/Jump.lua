
Jump = {}
Jump.minZ = 0
Jump.distanceBase = 1
Jump.enduranceLevelThreshold = 2
Jump.heavyloadLevelThreshold = 2
Jump.inhibit = false
Jump.key = 'Crouch'


Jump.getJumpDistance = function(playerObj)
    if playerObj:getMoodles():getMoodleLevel(MoodleType.Endurance) > Jump.enduranceLevelThreshold or
       playerObj:getMoodles():getMoodleLevel(MoodleType.HeavyLoad) > Jump.heavyloadLevelThreshold then
        return nil
    end
    
    local modifier = playerObj:getPerkLevel(Perks.Fitness)
    if playerObj:isRunning() then
        modifier = (modifier + playerObj:getPerkLevel(Perks.Sprinting)) / 2
    elseif playerObj:isSprinting() then
        modifier = modifier + playerObj:getPerkLevel(Perks.Sprinting)
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
    local body_damage = playerObj isoPlayer:getBodyDamage()
    if body_damage then
        for _, bp_type in ipairs(Jump.RelatedBodyPart) do
            local body_part = body_damage:getBodyPart(bp_type)
            if body_part:getFractureTime() > 0.0F or 
               body_part:isDeepWounded() or 
               bP:getStiffness() >= 50.0 then
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
    if destSquare == horz_next_square and not direction.horzBlocked then
        return horz_next_square
    end
    
    local vert_next_square = currSquare:getAdjacentSquare(direction.vertical)
    if not direction.vertBlocked then
        direction.vertBlocked = Jump.isBlocked(currSquare, vert_next_square)
    end
    if destSquare == vert_next_square and not direction.vertBlocked then
        return vert_next_square
    end

    local next_square = nil
    if horz_next_square then
        next_square = horz_next_square:getAdjacentSquare(direction.vertical)
        if not direction.horzBlocked then
            direction.horzBlocked = Jump.isBlocked(horz_next_square, next_square)
        end
    elseif vert_next_square then
        next_square = vert_next_square:getAdjacentSquare(direction.horizontal)
        if not direction.vertBlocked then
            direction.vertBlocked = Jump.isBlocked(vert_next_square, next_square)
        end
    end
    
    if not next_square or (direction.horzBlocked and direction.vertBlocked) then
        return currSquare
    elseif next_square == destSquare and not (direction.vertBlocked or direction.horzBlocked) then
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

    local curr_square = playerObj:getCurrentSquare()
    
    if not curr_square then
        return nil
    end

    local direction = {
        horzBlocked = false,
        vertBlocked = false,
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

    local to_square = nil
    local z = playerObj:getZ()
    while z >= Jump.minZ and to_square == nil do
        dest_square = getCell():getGridSquare(targetX, targetY, z)
        to_square = Jump.getNextSquareRecurse(currSquare, dest_square, direction)
        if to_square then
            z = Jump.minZ - 1
        else
            z = z - 1
        end
    end

    return to_square
end


function Jump.onPlayerUpdate(playerObj)
    if not playerObj or
       not playerObj:getSquare() or 
       playerObj:getSquare():HasStairs() or -- diffclut Z with stairs.
       playerObj:getVehicle() then
        -- refused is not vaild scenes.
        return
    end
    
    if playerObj:isCurrentState(IdleState.instance()) then
        if not Jump.inhibit then
            Jump.inhibit = true
        end
    else
        Jump.inhibit = false
    end
    
    printDebug({"Jump.inhibit:", Jump.inhibit, playerObj:isCurrentState(IdleState.instance())})
    if Jump.inhibit then
        printDebug({
            "Running / Sprinting: "..tostring(playerObj:isRunning())..'/'..tostring(playerObj:isSprinting()),
            "isKeyPressed:", isKeyPressed(getCore():getKey(Jump.key))
        })
        --when pressing interaction key while running or sprinting
        if (playerObj:isRunning() or playerObj:isSprinting()) and
           isKeyPressed(getCore():getKey(Jump.key)) and
           not playerObj:hasTimedActions() and 
           not Jump.isBodyDamaged(playerObj) then

            local distance = Jump.getJumpDistance(playerObj)
            printDebug(distance, 'Distance')
            if distance ~= nil then
                -- Credit: Tchernobill
                local orient_angle = playerObj:getAnimAngleRadians() 
                --0 = East, PI/2 = South, -PI/2=North, PI=West
                local dest_x = math.cos(orient_angle) * distance
                local dest_y = math.sin(orient_angle) * distance
                local dest_square = Jump.getDestSquare(playerObj, dest_x, dest_y)
                printDebug(distance, 'Dest Square')
                if dest_square then       
                    ISTimedActionQueue.clear(playerObj)
                    ISTimedActionQueue.add(ISJumpToAction:new(playerObj, dest_square))
                end
            end
        end
    end
end

Events.OnPlayerUpdate.Add(Jump.onPlayerUpdate)
