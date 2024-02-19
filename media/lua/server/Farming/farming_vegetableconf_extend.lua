require "Farming/SFarmingSystem"
require "Farming/farming_vegetableconf"


-- Corn
-- Need 6 seeds
-- Water lvl over 70
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
farming_vegetableconf.props["Corn"].seedName = "RavenCraft.CornSeed";
farming_vegetableconf.props["Corn"].seedPerVeg = 3;

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

farming_vegetableconf.growCorn = farming_vegetableconf.growCabbage


-- Peanuts 
-- Need 6 seeds
-- Water lvl over 65
-- Need 3 weeks (84h per phase)
farming_vegetableconf.icons["Peanuts"] = "Item_Peanut";

farming_vegetableconf.props["Peanuts"] = {};
farming_vegetableconf.props["Peanuts"].seedsRequired = 6;
farming_vegetableconf.props["Peanuts"].texture = "vegetation_farming_01_45";
farming_vegetableconf.props["Peanuts"].waterLvl = 65;
farming_vegetableconf.props["Peanuts"].timeToGrow = ZombRand(89, 103);
farming_vegetableconf.props["Peanuts"].minVeg = 3;
farming_vegetableconf.props["Peanuts"].maxVeg = 4;
farming_vegetableconf.props["Peanuts"].minVegAutorized = 5;
farming_vegetableconf.props["Peanuts"].maxVegAutorized = 9;
farming_vegetableconf.props["Peanuts"].vegetableName = "Base.Peanuts";
farming_vegetableconf.props["Peanuts"].seedName = "RavenCraft.PeanutsSeed";
farming_vegetableconf.props["Peanuts"].seedPerVeg = 3;

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


farming_vegetableconf.growPeanuts = farming_vegetableconf.growPotato


-- Wheat
-- Need 9 seeds
-- Water lvl over 85
-- Need 4 weeks to grow (112h per phase)
farming_vegetableconf.icons["Wheat"] = "Item_Wheat";

farming_vegetableconf.props["Wheat"] = {};
farming_vegetableconf.props["Wheat"].seedsRequired = 9;
farming_vegetableconf.props["Wheat"].texture = "vegetation_farming_01_76";
farming_vegetableconf.props["Wheat"].timeToGrow = ZombRand(103, 117);
farming_vegetableconf.props["Wheat"].waterLvl = 85;
farming_vegetableconf.props["Wheat"].minVeg = 6;
farming_vegetableconf.props["Wheat"].maxVeg = 12;
farming_vegetableconf.props["Wheat"].minVegAutorized = 12;
farming_vegetableconf.props["Wheat"].maxVegAutorized = 24;
farming_vegetableconf.props["Wheat"].vegetableName = "RavenCraft.Wheat";
farming_vegetableconf.props["Wheat"].seedName = "RavenCraft.WheatSeed";
farming_vegetableconf.props["Wheat"].seedPerVeg = 2;

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

farming_vegetableconf.growWheat = farming_vegetableconf.growCabbage


-- Zucchini
-- Need 4 seeds
-- Water lvl over 75
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
farming_vegetableconf.props["Zucchini"].seedName = "RavenCraft.ZucchiniSeed";
farming_vegetableconf.props["Zucchini"].seedPerVeg = 2;

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

farming_vegetableconf.growZucchini = farming_vegetableconf.growTomato


-- Pumpkin
-- Need 9 seeds
-- Water lvl over 70
-- Need 4 weeks to grow (112h per phase)
farming_vegetableconf.icons["Pumpkin"] = "Item_Pumpkin";

farming_vegetableconf.props["Pumpkin"] = {};
farming_vegetableconf.props["Pumpkin"].seedsRequired = 9;
farming_vegetableconf.props["Pumpkin"].texture = "vegetation_farming_01_29";
farming_vegetableconf.props["Pumpkin"].waterLvl = 70;
farming_vegetableconf.props["Pumpkin"].timeToGrow = ZombRand(103, 117);
farming_vegetableconf.props["Pumpkin"].minVeg = 1;
farming_vegetableconf.props["Pumpkin"].maxVeg = 2;
farming_vegetableconf.props["Pumpkin"].minVegAutorized = 5;
farming_vegetableconf.props["Pumpkin"].maxVegAutorized = 6;
farming_vegetableconf.props["Pumpkin"].vegetableName = "Base.Pumpkin";
farming_vegetableconf.props["Pumpkin"].seedName = "RavenCraft.PumpkinSeed";
farming_vegetableconf.props["Pumpkin"].seedPerVeg = 12;

