require "RCCore"


TreadmillMenu = {}
TreadmillMenu.doBuildMenu = function(player, context, worldobjects)

	local treadmillMachine = nil
	local treadmillExercise = FitnessExercises.exercisesType.treadmill
	
	if not treadmillExercise then return end

	for _, obj in ipairs(worldobjects) do
		if obj:getSprite() and treadmillExercise.nearby.sprites[obj:getSprite():getName()] then
			treadmillMachine = obj
			break
		end

	end

	if treadmillMachine then 
		local treadmillRegularity = math.floor(getSpecificPlayer(player):getFitness():getRegularity("treadmill"))
		local contextMenuText = getText("ContextMenu_USE_EXER_TREADMILL", treadmillRegularity)

		context:addDebugOption(contextMenuText,
							   worldobjects,
							   TreadmillMenu.onUseTreadmill,
							   getSpecificPlayer(player),
							   treadmillMachine,
							   treadmillExercise,
							   60)
	end
	
	
end


-- Do when player selects option to use a treadmill (from context menu)
TreadmillMenu.onUseTreadmill = function(worldobjects, player, treadmillMachine, treadmillExercise, length)
	
	forceDropHeavyItems(player)

	player:setPrimaryHandItem(nil)
	player:setSecondaryHandItem(nil)
	
	if player:getMoodles():getMoodleLevel(MoodleType.Endurance) > 2 then
		player:Say(getText("IGUI_PLAYER_TEXT_TOO_EXHAUSTED"))
		return
	end
	if player:getMoodles():getMoodleLevel(MoodleType.Pain) > 3 then
		player:Say(getText("IGUI_PLAYER_TEXT_TOO_PAIN"))
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
		player:Say(getText("IGUI_PLAYER_TEXT_TOO_HEAVY"))
		return
	end
	

	local facingX = treadmillMachine:getX()
	local facingY = treadmillMachine:getY()

	local properties = treadmillMachine:getSprite():getProperties()
	if properties:Is("Facing") then
		local facing = properties:Val("Facing")
		-- DO NOT use getW, getE, getN, getS, ...
		-- seems get blocked square as nil.
		if facing == "S" then
			facingY = facingY - 10
			-- face_to_square = target_square:getN()
		elseif facing == "E" then
			facingX = facingX - 10
			-- face_to_square = target_square:getW()
		elseif facing == "W" then
			facingX = facingX + 10
			-- face_to_square = target_square:getE()
		elseif facing == "N" then
			facingY = facingY + 10
			-- face_to_square = target_square:getS()
		end
	end

	if AdjacentFreeTileFinder.privTrySquare(player:getCurrentSquare(), treadmillMachine:getSquare()) then
		ISTimedActionQueue.add(ISWalkToTimedAction:new(player, treadmillMachine:getSquare()))
		ISTimedActionQueue.add(ISCharacterFacingToAction:new(player, facingX, facingY))
		ISTimedActionQueue.add(ISFitnessAction:new(player, treadmillExercise.type, length , ISFitnessUI:new(0,0, 600, 350, player) , treadmillExercise))
	else
		
	end
end

if isDebugEnabled() then
	Events.OnPreFillWorldObjectContextMenu.Add(TreadmillMenu.doBuildMenu);
end
