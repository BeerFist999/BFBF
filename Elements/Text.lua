local _, BFBF = ...

local Text = {}
BFBF.Elements.Text = Text

local function createFontString(root, justifyH, fontObject, size)
    local text = root:CreateFontString(nil, "OVERLAY", fontObject)
    text:SetJustifyH(justifyH)
    text:SetJustifyV("MIDDLE")
    text:SetFont(text:GetFont(), size)
    return text
end

function Text:Create(root)
    root.Name = createFontString(root, "LEFT", "GameFontNormalSmall", 12)
    root.HealthText = createFontString(root, "RIGHT", "GameFontNormalSmall", 12)
    root.PowerText = createFontString(root, "RIGHT", "GameFontNormalSmall", 12)
    root.Level = createFontString(root, "RIGHT", "GameNormalNumberFont", 12)
    root.Name:SetTextColor(1, 1, 1)
    root.Level:SetTextColor(1, 0.82, 0)
end

function Text:Update(root)
    local unit = root.unit
    local name = UnitName(unit)
    local level = UnitLevel(unit)

    root.Name:SetText(name or "")
    root.Level:SetText(level and level > 0 and level or "??")
    -- Health values may be secret. Health text remains intentionally blank
    -- until a native secret-safe text path is introduced.
    root.HealthText:SetText("")
    -- Power values may be secret. Power text remains intentionally blank
    -- until a native secret-safe text path is introduced.
    root.PowerText:SetText("")
end
