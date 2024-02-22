require "utils"


TreadmillMenu = {}
TreadmillMenu.doBuildMenu = function(player, context, worldobjects)

	local treadmillObject = nil

	for _,object in ipairs(worldobjects) do
		local square = object:getSquare()
		if not square then return end
		
		for i=1,square:getObjects():size() do
			local obj = square:getObjects():get(i-1)
			
			if obj:getSprite() then
				local properties = obj:getSprite():getProperties()
				if not properties then return end

				if properties:Is("GroupName") and properties:Is("CustomName") then
					local groupName = properties:Val("GroupName")
					local customName = properties:Val("CustomName")
				
					if groupName == 'Human' and customName == "Hamster Wheel" then
						if utils.isBeforeElecShut() or square:haveElectricity() then
							treadmillObject = obj
							break
						else
							getSpecificPlayer(player):Say(getText("IGUI_PLAYER_TEXT_TREADMILL_NEED_ELC"))
							return
						end
					end
				end
			end
		end
	end
	
	if treadmillObject then 
		local treadmillRegularity = math.floor(getSpecificPlayer(player):getFitness():getRegularity("treadmill"))
		local contextMenuText = getText("ContextMenu_USE_EXER_TREADMILL", treadmillRegularity)
		local actionType = "treadmill"
		context:addOption(contextMenuText,
						worldobjects,
						TreadmillMenu.onUseTreadmill,
						getSpecificPlayer(player),
						treadmillObject,
						actionType,
						5760)
	end
	
	
end


TreadmillMenu.walkToFront = function(thisPlayer, treadmillObject)
	local frontSquare = nil
	local controllerSquare = nil
	local spriteName = treadmillObject:getSprite():getName()
	if not spriteName then
		return false
	end

	local properties = treadmillObject:getSprite():getProperties()
	
	local facing = nil
	if properties:Is("Facing") then
		facing = properties:Val("Facing")
	else
		return
	end
	
	if facing == "S" then
		frontSquare = treadmillObject:getSquare():getS()
	elseif facing == "E" then
		frontSquare = treadmillObject:getSquare():getE()
	elseif facing == "W" then
		frontSquare = treadmillObject:getSquare():getW()
	elseif facing == "N" then
		frontSquare = treadmillObject:getSquare():getN()
	end
	
	if not frontSquare then
		return false
	end
	
	if not controllerSquare then
		controllerSquare = treadmillObject:getSquare()
	end

	-- If the front of treadmill square is valid, walk to it
	if AdjacentFreeTileFinder.privTrySquare(controllerSquare, frontSquare) then
		ISTimedActionQueue.add(ISWalkToTimedAction:new(thisPlayer, frontSquare))
		return true
	end
	return false
end


-- Do when player selects option to use a treadmill (from context menu)
TreadmillMenu.onUseTreadmill = function(worldobjects, player, machine, actionType, length)
	if TreadmillMenu.walkToFront(player, machine) then
	
		forceDropHeavyItems(player)
		player:setPrimaryHandItem(nil)
		player:setSecondaryHandItem(nil)
		
		if player:getMoodles():getMoodleLevel(MoodleType.Endurance) > 2 then
			player:Say(getText("IGUI_PLAYER_TEXT_IGUI_PLAYER_TEXT_TOO_EXHAUSTED"))
			return
		end
		if player:getMoodles():getMoodleLevel(MoodleType.Pain) > 3 then
			player:Say(getText("IGUI_PLAYER_TEXT_IGUI_PLAYER_TEXT_TOO_PAIN"))
			return
		end
				
		-- take off worn container items / bages
		for i=0,player:getWornItems():size()-1 do
			local item = player:getWornItems():get(i):getItem();
			if item and instanceof(item, "InventoryContainer") then
				ISTimedActionQueue.add(ISUnequipAction:new(player, item, 50));
			end
		end
		
		if player:getMoodles():getMoodleLevel(MoodleType.HeavyLoad) > 2 then
			player:Say(getText("IGUI_PLAYER_TEXT_IGUI_PLAYER_TEXT_TOO_HEAVY"))
			return
		end
		ISTimedActionQueue.add(ISFitnessAction:new(player, actionType, length , ISFitnessUI:new(0,0, 600, 350, player) , FitnessExercises.exercisesType.treadmill ))
	end
end

Events.OnPreFillWorldObjectContextMenu.Add(TreadmillMenu.doBuildMenu);
