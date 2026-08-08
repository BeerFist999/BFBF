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

    if not UnitExists(unit) then
        root.HealthBar:SetMinMaxValues(0, 1)
        root.HealthBar:SetValue(0)
        return
    end

    local current = UnitHealth(unit)
    local maximum = UnitHealthMax(unit)

    -- Health values can be secret on current Retail clients. Pass them only
    -- through native StatusBar APIs; do not inspect or calculate with them.
    root.HealthBar:SetMinMaxValues(0, maximum)
    root.HealthBar:SetValue(current)

    local red, green, blue = UnitSelectionColor(unit)
    if red then
        root.HealthBar:SetStatusBarColor(red, green, blue)
    else
        root.HealthBar:SetStatusBarColor(unpack(BFBF.Media.healthColor))
    end
end
