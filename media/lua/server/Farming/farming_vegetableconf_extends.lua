require "Farming/SFarmingSystem"
require "Farming/farming_vegetableconf"


-- common growing
farming_vegetableconf.growPlantUniversal = function(planting, nextGrowing, updateNbOfGrow)
	local nbOfGrow = planting.nbOfGrow;
	local water = farming_vegetableconf.calcWater(planting.waterNeeded, planting.waterLvl);
	local waterMax = farming_vegetableconf.calcWater(planting.waterLvl, planting.waterNeededMax);
	local diseaseLvl = farming_vegetableconf.calcDisease(planting.mildewLvl);
	local conf = farming_vegetableconf.props[planting.typeOfSeed]

	if conf.restoreGrow and nbOfGrow <= 0 then
		nbOfGrow = 0;
		planting.nbOfGrow = 0;
	end

	if(nbOfGrow == 0) then -- young  Tips: Don't know why Cabbage is nbOfGrow <= 0
		planting = growNext(planting,
							farming_vegetableconf.getSpriteName(planting),
							farming_vegetableconf.getObjectName(planting),
							nextGrowing,
							conf.timeToGrow + water + diseaseLvl);
		planting.waterNeeded = math.min(conf.waterLvl + 5, 100);
	elseif (nbOfGrow <= 4) then -- young
		if(water >= 0 and diseaseLvl >= 0) then
			planting = growNext(planting,
								farming_vegetableconf.getSpriteName(planting),
								farming_vegetableconf.getObjectName(planting),
								nextGrowing,
								conf.timeToGrow + water + diseaseLvl);
			planting.waterNeeded = conf.waterLvl;
			planting.waterNeededMax = conf.waterLvlMax;
		else
			badPlant(water, waterMax, diseaseLvl, planting, nextGrowing, updateNbOfGrow);
		end
	elseif (nbOfGrow == 5) then -- mature
		if(water >= 0 and diseaseLvl >= 0) then
			if conf.harvestSeedOnly then
				planting = growNext(planting,
									farming_vegetableconf.getSpriteName(planting),
									farming_vegetableconf.getObjectName(planting),
									nextGrowing,
									conf.timeToGrow + water + diseaseLvl);
			else
				planting.nextGrowing = calcNextGrowing(nextGrowing,
													   conf.timeToGrow + water + diseaseLvl);
				planting:setObjectName(farming_vegetableconf.getObjectName(planting))
				planting:setSpriteName(farming_vegetableconf.getSpriteName(planting))
				planting.hasVegetable = true;
			end
		else
			badPlant(water, waterMax, diseaseLvl, planting, nextGrowing, updateNbOfGrow);
		end
	elseif (nbOfGrow == 6) then -- mature with seed
		if(water >= 0 and diseaseLvl >= 0) then
			local timeToBad = conf.timeToBad
			if not timeToBad then
				timeToBad = 248
			end
			planting.nextGrowing = calcNextGrowing(nextGrowing, timeToBad);
			planting:setObjectName(farming_vegetableconf.getObjectName(planting))
			planting:setSpriteName(farming_vegetableconf.getSpriteName(planting))
			planting.hasVegetable = true;
			planting.hasSeed = true;
		else
			badPlant(water, waterMax, diseaseLvl, planting, nextGrowing, updateNbOfGrow);
		end
	elseif (planting.state ~= "rotten") then -- rotten
		planting:rottenThis()
	end
	return planting;
end


-- Corn
-- Need 6 seeds
-- Need Water lvl over 70
-- need 4 weeks (112 hours per phase)
farming_vegetableconf.icons["Corn"] = "Item_Corn";

farming_vegetableconf.props["Corn"] = {};
farming_vegetableconf.props["Corn"].seedsRequired = 6;
farming_vegetableconf.props["Corn"].texture = "vegetation_farming_01_78";
farming_vegetableconf.props["Corn"].timeToGrow = ZombRand(103, 117);
farming_vegetableconf.props["Corn"].waterLvl = 70;
farming_vegetableconf.props["Corn"].minVeg = 4;
farming_vegetableconf.props["Corn"].maxVeg = 6;
farming_vegetableconf.props["Corn"].minVegAutorized = 6;
farming_vegetableconf.props["Corn"].maxVegAutorized = 12;
farming_vegetableconf.props["Corn"].vegetableName = "Base.Corn";
farming_vegetableconf.props["Corn"].seedName = getPackageItemType(".CornSeed");
farming_vegetableconf.props["Corn"].seedPerVeg = 3;
farming_vegetableconf.props["Corn"].harvestSeedOnly = true;

farming_vegetableconf.sprite["Corn"] = {
"vegetation_farming_01_72",
"vegetation_farming_01_73",
"vegetation_farming_01_74",
"vegetation_farming_01_75",
"vegetation_farming_01_76",
"vegetation_farming_01_77",
"vegetation_farming_01_78",
"vegetation_farming_01_79"
}

farming_vegetableconf.growCorn = farming_vegetableconf.growPlantUniversal


-- Peanuts 
-- Need 6 seeds
-- Need Water lvl over 65
-- Need 3 weeks (84h per phase)
farming_vegetableconf.icons["Peanuts"] = "Item_Peanut";

