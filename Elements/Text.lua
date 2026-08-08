local _, BFBF = ...

local Text = {}
BFBF.Elements.Text = Text

local function createFontString(root, justifyH)
    local text = root:CreateFontString(nil, "OVERLAY", BFBF.Media.font)
    text:SetFontObject(BFBF.Media.font)
    text:SetJustifyH(justifyH)
    text:SetJustifyV("MIDDLE")
    text:SetFont(text:GetFont(), 12)
    return text
end

function Text:Create(root)
    root.Name = createFontString(root, "LEFT")
    root.HealthText = createFontString(root, "RIGHT")
    root.PowerText = createFontString(root, "RIGHT")
    root.Level = createFontString(root, "RIGHT")
end

function Text:Update(root, healthCurrent, healthMaximum, powerCurrent, powerMaximum)
    local unit = root.unit
    local name = UnitName(unit)
    local level = UnitLevel(unit)

    root.Name:SetText(name or "")
    root.Level:SetText(level and level > 0 and level or "??")
    root.HealthText:SetText(string.format("%d / %d", healthCurrent or 0, healthMaximum or 0))
    root.PowerText:SetText(string.format("%d / %d", powerCurrent or 0, powerMaximum or 0))
end
