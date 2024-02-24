require "NPCs/MainCreationMethods"

local oldDoTraits = BaseGameCharacterDetails.DoTraits

function ExpanedDoTraits()
    oldDoTraits()
    local handy = TraitFactory.getTrait("Handy")
    handy:addXPBoost(Perks.SmallBlunt, 1)
    handy:setDescription('') -- clear old description.
    BaseGameCharacterDetails.SetTraitDescription(handy)
end

Events.OnGameBoot.Add(ExpanedDoTraits);