farming_vegetableconf.props["Peanuts"] = {};
farming_vegetableconf.props["Peanuts"].seedsRequired = 6;
farming_vegetableconf.props["Peanuts"].texture = "vegetation_farming_01_45";
farming_vegetableconf.props["Peanuts"].waterLvl = 65;
farming_vegetableconf.props["Peanuts"].timeToGrow = ZombRand(89, 103);
farming_vegetableconf.props["Peanuts"].minVeg = 4;
farming_vegetableconf.props["Peanuts"].maxVeg = 6;
farming_vegetableconf.props["Peanuts"].minVegAutorized = 6;
farming_vegetableconf.props["Peanuts"].maxVegAutorized = 10;
farming_vegetableconf.props["Peanuts"].vegetableName = "Base.Peanuts";
farming_vegetableconf.props["Peanuts"].seedName = getPackageItemType(".PeanutsSeed");
farming_vegetableconf.props["Peanuts"].seedPerVeg = 3;
farming_vegetableconf.props["Peanuts"].harvestSeedOnly = true;

farming_vegetableconf.sprite["Peanuts"] = {
"vegetation_farming_01_40",
"vegetation_farming_01_41",
"vegetation_farming_01_42",
"vegetation_farming_01_43",
"vegetation_farming_01_44",
"vegetation_farming_01_46",
"vegetation_farming_01_45",
"vegetation_farming_01_47"
}


farming_vegetableconf.growPeanuts = farming_vegetableconf.growPlantUniversal


-- Wheat
-- Need 9 seeds
-- Need Water lvl over 85
-- Need 4 weeks to grow (112h per phase)
farming_vegetableconf.icons["Wheat"] = "Item_Wheat";

farming_vegetableconf.props["Wheat"] = {};
farming_vegetableconf.props["Wheat"].seedsRequired = 9;
farming_vegetableconf.props["Wheat"].texture = "vegetation_farming_01_76";
farming_vegetableconf.props["Wheat"].timeToGrow = ZombRand(103, 117);
farming_vegetableconf.props["Wheat"].waterLvl = 85;
farming_vegetableconf.props["Wheat"].minVeg = 4;
farming_vegetableconf.props["Wheat"].maxVeg = 12;
farming_vegetableconf.props["Wheat"].minVegAutorized = 8;
farming_vegetableconf.props["Wheat"].maxVegAutorized = 16;
farming_vegetableconf.props["Wheat"].vegetableName = getPackageItemType(".Wheat");
farming_vegetableconf.props["Wheat"].seedName = getPackageItemType(".WheatSeed");
farming_vegetableconf.props["Wheat"].seedPerVeg = 2;
farming_vegetableconf.props["Wheat"].harvestSeedOnly = true;

farming_vegetableconf.sprite["Wheat"] = {
"vegetation_farming_01_72",
"vegetation_farming_01_73",
"vegetation_farming_01_74",
"vegetation_farming_01_74",
"vegetation_farming_01_75",
"vegetation_farming_01_75",
"vegetation_farming_01_76",
"vegetation_farm_01_34"
}

farming_vegetableconf.growWheat = farming_vegetableconf.growPlantUniversal


-- Zucchini
-- Need 4 seeds
-- Need Water lvl over 75
-- Need 3 weeks (84h per phase)
farming_vegetableconf.icons["Zucchini"] = "Item_Zucchini";

farming_vegetableconf.props["Zucchini"] = {};
farming_vegetableconf.props["Zucchini"].seedsRequired = 4;
farming_vegetableconf.props["Zucchini"].texture = "vegetation_farming_01_69";
farming_vegetableconf.props["Zucchini"].waterLvl = 75;
farming_vegetableconf.props["Zucchini"].timeToGrow = ZombRand(89, 103);
farming_vegetableconf.props["Zucchini"].minVeg = 4;
farming_vegetableconf.props["Zucchini"].maxVeg = 5;
farming_vegetableconf.props["Zucchini"].minVegAutorized = 6;
farming_vegetableconf.props["Zucchini"].maxVegAutorized = 10;
farming_vegetableconf.props["Zucchini"].vegetableName = "Base.Zucchini";
farming_vegetableconf.props["Zucchini"].seedName = getPackageItemType(".ZucchiniSeed");
farming_vegetableconf.props["Zucchini"].seedPerVeg = 2;
farming_vegetableconf.props["Zucchini"].harvestSeedOnly = true;

farming_vegetableconf.sprite["Zucchini"] = {
	"vegetation_farming_01_64",
	"vegetation_farming_01_65",
	"vegetation_farming_01_66",
	"vegetation_farming_01_67",
	"vegetation_farming_01_67",
	"vegetation_farming_01_68",
	"vegetation_farming_01_69",
	"vegetation_farming_01_71"
}

farming_vegetableconf.growZucchini = farming_vegetableconf.growPlantUniversal


-- Pumpkin
-- Need 9 seeds
-- Need Water lvl over 70
-- Need 4 weeks to grow (112h per phase)
farming_vegetableconf.icons["Pumpkin"] = "Item_Pumpkin";

