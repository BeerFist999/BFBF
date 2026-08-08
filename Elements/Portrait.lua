local _, BFBF = ...

local Portrait = {}
BFBF.Elements.Portrait = Portrait

function Portrait:Create(root)
    local texture = root:CreateTexture(nil, "BACKGROUND", nil, 1)
    local mask = root:CreateMaskTexture(nil, "BACKGROUND", nil, 2)

    if root.unit == "player" then
        mask:SetAtlas(BFBF.Media.atlas.playerPortraitMask)
    else
        mask:SetAtlas(BFBF.Media.atlas.targetPortraitMask)
    end
    mask:SetAllPoints(texture)
    texture:AddMaskTexture(mask)

    root.Portrait = texture
    root.PortraitMask = mask
    return texture
end

function Portrait:Update(root)
    -- Disable the helper's default mask and use the explicit Blizzard-style
    -- mask created for this independent BFBF renderer.
    SetPortraitTexture(root.Portrait, root.unit, true)
end
