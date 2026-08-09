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
local OUTER_PADDING = 4

function Layout:Apply(root)
    local width, height = root:GetSize()
    local portraitSize = math.min(PORTRAIT_SIZE, height - (OUTER_PADDING * 2))
    local portraitTop = math.min(PORTRAIT_TOP, math.max(OUTER_PADDING, (height - portraitSize) / 2))
    local barRight = width - PORTRAIT_RIGHT - portraitSize
    local barWidth = math.max(MIN_BAR_WIDTH, barRight - BAR_LEFT)
    local powerWidth = barWidth + 8
    local totalBarHeight = HEALTH_HEIGHT + BAR_GAP + POWER_HEIGHT
    local healthTop = math.max(
        OUTER_PADDING,
        math.min(height - totalBarHeight - OUTER_PADDING, 40 + ((height - BASE_HEIGHT) / 2))
    )
    local nameTop = math.max(OUTER_PADDING, healthTop - 14)

    BFBF.Media:ApplyScalableFrameArt(root, {
        width = width,
        height = height,
        panelLeft = BAR_LEFT - 1,
        panelRight = barRight + 1,
        dividerX = barRight + 3,
    })

    root.Portrait:ClearAllPoints()
    root.Portrait:SetSize(portraitSize, portraitSize)
    root.Portrait:SetPoint("TOPRIGHT", root, "TOPRIGHT", -PORTRAIT_RIGHT, -portraitTop)

    root.Name:ClearAllPoints()
    root.Name:SetPoint("TOPLEFT", root, "TOPLEFT", BAR_LEFT + 29, -nameTop)
    root.Name:SetPoint("TOPRIGHT", root, "TOPLEFT", barRight, -nameTop)
    root.Name:SetHeight(12)

    root.Level:ClearAllPoints()
    root.Level:SetSize(22, 14)
    root.Level:SetPoint("TOPLEFT", root, "TOPLEFT", BAR_LEFT + 2, -nameTop)

    root.HealthBar:ClearAllPoints()
    root.HealthBar:SetSize(barWidth, HEALTH_HEIGHT)
    root.HealthBar:SetPoint("TOPLEFT", root, "TOPLEFT", BAR_LEFT, -healthTop)

    root.PowerBar:ClearAllPoints()
    root.PowerBar:SetSize(powerWidth, POWER_HEIGHT)
    root.PowerBar:SetPoint("TOPLEFT", root.HealthBar, "BOTTOMLEFT", 0, -BAR_GAP)

    root.HealthText:ClearAllPoints()
    root.HealthText:SetAllPoints(root.HealthBar)

    root.PowerText:ClearAllPoints()
    root.PowerText:SetAllPoints(root.PowerBar)
end