farming_vegetableconf.props["Pumpkin"] = {};
farming_vegetableconf.props["Pumpkin"].seedsRequired = 5;
farming_vegetableconf.props["Pumpkin"].texture = "rc_vegetation_farming_pumpkin_6";
farming_vegetableconf.props["Pumpkin"].waterLvl = 70;
farming_vegetableconf.props["Pumpkin"].timeToGrow = ZombRand(103, 117);
farming_vegetableconf.props["Pumpkin"].minVeg = 1;
farming_vegetableconf.props["Pumpkin"].maxVeg = 2;
farming_vegetableconf.props["Pumpkin"].minVegAutorized = 2;
farming_vegetableconf.props["Pumpkin"].maxVegAutorized = 3;
farming_vegetableconf.props["Pumpkin"].vegetableName = "Base.Pumpkin";
farming_vegetableconf.props["Pumpkin"].seedName = getPackageItemType(".PumpkinSeed");
farming_vegetableconf.props["Pumpkin"].seedPerVeg = 3;
farming_vegetableconf.props["Pumpkin"].harvestSeedOnly = true;

farming_vegetableconf.sprite["Pumpkin"] = {
	"rc_vegetation_farming_pumpkin_0",
	"rc_vegetation_farming_pumpkin_1",
	"rc_vegetation_farming_pumpkin_2",
	"rc_vegetation_farming_pumpkin_3",
	"rc_vegetation_farming_pumpkin_4",
	"rc_vegetation_farming_pumpkin_5",
	"rc_vegetation_farming_pumpkin_6",
	"rc_vegetation_farming_pumpkin_7"
}

farming_vegetableconf.growPumpkin = farming_vegetableconf.growPlantUniversal


-- Watermelon
-- Need 9 seeds
-- Need Water lvl over 70
-- Need 4 weeks to grow (112h per phase)
farming_vegetableconf.icons["Watermelon"] = "Item_Watermelon";

farming_vegetableconf.props["Watermelon"] = {};
farming_vegetableconf.props["Watermelon"].seedsRequired = 5;
farming_vegetableconf.props["Watermelon"].texture = "rc_vegetation_farming_watermelon_6";
farming_vegetableconf.props["Watermelon"].waterLvl = 70;
farming_vegetableconf.props["Watermelon"].timeToGrow = ZombRand(103, 117);
farming_vegetableconf.props["Watermelon"].minVeg = 1;
farming_vegetableconf.props["Watermelon"].maxVeg = 2;
farming_vegetableconf.props["Watermelon"].minVegAutorized = 2;
farming_vegetableconf.props["Watermelon"].maxVegAutorized = 3;
farming_vegetableconf.props["Watermelon"].vegetableName = "Base.Watermelon";
farming_vegetableconf.props["Watermelon"].seedName = getPackageItemType(".WatermelonSeed");
farming_vegetableconf.props["Watermelon"].seedPerVeg = 3;
farming_vegetableconf.props["Watermelon"].harvestSeedOnly = true;

farming_vegetableconf.sprite["Watermelon"] = {
	"rc_vegetation_farming_watermelon_0",
	"rc_vegetation_farming_watermelon_1",
	"rc_vegetation_farming_watermelon_2",
	"rc_vegetation_farming_watermelon_3",
	"rc_vegetation_farming_watermelon_4",
	"rc_vegetation_farming_watermelon_5",
	"rc_vegetation_farming_watermelon_6",
	"rc_vegetation_farming_watermelon_7"
}

farming_vegetableconf.growWatermelon = farming_vegetableconf.growPlantUniversal

-- Onion
-- Need 6 seeds
-- Need Water lvl over 65
-- Need 3 weeks (84h per phase)
farming_vegetableconf.icons["Onion"] = "Item_Onion";

farming_vegetableconf.props["Onion"] = {};
farming_vegetableconf.props["Onion"].seedsRequired = 6;
farming_vegetableconf.props["Onion"].texture = "vegetation_farming_01_53";
farming_vegetableconf.props["Onion"].waterLvl = 65;
farming_vegetableconf.props["Onion"].timeToGrow = ZombRand(89, 103);
farming_vegetableconf.props["Onion"].minVeg = 4;
farming_vegetableconf.props["Onion"].maxVeg = 5;
farming_vegetableconf.props["Onion"].minVegAutorized = 6;
farming_vegetableconf.props["Onion"].maxVegAutorized = 10;
farming_vegetableconf.props["Onion"].vegetableName = "Base.Onion";
farming_vegetableconf.props["Onion"].seedName = getPackageItemType(".OnionSeed");
farming_vegetableconf.props["Onion"].seedPerVeg = 2;

farming_vegetableconf.sprite["Onion"] = {
	"vegetation_farming_01_48",
	"vegetation_farming_01_49",
	"vegetation_farming_01_50",
	"vegetation_farming_01_51",
	"vegetation_farming_01_52",
	"vegetation_farming_01_54",
	"vegetation_farming_01_53",
	"vegetation_farming_01_55"
}

farming_vegetableconf.growOnion = farming_vegetableconf.growPlantUniversal