farming_vegetableconf.sprite["Pumpkin"] = {
	"vegetation_farming_01_24",
	"vegetation_farming_01_25",
	"vegetation_farming_01_26",
	"vegetation_farming_01_27",
	"vegetation_farming_01_28",
	"vegetation_farming_01_30",
	"vegetation_farming_01_29",
	"vegetation_farming_01_31"
}

farming_vegetableconf.growPumpkin = farming_vegetableconf.growBroccoli



-- Onion
-- Need 6 seeds
-- Need water lvl between 45 and 85
-- Need 3 weeks (84h per phase)
farming_vegetableconf.icons["Onion"] = "Item_Onion";

farming_vegetableconf.props["Onion"] = {};
farming_vegetableconf.props["Onion"].seedsRequired = 6;
farming_vegetableconf.props["Onion"].texture = "vegetation_farming_01_53";
farming_vegetableconf.props["Onion"].waterLvl = 45;
farming_vegetableconf.props["Onion"].waterLvlMax = 85;
farming_vegetableconf.props["Onion"].timeToGrow = ZombRand(89, 103);
farming_vegetableconf.props["Onion"].minVeg = 1;
farming_vegetableconf.props["Onion"].maxVeg = 2;
farming_vegetableconf.props["Onion"].minVegAutorized = 5;
farming_vegetableconf.props["Onion"].maxVegAutorized = 6;
farming_vegetableconf.props["Onion"].vegetableName = "Base.Onion";
farming_vegetableconf.props["Onion"].seedName = "RavenCraft.OnionSeed";
farming_vegetableconf.props["Onion"].seedPerVeg = 12;

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

farming_vegetableconf.growOnion = farming_vegetableconf.growRedRadish



-- Lettuce
-- Need 6 seeds
-- Water lvl over 85
-- Need 2 weeks (48h per phase)
farming_vegetableconf.icons["Lettuce"] = "Item_Lettuce";

farming_vegetableconf.props["Lettuce"] = {};
farming_vegetableconf.props["Lettuce"].seedsRequired = 9;
farming_vegetableconf.props["Lettuce"].texture = "vegetation_farming_01_22";
farming_vegetableconf.props["Lettuce"].waterLvl = 85;
farming_vegetableconf.props["Lettuce"].timeToGrow = ZombRand(46, 52);
farming_vegetableconf.props["Lettuce"].minVeg = 4;
farming_vegetableconf.props["Lettuce"].maxVeg = 6;
farming_vegetableconf.props["Lettuce"].minVegAutorized = 9;
farming_vegetableconf.props["Lettuce"].maxVegAutorized = 11;
farming_vegetableconf.props["Lettuce"].vegetableName = "Base.Lettuce";
farming_vegetableconf.props["Lettuce"].seedName = "RavenCraft.LettuceSeed";
farming_vegetableconf.props["Lettuce"].seedPerVeg = 3;

farming_vegetableconf.sprite["Lettuce"] = {
	"vegetation_farming_01_16",
	"vegetation_farming_01_17",
	"vegetation_farming_01_18",
	"vegetation_farming_01_19",
	"vegetation_farming_01_20",
	"vegetation_farming_01_22",
	"vegetation_farming_01_21",
	"vegetation_farming_01_23"
}

farming_vegetableconf.growLettuce = farming_vegetableconf.growCabbage



-- Leek
-- Need 6 seeds
-- Need water lvl between 55 and 100
-- Grow in 17 days (52h per phase)
farming_vegetableconf.icons["Leek"] = "Item_Leek";

farming_vegetableconf.props["Leek"] = {};
farming_vegetableconf.props["Leek"].seedsRequired = 6;
farming_vegetableconf.props["Leek"].texture = "vegetation_farming_01_37";
farming_vegetableconf.props["Leek"].waterLvl = 55;
farming_vegetableconf.props["Leek"].waterLvlMax = 100;
farming_vegetableconf.props["Leek"].timeToGrow = ZombRand(50, 55);
farming_vegetableconf.props["Leek"].minVeg = 6;
farming_vegetableconf.props["Leek"].maxVeg = 9;
farming_vegetableconf.props["Leek"].minVegAutorized = 12;
farming_vegetableconf.props["Leek"].maxVegAutorized = 24;
farming_vegetableconf.props["Leek"].vegetableName = "Base.Leek";
farming_vegetableconf.props["Leek"].seedName = "RavenCraft.LeekSeed";
farming_vegetableconf.props["Leek"].seedPerVeg = 3;

farming_vegetableconf.sprite["Leek"] = {
	"vegetation_farming_01_32",
	"vegetation_farming_01_33",
	"vegetation_farming_01_34",
	"vegetation_farming_01_35",
	"vegetation_farming_01_35",
	"vegetation_farming_01_36",
	"vegetation_farming_01_37",
	"vegetation_farming_01_39"
}

farming_vegetableconf.growLeek = farming_vegetableconf.growCarrots


