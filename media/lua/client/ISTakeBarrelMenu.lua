--***********************************************************
--**                    ROBERT JOHNSON                     **
--**       Contextual menu for building stuff when clicking in the inventory        **
--***********************************************************

ISTakeBarrelMenu = {};

ISTakeBarrelMenu.doBuildMenu = function(player, context, worldobjects, test)

	if test and ISWorldObjectContextMenu.Test then return true end

    local barrel = nil;
    local playerInv = getSpecificPlayer(player):getInventory();

	local squares = {}
        for j=#worldobjects,1,-1 do
			local v = worldobjects[j]
			if v:getSquare() then
				local dup = false
				for i=1,#squares do
					if squares[i] == v:getSquare() then dup = true; break end
				end
				if not dup then table.insert(squares, v:getSquare()) end
			end
		end
		for i=1,#squares do
			for j=0,squares[i]:getObjects():size()-1 do
				local v = squares[i]:getObjects():get(j)
				local properties = v:getSprite():getProperties()
				local name = (properties :Is("CustomName") and properties :Val("CustomName")) or "None"

					if name == "Barrel" then
						barrel = v;
					end
			end
        end

    if barrel then
		if test then return ISWorldObjectContextMenu.setTest() end
		context:addOption(getText("ContextMenu_TAKE_BARREL"), worldobjects, ISTakeBarrelMenu.onTakeBarrel, getSpecificPlayer(player), barrel);
    end

end

ISTakeBarrelMenu.onTakeBarrel = function(worldobjects, player, barrel)
	if luautils.walkAdj(player, barrel:getSquare()) then
		local square = barrel:getSquare();
		ISTimedActionQueue.add(ISTakeBarrel:new(player, barrel));
	end
end

Events.OnFillWorldObjectContextMenu.Add(ISTakeBarrelMenu.doBuildMenu);