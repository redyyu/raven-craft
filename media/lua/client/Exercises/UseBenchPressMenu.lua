
BenchPressMenu = {}
BenchPressMenu.doBuildMenu = function(player, context, worldobjects)

	local benchMachine = nil
	local benchExercise = FitnessExercises.exercisesType.benchpress
	
	if not benchExercise then return end


	for _,object in ipairs(worldobjects) do
		local square = object:getSquare()
		if not square then return end
		
		for i=1,square:getObjects():size() do
			local obj = square:getObjects():get(i-1)
			if obj:getSprite() and benchExercise.nearby.sprites[obj:getSprite():getName()] then
				benchMachine = obj
				break
			end 
		end 
	end

	if benchMachine then
		local benchRegularity = math.floor(getSpecificPlayer(player):getFitness():getRegularity("benchpress"))
		local contextMenuText = getText("ContextMenu_USE_EXER_BENCH", benchRegularity)

		context:addOption(contextMenuText,
						worldobjects,
						BenchPressMenu.onUseBench,
						getSpecificPlayer(player),
						benchMachine,
						benchExercise,
						60)
	end
	
end


function BenchPressMenu.onUseBench(worldobjects, player, benchMachine, benchExercise, length)

	forceDropHeavyItems(player)
	
	if not player:getInventory():contains("Base.BarBell", true) then
		player:Say(getText("IGUI_PLAYER_TEXT_NEED_BARBELL"))
		return
	end
	if player:getMoodles():getMoodleLevel(MoodleType.Endurance) > 2 then
		player:Say(getText("IGUI_PLAYER_TEXT_TOO_EXHAUSTED"))
		return
	end
	if player:getMoodles():getMoodleLevel(MoodleType.Pain) > 3 then
		player:Say(getText("IGUI_PLAYER_TEXT_TOO_PAIN"))
		return
	end
	
	-- take off and drop worn container items / bages
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
		
	ISWorldObjectContextMenu.equip(player, player:getPrimaryHandItem(), "Base.BarBell", true, true);

	local facingX = benchMachine:getX()
	local facingY = benchMachine:getY()

	local properties = benchMachine:getSprite():getProperties()
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
	if AdjacentFreeTileFinder.privTrySquare(player:getCurrentSquare(), benchMachine:getSquare()) then
		ISTimedActionQueue.add(ISWalkToTimedAction:new(player, benchMachine:getSquare()))
		ISTimedActionQueue.add(ISCharacterFacingToAction:new(player, facingX, facingY))
		ISTimedActionQueue.add(ISFitnessAction:new(player, benchExercise.type, length , ISFitnessUI:new(0,0, 600, 350, player) , benchExercise))
	end
end

Events.OnPreFillWorldObjectContextMenu.Add(BenchPressMenu.doBuildMenu);