-- Eggplant
-- Need 6 seeds
-- Water lvl over 75
-- Need 3 weeks (84h per phase)
farming_vegetableconf.icons["Eggplant"] = "Item_Eggplant";

farming_vegetableconf.props["Eggplant"] = {};
farming_vegetableconf.props["Eggplant"].seedsRequired = 6;
farming_vegetableconf.props["Eggplant"].texture = "vegetation_farming_01_69";
farming_vegetableconf.props["Eggplant"].waterLvl = 75;
farming_vegetableconf.props["Eggplant"].timeToGrow = ZombRand(89, 103);
farming_vegetableconf.props["Eggplant"].minVeg = 4;
farming_vegetableconf.props["Eggplant"].maxVeg = 5;
farming_vegetableconf.props["Eggplant"].minVegAutorized = 6;
farming_vegetableconf.props["Eggplant"].maxVegAutorized = 10;
farming_vegetableconf.props["Eggplant"].vegetableName = "Base.Eggplant";
farming_vegetableconf.props["Eggplant"].seedName = "RavenCraft.EggplantSeed";
farming_vegetableconf.props["Eggplant"].seedPerVeg = 2;

farming_vegetableconf.sprite["Eggplant"] = {
	"vegetation_farming_01_64",
	"vegetation_farming_01_65",
	"vegetation_farming_01_66",
	"vegetation_farming_01_66",
	"vegetation_farming_01_67",
	"vegetation_farming_01_68",
	"vegetation_farming_01_69",
	"vegetation_farming_01_71"
}

farming_vegetableconf.growEggplant = farming_vegetableconf.growTomato


-- Edamame
-- Need 6 seeds
-- Water lvl over 75
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
farming_vegetableconf.props["Edamame"].seedName = "RavenCraft.EdamameSeed";
farming_vegetableconf.props["Edamame"].seedPerVeg = 2;

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

farming_vegetableconf.growEdamame = farming_vegetableconf.growTomato


-- Daikon
-- Need 6 seeds
-- Need water lvl between 55 and 100
-- Need 3 weeks (84h per phase)
farming_vegetableconf.icons["Daikon"] = "Item_Daikon";

farming_vegetableconf.props["Daikon"] = {};
farming_vegetableconf.props["Daikon"].seedsRequired = 6;
farming_vegetableconf.props["Daikon"].texture = "vegetation_farming_01_53";
farming_vegetableconf.props["Daikon"].waterLvl = 55;
farming_vegetableconf.props["Daikon"].waterLvlMax = 85;
farming_vegetableconf.props["Daikon"].timeToGrow = ZombRand(89, 103);
farming_vegetableconf.props["Daikon"].minVeg = 4;
farming_vegetableconf.props["Daikon"].maxVeg = 9;
farming_vegetableconf.props["Daikon"].minVegAutorized = 11;
farming_vegetableconf.props["Daikon"].maxVegAutorized = 15;
farming_vegetableconf.props["Daikon"].vegetableName = "Base.Daikon";
farming_vegetableconf.props["Daikon"].seedName = "RavenCraft.DaikonSeed";
farming_vegetableconf.props["Daikon"].seedPerVeg = 4;

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

farming_vegetableconf.growDaikon = farming_vegetableconf.growRedRadish


-- PepperJalapeno
-- Need 5 seeds
-- Water lvl over 75
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
farming_vegetableconf.props["PepperJalapeno"].seedName = "RavenCraft.PepperJalapenoSeed";
farming_vegetableconf.props["PepperJalapeno"].seedPerVeg = 2;

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

farming_vegetableconf.growPepperJalapeno = farming_vegetableconf.growTomato



-- PepperHabanero
-- Need 5 seeds
-- Water lvl over 75
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
farming_vegetableconf.props["PepperHabanero"].seedName = "RavenCraft.PepperHabaneroSeed";
farming_vegetableconf.props["PepperHabanero"].seedPerVeg = 2;

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

farming_vegetableconf.growPepperHabanero = farming_vegetableconf.growTomato



-- BellPepper
-- Need 5 seeds
-- Water lvl over 75
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
farming_vegetableconf.props["BellPepper"].seedName = "RavenCraft.BellPepperSeed";
farming_vegetableconf.props["BellPepper"].seedPerVeg = 2;

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

farming_vegetableconf.growBellPepper = farming_vegetableconf.growTomato


-- BellPepper
-- Need 5 seeds
-- Water lvl over 75
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
farming_vegetableconf.props["BellPepper"].seedName = "RavenCraft.BellPepperSeed";
farming_vegetableconf.props["BellPepper"].seedPerVeg = 2;

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

farming_vegetableconf.growBellPepper = farming_vegetableconf.growTomato