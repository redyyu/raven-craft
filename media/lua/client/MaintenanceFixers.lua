-- inspired by `Workshop ID: 2920089312`, `Mod ID: MaintenanceImprovesRepair`
-- Very nice coding style. 
-- Unfortunately, the author's name is not found.

MaintenanceFixers = {}

MaintenanceFixers.OnGameStart = function ()
    local allFixing = getScriptManager():getAllFixing(ArrayList:new())
    for i=0,allFixing:size()-1 do
        local fixing = allFixing:get(i)
        local requiredItems = fixing:getRequiredItem() -- returns a list, even tho the name suggests otherwise

        local fixers = fixing:getFixers()
        local fixersToDelete = ArrayList:new()
        local newFixers = ArrayList:new()
        for j=0,fixers:size()-1 do
            local fixer = fixers:get(j)
            local skills = fixer:getFixerSkills()
            local maintenanceSkill = FixerSkill.new("Maintenance", 0)

            if skills == nil then
                -- print(string.format("Fixer %s has no associated skills, creating new fixer", fixing:getName(), fixer:getFixerName()))
                local newFixer = Fixer.new(fixer:getFixerName(), LinkedList:new(), fixer:getNumberOfUse())
                fixersToDelete:add(fixer)
                newFixers:add(newFixer)
                skills = newFixer:getFixerSkills()
                skills:add(maintenanceSkill)
            else
                -- print(string.format("Fixer %s already associated skills, add to fixers", fixing:getName(), fixer:getFixerName()))
                skills:add(maintenanceSkill)
            end
        end

        for j=0,fixersToDelete:size()-1 do
            local oldFixer = fixersToDelete:get(j)
            -- print(string.format("Delete fixer %s", oldFixer:getFixerName()))
            fixers:remove(oldFixer)
        end
        for j=0,newFixers:size()-1 do
            local newFixer = newFixers:get(j)
            -- print(string.format("Add new fixer %s", newFixer:getFixerName()))
            fixers:add(newFixer)
        end
    end
end

Events.OnGameStart.Add(MaintenanceFixers.OnGameStart)
