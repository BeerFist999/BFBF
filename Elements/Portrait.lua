local _, BFBF = ...

local Portrait = {}
BFBF.Elements.Portrait = Portrait

function Portrait:Create(root)
    -- Portraits are deliberately above frame art. The art atlas may be
    -- constrained at non-baseline sizes, while the portrait remains visible.
    local texture = root:CreateTexture(nil, "ARTWORK", nil, 1)
    local mask = root:CreateMaskTexture(nil, "ARTWORK", nil, 2)

    if root.unit == "player" then
        mask:SetAtlas(BFBF.Media.atlas.playerPortraitMask)
        mask:SetAllPoints(texture)
    else
        mask:SetAtlas(BFBF.Media.atlas.targetPortraitMask)
        -- TargetFrame.xml offsets the circular mask by one pixel at the
        -- top/right edge rather than using an unmodified all-points mask.
        mask:SetPoint("TOPLEFT", texture, "TOPLEFT", 0, -1)
        mask:SetPoint("BOTTOMRIGHT", texture, "BOTTOMRIGHT", -1, 0)
    end
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
