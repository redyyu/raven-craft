--[[
		Original Developed by Codename280
		Modified by Raven.R
		Working Bench press 41.78+
]]

require "TimedActions/ISFitnessAction"

local soundFileBenchpress = "ExercisesBench"
local soundFileTreadmill = "ExercisesTreadmillrun"
local soundEnd = "ExercisesTreadmillend"
local soundFile = nil
local gameSound = 0


local oldWaitToStart = ISFitnessAction.waitToStart
function ISFitnessAction:waitToStart()
	if self.exercise == "benchpress" then
		soundFile = soundFileBenchpress
	elseif self.exercise == "treadmill" then
		soundFile = soundFileTreadmill	
	end
	return oldWaitToStart(self)
end


local oldExeLooped = ISFitnessAction.exeLooped

function ISFitnessAction:exeLooped()

	if self.exercise == "treadmill" then
		-- gain Sprinting XP when use treadmill
		self.character:getXp():AddXP(Perks.Sprinting, self.exeData.xpMod);
	end

	oldExeLooped(self)
end

local function ExerEndOfAction(self)
	if self.exercise == "treadmill" then
		-- Make sure game sound has stopped
		if gameSound and
			gameSound ~= 0 and
			self.character:getEmitter():isPlaying(gameSound) then
			self.character:getEmitter():stopSound(gameSound);
		end
		self.character:getEmitter():stopSound(gameSound);


		local soundRadius = 15
		local volume = 6

		gameSound = self.character:getEmitter():playSound(soundEnd);
			
		addSound(self.character,
				 self.character:getX(),
				 self.character:getY(),
				 self.character:getZ(),
				 soundRadius,
				 volume)
		
	elseif self.exercise == "benchpress" then
		if gameSound and
			gameSound ~= 0 and
			self.character:getEmitter():isPlaying(gameSound) then
			self.character:getEmitter():stopSound(gameSound);
		end

		local soundRadius = 13
		local volume = 6
			
		addSound(self.character,
				 self.character:getX(),
				 self.character:getY(),
				 self.character:getZ(),
				 soundRadius,
				 volume)
	
	end	

end


local oldUpdate = ISFitnessAction.update

function ISFitnessAction:update()
	if self.exercise == "treadmill" or self.exercise == "benchpress" then
		
		local isPlaying = gameSound
			and gameSound ~= 0
			and self.character:getEmitter():isPlaying(gameSound)

		if not isPlaying then
			local soundRadius = 13
			local volume = 6

			-- Use the emitter because it emits sound in the world (zombies can hear)
			gameSound = self.character:getEmitter():playSound(soundFile);
			
			addSound(self.character,
					 self.character:getX(),
					 self.character:getY(),
					 self.character:getZ(),
					 soundRadius,
					 volume)
		end
	end	
	
	oldUpdate(self)	
end


local oldStop = ISFitnessAction.stop

function ISFitnessAction:stop()
	ExerEndOfAction(self)
	oldStop(self)
end

local oldPerform = ISFitnessAction.perform

function ISFitnessAction:perform()
	ExerEndOfAction(self)
	oldPerform(self)
end

