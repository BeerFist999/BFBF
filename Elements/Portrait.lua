local _, BFBF = ...

local Portrait = {}
BFBF.Elements.Portrait = Portrait

function Portrait:Create(root)
    local texture = root:CreateTexture(nil, "BACKGROUND")
    root.Portrait = texture
    return texture
end

function Portrait:Update(root)
    SetPortraitTexture(root.Portrait, root.unit)
end
