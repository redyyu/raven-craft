require "TimedActions/ISBaseTimedAction"

ISJumpToAction = ISBaseTimedAction:derive("ISJumpToAction")


function ISJumpToAction:isValid()
    return true
end


function ISJumpToAction:animEvent(event, parameter)
    if event == 'JumpDone' then
        self:releaseAnimControl()
    elseif event == 'TouchGround' then
        self.forceZ = nil
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
        self.character:setZ(self.forceZ)
        self.character:setLz(self.forceZ)
    end
    
end


function ISJumpToAction:start()
    self.action:setUseProgressBar(false)
    
    local anim = nil
    if self.isSprinting then
        anim = 'JumpSprintStart'
    elseif self.isRunning then
        anim = 'JumpRunStart'
    end
    
    if anim then
        self:setActionAnim(anim)
        self.startX = character:getX()
        self.startY = character:getY()
        self.destX = self.destSquare:getX()
        self.destY = self.destSquare:getY()
        self.forceZ = self.character:getZ()
    end
end


function ISJumpToAction:create()
    ISBaseTimedAction.create(self)
    self.action:setUseProgressBar(false)
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
    o.stopOnAim = true
    o.isInvalid = false
    o.lastUpdateTime = nil
    o.startSquare = character:getCurrentSquare()
    o.destSquare = destSquare
    o.startX = character:getX()
    o.startY = character:getY()
    o.destX = o.destSquare:getX()
    o.destY = o.destSquare:getY()
    o.isSprinting = character:isSprinting()
    o.isRunning = character:isRunning()
    o.forceZ = character:getZ()

    o.maxTime = -1
    if o.isSprinting then
        o.maxTime = 10
    elseif o.isRunning then
        o.maxTime = 6
    end
end


function ISJumpToAction:releaseAnimControl()
    self.character:setRunning(self.isRunning)
    self.character:setSprinting(self.isSprinting)
    self.character:setIgnoreMovement(false)
end

function ISJumpToAction:consumeEndurance() --same as vault over fence
    local stats = self.character:getStats()
    if self.isSprinting then
        stats:setEndurance(stats:getEndurance() - ZomboidGlobals.RunningEnduranceReduce * 700.0)
    elseif self.isRunning then
        stats:setEndurance(stats:getEndurance() - ZomboidGlobals.RunningEnduranceReduce * 300.0)
    end
end
