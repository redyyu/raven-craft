-- used to spawn underwear automatically on zeds
UnderwearDefinition = UnderwearDefinition or {};

-- base chance of having a special underwear spawning, don't want this too high as it adds new items on dead zeds everytime!
-- UnderwearDefinition.baseChance = 70;

-- outfit name
UnderwearDefinition.Female_Corset_Bodysuit = {
	chanceToSpawn = 1, -- weighted chance, can exced 100
	gender = "female",
	top = {
		{name="Corset_BodysuitBlack", chance=34},
		{name="Corset_BodysuitRed", chance=33},
		{name="Corset_BodysuitTINT", chance=33},
	},
	-- bottom = "FrillyUnderpants_Black",
}

UnderwearDefinition.Female_Corset = {
	chanceToSpawn = 1, -- weighted chance, can exced 100
	gender = "female",
	top = {
		{name="Corset", chance=50},
		{name="Corset_ToplessBodysuitTINT", chance=25},
		{name="Corset_ToplessTINT", chance=25},
	},
	-- bottom = "Underpants_White",
}

-- UnderwearDefinition.Female_FrillyRed = {
-- 	chanceToSpawn = 5,
-- 	gender = "female",
-- 	top = {
-- 		{name="Bra_Straps_FrillyRed", chance=50},
-- 		{name="Bra_Strapless_FrillyRed", chance=50},
-- 		{name="Corset_Red", chance=5},
-- 	},
-- 	bottom = "FrillyUnderpants_Red",
-- }
