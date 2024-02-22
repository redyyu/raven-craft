require "Definitions/FitnessExercises"

FitnessExercises.exercisesType.benchpress = {
		type = "benchpress",
		name = getText("IGUI_BenchPress"),
		tooltip = getText("IGUI_BenchPress_Tooltip"),
		stiffness = "arms,chest",
		item = "Base.BarBell",
		nearby = "Fitness Contraption",
		electricity = true,
		metabolics = Metabolics.FitnessHeavy,
		xpMod = 1.5,
	}

FitnessExercises.exercisesType.treadmill = {
		type = "treadmill",
		name = getText("IGUI_Treadmill"),
		tooltip = getText("IGUI_Treadmill_Tooltip"),
		stiffness = "legs", 
		nearby = "Human Hamster Wheel",
		metabolics = Metabolics.Fitness,
		xpMod = 0.8,
	}
