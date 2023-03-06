require "TimedActions/ISBaseTimedAction"

ISGunSuicide = ISBaseTimedAction:derive("ISGunSuicide")

function ISGunSuicide:isValid()
	return true
end

function ISGunSuicide:update()
	local game_speed = UIManager.getSpeedControls():getCurrentGameSpeed()
    if game_speed ~= 1 then
        UIManager.getSpeedControls():SetCurrentGameSpeed(1)
    end

	if self:getJobDelta() > 0 and not self.isOff then
		self.character:splatBloodFloorBig();
		self.isOff = true;
	end

	if self:getJobDelta() >= self.shotTime and not self.isStartSound then
		self.character:getEmitter():playSound(self.item:getSwingSound())
		self.isStartSound = true;
	end
end

function ISGunSuicide:start()
	self:setActionAnim(self.anim)
end

function ISGunSuicide:perform()
	self.item:setCurrentAmmoCount(math.max(self.item:getCurrentAmmoCount() - self.item:getAmmoPerShoot(), 0))
	self.character:getBodyDamage():RestoreToFullHealth()
	self.character:getBodyDamage():setInfectionLevel(0)
	self.character:Kill(self.character)
	
	ISBaseTimedAction.perform(self)
end

function ISGunSuicide:new(character, item, anim, shotTime, maxTime)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.item = item
	o.anim = anim
	o.shotTime = shotTime
	o.maxTime = maxTime
	
	return o
end




