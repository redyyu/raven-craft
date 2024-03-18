
CrossbowTypes = {
	-- those are Models defined by script.
	-- IMPORTANT!! when `setWeaponSprite` to a bugge sprite, must trigger the `setWeaponSprites` agian.
	-- otherwise is no change when ReStrat game or change Script.

	['CrossbowWooden'] = {
		sprite = RC.getPackageItemType('.CrossbowWooden'),
		sprite_drawn = RC.getPackageItemType('.CrossbowWoodenDrawn'),
	},
	['CrossbowHand'] = {
		sprite = RC.getPackageItemType('.CrossbowHand'),
		sprite_drawn = RC.getPackageItemType('.CrossbowHandDrawn'),
	},
	['CrossbowCompound'] = {
		sprite = RC.getPackageItemType('.CrossbowCompound'),
		sprite_drawn = RC.getPackageItemType('.CrossbowCompoundDrawn'),
	},
}