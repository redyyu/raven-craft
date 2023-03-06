local MODAL_WIDTH = 400;
local MODAL_HEIGHT = 140;

-- Suicide by Shotgun or Rifle --

local function doTwoHandGunSuicide(dummy, button, playerObj, item)
    if button.internal == "NO" then return end

    ISInventoryPaneContextMenu.equipWeapon(item, true, true, playerObj:getPlayerNum())
    ISTimedActionQueue.add(ISGunSuicide:new(playerObj, item, "Suicide_TwoHand", 0.5, 120))
end


local function onTwoHandGunSuicide(playerObj, item)
    local playerNum = playerObj:getPlayerNum();
    local pos_x = getCore():getScreenWidth()/2 - MODAL_WIDTH/2;
    local pos_y = getCore():getScreenHeight()/2 - MODAL_HEIGHT/2;

	local modal = ISModalDialog:new(pos_x, pos_y, MODAL_WIDTH, MODAL_HEIGHT, getText("Tooltip_SUICIDE_CONFIRM"),
		true, nil, doTwoHandGunSuicide, playerNum, playerObj, item);

	modal:initialise()
	modal.prevFocus = getPlayerMechanicsUI(playerNum)
	modal.moveWithMouse = true
	modal:addToUIManager()
	if JoypadState.players[playerNum+1] then
		setJoypadFocus(playerNum, modal)
	end
end


-- Suicide by Hand Gun --

local animHandGuns = {
    "Suicide_OneHand_1",
    "Suicide_OneHand_2",
    "Suicide_OneHand_3",
}

local function doHandGunSuicide(dummy, button, playerObj, item)
    if button.internal == "NO" then return end
    
    local anim =  animHandGuns[1 + ZombRand(3)];

    ISInventoryPaneContextMenu.equipWeapon(item, true, false, playerObj:getPlayerNum())
    ISTimedActionQueue.add(ISGunSuicide:new(playerObj, item, anim, 0.3, 100))
end


local function onHandGunSuicide(playerObj, item)
    local playerNum = playerObj:getPlayerNum();
    local pos_x = getCore():getScreenWidth()/2 - MODAL_WIDTH/2;
    local pos_y = getCore():getScreenHeight()/2 - MODAL_HEIGHT/2;
    
	local modal = ISModalDialog:new(pos_x, pos_y, MODAL_WIDTH, MODAL_HEIGHT, getText("Tooltip_SUICIDE_CONFIRM"),
		true, nil, doHandGunSuicide, playerNum, playerObj, item);

	modal:initialise()
	modal.prevFocus = getPlayerMechanicsUI(playerNum)
	modal.moveWithMouse = true
	modal:addToUIManager()
	if JoypadState.players[playerNum+1] then
		setJoypadFocus(playerNum, modal)
	end
end


local function doBuildSuicideMenu(player, context, items)
    local playerObj = getSpecificPlayer(player)

    items = ISInventoryPane.getActualItems(items)
    for _, item in ipairs(items) do
        if instanceof(item, "HandWeapon") and item:isAimedFirearm() then
            local option = nil
            if item:isRequiresEquippedBothHands() then
                option = context:addOption(getText("ContextMenu_GUN_SUICIDE"), playerObj, onTwoHandGunSuicide, item); 
            else
                option = context:addOption(getText("ContextMenu_GUN_SUICIDE"), playerObj, onHandGunSuicide, item);   
            end

            if (item:haveChamber() and not item:isRoundChambered()) or (not item:haveChamber() and item:getCurrentAmmoCount() <= 0) then
                local toolTip = ISToolTip:new();
                toolTip:initialise();
                
                option.toolTip = toolTip;
                option.notAvailable = true;

                toolTip:setName(getText("ContextMenu_GUN_SUICIDE"));
                toolTip.description = getText("Tooltip_NO_AMMO");
            end
        end
	end
end

Events.OnFillInventoryObjectContextMenu.Add(doBuildSuicideMenu);
