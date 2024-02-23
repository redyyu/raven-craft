--[[
	Set sprite properties for climbing, square takes properties from objects, objects from sprites.
	To prevent falling during climbing we make the custom sprites more persistent and able to pass their properties to the square.
	IDs used are in the range for fileNumber 100, used by mod SpearTraps
--]]

local Ladder = {
	idW = 26476542,
	idN = 26476543,
	climbLadderTopW = "TopOfLadderW",
	climbLadderTopN = "TopOfLadderN",
}


function Ladder.getTopOfLadder(square, north)
	local objects = square:getObjects()
	for i = 0, objects:size() - 1 do
		local obj = objects:get(i)
		local name = obj:getTextureName()
		if name == ( north and Ladder.climbLadderTopN or Ladder.climbLadderTopW ) then
			return obj
		end
	end
	return nil
end

---@return IsoObject topOfLadder
function Ladder.addTopOfLadder(square, north)
	local props = square:getProperties()
	if props:Is(north and IsoFlagType.WallN or IsoFlagType.WallW) or props:Is(IsoFlagType.WallNW) then
		Ladder.removeTopOfLadder(square)
		return nil
	end

	if props:Is(north and IsoFlagType.climbSheetTopN or IsoFlagType.climbSheetTopW) then
		return Ladder.getTopOfLadder(square, north)
	else
		local object = IsoObject.new(getCell(), square, north and Ladder.climbLadderTopN or Ladder.climbLadderTopW)
		square:transmitAddObjectToSquare(object, -1)
		return object
	end
end

function Ladder.removeTopOfLadder(square)
	if not square then return end
	local objects = square:getObjects()
	for i = objects:size() - 1, 0, - 1  do
		local object = objects:get(i)
		local sprite = object:getTextureName()
		if sprite == Ladder.climbLadderTopN or sprite == Ladder.climbLadderTopW then
			square:transmitRemoveItemFromSquare(object)
		end
	end
end

function Ladder.makeLadderClimbable(square, north)
	local x, y, z = square:getX(), square:getY(), square:getZ()
	local flags = north and { climbSheet = IsoFlagType.climbSheetN, climbSheetTop = IsoFlagType.climbSheetTopN, Wall = IsoFlagType.WallN }
		or { climbSheet = IsoFlagType.climbSheetW, climbSheetTop = IsoFlagType.climbSheetTopW, Wall = IsoFlagType.WallW }
	local topSquare = square
	local topObject

	while true do
		topObject = topSquare:Is(flags.climbSheetTop) and Ladder.getTopOfLadder(topSquare,north)
		z = z + 1
		local aboveSquare = getSquare(x, y, z)
		if not aboveSquare or aboveSquare:TreatAsSolidFloor() or aboveSquare:Is("RoofGroup") then break end
		if aboveSquare:Is(flags.climbSheet) then
			if topObject then topSquare:transmitRemoveItemFromSquare(topObject) end
			topSquare = aboveSquare
		elseif not (aboveSquare:Is(flags.Wall) or aboveSquare:Is(IsoFlagType.WallNW)) then
			if topObject then topSquare:transmitRemoveItemFromSquare(topObject) end
			topSquare = aboveSquare
			break
		else
			Ladder.removeTopOfLadder(aboveSquare)
			break
		end
	end

	-- if topSquare == square then return end
	topObject = Ladder.addTopOfLadder(topSquare, north)
end

function Ladder.makeLadderClimbableFromTop(square)

	local x = square:getX()
	local y = square:getY()
	local z = square:getZ() - 1

	local belowSquare = getSquare(x, y, z)
	if belowSquare then
		Ladder.makeLadderClimbableFromBottom(getSquare(x - 1, y,     z))
		Ladder.makeLadderClimbableFromBottom(getSquare(x + 1, y,     z))
		Ladder.makeLadderClimbableFromBottom(getSquare(x,     y - 1, z))
		Ladder.makeLadderClimbableFromBottom(getSquare(x,     y + 1, z))
	end
end

function Ladder.makeLadderClimbableFromBottom(square)

	if not square then return end

	local props = square:getProperties()
	if props:Is(IsoFlagType.climbSheetN) then
		Ladder.makeLadderClimbable(square, true)
	elseif props:Is(IsoFlagType.climbSheetW) then
		Ladder.makeLadderClimbable(square, false)
	end
