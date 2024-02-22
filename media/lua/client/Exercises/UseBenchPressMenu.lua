
BenchPressMenu = {}
BenchPressMenu.doBuildMenu = function(player, context, worldobjects)

	local benchObject = nil

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
					
					if groupName == "Fitness" and customName == "Contraption" then				
						benchObject = obj
						break
					end
				end
			end 
		end 
	end

	if benchObject then
		local benchRegularity = math.floor(getSpecificPlayer(player):getFitness():getRegularity("benchpress"))
		local contextMenuText = getText("ContextMenu_USE_EXER_BENCH", benchRegularity)
		local actionType = "benchpress"

		context:addOption(contextMenuText,
						worldobjects,
						BenchPressMenu.onUseBench,
						getSpecificPlayer(player),
						benchObject,
						actionType,
						20)
	end
	
end

BenchPressMenu.getFrontSquare = function(square, facing)
	local value = nil
	
	if facing == "S" then
		value = square:getS()
	elseif facing == "E" then
		value = square:getE()
	elseif facing == "W" then
		value = square:getW()
	elseif facing == "N" then
		value = square:getN()
	end
	
	return value
end

BenchPressMenu.getFacing = function(properties)

	local facing = nil
	
	if properties:Is("Facing") then
		facing = properties:Val("Facing")
	end
	return facing
end

function BenchPressMenu.walkToFront(thisPlayer, benchObject)

	local controllerSquare = nil
	local spriteName = benchObject:getSprite():getName()
	if not spriteName then
		return false
	end

	local properties = benchObject:getSprite():getProperties()
	local facing = BenchPressMenu.getFacing(properties)
	if facing == nil then
		return false
	end
	
	local frontSquare = BenchPressMenu.getFrontSquare(benchObject:getSquare(), facing)
	local turn = BenchPressMenu.getFrontSquare(frontSquare, facing)
	
	if not frontSquare then
		return false
	end
	if not controllerSquare then
		controllerSquare = benchObject:getSquare()
	end
	if AdjacentFreeTileFinder.privTrySquare(controllerSquare, frontSquare) then
		luautils.walkAdj(thisPlayer, frontSquare)
		thisPlayer:faceLocation(benchObject:getSquare():getX(), benchObject:getSquare():getY())
		return true
	end
	return false
end


function BenchPressMenu.onUseBench(worldobjects, player, machine, actionType, length)
	if BenchPressMenu.walkToFront(player, machine) then
	
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
			player:Say(getText("IGUI_PLAYER_TEXT_TOO_PAIND"))
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

		ISTimedActionQueue.add(ISFitnessAction:new(player, actionType, length , ISFitnessUI:new(0,0, 600, 350, player) , FitnessExercises.exercisesType.benchpress ))
	end
end

Events.OnPreFillWorldObjectContextMenu.Add(BenchPressMenu.doBuildMenu);
