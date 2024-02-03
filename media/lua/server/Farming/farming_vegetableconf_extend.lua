require "Farming/SFarmingSystem"
require "Farming/farming_vegetableconf"


-- Corn
farming_vegetableconf.icons["Corn"] = "Item_Corn";

farming_vegetableconf.props["Corn"] = {};
farming_vegetableconf.props["Corn"].seedsRequired = 6;
farming_vegetableconf.props["Corn"].texture = "vegetation_farming_01_78";
farming_vegetableconf.props["Corn"].timeToGrow = ZombRand(85, 100);
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

-- Need 4 seeds
-- Water lvl over 70
-- Need 3 weeks (90h per phase)
farming_vegetableconf.growCorn = function(planting, nextGrowing, updateNbOfGrow)
	local nbOfGrow = planting.nbOfGrow;
	local water = farming_vegetableconf.calcWater(planting.waterNeeded, planting.waterLvl);
	local diseaseLvl = farming_vegetableconf.calcDisease(planting.mildewLvl);
	if(nbOfGrow == 0) then -- young
		planting = growNext(planting, farming_vegetableconf.getSpriteName(planting), farming_vegetableconf.getObjectName(planting), nextGrowing, farming_vegetableconf.props[planting.typeOfSeed].timeToGrow + water + diseaseLvl);
		planting.waterNeeded = 75;
	elseif (nbOfGrow <= 4) then -- young
		if(water >= 0 and diseaseLvl >= 0) then
			planting = growNext(planting, farming_vegetableconf.getSpriteName(planting), farming_vegetableconf.getObjectName(planting), nextGrowing, farming_vegetableconf.props[planting.typeOfSeed].timeToGrow + water + diseaseLvl);
			planting.waterNeeded = farming_vegetableconf.props[planting.typeOfSeed].waterLvl;
			planting.waterNeededMax = farming_vegetableconf.props[planting.typeOfSeed].waterLvlMax;
		else
			badPlant(water, nil, diseaseLvl, planting, nextGrowing, updateNbOfGrow);
		end
	elseif (nbOfGrow == 5) then -- mature
		if(water >= 0 and diseaseLvl >= 0) then
			planting.nextGrowing = calcNextGrowing(nextGrowing, farming_vegetableconf.props[planting.typeOfSeed].timeToGrow + water + diseaseLvl);
			planting:setObjectName(farming_vegetableconf.getObjectName(planting))
			planting:setSpriteName(farming_vegetableconf.getSpriteName(planting))
			planting.hasVegetable = true;
		else
			badPlant(water, nil, diseaseLvl, planting, nextGrowing, updateNbOfGrow);
		end
	elseif (nbOfGrow == 6) then -- mature with seed
		if(water >= 0 and diseaseLvl >= 0) then
			planting.nextGrowing = calcNextGrowing(nextGrowing, 60);
			planting:setObjectName(farming_vegetableconf.getObjectName(planting))
			planting:setSpriteName(farming_vegetableconf.getSpriteName(planting))
			planting.hasVegetable = true;
			planting.hasSeed = true;
		else
			badPlant(water, nil, diseaseLvl, planting, nextGrowing, updateNbOfGrow);
		end
	elseif (planting.state ~= "rotten") then -- rotten
		planting:rottenThis()
	end
	return planting;
end

local spray = getScriptManager():FindItem("farming.GardeningSprayCigarettes"):getDisplayName();
print(spray)

-- Wheat
farming_vegetableconf.icons["Wheat"] = "Item_Wheat";

farming_vegetableconf.props["Wheat"] = {};
farming_vegetableconf.props["Wheat"].seedsRequired = 5;
farming_vegetableconf.props["Wheat"].texture = "vegetation_farming_01_76";
farming_vegetableconf.props["Wheat"].timeToGrow = ZombRand(46, 52);
farming_vegetableconf.props["Wheat"].waterLvl = 70;
farming_vegetableconf.props["Wheat"].minVeg = 6;
farming_vegetableconf.props["Wheat"].maxVeg = 12;
farming_vegetableconf.props["Wheat"].minVegAutorized = 12;
farming_vegetableconf.props["Wheat"].maxVegAutorized = 24;
farming_vegetableconf.props["Wheat"].vegetableName = "RavenCraft.Wheat";
farming_vegetableconf.props["Wheat"].seedName = "RavenCraft.WheatSeed";
farming_vegetableconf.props["Wheat"].seedPerVeg = 1;

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

-- need 6 seeds
-- need to have more than 70 water lvl
-- need 4 weeks (112 hours per phase)
farming_vegetableconf.growWheat = function(planting, nextGrowing, updateNbOfGrow)
	local nbOfGrow = planting.nbOfGrow;
	local water = farming_vegetableconf.calcWater(planting.waterNeeded, planting.waterLvl);
	local diseaseLvl = farming_vegetableconf.calcDisease(planting.mildewLvl);
	if (nbOfGrow <= 0) then -- seed
		nbOfGrow = 0;
		planting.nbOfGrow = 0;
		planting = growNext(planting, farming_vegetableconf.getSpriteName(planting), farming_vegetableconf.getObjectName(planting), nextGrowing, (farming_vegetableconf.props[planting.typeOfSeed].timeToGrow * 0.5) + water + diseaseLvl);
		planting.waterNeeded = 75;
	elseif (nbOfGrow <= 4) then -- young
		if(water >= 0 and diseaseLvl >= 0) then
			planting = growNext(planting, farming_vegetableconf.getSpriteName(planting), farming_vegetableconf.getObjectName(planting), nextGrowing, (farming_vegetableconf.props[planting.typeOfSeed].timeToGrow * 1.5) + water + diseaseLvl);
			planting.waterNeeded = farming_vegetableconf.props[planting.typeOfSeed].waterLvl;
		else
			badPlant(water, nil, diseaseLvl, planting, nextGrowing, updateNbOfGrow);
		end
	elseif (nbOfGrow == 5) then -- mature
		if(water >= 0 and diseaseLvl >= 0) then
			planting.nextGrowing = calcNextGrowing(nextGrowing, (farming_vegetableconf.props[planting.typeOfSeed].timeToGrow * 2) + water + diseaseLvl);
			planting:setObjectName(farming_vegetableconf.getObjectName(planting))
			planting:setSpriteName(farming_vegetableconf.getSpriteName(planting))
		else
			badPlant(water, nil, diseaseLvl, planting, nextGrowing, updateNbOfGrow);
		end
	elseif (nbOfGrow == 6) then -- mature with seed
		if(water >= 0) then
			planting.nextGrowing = calcNextGrowing(nextGrowing, 120);
			planting:setObjectName(farming_vegetableconf.getObjectName(planting))
			planting:setSpriteName(farming_vegetableconf.getSpriteName(planting))
			planting.hasVegetable = true;
			planting.hasSeed = true;
		else
			badPlant(water, nil, diseaseLvl, planting, nextGrowing, updateNbOfGrow);
		end
	elseif (planting.state ~= "rotten") then -- rotten
		planting:rottenThis()
	end
	return planting;
end