end

-- The wookiee says to use getCore():getKey("Interact")
-- because then it respects their vanilla rebindings.
function Ladder.OnKeyPressed(key)
	if key == getCore():getKey("Interact") then
		local player = getPlayer()
		if not player or player:isDead() then return end
		if MainScreen.instance:isVisible() then return end

		-- Will store last player to attempt to climb a ladder.

		local square = player:getSquare()
		Ladder.makeLadderClimbableFromTop(square)
		Ladder.makeLadderClimbableFromBottom(square)
	end
end

Events.OnKeyPressed.Add(Ladder.OnKeyPressed)

--
-- When a player places a crafted ladder, he won't be able to climb it unless:
-- - the ladder sprite has the proper flags set
-- - the player moves to another chunk and comes back
-- - the player quit and load the saved game
-- - the same sprite was already spawned and went through the LoadGridsquare event
--
-- We add the missing flags here to work around the issue.
--

-- Compatibility: Adding a backup for anyone who needs it.

-- Ladder.ISMoveablesAction = {
-- 	perform = ISMoveablesAction.perform
-- }

-- local ISMoveablesAction_perform = ISMoveablesAction.perform

-- function ISMoveablesAction:perform()

-- 	ISMoveablesAction_perform(self)

-- 	if self.mode == 'pickup' then
-- 		Ladder.removeLadder(getSquare(self.square:getX(),self.square:getY(),self.square:getZ()+1))
-- 	end
-- end

-- require "TimedActions/ISDestroyStuffAction"
-- Ladder.ISDestroyStuffAction = {
-- 	perform = ISDestroyStuffAction.perform,
--  }

-- function ISDestroyStuffAction:perform()
-- 	if self.item:haveSheetRope() then
-- 		Ladder.removeLadder(self.item:getSquare())
-- 	end
-- 	return Ladder.ISDestroyStuffAction.perform(self)
-- end

-- Sprite flags


Ladder.westLadderTiles = {
	"industry_02_86", "location_sewer_01_32", "industry_railroad_05_20", "industry_railroad_05_36", "walls_commercial_03_0",
	"edit_ddd_RUS_decor_house_01_16", "edit_ddd_RUS_decor_house_01_19", "edit_ddd_RUS_industry_crane_01_72",
	"edit_ddd_RUS_industry_crane_01_73", "rus_industry_crane_ddd_01_24", "rus_industry_crane_ddd_01_25",
	"A1 Wall_48", "A1 Wall_80", "A1_CULT_36", "aaa_RC_6", "trelai_tiles_01_30", "trelai_tiles_01_38",
	"industry_crane_rus_72", "industry_crane_rus_73"
}

Ladder.northLadderTiles = {
	"location_sewer_01_33", "industry_railroad_05_21", "industry_railroad_05_37",
	"edit_ddd_RUS_decor_house_01_17", "edit_ddd_RUS_decor_house_01_18",
	"edit_ddd_RUS_industry_crane_01_76", "edit_ddd_RUS_industry_crane_01_77",
	"A1 Wall_49", "A1 Wall_81", "A1_CULT_37", "aaa_RC_14", "trelai_tiles_01_31",
	"trelai_tiles_01_39", "industry_crane_rus_76", "industry_crane_rus_77",
}

