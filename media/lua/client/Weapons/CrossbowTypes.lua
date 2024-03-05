
CrossbowTypes = {
	-- those are Models defined by script.
	-- IMPORTANT!! when `setWeaponSprite` to a bugge sprite, must trigger the `setWeaponSprites` agian.
	-- otherwise is no change when ReStrat game or change Script.

	['CrossbowWooden'] = {
		sprite = getPackageItemType('.CrossbowWooden'),
		sprite_drawn = getPackageItemType('.CrossbowWoodenDrawn'),
	},
	['CrossbowHand'] = {
		sprite = getPackageItemType('.CrossbowHand'),
		sprite_drawn = getPackageItemType('.CrossbowHandDrawn'),
	},
	['CrossbowCompound'] = {
		sprite = getPackageItemType('.CrossbowCompound'),
		sprite_drawn = getPackageItemType('.CrossbowCompoundDrawn'),
	},
}