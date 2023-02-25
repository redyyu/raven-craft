local READING_SPPED_RATE = 0.75;


local OldIsValid = ISReadABook.isValid
local OldNew = ISReadABook.new
local OldStop = ISReadABook.stop


function ISReadABook:isValid()
	return  OldIsValid(self) == true
		and (self.character:isTimedActionInstant()
		 or  self.character:isSitOnGround() == self.isCharacterSitOnGround)
end

function ISReadABook:stop()
	local result = OldStop(self)

	if not self.character:isTimedActionInstant() then
		local isSitOnGround = self.character:isSitOnGround()
		if	isSitOnGround and isSitOnGround ~= self.isCharacterSitOnGround then
			ISTimedActionQueue.add(ISReadABook:new(self.character, self.item, self.initialTime))
		end
	end


	return result
end

function ISReadABook:new(character, item, time)
	local instance = OldNew(self, character, item, time)
	-- print('----------------------Start Reading-------------------')
	-- print(character:isSitOnGround())
	-- print('----------------------Start Reading-------------------')
	-- print(instance.maxTime)
	if not instance.character:isTimedActionInstant() then
		instance.isCharacterSitOnGround = character:isSitOnGround();
		if instance.isCharacterSitOnGround then
			instance.maxTime = math.floor(instance.maxTime * READING_SPPED_RATE)
			-- print(instance.maxTime)
		end
	end

	return instance
end
