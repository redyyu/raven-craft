
-- it will take no effect when those item is overrided by scripts

-- local item = ScriptManager.instance:getItem("Base.Bullets9mmBox")    
-- if item then 
--     item:DoParam("StaticModel = pouch")
--     item:DoParam("AttachmentType = Gear")
-- end
-- local item = ScriptManager.instance:getItem("Base.Bullets38Box")    
-- if item then 
--     item:DoParam("StaticModel = pouch")
--     item:DoParam("AttachmentType = Gear")
-- end
-- local item = ScriptManager.instance:getItem("Base.Bullets44Box")    
-- if item then 
--     item:DoParam("StaticModel = pouch")
--     item:DoParam("AttachmentType = Gear")
-- end
-- local item = ScriptManager.instance:getItem("Base.Bullets45Box")    
-- if item then 
--     item:DoParam("StaticModel = pouch")
--     item:DoParam("AttachmentType = Gear")
-- end
-- local item = ScriptManager.instance:getItem("Base.Bullets223Box")    
-- if item then 
--     item:DoParam("StaticModel = pouch")
--     item:DoParam("AttachmentType = Gear")
-- end
-- local item = ScriptManager.instance:getItem("Base.Bullets308Box")    
-- if item then 
--     item:DoParam("StaticModel = pouch")
--     item:DoParam("AttachmentType = Gear")
-- end
-- local item = ScriptManager.instance:getItem("Base.Bullets556Box")    
-- if item then 
--     item:DoParam("StaticModel = pouch")
--     item:DoParam("AttachmentType = Gear")
-- end
-- local item = ScriptManager.instance:getItem("Base.BulletsShotgunShellsBox")
-- if item then 
--     item:DoParam("StaticModel = pouch")
--     item:DoParam("AttachmentType = Gear")
-- end
local item = ScriptManager.instance:getItem("Base.9mmClip")
if item then 
    item:DoParam("AttachmentType = Mag")
end
local item = ScriptManager.instance:getItem("Base.44Clip")
if item then 
    item:DoParam("AttachmentType = Mag")
end
local item = ScriptManager.instance:getItem("Base.45Clip")
if item then 
    item:DoParam("AttachmentType = Mag")
end
local item = ScriptManager.instance:getItem("Base.223Clip")
if item then 
    item:DoParam("AttachmentType = Mag")
end
local item = ScriptManager.instance:getItem("Base.308Clip")
if item then 
    item:DoParam("AttachmentType = Mag")
end
local item = ScriptManager.instance:getItem("Base.556Clip")
if item then 
    item:DoParam("AttachmentType = Mag")
end
local item = ScriptManager.instance:getItem("Base.M14Clip")
if item then 
    item:DoParam("AttachmentType = Mag")
end


local item = ScriptManager.instance:getItem("Base.Pop")
if item then 
    item:DoParam("AttachmentType = Bottle")
end
local item = ScriptManager.instance:getItem("Base.Pop2")
if item then 
    item:DoParam("AttachmentType = Bottle")
end
local item = ScriptManager.instance:getItem("Base.Pop3")
if item then 
    item:DoParam("AttachmentType = Bottle")
end

local item = ScriptManager.instance:getItem("Base.WaterBottleFull")
if item then 
    item:DoParam("AttachmentType = Bottle")
end
local item = ScriptManager.instance:getItem("Base.WaterBottleEmpty")
if item then 
    item:DoParam("AttachmentType = Bottle")
end
local item = ScriptManager.instance:getItem("Base.WaterBottlePetrol")
if item then 
    item:DoParam("AttachmentType = Bottle")
end


local item = ScriptManager.instance:getItem("Base.PopBottle")
if item then 
    item:DoParam("AttachmentType = Bottle")
end
local item = ScriptManager.instance:getItem("Base.WaterPopBottle")
if item then 
    item:DoParam("AttachmentType = Bottle")
end
local item = ScriptManager.instance:getItem("Base.PopBottleEmpty")
if item then 
    item:DoParam("AttachmentType = Bottle")
end
local item = ScriptManager.instance:getItem("Base.PetrolPopBottle")
if item then 
    item:DoParam("AttachmentType = Bottle")
end

-- Shall not Glass bottle on bag

