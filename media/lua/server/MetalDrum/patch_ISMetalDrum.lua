-- This Patch is for make MetalDrum with differnt barrel colors.
-- but all that work is only for the color, looks dum.
-- it's work pertty good, but NO NEED use it, just keep Vanilla colors is fine.


-- require "MetalDrum/BuildingObjects/ISMetalDrum"

-- local OldISMetalDrumCreate = ISMetalDrum.create
-- function ISMetalDrum:create(x, y, z, north, sprite)
--     OldISMetalDrumCreate(self, x, y, z, north, self.baseSprite)
--     -- setOverlaySprite not just use sprite because this custom sprite is only a image.
--     -- not a fully sprite tile. the collision might be buggy, unable to pickup...
--     -- there good way is make a sprite tile or create a new IsoSprite.
--     -- but that mean this MOD will unable deactive without start new game save.
--     -- and I don't know how IsoSprite work, looks too complicate.
--     -- so the easy way is use overlay sprite, keep it simple.
--     if self.overlaySprite then
--         self.javaObject:setOverlaySprite(self.overlaySprite)
--         self.javaObject:getModData()["OverlaySprite"] = self.overlaySprite
--     end
-- end


-- local OldISMetalDrumNew = ISMetalDrum.new
-- function ISMetalDrum:new(player, sprite, overlaySprite, previewSprite)
--     local o = OldISMetalDrumNew(self, player, previewSprite or sprite)
--     o.baseSprite = sprite
--     o.overlaySprite = overlaySprite
--     return o;
-- end


-- local function OnObjectAdded(object) -- for resotre OverlaySprite after pickup and place.
-- 	if object:getModData()["OverlaySprite"] then
--         object:setOverlaySprite(object:getModData()["OverlaySprite"])
--     end
-- end

-- Events.OnObjectAdded.Add(OnObjectAdded)