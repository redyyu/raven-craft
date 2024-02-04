local spawn_chance = SandboxVars.RavenCraft.SpawnChance;
local spawn_chance_percent = spawn_chance / 100;

table.insert(ZombiesZoneDefinition.Default, {name = "ArmoredPolice", chance=0.1*spawn_chance_percent});
table.insert(ZombiesZoneDefinition.Default, {name = "ArmoredArmy", chance=0.1*spawn_chance_percent});
table.insert(ZombiesZoneDefinition.Default, {name = "ArmoredSurvivalist", chance=0.1*spawn_chance_percent});

table.insert(ZombiesZoneDefinition.Police, {name = "ArmoredPolice", chance=1*spawn_chance_percent});
table.insert(ZombiesZoneDefinition.PoliceState, {name = "ArmoredPolice", chance=0.5*spawn_chance_percent});
table.insert(ZombiesZoneDefinition.Prison, {name = "ArmoredPolice", chance=1*spawn_chance_percent});

table.insert(ZombiesZoneDefinition.Army, {name = "ArmoredArmy", chance=2*spawn_chance_percent});
table.insert(ZombiesZoneDefinition.SecretBase, {name = "ArmoredArmy", chance=2*spawn_chance_percent});

table.insert(ZombiesZoneDefinition.Survivalist, {name = "ArmoredSurvivalist", chance=2*spawn_chance_percent});

-- Add more HazardSuit for get Cure Injection
table.insert(ZombiesZoneDefinition.Prison, {name = "HazardSuit", chance=30*spawn_chance_percent});
table.insert(ZombiesZoneDefinition.Army, {name = "HazardSuit", chance=30*spawn_chance_percent});
table.insert(ZombiesZoneDefinition.SecretBase, {name = "HazardSuit", chance=50*spawn_chance_percent});
table.insert(ZombiesZoneDefinition.Default, {name = "HazardSuit", chance=0.02*spawn_chance_percent});