local _, BFBF = ...

BFBF.Media.statusBarTexture = "Interface\\TargetingFrame\\UI-StatusBar"
BFBF.Media.backgroundColor = { 0.08, 0.08, 0.08, 0.85 }
BFBF.Media.healthColor = { 0.20, 0.80, 0.20, 1 }
BFBF.Media.font = "GameFontNormalSmall"

-- Blizzard-owned atlases are used only as visual resources on BFBF's own
-- frames. BFBF never references or changes Blizzard's unit-frame objects.
BFBF.Media.atlas = {
    playerFrame = "UI-HUD-UnitFrame-Player-PortraitOn",
    targetFrame = "UI-HUD-UnitFrame-Target-PortraitOn",
    targetType = "UI-HUD-UnitFrame-Target-PortraitOn-Type",
    playerPower = "UI-HUD-UnitFrame-Player-PortraitOn-Bar-Mana",
    targetPower = "UI-HUD-UnitFrame-Target-PortraitOn-Bar-Mana",
    playerPortraitMask = "UI-HUD-UnitFrame-Player-Portrait-Mask",
    targetPortraitMask = "CircleMask",
}

local scalableStyles = {
    player = {
        background = { 0.04, 0.08, 0.15, 0.96 },
        panel = { 0.08, 0.16, 0.26, 0.90 },
        border = { 0.78, 0.64, 0.22, 0.95 },
        highlight = { 0.25, 0.55, 0.86, 0.72 },
    },
    target = {
        background = { 0.14, 0.07, 0.05, 0.96 },
        panel = { 0.24, 0.12, 0.08, 0.90 },
        border = { 0.82, 0.65, 0.24, 0.95 },
        highlight = { 0.88, 0.42, 0.18, 0.72 },
    },
}

local function createColorRegion(root, drawLayer, subLevel, color)
    local region = root:CreateTexture(nil, drawLayer, nil, subLevel)
    region:SetColorTexture(unpack(color))
    return region
end

function BFBF.Media:CreateScalableFrameArt(root, styleName)
    local style = scalableStyles[styleName]
    local art = {
        background = createColorRegion(root, "BACKGROUND", -4, style.background),
        panel = createColorRegion(root, "BACKGROUND", -3, style.panel),
        top = createColorRegion(root, "BACKGROUND", -2, style.border),
        bottom = createColorRegion(root, "BACKGROUND", -2, style.border),
        left = createColorRegion(root, "BACKGROUND", -2, style.border),
        right = createColorRegion(root, "BACKGROUND", -2, style.border),
        divider = createColorRegion(root, "BACKGROUND", -2, style.border),
        highlight = createColorRegion(root, "BACKGROUND", -1, style.highlight),
    }

    root.ScalableArt = art
    return art
end

local function setShown(art, shown)
    for _, region in pairs(art) do
        region:SetShown(shown)
    end
end

function BFBF.Media:ApplyScalableFrameArt(root, geometry)
    local art = root.ScalableArt
    local baseline = geometry.width == 232 and geometry.height == 100

    root.FrameArt:SetShown(baseline)
    if root.FrameAccent then
        root.FrameAccent:SetShown(baseline)
    end

    setShown(art, not baseline)
    if baseline then
        return
    end

    art.background:ClearAllPoints()
    art.background:SetPoint("TOPLEFT", root, "TOPLEFT", 2, -2)
    art.background:SetPoint("BOTTOMRIGHT", root, "BOTTOMRIGHT", -2, 2)

    art.panel:ClearAllPoints()
    art.panel:SetPoint("TOPLEFT", root, "TOPLEFT", geometry.panelLeft, -3)
    art.panel:SetPoint("BOTTOMRIGHT", root, "BOTTOMLEFT", geometry.panelRight, 3)

    art.top:ClearAllPoints()
    art.top:SetPoint("TOPLEFT", root, "TOPLEFT")
    art.top:SetPoint("TOPRIGHT", root, "TOPRIGHT")
    art.top:SetHeight(2)

    art.bottom:ClearAllPoints()
    art.bottom:SetPoint("BOTTOMLEFT", root, "BOTTOMLEFT")
    art.bottom:SetPoint("BOTTOMRIGHT", root, "BOTTOMRIGHT")
    art.bottom:SetHeight(2)

    art.left:ClearAllPoints()
    art.left:SetPoint("TOPLEFT", root, "TOPLEFT")
    art.left:SetPoint("BOTTOMLEFT", root, "BOTTOMLEFT")
    art.left:SetWidth(2)

    art.right:ClearAllPoints()
    art.right:SetPoint("TOPRIGHT", root, "TOPRIGHT")
    art.right:SetPoint("BOTTOMRIGHT", root, "BOTTOMRIGHT")
    art.right:SetWidth(2)

    art.divider:ClearAllPoints()
    art.divider:SetPoint("TOPLEFT", root, "TOPLEFT", geometry.dividerX, -4)
    art.divider:SetPoint("BOTTOMLEFT", root, "BOTTOMLEFT", geometry.dividerX, 4)
    art.divider:SetWidth(2)

    art.highlight:ClearAllPoints()
    art.highlight:SetPoint("TOPLEFT", root, "TOPLEFT", geometry.panelLeft, -3)
    art.highlight:SetPoint("TOPRIGHT", root, "TOPLEFT", geometry.panelRight, -3)
    art.highlight:SetHeight(1)
end
