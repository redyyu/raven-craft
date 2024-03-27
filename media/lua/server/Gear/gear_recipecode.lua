require "recipecode"


-- Return true if recipe is valid, false otherwise
function Recipe.OnTest.FlashlightBatteryRemoval(sourceItem, result)
	return sourceItem:getUsedDelta() > 0;
end

-- When creating item in result box of crafting panel.
function Recipe.OnCreate.FlashlightBatteryRemoval(items, result, player)
	for i=0, items:size()-1 do
		local item = items:get(i)
		-- we found the battery, we change his used delta according to the battery
		if item:isTorchCone() then
			result:setUsedDelta(item:getUsedDelta());
			-- then we empty the torch used delta (his energy)
			item:setUsedDelta(0);
		end
	end
end

-- Return true if recipe is valid, false otherwise
function Recipe.OnTest.FlashlightBatteryInsert(sourceItem, result)
	if sourceItem:isTorchCone() then
		return sourceItem:getUsedDelta() == 0; -- Only allow the battery inserting if the flashlight has no battery left in it.
	end
	return true -- the battery
end


-- When creating item in result box of crafting panel.
function Recipe.OnCreate.FlashlightBatteryInsert(items, result, player)
	for i=0, items:size()-1 do
	  -- we found the battery, we change his used delta according to the battery
	  if items:get(i):getType() == "Battery" then
		  result:setUsedDelta(items:get(i):getUsedDelta())
	  end
	end
  end


-- print chestrig and webbing to different color texture.
function Recipe.OnCreate.printChestRigToBrown(items, resultItem, player)
	if resultItem:getType() == 'ChestRig' or resultItem:getType() == 'Webbing' then
    	resultItem:getVisual():setTextureChoice(0)
		resultItem:synchWithVisual()
	end
end

function Recipe.OnCreate.printChestRigToBlack(items, resultItem, player)
	if resultItem:getType() == 'ChestRig' or resultItem:getType() == 'Webbing' then
    	resultItem:getVisual():setTextureChoice(1)
		resultItem:synchWithVisual()
	end
end

function Recipe.OnCreate.printChestRigToArmy(items, resultItem, player)
	if resultItem:getType() == 'ChestRig' or resultItem:getType() == 'Webbing' then
    	resultItem:getVisual():setTextureChoice(2)
		resultItem:synchWithVisual()
	end
end

