local _, BFBF = ...

local Health = {}
BFBF.Elements.Health = Health

function Health:Create(root)
    local bar = CreateFrame("StatusBar", nil, root)
    bar:SetStatusBarTexture(BFBF.Media.statusBarTexture)
    bar:SetStatusBarColor(unpack(BFBF.Media.healthColor))
    bar:SetMinMaxValues(0, 1)
    bar:SetValue(1)
    root.HealthBar = bar
    return bar
end

function Health:Update(root)
    local unit = root.unit
    local current = UnitHealth(unit) or 0
    local maximum = UnitHealthMax(unit) or 0

    root.HealthBar:SetMinMaxValues(0, maximum > 0 and maximum or 1)
    root.HealthBar:SetValue(current)

    local red, green, blue = UnitSelectionColor(unit)
    if red then
        root.HealthBar:SetStatusBarColor(red, green, blue)
    else
        root.HealthBar:SetStatusBarColor(unpack(BFBF.Media.healthColor))
    end

    return current, maximum
end
