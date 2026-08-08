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
