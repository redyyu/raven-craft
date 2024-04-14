--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

-- Locations must be declared in render-order.
-- Location IDs must match BodyLocation= and CanBeEquipped= values in items.txt.
local group = BodyLocations.getGroup("Human")

group:getOrCreateLocation("TorsoRig")

group:getOrCreateLocation("ArmorArms")
group:getOrCreateLocation("ArmorLegs")
group:getOrCreateLocation("ArmorShoulder")
group:getOrCreateLocation("ArmorHands")
group:getOrCreateLocation("ArmorNeck")

group:getOrCreateLocation("ArmorFull")

group:setExclusive("ArmorFull", "ArmorArms")
group:setExclusive("ArmorFull", "ArmorLegs")
group:setExclusive("ArmorFull", "ArmorShoulder")
group:setExclusive("ArmorFull", "ArmorHands")
group:setExclusive("ArmorFull", "ArmorNeck")

group:getOrCreateLocation("TightMask")  -- for some mask wearing with FullHat, Masks or Glasses.

group:setHideModel("BathRobe", "ArmorFull")
group:setHideModel("BathRobe", "ArmorArms")
group:setHideModel("BathRobe", "ArmorLegs")
group:setHideModel("BathRobe", "ArmorShoulder")
group:setHideModel("BathRobe", "ArmorHands")
group:setHideModel("BathRobe", "ArmorNeck")

group:setHideModel("FullSuitHead", "ArmorFull")
group:setHideModel("FullSuitHead", "ArmorArms")
group:setHideModel("FullSuitHead", "ArmorLegs")
group:setHideModel("FullSuitHead", "ArmorShoulder")
group:setHideModel("FullSuitHead", "ArmorHands")
group:setHideModel("FullSuitHead", "ArmorNeck")

group:setHideModel("FullSuit", "ArmorFull")
group:setHideModel("FullSuit", "ArmorArms")
group:setHideModel("FullSuit", "ArmorLegs")
group:setHideModel("FullSuit", "ArmorShoulder")
group:setHideModel("FullSuit", "ArmorHands")
group:setHideModel("FullSuit", "ArmorNeck")



-- VERY IMPORTANT TIPs.
-- if got DoSomthing(BloodBodyPartType) Error.
-- BloodBodyPartType is null.
-- is not blood or body location not created.
-- that's pretty much like clothingItem not exist.
-- make sure clothingItem xml is in right place and naming.
-- also must be defined in fileGuidTable correct.
-- probably need restart game to load xml.
