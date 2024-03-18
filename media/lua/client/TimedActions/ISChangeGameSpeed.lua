require "TimedActions/ISBaseTimedAction"


ISRestoreGameSpeed = ISBaseTimedAction:derive("ISRestoreGameSpeed")


function ISRestoreGameSpeed:isValid()
	return true
end

function ISRestoreGameSpeed:stop()
	ISBaseTimedAction.stop(self)
end

function ISRestoreGameSpeed:perform()
	UIManager.getSpeedControls():SetCurrentGameSpeed(self.gameSpeed)
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISRestoreGameSpeed:create()
	ISBaseTimedAction.create(self)
	self.action:setUseProgressBar(false)
end

function ISRestoreGameSpeed:new(game_speed)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.maxTime = 0
	o.stopOnWalk = false
	o.stopOnRun = false
	if game_speed == nil or game_speed == true then
		o.gameSpeed = 1
	elseif type(game_speed) ~= 'number' then
		o.gameSpeed = 0
	else
		game_speed = math.floor(game_speed)
		o.gameSpeed = math.max(math.min(game_speed, 3), 0)
	return o
end
