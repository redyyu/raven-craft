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

