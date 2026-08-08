local _, BFBF = ...

local Layout = {}
BFBF.Layouts.Player = Layout

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
    root.Portrait:SetSize(60 * portraitScale, 60 * portraitScale)
    root.Portrait:SetPoint("TOPLEFT", root, "TOPLEFT", 24 * scaleX, -19 * scaleY)

    root.Name:ClearAllPoints()
    root.Name:SetSize(96 * scaleX, 12 * scaleY)
    root.Name:SetPoint("TOPLEFT", root, "TOPLEFT", 88 * scaleX, -27 * scaleY)

    root.Level:ClearAllPoints()
    root.Level:SetSize(24 * scaleX, 14 * scaleY)
    root.Level:SetPoint("TOPRIGHT", root, "TOPRIGHT", -24.5 * scaleX, -27 * scaleY)

    root.HealthBar:ClearAllPoints()
    root.HealthBar:SetSize(124 * scaleX, 19 * scaleY)
    root.HealthBar:SetPoint("TOPLEFT", root, "TOPLEFT", 85 * scaleX, -40 * scaleY)

    root.PowerBar:ClearAllPoints()
    root.PowerBar:SetSize(124 * scaleX, 10 * scaleY)
    root.PowerBar:SetPoint("TOPLEFT", root, "TOPLEFT", 85 * scaleX, -61 * scaleY)

    root.HealthText:ClearAllPoints()
    root.HealthText:SetAllPoints(root.HealthBar)

    root.PowerText:ClearAllPoints()
    root.PowerText:SetAllPoints(root.PowerBar)
end