-- Lettuce
-- Need 9 seeds
-- Need Water lvl over 75
-- Need 2 weeks (48h per phase)
farming_vegetableconf.icons["Lettuce"] = "Item_Lettuce";

farming_vegetableconf.props["Lettuce"] = {};
farming_vegetableconf.props["Lettuce"].seedsRequired = 9;
farming_vegetableconf.props["Lettuce"].texture = "vegetation_farming_01_20";
farming_vegetableconf.props["Lettuce"].waterLvl = 75;
farming_vegetableconf.props["Lettuce"].timeToGrow = ZombRand(46, 52);
farming_vegetableconf.props["Lettuce"].minVeg = 4;
farming_vegetableconf.props["Lettuce"].maxVeg = 6;
farming_vegetableconf.props["Lettuce"].minVegAutorized = 9;
farming_vegetableconf.props["Lettuce"].maxVegAutorized = 11;
farming_vegetableconf.props["Lettuce"].vegetableName = "Base.Lettuce";
farming_vegetableconf.props["Lettuce"].seedName = getPackageItemType(".LettuceSeed");
farming_vegetableconf.props["Lettuce"].seedPerVeg = 3;

farming_vegetableconf.sprite["Lettuce"] = {
	"vegetation_farming_01_16",
	"vegetation_farming_01_17",
	"vegetation_farming_01_18",
	"vegetation_farming_01_18",
	"vegetation_farming_01_19",
	"vegetation_farming_01_19",
	"vegetation_farming_01_20",
	"vegetation_farming_01_23"
}

farming_vegetableconf.growLettuce = farming_vegetableconf.growPlantUniversal



-- Leek
-- Need 6 seeds
-- Need Water lvl 65
-- Grow in 17 days (52h per phase)
farming_vegetableconf.icons["Leek"] = "Item_Leek";

farming_vegetableconf.props["Leek"] = {};
farming_vegetableconf.props["Leek"].seedsRequired = 6;
farming_vegetableconf.props["Leek"].texture = "vegetation_farming_01_36";
farming_vegetableconf.props["Leek"].waterLvl = 65;
farming_vegetableconf.props["Leek"].timeToGrow = ZombRand(50, 55);
farming_vegetableconf.props["Leek"].minVeg = 6;
farming_vegetableconf.props["Leek"].maxVeg = 9;
farming_vegetableconf.props["Leek"].minVegAutorized = 6;
farming_vegetableconf.props["Leek"].maxVegAutorized = 10;
farming_vegetableconf.props["Leek"].vegetableName = "Base.Leek";
farming_vegetableconf.props["Leek"].seedName = getPackageItemType(".LeekSeed");
farming_vegetableconf.props["Leek"].seedPerVeg = 2;

farming_vegetableconf.sprite["Leek"] = {
	"vegetation_farming_01_32",
	"vegetation_farming_01_33",
	"vegetation_farming_01_34",
	"vegetation_farming_01_34",
	"vegetation_farming_01_35",
	"vegetation_farming_01_35",
	"vegetation_farming_01_36",
	"vegetation_farming_01_39"
}

farming_vegetableconf.growLeek = farming_vegetableconf.growPlantUniversal


-- Eggplant
-- Need 6 seeds
-- Need Water  lvl over 75
-- Need 3 weeks (84h per phase)
farming_vegetableconf.icons["Eggplant"] = "Item_Eggplant";

farming_vegetableconf.props["Eggplant"] = {};
farming_vegetableconf.props["Eggplant"].seedsRequired = 6;
farming_vegetableconf.props["Eggplant"].texture = "rc_vegetation_farming_eggplant_6";
farming_vegetableconf.props["Eggplant"].waterLvl = 75;
farming_vegetableconf.props["Eggplant"].timeToGrow = ZombRand(89, 103);
farming_vegetableconf.props["Eggplant"].minVeg = 4;
farming_vegetableconf.props["Eggplant"].maxVeg = 5;
farming_vegetableconf.props["Eggplant"].minVegAutorized = 6;
farming_vegetableconf.props["Eggplant"].maxVegAutorized = 10;
farming_vegetableconf.props["Eggplant"].vegetableName = "Base.Eggplant";
farming_vegetableconf.props["Eggplant"].seedName = getPackageItemType(".EggplantSeed");
farming_vegetableconf.props["Eggplant"].seedPerVeg = 2;

farming_vegetableconf.sprite["Eggplant"] = {
	"rc_vegetation_farming_eggplant_0",
	"rc_vegetation_farming_eggplant_1",
	"rc_vegetation_farming_eggplant_2",
	"rc_vegetation_farming_eggplant_3",
	"rc_vegetation_farming_eggplant_4",
	"rc_vegetation_farming_eggplant_5",
	"rc_vegetation_farming_eggplant_6",
	"rc_vegetation_farming_eggplant_7"
}

farming_vegetableconf.growEggplant = farming_vegetableconf.growPlantUniversal


-- Edamame
-- Need 6 seeds
-- Need Water lvl over 75
-- Need 3 weeks (84h per phase)
farming_vegetableconf.icons["Edamame"] = "Item_Edamame";

