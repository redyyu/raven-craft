require 'Definitions/MakeUpDefinitions'

-- Eye Shadows

makeup = {}  -- it is local in `MakeUpDefinitions.lua` already.
makeup.name = "EyeShadowSliver"
makeup.category = "EyesShadow"
makeup.item = RC.getPackageItemType(".MakeUp_EyesShadowSliver")
makeup.makeuptypes = {}
makeup.makeuptypes["Eyes"] = true
makeup.makeuptypes["All"] = true
table.insert(MakeUpDefinitions.makeup, makeup)

makeup = {}
makeup.name = "EyeShadowPurple"
makeup.category = "EyesShadow"
makeup.item = RC.getPackageItemType(".MakeUp_EyesShadowPurple")
makeup.makeuptypes = {}
makeup.makeuptypes["Eyes"] = true
makeup.makeuptypes["All"] = true
table.insert(MakeUpDefinitions.makeup, makeup)


-- Lips

makeup = {}
makeup.name = "LipsSliver"
makeup.category = "Lips"
makeup.item = RC.getPackageItemType(".MakeUp_LipsSliver")
makeup.makeuptypes = {}
makeup.makeuptypes["Lips"] = true
makeup.makeuptypes["All"] = true
table.insert(MakeUpDefinitions.makeup, makeup)

makeup = {}
makeup.name = "LipsPurple"
makeup.category = "Lips"
makeup.item = RC.getPackageItemType(".MakeUp_LipsPurple")
makeup.makeuptypes = {}
makeup.makeuptypes["Lips"] = true
makeup.makeuptypes["All"] = true
table.insert(MakeUpDefinitions.makeup, makeup)
