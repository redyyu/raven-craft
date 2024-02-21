require "Farming/ScavengeDefinition";

local forest_scrapmetal = {};
forest_scrapmetal.type = "Base.ScrapMetal";
forest_scrapmetal.minCount = 1;
forest_scrapmetal.maxCount = 2;
forest_scrapmetal.skill = 6;

table.insert(scavenges.forestGoods, forest_scrapmetal);