farming_vegetableconf.props["Edamame"] = {};
farming_vegetableconf.props["Edamame"].seedsRequired = 6;
farming_vegetableconf.props["Edamame"].texture = "vegetation_farming_01_68";
farming_vegetableconf.props["Edamame"].waterLvl = 75;
farming_vegetableconf.props["Edamame"].timeToGrow = ZombRand(89, 103);
farming_vegetableconf.props["Edamame"].minVeg = 4;
farming_vegetableconf.props["Edamame"].maxVeg = 5;
farming_vegetableconf.props["Edamame"].minVegAutorized = 6;
farming_vegetableconf.props["Edamame"].maxVegAutorized = 10;
farming_vegetableconf.props["Edamame"].vegetableName = "Base.Edamame";
farming_vegetableconf.props["Edamame"].seedName = getPackageItemType(".EdamameSeed");
farming_vegetableconf.props["Edamame"].seedPerVeg = 2;
farming_vegetableconf.props["Edamame"].harvestSeedOnly = true;

farming_vegetableconf.sprite["Edamame"] = {
	"vegetation_farming_01_64",
	"vegetation_farming_01_65",
	"vegetation_farming_01_66",
	"vegetation_farming_01_66",
	"vegetation_farming_01_67",
	"vegetation_farming_01_67",
	"vegetation_farming_01_68",
	"vegetation_farming_01_71"
}

farming_vegetableconf.growEdamame = farming_vegetableconf.growPlantUniversal


-- Daikon
-- Need 6 seeds
-- Need Water lvl between 65
-- Need 3 weeks (84h per phase)
farming_vegetableconf.icons["Daikon"] = "Item_Daikon";

farming_vegetableconf.props["Daikon"] = {};
farming_vegetableconf.props["Daikon"].seedsRequired = 6;
farming_vegetableconf.props["Daikon"].texture = "vegetation_farming_01_53";
farming_vegetableconf.props["Daikon"].waterLvl = 65;
farming_vegetableconf.props["Daikon"].timeToGrow = ZombRand(89, 103);
farming_vegetableconf.props["Daikon"].minVeg = 4;
farming_vegetableconf.props["Daikon"].maxVeg = 6;
farming_vegetableconf.props["Daikon"].minVegAutorized = 5;
farming_vegetableconf.props["Daikon"].maxVegAutorized = 9;
farming_vegetableconf.props["Daikon"].vegetableName = "Base.Daikon";
farming_vegetableconf.props["Daikon"].seedName = getPackageItemType(".DaikonSeed");
farming_vegetableconf.props["Daikon"].seedPerVeg = 2;

farming_vegetableconf.sprite["Daikon"] = {
	"vegetation_farming_01_48",
	"vegetation_farming_01_49",
	"vegetation_farming_01_50",
	"vegetation_farming_01_51",
	"vegetation_farming_01_52",
	"vegetation_farming_01_54",
	"vegetation_farming_01_53",
	"vegetation_farming_01_55"
}

farming_vegetableconf.growDaikon = farming_vegetableconf.growPlantUniversal


-- PepperJalapeno
-- Need 5 seeds
-- Need Water lvl over 75
-- Need 3 weeks (84h per phase)
farming_vegetableconf.icons["PepperJalapeno"] = "Item_PepperJalapeno";

farming_vegetableconf.props["PepperJalapeno"] = {};
farming_vegetableconf.props["PepperJalapeno"].seedsRequired = 5;
farming_vegetableconf.props["PepperJalapeno"].texture = "vegetation_farming_01_70";
farming_vegetableconf.props["PepperJalapeno"].waterLvl = 75;
farming_vegetableconf.props["PepperJalapeno"].timeToGrow = ZombRand(89, 103);
farming_vegetableconf.props["PepperJalapeno"].minVeg = 4;
farming_vegetableconf.props["PepperJalapeno"].maxVeg = 5;
farming_vegetableconf.props["PepperJalapeno"].minVegAutorized = 6;
farming_vegetableconf.props["PepperJalapeno"].maxVegAutorized = 10;
farming_vegetableconf.props["PepperJalapeno"].vegetableName = "Base.PepperJalapeno";
farming_vegetableconf.props["PepperJalapeno"].seedName = getPackageItemType(".PepperJalapenoSeed");
farming_vegetableconf.props["PepperJalapeno"].seedPerVeg = 2;
farming_vegetableconf.props["PepperJalapeno"].harvestSeedOnly = true;

farming_vegetableconf.sprite["PepperJalapeno"] = {
	"vegetation_farming_01_64",
	"vegetation_farming_01_65",
	"vegetation_farming_01_66",
	"vegetation_farming_01_67",
	"vegetation_farming_01_68",
	"vegetation_farming_01_69",
	"vegetation_farming_01_70",
	"vegetation_farming_01_71"
}

farming_vegetableconf.growPepperJalapeno = farming_vegetableconf.growPlantUniversal




-- PepperHabanero
-- Need 5 seeds
-- Need Water lvl over 75
-- Need 3 weeks (84h per phase)
farming_vegetableconf.icons["PepperHabanero"] = "Item_PepperHabanero";

