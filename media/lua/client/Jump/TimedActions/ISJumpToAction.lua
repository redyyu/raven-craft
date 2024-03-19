require "TimedActions/ISBaseTimedAction"

ISJumpToAction = ISBaseTimedAction:derive("ISJumpToAction")


function ISJumpToAction:isValid()
    return self.anim ~= nil
end


function ISJumpToAction:animEvent(event, parameter)
    if event == 'JumpDone' then
        self:releaseAnimControl()
    elseif event == 'TouchGround' then
        self.forceZ = nil
    elseif event == 'Thump' then
       -- pass
    end
end


function ISJumpToAction:update()
    if self.forceZ then
        local deltaX = (self.destX - self.startX) * self:getJobDelta()
        local deltaY = (self.destY - self.startY) * self:getJobDelta()

        self.character:setX(self.startX + deltaX)
        self.character:setY(self.startY + deltaY)

        self.character:setLx(self.startX + deltaX)
        self.character:setLy(self.startY + deltaY)

        -- prevent falling while jumping.
        self.character:setFallTime(0)
        self.character:setbFalling(false)
        self.character:setZ(self.forceZ)
        self.character:setLz(self.forceZ)


        local currentSquare = self.character:getCurrentSquare()
        if currentSquare and currentSquare ~= self.lastKnownSquare then
            -- if not currentSquare:Is(IsoFlagType.solidfloor) then
            --     currentSquare:addFloor('');
            --     currentSquare:RecalcAllWithNeighbours(true)
            -- end
            self.lastKnownSquare = currentSquare
        end
    end
    
end


function ISJumpToAction:start()
    if self.anim then
        self:setActionAnim(self.anim)
        self.startX = self.character:getX()
        self.startY = self.character:getY()
        self.destX = self.destSquare:getX()
        self.destY = self.destSquare:getY()
        self.forceZ = self.character:getZ()
        self.character:setIgnoreMovement(true)
        self.character:setRunning(false)
        self.character:setSprinting(false)
        self.lastKnownSquare = self.character:getCurrentSquare()
    end
end


function ISJumpToAction:create()
    if self.hasSprinting then
        self.anim = 'JumpSprintStart'
    elseif self.hasRunning then
        self.anim = 'JumpRunStart'
    end
    ISBaseTimedAction.create(self)
end


function ISJumpToAction:stop()
    self:releaseAnimControl()
    ISBaseTimedAction.stop(self)
end


function ISJumpToAction:perform()
    self:consumeEndurance()
    self:releaseAnimControl()
    ISBaseTimedAction.perform(self)
end


function ISJumpToAction:new(character, destSquare)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.stopOnWalk = false
    o.stopOnRun = false
    o.stopOnAim = false

    o.lastUpdateTime = nil
    o.lastKnownSquare = character:getCurrentSquare()
    o.destSquare = destSquare
    o.startX = character:getX()
    o.startY = character:getY()
    o.destX = o.destSquare:getX()
    o.destY = o.destSquare:getY()
    o.hasSprinting = character:isSprinting()
    o.hasRunning = character:isRunning()
    o.forceZ = destSquare:getZ()

    o.useProgressBar = false

    if o.hasSprinting then
        o.maxTime = 25
    elseif o.hasRunning then
        o.maxTime = 15
    else
        o.maxTime = 0
    end
    o.anim = nil
   
    return o
end


function ISJumpToAction:releaseAnimControl()
    self.character:setRunning(self.hasRunning)
    self.character:setSprinting(self.hasSprinting)
    self.character:setIgnoreMovement(false)
end

function ISJumpToAction:consumeEndurance() --same as vault over fence
    local stats = self.character:getStats()
    if self.hasSprinting then
        stats:setEndurance(stats:getEndurance() - ZomboidGlobals.RunningEnduranceReduce * 700.0)
    elseif self.hasRunning then
        stats:setEndurance(stats:getEndurance() - ZomboidGlobals.RunningEnduranceReduce * 300.0)
    end
end
