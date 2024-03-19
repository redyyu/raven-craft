
Jump = {}
Jump.inhibit = false


function Jump.onPlayerUpdate(playerObj)
    if not playerObj or not playerObj:getSquare() or playerObj:getVehicle() then return end
    -- refused is not vaild scene.

    local square = playerObj:getSquare()
    
    if playerObj:isCurrentState(IdleState.instance()) then
        if not JumpI.inhibit then
            JumpI.inhibit = true
        end
    end
    
    if JumpI.inhibit or not playerObj:isRunning() and not playerObj:isSprinting() then return end--need to run or sprint
    
    --when pressing interaction key while no action active
    if isKeyPressed(getCore():getKey(JumpI.key)) and not playerObj:hasTimedActions() and not square:HasStairs() and not JumpI.isHealthInhibitingJump(playerObj) then
        local charOrientationAngle = playerObj:getAnimAngleRadians();--Hum, this is angle 0 = East, PI/2 = South, -PI/2=North, PI=West
        
        local targetDist = 1.5--todo compute distance from skills and traits
        local targetX = playerObj:getX()+ math.cos(charOrientationAngle) * targetDist
        local targetY = playerObj:getY()+ math.sin(charOrientationAngle) * targetDist
        local targetSquareValidForJump = JumpI.isValidjumpTarget(targetX,targetY,playerObj:getZ())
        if targetSquareValidForJump then
            local target = {x=targetX,y=targetY,z=playerObj:getZ()}
            if JumpI.Verbose then print('JumpI.OnPlayerUpdate targetSquareValidForJump '..sq2str(square)..' => '..tab2str(target)) end            
            JumpI.inhibit = true
            
            ISTimedActionQueue.clear(playerObj)
            ISTimedActionQueue.add(ISJumpAction:new(playerObj, target));
        end
    end
end

Events.OnPlayerUpdate.Add(Jump.onPlayerUpdate)

--target square is valid if one tile is valid at or below it
function JumpI.isValidjumpTarget(targetX, targetY, targetZ)
    local z = targetZ
    while z >= JumpI.MinZ and getCell():getGridSquare(targetX, targetY, z) == nil do
        z = z - 1
    end
    return z >= JumpI.MinZ
end

function JumpI.OnKeyStartPressed(key)
    if JumpI.Verbose then print ('JumpI.OnKeyStartPressed '..key) end
    if key == getCore():getKey(JumpI.key) then
        JumpI.inhibit = false
    end
end

Events.OnKeyStartPressed.Add(JumpI.OnKeyStartPressed)
