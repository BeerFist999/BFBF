local _, BFBF = ...

local Layout = {}
BFBF.Layouts.Target = Layout

local BASE_WIDTH, BASE_HEIGHT = 232, 100
local PORTRAIT_SIZE = 58
local PORTRAIT_RIGHT = 26
local PORTRAIT_TOP = 19
local HEALTH_HEIGHT = 20
local POWER_HEIGHT = 10
local BAR_GAP = 1
local BAR_LEFT = 22
local MIN_BAR_WIDTH = 40

function Layout:Apply(root)
    local width, height = root:GetSize()
    local portraitSize = math.min(PORTRAIT_SIZE, height - 8)
    local portraitTop = math.min(PORTRAIT_TOP, math.max(4, (height - portraitSize) / 2))
    local barRight = width - PORTRAIT_RIGHT - portraitSize
    local barWidth = math.max(MIN_BAR_WIDTH, barRight - BAR_LEFT)
    local totalBarHeight = HEALTH_HEIGHT + BAR_GAP + POWER_HEIGHT
    local healthTop = math.max(4, math.min(height - totalBarHeight - 4, 40 + ((height - BASE_HEIGHT) / 2)))
    local nameTop = math.max(4, healthTop - 14)
    local artScale = math.min(1, width / BASE_WIDTH, height / BASE_HEIGHT)

    root.FrameArt:ClearAllPoints()
    root.FrameArt:SetScale(artScale)
    root.FrameArt:SetPoint("TOPRIGHT", root, "TOPRIGHT")

    root.Portrait:ClearAllPoints()
    root.Portrait:SetSize(portraitSize, portraitSize)
    root.Portrait:SetPoint("TOPRIGHT", root, "TOPRIGHT", -PORTRAIT_RIGHT, -portraitTop)

    root.FrameAccent:ClearAllPoints()
    root.FrameAccent:SetScale(artScale)
    root.FrameAccent:SetPoint("TOPRIGHT", root, "TOPRIGHT", -75 * artScale, -25 * artScale)

    root.Name:ClearAllPoints()
    root.Name:SetPoint("TOPLEFT", root, "TOPLEFT", BAR_LEFT + 29, -nameTop)
    root.Name:SetPoint("TOPRIGHT", root, "TOPLEFT", barRight, -nameTop)
    root.Name:SetHeight(12)

    root.Level:ClearAllPoints()
    root.Level:SetSize(22, 14)
    root.Level:SetPoint("TOPLEFT", root, "TOPLEFT", BAR_LEFT + 2, -nameTop)

    root.HealthBar:ClearAllPoints()
    root.HealthBar:SetSize(barWidth, HEALTH_HEIGHT)
    -- TargetFrame's source uses the root LEFT point (vertical centre), not
    -- BOTTOMLEFT. This keeps health and power inside BFBF's own root.
    root.HealthBar:SetPoint("TOPLEFT", root, "TOPLEFT", BAR_LEFT, -healthTop)

    root.PowerBar:ClearAllPoints()
    root.PowerBar:SetSize(barWidth, POWER_HEIGHT)
    root.PowerBar:SetPoint("TOPLEFT", root.HealthBar, "BOTTOMLEFT", 0, -BAR_GAP)

    root.HealthText:ClearAllPoints()
    root.HealthText:SetAllPoints(root.HealthBar)

    root.PowerText:ClearAllPoints()
    root.PowerText:SetAllPoints(root.PowerBar)
end
