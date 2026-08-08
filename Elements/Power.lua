local _, BFBF = ...

local Power = {}
BFBF.Elements.Power = Power

function Power:Create(root)
    local bar = CreateFrame("StatusBar", nil, root)
    bar:SetStatusBarTexture(BFBF.Media.statusBarTexture)
    bar:GetStatusBarTexture():SetAtlas(
        root.unit == "player" and BFBF.Media.atlas.playerPower or BFBF.Media.atlas.targetPower
    )
    bar:SetMinMaxValues(0, 1)
    bar:SetValue(0)

    local background = bar:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints(bar)
    background:SetTexture(BFBF.Media.statusBarTexture)
    background:SetVertexColor(0, 0, 0, 0.65)

    root.PowerBar = bar
    root.PowerBackground = background
    return bar
end

function Power:Update(root)
    local unit = root.unit

    if not UnitExists(unit) then
        root.PowerBar:SetMinMaxValues(0, 1)
        root.PowerBar:SetValue(0)
        return
    end

    local powerType, powerToken = UnitPowerType(unit)
    local current = UnitPower(unit, powerType)
    local maximum = UnitPowerMax(unit, powerType)
    local color = PowerBarColor and (PowerBarColor[powerType] or PowerBarColor[powerToken])

    -- Power values can be secret on current Retail clients. Pass them only
    -- through native StatusBar APIs; do not inspect or calculate with them.
    root.PowerBar:SetMinMaxValues(0, maximum)
    root.PowerBar:SetValue(current)

    if color then
        root.PowerBar:SetStatusBarColor(color.r, color.g, color.b)
    else
        root.PowerBar:SetStatusBarColor(0.25, 0.45, 0.90)
    end
end