for index = 1, 62 do
	local name = "basement_objects_02_" .. index
	if index % 2 == 0 then
		Ladder.westLadderTiles[#Ladder.westLadderTiles + 1] = name
	else
		Ladder.northLadderTiles[#Ladder.northLadderTiles + 1] = name
	end
end

Ladder.holeTiles = {
	"floors_interior_carpet_01_24"
}

Ladder.poleTiles = {
	"recreational_sports_01_32", "recreational_sports_01_33"
}

-- too many not need those, just check startswith `crafted_01_`
-- Ladder.sheetRope = {
-- 	"crafted_01_0", "crafted_01_1", "crafted_01_3", "crafted_01_4", "crafted_01_5", 
-- 	"crafted_01_8", "crafted_01_9", "crafted_01_10", "crafted_01_13", "crafted_01_14", "crafted_01_15", 
-- 	"crafted_01_22", "crafted_01_23",
-- 	"crafted_01_48", "crafted_01_49", "crafted_01_50", "crafted_01_53",
-- }

Ladder.excludeAnimTiles = {}
for each, name in ipairs(Ladder.poleTiles) do
	Ladder.excludeAnimTiles[name] = true
end


Ladder.setLadderClimbingFlags = function(manager)
	print('-----------CLIMBLINGFlags-----------------------')
	for _, name in ipairs(Ladder.westLadderTiles) do
		local properties = manager:getSprite(name):getProperties()
		properties:Set(IsoFlagType.climbSheetW)
		-- properties:Set('CustomName', 'Ladder')
	end

	for _, name in ipairs(Ladder.northLadderTiles) do
		local properties = manager:getSprite(name):getProperties()
		properties:Set(IsoFlagType.climbSheetN)
		-- properties:Set('CustomName', 'Ladder')
	end

	for _, name in ipairs(Ladder.holeTiles) do
		local properties = manager:getSprite(name):getProperties()
		properties:Set(IsoFlagType.climbSheetTopW)
		properties:Set(IsoFlagType.HoppableW)
		properties:UnSet(IsoFlagType.solidfloor)
	end

	for _, name in ipairs(Ladder.poleTiles) do
		manager:getSprite(name):getProperties():Set(IsoFlagType.climbSheetW)
	end

	local spriteW = manager:AddSprite(Ladder.climbLadderTopW, Ladder.idW)
	spriteW:setName(Ladder.climbLadderTopW)
	local propsW = spriteW:getProperties()
	propsW:Set(IsoFlagType.climbSheetTopW)
	propsW:Set(IsoFlagType.HoppableW)
	propsW:CreateKeySet()

	local spriteN = manager:AddSprite(Ladder.climbLadderTopN, Ladder.idN)
	spriteN:setName(Ladder.climbLadderTopN)
	local propsN = spriteN:getProperties()
	propsN:Set(IsoFlagType.climbSheetTopN)
	propsN:Set(IsoFlagType.HoppableN)
	propsN:CreateKeySet()

	print('----------------DFDDDDDDDSSDFFSDFSDF---------------')
	print(spriteW:getSquare())
	print('----------------DFDDDDDDDSSDFFSDFSDF---------------')

end

Ladder.doBuildMenu = function(player, context, worldobjects, test)
	local playerObj = getSpecificPlayer(player)
	-- local climbOption = context:getOptionFromName(getText("ContextMenu_Climb_Sheet_Rope"))
	-- local removeRopeOption = context:getOptionFromName(getText("ContextMenu_Remove_escape_rope"))

	-- local is_ladder = true
	-- local square = nil

	-- for _, obj in ipairs(worldobjects) do
	-- 	square = obj:getSquare()
	-- 	local prop = obj:getProperties()
	-- 	print('----------Have Sheet Rope ---------')
	-- 	print(prop:Val('CustomName'))
	-- 	print('--------- End -Have Sheet Rope ---------')
	
	-- 	if Ladder.excludeAnimTiles[obj:getTextureName()] then
	-- 		-- check if no need ladder action
	-- 		is_ladder = false
	-- 		break
	-- 	end
	-- end

	-- if climbOption then
		
	-- 	local is_down = false

	-- 	-- if square then
	-- 	-- 	is_down = playerObj:getZ() > square:getZ()
	-- 	-- 	square =  AdjacentFreeTileFinder.Find(getSquare(square:getX(), square:getY(), playerObj:getZ()), playerObj)
	-- 	-- end
		
	-- 	local opt_name = is_ladder and getText("ContextMenu_CLIMB_LADDER") or climbOption.name
	-- 	context:removeOptionByName(climbOption.name)
	-- 	if square and playerObj:canClimbSheetRope(square) and playerObj:getPerkLevel(Perks.Strength) >= 0 then
	-- 		context:addOptionOnTop(opt_name, worldobjects, ISWorldObjectContextMenu.onClimbSheetRope, square, is_down, player)
	-- 	end
	-- end

	-- -- take care remove escape rope, ledder's no need this option
	-- -- otherwise will cause Error.
	-- if removeRopeOption and squ then
	-- 	-- context:removeOptionByName(removeRopeOption.name)
	-- 	print('------------------dsafasdfasdfasdfsddsafdsaf----------------------------')
	-- end
end

Events.OnLoadedTileDefinitions.Add(Ladder.setLadderClimbingFlags)
Events.OnFillWorldObjectContextMenu.Add(Ladder.doBuildMenu)
