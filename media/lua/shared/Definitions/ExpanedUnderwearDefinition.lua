-- used to spawn underwear automatically on zeds
UnderwearDefinition = UnderwearDefinition or {};

-- base chance of having a special underwear spawning, don't want this too high as it adds new items on dead zeds everytime!
-- UnderwearDefinition.baseChance = 70;

-- outfit name
UnderwearDefinition.Female_Corset = {
	chanceToSpawn = 2, -- weighted chance, can exced 100
	gender = "female",
	top = {
		{name="Corset", chance=15},
		{name="Corset_Black", chance=15},
		{name="Corset_Red", chance=15},
		{name="RavenCraft.Corset_ToplessBodysuitTINT", chance=5},
		{name="RavenCraft.Corset_ToplessTINT", chance=5},
		{name="RavenCraft.Corset_Pink", chance=10},
		{name="RavenCraft.Corset_BodysuitPink", chance=10},
		{name="RavenCraft.Corset_BodysuitBlack", chance=10},
		{name="RavenCraft.Corset_BodysuitRed", chance=10},
		{name="RavenCraft.Corset_BodysuitTINT", chance=10},
	},
	bottom = "Underpants_White",
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