farming_vegetableconf.props["PepperHabanero"] = {};
farming_vegetableconf.props["PepperHabanero"].seedsRequired = 5;
farming_vegetableconf.props["PepperHabanero"].texture = "vegetation_farming_01_70";
farming_vegetableconf.props["PepperHabanero"].waterLvl = 75;
farming_vegetableconf.props["PepperHabanero"].timeToGrow = ZombRand(89, 103);
farming_vegetableconf.props["PepperHabanero"].minVeg = 4;
farming_vegetableconf.props["PepperHabanero"].maxVeg = 5;
farming_vegetableconf.props["PepperHabanero"].minVegAutorized = 6;
farming_vegetableconf.props["PepperHabanero"].maxVegAutorized = 10;
farming_vegetableconf.props["PepperHabanero"].vegetableName = "Base.PepperHabanero";
farming_vegetableconf.props["PepperHabanero"].seedName = getPackageItemType(".PepperHabaneroSeed");
farming_vegetableconf.props["PepperHabanero"].seedPerVeg = 2;
farming_vegetableconf.props["PepperHabanero"].harvestSeedOnly = true;

farming_vegetableconf.sprite["PepperHabanero"] = {
	"vegetation_farming_01_64",
	"vegetation_farming_01_65",
	"vegetation_farming_01_66",
	"vegetation_farming_01_67",
	"vegetation_farming_01_68",
	"vegetation_farming_01_69",
	"vegetation_farming_01_70",
	"vegetation_farming_01_71"
}

farming_vegetableconf.growPepperHabanero = farming_vegetableconf.growPlantUniversal



-- BellPepper
-- Need 5 seeds
-- Need Water lvl over 75
-- Need 3 weeks (84h per phase)
farming_vegetableconf.icons["BellPepper"] = "Item_BellPepper";

farming_vegetableconf.props["BellPepper"] = {};
farming_vegetableconf.props["BellPepper"].seedsRequired = 5;
farming_vegetableconf.props["BellPepper"].texture = "vegetation_farming_01_70";
farming_vegetableconf.props["BellPepper"].waterLvl = 75;
farming_vegetableconf.props["BellPepper"].timeToGrow = ZombRand(89, 103);
farming_vegetableconf.props["BellPepper"].minVeg = 4;
farming_vegetableconf.props["BellPepper"].maxVeg = 5;
farming_vegetableconf.props["BellPepper"].minVegAutorized = 6;
farming_vegetableconf.props["BellPepper"].maxVegAutorized = 10;
farming_vegetableconf.props["BellPepper"].vegetableName = "Base.BellPepper";
farming_vegetableconf.props["BellPepper"].seedName = getPackageItemType(".BellPepperSeed");
farming_vegetableconf.props["BellPepper"].seedPerVeg = 2;
farming_vegetableconf.props["BellPepper"].harvestSeedOnly = true;

farming_vegetableconf.sprite["BellPepper"] = {
	"vegetation_farming_01_64",
	"vegetation_farming_01_65",
	"vegetation_farming_01_66",
	"vegetation_farming_01_67",
	"vegetation_farming_01_68",
	"vegetation_farming_01_69",
	"vegetation_farming_01_70",
	"vegetation_farming_01_71"
}

farming_vegetableconf.growBellPepper = farming_vegetableconf.growPlantUniversal


-- Apple
-- Need 6 seeds
-- Need Water lvl over 80
-- Need 4 weeks (112h per phase)
farming_vegetableconf.icons["Apple"] = "Item_Apple";

farming_vegetableconf.props["Apple"] = {};
farming_vegetableconf.props["Apple"].seedsRequired = 12;
farming_vegetableconf.props["Apple"].texture = "rc_vegetation_farming_apple_6";
farming_vegetableconf.props["Apple"].waterLvl = 80;
farming_vegetableconf.props["Apple"].timeToGrow = ZombRand(103, 117);
farming_vegetableconf.props["Apple"].minVeg = 6;
farming_vegetableconf.props["Apple"].maxVeg = 12;
farming_vegetableconf.props["Apple"].minVegAutorized = 8;
farming_vegetableconf.props["Apple"].maxVegAutorized = 16;
farming_vegetableconf.props["Apple"].vegetableName = "Base.Apple";
farming_vegetableconf.props["Apple"].seedName = getPackageItemType(".AppleSeed");
farming_vegetableconf.props["Apple"].seedPerVeg = 2;
farming_vegetableconf.props["Apple"].harvestSeedOnly = true;

farming_vegetableconf.sprite["Apple"] = {
	"rc_vegetation_farming_apple_0",
	"rc_vegetation_farming_apple_1",
	"rc_vegetation_farming_apple_2",
	"rc_vegetation_farming_apple_3",
	"rc_vegetation_farming_apple_4",
	"rc_vegetation_farming_apple_5",
	"rc_vegetation_farming_apple_6",
	"rc_vegetation_farming_apple_7"
}

farming_vegetableconf.growApple = farming_vegetableconf.growPlantUniversal


-- Banana
-- Need 4 seeds
-- Need Water lvl over 80
-- Need 3 weeks (84h per phase)
farming_vegetableconf.icons["Banana"] = "Item_Banana";

