require "Hotbar/ISHotbarAttachDefinition"
if not ISHotbarAttachDefinition then
    return
end

local AttachementExtends = {
    SmallBeltLeft = {
        BigBlade = "Belt Left Upside", 
    },
    SmallBeltRight = {
        BigBlade = "Belt Right Upside",
    },
}

for _,t in pairs(ISHotbarAttachDefinition) do
    if t.type and AttachementExtends[t.type] then
        for k, v in pairs(AttachementExtends[t.type]) do
            if t.attachments and not t.attachments[k] then
                t.attachments[k] = v;
            end
        end
    end
end
