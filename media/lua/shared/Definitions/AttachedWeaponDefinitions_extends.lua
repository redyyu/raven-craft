-- define weapons to be attached to zombies when creating them
-- random knives inside their neck, spear in their stomach, meatcleaver in their back...
-- this is used in IsoZombie.addRandomAttachedWeapon()

AttachedWeaponDefinitions = AttachedWeaponDefinitions or {};

AttachedWeaponDefinitions.chanceOfAttachedWeapon = 6; -- Global chance of having an attached weapon, if we pass this we gonna add randomly one from the list


AttachedWeaponDefinitions.crossbowBack = {
	chance = 1,
	weaponLocation = {"Rifle On Back"},
	bloodLocations = {"Back"}
	addHoles = true,
	daySurvived = 20,
	weapons = {
		"RavenCraft.CrossbowWooden",
		"RavenCraft.CrossbowHand",
		"RavenCraft.CrossbowCompound",
	},
}
