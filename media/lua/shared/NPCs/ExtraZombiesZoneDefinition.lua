table.insert(ZombiesZoneDefinition.Default, {name = "ArmoredPolice", chance=0.05})
table.insert(ZombiesZoneDefinition.Default, {name = "ArmoredArmy", chance=0.05})
table.insert(ZombiesZoneDefinition.Default, {name = "ArmoredSurvivalist", chance=0.05})

table.insert(ZombiesZoneDefinition.Police, {name = "ArmoredPolice", chance=0.5})
table.insert(ZombiesZoneDefinition.PoliceState, {name = "ArmoredPolice", chance=0.25})
table.insert(ZombiesZoneDefinition.Prison, {name = "ArmoredPolice", chance=0.5})

table.insert(ZombiesZoneDefinition.Army, {name = "ArmoredArmy", chance=1})
table.insert(ZombiesZoneDefinition.SecretBase, {name = "ArmoredArmy", chance=1})

table.insert(ZombiesZoneDefinition.Survivalist, {name = "ArmoredSurvivalist", chance=1})

-- Add more HazardSuit for get Cure Injection
table.insert(ZombiesZoneDefinition.Prison, {name = "HazardSuit", chance=10})
table.insert(ZombiesZoneDefinition.Army, {name = "HazardSuit", chance=10})
table.insert(ZombiesZoneDefinition.SecretBase, {name = "HazardSuit", chance=20})
table.insert(ZombiesZoneDefinition.Default, {name = "HazardSuit", chance=0.01})