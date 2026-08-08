local _, BFBF = ...

local Layout = {}
BFBF.Layouts.Player = Layout

function Layout:Apply(root)
    local width, height = root:GetSize()
    local padding = math.max(8, math.floor(height * 0.08))
    local portraitSize = math.max(36, math.min(60, height - (padding * 2)))
    local contentLeft = padding + portraitSize + padding
    local contentWidth = math.max(40, width - contentLeft - padding)
    local titleHeight = 14
    local topInset = math.max(18, math.floor(height * 0.20))
    local healthHeight = math.max(16, math.floor(height * 0.20))
    local powerHeight = math.max(7, math.floor(height * 0.08))

    root.Background:ClearAllPoints()
    root.Background:SetAllPoints(root)

    root.Portrait:ClearAllPoints()
    root.Portrait:SetSize(portraitSize, portraitSize)
    root.Portrait:SetPoint("LEFT", root, "LEFT", padding, 0)

    root.Name:ClearAllPoints()
    root.Name:SetSize(contentWidth - 28, titleHeight)
    root.Name:SetPoint("TOPLEFT", root, "TOPLEFT", contentLeft, -padding)

    root.Level:ClearAllPoints()
    root.Level:SetSize(28, titleHeight)
    root.Level:SetPoint("TOPRIGHT", root, "TOPRIGHT", -padding, -padding)

    root.HealthBar:ClearAllPoints()
    root.HealthBar:SetSize(contentWidth, healthHeight)
    root.HealthBar:SetPoint("TOPLEFT", root, "TOPLEFT", contentLeft, -topInset)

    root.PowerBar:ClearAllPoints()
    root.PowerBar:SetSize(contentWidth, powerHeight)
    root.PowerBar:SetPoint("TOPLEFT", root.HealthBar, "BOTTOMLEFT", 0, -2)

    root.HealthText:ClearAllPoints()
    root.HealthText:SetAllPoints(root.HealthBar)

    root.PowerText:ClearAllPoints()
    root.PowerText:SetAllPoints(root.PowerBar)
end