-- local item = ScriptManager.instance:getItem("Base.Wine")
-- if item then
--     item:DoParam("AttachmentType = Bottle")
-- end
-- local item = ScriptManager.instance:getItem("Base.Wine2")
-- if item then
--     item:DoParam("AttachmentType = Bottle")
-- end
-- local item = ScriptManager.instance:getItem("Base.WineEmpty")
-- if item then 
--     item:DoParam("AttachmentType = Bottle")
-- end
-- local item = ScriptManager.instance:getItem("Base.WineEmpty2")
-- if item then 
--     item:DoParam("AttachmentType = Bottle")
-- end
-- local item = ScriptManager.instance:getItem("Base.WineWaterFull")
-- if item then
--     item:DoParam("AttachmentType = Bottle")
-- end
-- local item = ScriptManager.instance:getItem("Base.WinePetrol")
-- if item then 
--     item:DoParam("AttachmentType = Bottle")
-- end



local item = ScriptManager.instance:getItem("Base.Molotov")
if item then
    item:DoParam("AttachmentType = Bottle")
end

local item = ScriptManager.instance:getItem("Base.WhiskeyFull")
if item then
    item:DoParam("AttachmentType = Bottle")
end
local item = ScriptManager.instance:getItem("Base.WhiskeyWaterFull")
if item then
    item:DoParam("AttachmentType = Bottle")
end
local item = ScriptManager.instance:getItem("Base.WhiskeyEmpty")
if item then 
    item:DoParam("AttachmentType = Bottle")
end
local item = ScriptManager.instance:getItem("Base.WhiskeyPetrol")
if item then 
    item:DoParam("AttachmentType = Bottle")
end

local item = ScriptManager.instance:getItem("Base.Hat_GasMask")
if item then 
    item:DoParam("AttachmentType = Gear")
    item:DoParam("StaticModel = GasMask")
end
local item = ScriptManager.instance:getItem("Base.Saw")
if item then 
    item:DoParam("AttachmentType = Saw")
    item:DoParam("primaryAnimMask = HoldingTorchRight")
    item:DoParam("secondaryAnimMask = HoldingTorchLeft")
end
local item = ScriptManager.instance:getItem("Base.BlowTorch")
if item then 
    item:DoParam("AttachmentType = Tool")
    item:DoParam("primaryAnimMask = HoldingTorchRight")
    item:DoParam("secondaryAnimMask = HoldingTorchLeft")
end
    

    
-- local item = ScriptManager.instance:getItem("Base.Bandaid")    
-- if item then 
--     item:DoParam("StaticModel = pouch")
--     item:DoParam("AttachmentType = Gear")
-- end    
-- local item = ScriptManager.instance:getItem("Base.Bandage")    
-- if item then 
--     item:DoParam("StaticModel = pouch")
--     item:DoParam("AttachmentType = Gear")
-- end
-- local item = ScriptManager.instance:getItem("Base.AlcoholBandage")    
-- if item then 
--     item:DoParam("StaticModel = pouch")
--     item:DoParam("AttachmentType = Gear")
-- end
-- local item = ScriptManager.instance:getItem("Base.SutureNeedle")    
-- if item then 
--     item:DoParam("StaticModel = pouch")
--     item:DoParam("AttachmentType = Gear")
-- end
    




local item = ScriptManager.instance:getItem("Base.MakeUp_GreenCamo")    
if item then 
    item:DoParam("OBSOLETE = true")
end

local item = ScriptManager.instance:getItem("Base.MakeUp_GreenCamo2")    
if item then 
    item:DoParam("OBSOLETE = true")
end

local item = ScriptManager.instance:getItem("Base.PetrolCan")    
if item then 
    item:DoParam("AttachmentType = Gas")
end
local item = ScriptManager.instance:getItem("Base.EmptyPetrolCan")    
if item then 
    item:DoParam("AttachmentType = Gas")
end



-- Silencer No need those, already ovrride firearms by script.
-- SilencerWeaponTable = {
-- 	["Silencer"] = {"Base.Pistol", "Base.Pistol2", "Base.Pistol3"}
-- 	["SilencerPipe"] = {"Base.Pistol", "Base.Pistol2", "Base.Pistol3", "Base.Shotgun", "Base.ShotgunSawnoff"}
-- 	["SilencerBottle"] = {"Base.Pistol", "Base.Pistol2", "Base.Pistol3", "Base.Shotgun", "Base.ShotgunSawnoff"}
--     ["SilencerRifle"]= {"Base.VarmintRifle", "Base.AssaultRifle", "Base.AssaultRifle2"},
-- }


-- for siltype, weapons in pairs(SilencerWeaponTable) do
-- 	for _, wp in ipairs(weapons) do
-- 		local item = ScriptManager.instance:getItem(wp)
-- 		if item then 
-- 			item:DoParam("ModelWeaponPart = " .. siltype .. " " .. siltype .." muzzle muzzle")
-- 		end
-- 	end
-- end