farming_vegetableconf.props["Banana"] = {};
farming_vegetableconf.props["Banana"].seedsRequired = 10;
farming_vegetableconf.props["Banana"].texture = "rc_vegetation_farming_banana_6";
farming_vegetableconf.props["Banana"].waterLvl = 80;
farming_vegetableconf.props["Banana"].timeToGrow = ZombRand(89, 103);
farming_vegetableconf.props["Banana"].minVeg = 5;
farming_vegetableconf.props["Banana"].maxVeg = 10;
farming_vegetableconf.props["Banana"].minVegAutorized = 8;
farming_vegetableconf.props["Banana"].maxVegAutorized = 16;
farming_vegetableconf.props["Banana"].vegetableName = "Base.Banana";
farming_vegetableconf.props["Banana"].seedName = getPackageItemType(".BananaSeed");
farming_vegetableconf.props["Banana"].seedPerVeg = 2;

farming_vegetableconf.sprite["Banana"] = {
	"rc_vegetation_farming_banana_0",
	"rc_vegetation_farming_banana_1",
	"rc_vegetation_farming_banana_2",
	"rc_vegetation_farming_banana_3",
	"rc_vegetation_farming_banana_4",
	"rc_vegetation_farming_banana_5",
	"rc_vegetation_farming_banana_6",
	"rc_vegetation_farming_banana_7"
}

farming_vegetableconf.growBanana = farming_vegetableconf.growPlantUniversal


-- Grapefruit
-- Need 6 seeds
-- Need Water lvl over 80
-- Need 4 weeks (112h per phase)
farming_vegetableconf.icons["Grapefruit"] = "Item_Grapefruit";

farming_vegetableconf.props["Grapefruit"] = {};
farming_vegetableconf.props["Grapefruit"].seedsRequired = 12;
farming_vegetableconf.props["Grapefruit"].texture = "rc_vegetation_farming_grapefruit_6";
farming_vegetableconf.props["Grapefruit"].waterLvl = 80;
farming_vegetableconf.props["Grapefruit"].timeToGrow = ZombRand(103, 117);
farming_vegetableconf.props["Grapefruit"].minVeg = 6;
farming_vegetableconf.props["Grapefruit"].maxVeg = 12;
farming_vegetableconf.props["Grapefruit"].minVegAutorized = 8;
farming_vegetableconf.props["Grapefruit"].maxVegAutorized = 16;
farming_vegetableconf.props["Grapefruit"].vegetableName = "Base.Grapefruit";
farming_vegetableconf.props["Grapefruit"].seedName = getPackageItemType(".GrapefruitSeed");
farming_vegetableconf.props["Grapefruit"].seedPerVeg = 2;
farming_vegetableconf.props["Grapefruit"].harvestSeedOnly = true;

farming_vegetableconf.sprite["Grapefruit"] = {
	"rc_vegetation_farming_grapefruit_0",
	"rc_vegetation_farming_grapefruit_1",
	"rc_vegetation_farming_grapefruit_2",
	"rc_vegetation_farming_grapefruit_3",
	"rc_vegetation_farming_grapefruit_4",
	"rc_vegetation_farming_grapefruit_5",
	"rc_vegetation_farming_grapefruit_6",
	"rc_vegetation_farming_grapefruit_7"
}

farming_vegetableconf.growGrapefruit = farming_vegetableconf.growPlantUniversal


-- Grapes
-- Need 12 seeds
-- Need Water lvl betwwen 70 - 85
-- Need 4 weeks (112h per phase)
farming_vegetableconf.icons["Grapes"] = "Item_Grapes";

farming_vegetableconf.props["Grapes"] = {};
farming_vegetableconf.props["Grapes"].seedsRequired = 10;
farming_vegetableconf.props["Grapes"].texture = "rc_vegetation_farming_grapes_6";
farming_vegetableconf.props["Grapes"].waterLvl = 70;
farming_vegetableconf.props["Grapes"].waterLvlMax = 85;
farming_vegetableconf.props["Grapes"].timeToGrow = ZombRand(103, 117);
farming_vegetableconf.props["Grapes"].minVeg = 5;
farming_vegetableconf.props["Grapes"].maxVeg = 12;
farming_vegetableconf.props["Grapes"].minVegAutorized = 8;
farming_vegetableconf.props["Grapes"].maxVegAutorized = 16;
farming_vegetableconf.props["Grapes"].vegetableName = "Base.Grapes";
farming_vegetableconf.props["Grapes"].seedName = getPackageItemType(".GrapesSeed");
farming_vegetableconf.props["Grapes"].seedPerVeg = 2;
farming_vegetableconf.props["Grapes"].harvestSeedOnly = true;

farming_vegetableconf.sprite["Grapes"] = {
	"rc_vegetation_farming_grapes_0",
	"rc_vegetation_farming_grapes_1",
	"rc_vegetation_farming_grapes_2",
	"rc_vegetation_farming_grapes_3",
	"rc_vegetation_farming_grapes_4",
	"rc_vegetation_farming_grapes_5",
	"rc_vegetation_farming_grapes_6",
	"rc_vegetation_farming_grapes_7"
}

farming_vegetableconf.growGrapes = farming_vegetableconf.growPlantUniversal


