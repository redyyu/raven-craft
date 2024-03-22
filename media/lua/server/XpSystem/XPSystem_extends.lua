require "XpSystem/XPSystem_SkillBook"

local Skills = {"Aiming", "Reloading", "LongBlade", "SmallBlade", "SmallBlunt", "Blunt", "Axe", "Spear"}

SkillBook["Aiming"] = {
    perk = Perks.Aiming,
    maxMultiplier1 = 2,
    maxMultiplier2 = 2,
    maxMultiplier3 = 2,
    maxMultiplier4 = 2,
    maxMultiplier5 = 2,
}

SkillBook["Reloading"] = {
    perk = Perks.Reloading,
    maxMultiplier1 = 2,
    maxMultiplier2 = 2,
    maxMultiplier3 = 2,
    maxMultiplier4 = 2,
    maxMultiplier5 = 2,
}

SkillBook["LongBlade"] = {
    perk = Perks.LongBlade,
    maxMultiplier1 = 2,
    maxMultiplier2 = 2,
    maxMultiplier3 = 2,
    maxMultiplier4 = 2,
    maxMultiplier5 = 2,
}


SkillBook["SmallBlade"] = {
    perk = Perks.SmallBlade,
    maxMultiplier1 = 2,
    maxMultiplier2 = 2,
    maxMultiplier3 = 2,
    maxMultiplier4 = 2,
    maxMultiplier5 = 2,
}

SkillBook["SmallBlunt"] = {
    perk = Perks.SmallBlunt,
    maxMultiplier1 = 2,
    maxMultiplier2 = 2,
    maxMultiplier3 = 2,
    maxMultiplier4 = 2,
    maxMultiplier5 = 2,
}

SkillBook["Blunt"] = {
    perk = Perks.Blunt,
    maxMultiplier1 = 2,
    maxMultiplier2 = 2,
    maxMultiplier3 = 2,
    maxMultiplier4 = 2,
    maxMultiplier5 = 2,
}


SkillBook["Axe"] = {
    perk = Perks.Axe,
    maxMultiplier1 = 2,
    maxMultiplier2 = 2,
    maxMultiplier3 = 2,
    maxMultiplier4 = 2,
    maxMultiplier5 = 2,
}

SkillBook["Spear"] = {
    perk = Perks.Spear,
    maxMultiplier1 = 2,
    maxMultiplier2 = 2,
    maxMultiplier3 = 2,
    maxMultiplier4 = 2,
    maxMultiplier5 = 2,
}


local function updateSkillBooks()
    local modifier = SandboxVars.RavenCraft.SkillBookMultiplierModifier
    for _, sk in ipairs(Skills) do
        local skill = SkillBook[sk]
        if skill then
            skill.maxMultiplier1 = skill.maxMultiplier1 * modifier
            skill.maxMultiplier2 = skill.maxMultiplier2 * modifier
            skill.maxMultiplier3 = skill.maxMultiplier3 * modifier
            skill.maxMultiplier4 = skill.maxMultiplier4 * modifier
            skill.maxMultiplier5 = skill.maxMultiplier5 * modifier
        end
    end
end

Events.OnGameStart.Add(updateSkillBooks)