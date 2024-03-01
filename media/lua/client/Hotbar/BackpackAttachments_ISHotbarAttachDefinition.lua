require "Hotbar/ISHotbarAttachDefinition"
if not ISHotbarAttachDefinition then
    return
end

local Hikingbag = {
	type = "Hikingbag",
	name = "Backpack",
	animset = "back",
	attachments = {
		Mag = "Hikingbag Walkie",
		Gear = "Hikingbag Gear",
		Canteen = "Hikingbag Canteen",
		Walkie = "Hikingbag Walkie",
		Bottle = "Hikingbag Bottle",
		Gas = "Hikingbag Gas",
		--Pan = "Hikingbag Gear",
	},
}
table.insert(ISHotbarAttachDefinition, Hikingbag);


local HikingbagLeft = {
	type = "HikingbagLeft",
	name = "Backpack Left",
	animset = "back",
	attachments = {
		Mag = "Hikingbag Left Walkie",
		Gear = "Hikingbag Left Gear",
		Canteen = "Hikingbag Left Canteen",
		Walkie = "Hikingbag Left Walkie",
		Bottle = "Hikingbag Left Bottle",
		Screwdriver  = "Hikingbag Left Tool2",
		Wrench = "Hikingbag Left Tool1",
		Tool = "Hikingbag Left Tool1",
		Saw = "Hikingbag Left Tool3",
		--Pan = "Hikingbag Left Gear",
	},
}
table.insert(ISHotbarAttachDefinition, HikingbagLeft);


local HikingbagRight = {
	type = "HikingbagRight",
	name = "Backpack Right",
	animset = "back",
	attachments = {
		Mag = "Hikingbag Right Walkie",
		Gear = "Hikingbag Right Gear",
		Canteen = "Hikingbag Right Canteen",
		Walkie = "Hikingbag Right Walkie",
		Bottle = "Hikingbag Right Bottle",
		Screwdriver  = "Hikingbag Right Tool2",
		Wrench = "Hikingbag Right Tool1",
		Tool = "Hikingbag Right Tool1",
		Saw = "Hikingbag Right Tool3",
		--Pan = "Hikingbag Right Gear",
	},
}
table.insert(ISHotbarAttachDefinition, HikingbagRight);


local ALICEpackLeft = {
	type = "ALICEpackLeft",
	name = "Backpack Left",
	animset = "back",
	attachments = {
		Mag = "ALICEpack Mag Left",
		Gear = "ALICEpack Gear Left",
		Canteen = "ALICEpack Canteen Left",
		Walkie = "ALICEpack Walkie Left",
		Bottle = "ALICEpack Bottle Left",
		--Pan = "ALICEpack Gear Left",
	},
}
table.insert(ISHotbarAttachDefinition, ALICEpackLeft);


local ALICEpack = {
	type = "ALICEpack",
	name = "Backpack",
	animset = "back",
	attachments = {
		Mag = "ALICEpack Mag",
		Gear = "ALICEpack Gear",
		Canteen = "ALICEpack Canteen",
		Walkie = "ALICEpack Walkie",
		Bottle = "ALICEpack Bottle",
		Gas = "ALICEpack Gas",
		--Pan = "ALICEpack Gear",
	},
}
table.insert(ISHotbarAttachDefinition, ALICEpack);


local ALICEpackRight = {
	type = "ALICEpackRight",
	name = "Backpack Right",
	animset = "back",
	attachments = {
		Mag = "ALICEpack Mag Right",
		Gear = "ALICEpack Gear Right",
		Canteen = "ALICEpack Canteen Right",
		Walkie = "ALICEpack Walkie Right",
		Bottle = "ALICEpack Bottle Right",
		--Pan = "ALICEpack Gear Right",
	},
}
table.insert(ISHotbarAttachDefinition, ALICEpackRight);