-- Lemon
-- Need 12 seeds
-- Need Water lvl over 80
-- Need 3 weeks (84h per phase)
farming_vegetableconf.icons["Lemon"] = "Item_Lemon";

farming_vegetableconf.props["Lemon"] = {};
farming_vegetableconf.props["Lemon"].seedsRequired = 12;
farming_vegetableconf.props["Lemon"].texture = "rc_vegetation_farming_lemon_6";
farming_vegetableconf.props["Lemon"].waterLvl = 80;
farming_vegetableconf.props["Lemon"].timeToGrow = ZombRand(89, 103);
farming_vegetableconf.props["Lemon"].minVeg = 6;
farming_vegetableconf.props["Lemon"].maxVeg = 12;
farming_vegetableconf.props["Lemon"].minVegAutorized = 8;
farming_vegetableconf.props["Lemon"].maxVegAutorized = 16;
farming_vegetableconf.props["Lemon"].vegetableName = "Base.Lemon";
farming_vegetableconf.props["Lemon"].seedName = getPackageItemType(".LemonSeed");
farming_vegetableconf.props["Lemon"].seedPerVeg = 2;
farming_vegetableconf.props["Lemon"].harvestSeedOnly = true;

farming_vegetableconf.sprite["Lemon"] = {
	"rc_vegetation_farming_lemon_0",
	"rc_vegetation_farming_lemon_1",
	"rc_vegetation_farming_lemon_2",
	"rc_vegetation_farming_lemon_3",
	"rc_vegetation_farming_lemon_4",
	"rc_vegetation_farming_lemon_5",
	"rc_vegetation_farming_lemon_6",
	"rc_vegetation_farming_lemon_7"
}

farming_vegetableconf.growLemon = farming_vegetableconf.growPlantUniversal


-- Orange
-- Need 12 seeds
-- Need Water lvl over 80
-- Need 4 weeks (84h per phase)
farming_vegetableconf.icons["Orange"] = "Item_Orange";

farming_vegetableconf.props["Orange"] = {};
farming_vegetableconf.props["Orange"].seedsRequired = 12;
farming_vegetableconf.props["Orange"].texture = "rc_vegetation_farming_orange_6";
farming_vegetableconf.props["Orange"].waterLvl = 80;
farming_vegetableconf.props["Orange"].timeToGrow = ZombRand(103, 117);
farming_vegetableconf.props["Orange"].minVeg = 6;
farming_vegetableconf.props["Orange"].maxVeg = 10;
farming_vegetableconf.props["Orange"].minVegAutorized = 8;
farming_vegetableconf.props["Orange"].maxVegAutorized = 16;
farming_vegetableconf.props["Orange"].vegetableName = "Base.Orange";
farming_vegetableconf.props["Orange"].seedName = getPackageItemType(".OrangeSeed");
farming_vegetableconf.props["Orange"].seedPerVeg = 2;
farming_vegetableconf.props["Orange"].harvestSeedOnly = true;

farming_vegetableconf.sprite["Orange"] = {
	"rc_vegetation_farming_orange_0",
	"rc_vegetation_farming_orange_1",
	"rc_vegetation_farming_orange_2",
	"rc_vegetation_farming_orange_3",
	"rc_vegetation_farming_orange_4",
	"rc_vegetation_farming_orange_5",
	"rc_vegetation_farming_orange_6",
	"rc_vegetation_farming_orange_7"
}

farming_vegetableconf.growOrange = farming_vegetableconf.growPlantUniversal


-- Peach
-- Need 10 seeds
-- Need Water lvl over 80
-- Need 4 weeks (84h per phase)
farming_vegetableconf.icons["Peach"] = "Item_Peach";

farming_vegetableconf.props["Peach"] = {};
farming_vegetableconf.props["Peach"].seedsRequired = 10;
farming_vegetableconf.props["Peach"].texture = "rc_vegetation_farming_peach_6";
farming_vegetableconf.props["Peach"].waterLvl = 80;
farming_vegetableconf.props["Peach"].timeToGrow = ZombRand(103, 117);
farming_vegetableconf.props["Peach"].minVeg = 5;
farming_vegetableconf.props["Peach"].maxVeg = 10;
farming_vegetableconf.props["Peach"].minVegAutorized = 8;
farming_vegetableconf.props["Peach"].maxVegAutorized = 16;
farming_vegetableconf.props["Peach"].vegetableName = "Base.Peach";
farming_vegetableconf.props["Peach"].seedName = getPackageItemType(".PeachSeed");
farming_vegetableconf.props["Peach"].seedPerVeg = 2;
farming_vegetableconf.props["Peach"].harvestSeedOnly = true;

farming_vegetableconf.sprite["Peach"] = {
	"rc_vegetation_farming_peach_0",
	"rc_vegetation_farming_peach_1",
	"rc_vegetation_farming_peach_2",
	"rc_vegetation_farming_peach_3",
	"rc_vegetation_farming_peach_4",
	"rc_vegetation_farming_peach_5",
	"rc_vegetation_farming_peach_6",
	"rc_vegetation_farming_peach_7"
}

farming_vegetableconf.growPeach = farming_vegetableconf.growPlantUniversal

