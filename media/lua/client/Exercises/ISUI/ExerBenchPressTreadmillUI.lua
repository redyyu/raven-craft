require "ISUI/ISFitnessUI"

-- function ISFitnessUI:updateExercises()
-- 	self.exercises:clear();
	
-- 	for i, v in pairs(FitnessExercises.exercisesType) do
-- 		self:addExerciseToList(i, v);
-- 	end

-- end	


local function nearbyItem(playerObj, nearbyName)
    local max_distance = 1
    local curr_square = playerObj:getCurrentSquare()
    local object_tables = {}

	for x=curr_square:getX()-max_distance, curr_square:getX()+max_distance do
		for y=curr_square:getY()-max_distance, curr_square:getY()+max_distance do
			local gs = getCell():getGridSquare(x, y, curr_square:getZ());
			if gs then
                local gs_objects = gs:getObjects()
                for j=0, gs_objects:size()-1 do
                    local obj = gs_objects:get(j)
					if obj:getSprite() then

						local properties = obj:getSprite():getProperties()
						if not properties then 
							return false
						end
						if properties:Is("GroupName") and properties:Is("CustomName") then
							local fullName = properties:Val("GroupName")..' '..properties:Val("CustomName")
							if fullName == nearbyName then				
								return true
							end
						end
						
					end
				end
			end
		end
	end

    return false
end


function ISFitnessUI:addExerciseToList(type, data)
	local text = data.name;
	local enabled = true;
	if data.item and not self.player:getInventory():contains(data.item, true) then
		local option = self.exercises.options[index];
		local item = InventoryItemFactory.CreateItem(data.item);
		enabled = false
		text = text .. getText("IGUI_FitnessNeedItem", item:getDisplayName())
	end
	if data.device and not nearbyItem(self.player, data.device) then
		enabled = false
		local device_name = 
		text = text .. getText("IGUI_FitnessNeedNerbyDevice", )
	elseif data.electricity and not utils.isBeforeElecShut() and not square:haveElectricity() then
		enabled = false
		text = text .. getText("IGUI_FitnessDeviceNeedElectricity")
	end
	self.exercises:addOption(text, type, nil, enabled);
end


function ISFitnessUI:onClick(button)
	if button.internal == "OK" then
		local haveItem = self:equipItems();
		if not haveItem then return; end
		
		if self.exeData.nearby then
		end

		-- local action = ISFitnessAction:new(self.player, self.selectedExe, tonumber(self.exeTime:getInternalText()), self, self.exeData);
		-- ISTimedActionQueue.add(action);
	elseif button.internal == "CLOSE" then
		self:setVisible(false);
		self:removeFromUIManager();
		local playerNum = self.player:getPlayerNum()
		if JoypadState.players[playerNum+1] then
			setJoypadFocus(playerNum, nil)
		end
	elseif button.internal == "CANCEL" then
		self.player:setVariable("ExerciseStarted", false);
		self.player:setVariable("ExerciseEnded", true);
	elseif button.internal == "RESETVALUES" then
		self.fitness:resetValues();
	end
end
