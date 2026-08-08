local _, BFBF = ...

local Layout = {}
BFBF.Layouts.Target = Layout

function Layout:Apply(root)
    local width, height = root:GetSize()
    local scaleX = width / 232
    local scaleY = height / 100
    local portraitScale = math.min(scaleX, scaleY)

    root.Background:ClearAllPoints()
    root.Background:SetAllPoints(root)

    root.FrameArt:ClearAllPoints()
    root.FrameArt:SetAllPoints(root)

    root.Portrait:ClearAllPoints()
    root.Portrait:SetSize(58 * portraitScale, 58 * portraitScale)
    root.Portrait:SetPoint("TOPRIGHT", root, "TOPRIGHT", -26 * scaleX, -19 * scaleY)

    root.Name:ClearAllPoints()
    root.Name:SetSize(90 * scaleX, 12 * scaleY)
    root.Name:SetPoint("TOPLEFT", root, "TOPLEFT", 42 * scaleX, -26 * scaleY)

    root.Level:ClearAllPoints()
    root.Level:SetSize(22 * scaleX, 14 * scaleY)
    root.Level:SetPoint("TOPLEFT", root, "TOPLEFT", 20 * scaleX, -27 * scaleY)

    root.HealthBar:ClearAllPoints()
    root.HealthBar:SetSize(126 * scaleX, 20 * scaleY)
    root.HealthBar:SetPoint("BOTTOMRIGHT", root, "BOTTOMLEFT", 148 * scaleX, 2 * scaleY)

    root.PowerBar:ClearAllPoints()
    root.PowerBar:SetSize(134 * scaleX, 10 * scaleY)
    root.PowerBar:SetPoint("TOPRIGHT", root.HealthBar, "BOTTOMRIGHT", 8 * scaleX, -1 * scaleY)

    root.HealthText:ClearAllPoints()
    root.HealthText:SetAllPoints(root.HealthBar)

    root.PowerText:ClearAllPoints()
    root.PowerText:SetAllPoints(root.PowerBar)
end
