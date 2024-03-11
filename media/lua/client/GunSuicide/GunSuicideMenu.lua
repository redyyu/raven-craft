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
		                            true, nil, doHandGunSuicide, playerNum, playerObj, item)

	modal:initialise()
	modal.prevFocus = getPlayerMechanicsUI(playerNum)
	modal.moveWithMouse = true
	modal:addToUIManager()
	if JoypadState.players[playerNum+1] then
		setJoypadFocus(playerNum, modal)
	end
end


local function doSuicideMenu(player, context, items)
    local playerObj = getSpecificPlayer(player)

    local items = ISInventoryPane.getActualItems(items)
    local one_hand_gun = nil
    local two_hand_gun = nil
    local is_loaded_gun = false

    for _, item in ipairs(items) do
        if instanceof(item, "HandWeapon") and item:isAimedFirearm() then
            is_loaded_gun = (item:haveChamber() and item:isRoundChambered()) or (not item:haveChamber() and item:getCurrentAmmoCount() > 0)
            if item:isRequiresEquippedBothHands() then
                if not two_hand_gun or is_loaded_gun then
                    two_hand_gun = item
                end
            else
                if not one_hand_gun or is_loaded_gun then
                    one_hand_gun = item
                end
            end
        end
	end
    
    local option = nil

    if two_hand_gun then
        option = context:addOption(getText("ContextMenu_GUN_SUICIDE"), playerObj, onTwoHandGunSuicide, two_hand_gun)
    elseif one_hand_gun then
        option = context:addOption(getText("ContextMenu_GUN_SUICIDE"), playerObj, onHandGunSuicide, one_hand_gun)
    end

    if option and not is_loaded_gun then
        local toolTip = ISToolTip:new()
        toolTip:initialise();
        
        option.toolTip = toolTip;
        option.notAvailable = true;

        toolTip:setName(getText("ContextMenu_GUN_SUICIDE"))
        toolTip.description = getText("Tooltip_NO_AMMO")
    end
end

Events.OnFillInventoryObjectContextMenu.Add(doSuicideMenu)
