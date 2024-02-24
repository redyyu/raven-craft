--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

-- Locations must be declared in render-order.
-- Location IDs must match BodyLocation= and CanBeEquipped= values in items.txt.
local group = BodyLocations.getGroup("Human")


group:getOrCreateLocation("ArmsArmor")
group:getOrCreateLocation("LegsArmor")
group:getOrCreateLocation("ShoulderArmor")
group:getOrCreateLocation("HandsArmor")

group:getOrCreateLocation("TightMask")  -- for some mask wearing with FullHat, Masks or Glasses.

-- VERY IMPORTANT TIPs.
-- if got DoSomthing(BloodBodyPartType) Error.
-- BloodBodyPartType is null.
-- is not blood or body location not created.
-- that's pretty much like clothingItem not exist.
-- make sure clothingItem xml is in right place and naming.
-- also must be defined in fileGuidTable correct.
-- probably need restart game to load xml.
