
local keyNames = {
	"Forward", "Backward", "Left", "Right"
}

-- local function exerisesKeyHandler(_keyPressed)
-- 	local player = getPlayer()
-- 	if player:getVariable("ExerciseStarted") then
-- 		local playerJoypadBind = player:getJoypadBind()
-- 		local axisY
-- 		local axisX

-- 		if playerJoypadBind == -1 then 
-- 			axisY = 0
-- 			axisX = 0
-- 		else
-- 			axisY = getJoypadMovementAxisY(playerJoypadBind);
-- 			axisX = getJoypadMovementAxisX(playerJoypadBind);
-- 		end
-- 		for i=1, #keyNames do
-- 			if _keyPressed == getCore():getKey(keyNames[i]) or axisX ~= 0 or axisX ~= 0 then
-- 				player:setVariable("ExerciseStarted", false);
-- 				player:setVariable("ExerciseEnded", true);
-- 			end
-- 		end
-- 	end
-- 	player:getXp():getMultiplierMap():remove(Perks.Fitness);
-- 	player:getXp():getMultiplierMap():remove(Perks.Strength);
-- end

-- Events.OnCustomUIKeyPressed.Add(exerisesKeyHandler);
