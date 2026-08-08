local _, BFBF = ...

local Power = {}
BFBF.Elements.Power = Power

function Power:Create(root)
    local bar = CreateFrame("StatusBar", nil, root)
    bar:SetStatusBarTexture(BFBF.Media.statusBarTexture)
    bar:SetMinMaxValues(0, 1)
    bar:SetValue(0)
    root.PowerBar = bar
    return bar
end

function Power:Update(root)
    local unit = root.unit
    local powerType, powerToken = UnitPowerType(unit)
    local current = UnitPower(unit, powerType) or 0
    local maximum = UnitPowerMax(unit, powerType) or 0
    local color = PowerBarColor and (PowerBarColor[powerType] or PowerBarColor[powerToken])

    root.PowerBar:SetMinMaxValues(0, maximum > 0 and maximum or 1)
    root.PowerBar:SetValue(current)

    if color then
        root.PowerBar:SetStatusBarColor(color.r, color.g, color.b)
    else
        root.PowerBar:SetStatusBarColor(0.25, 0.45, 0.90)
    end

    return current, maximum
end
