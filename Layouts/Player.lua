local _, BFBF = ...

local Layout = {}
BFBF.Layouts.Player = Layout

local BASE_WIDTH, BASE_HEIGHT = 232, 100
local PORTRAIT_SIZE = 60
local PORTRAIT_LEFT = 24
local PORTRAIT_TOP = 19
local HEALTH_HEIGHT = 19
local POWER_HEIGHT = 10
local BAR_GAP = 1
local RIGHT_INSET = 23
local MIN_BAR_WIDTH = 40
local OUTER_PADDING = 4

function Layout:Apply(root)
    local width, height = root:GetSize()
    local portraitSize = math.min(PORTRAIT_SIZE, height - (OUTER_PADDING * 2))
    local portraitTop = math.min(PORTRAIT_TOP, math.max(OUTER_PADDING, (height - portraitSize) / 2))
    local barLeft = PORTRAIT_LEFT + portraitSize + 1
    local barRight = width - RIGHT_INSET
    local barWidth = math.max(MIN_BAR_WIDTH, barRight - barLeft)
    local totalBarHeight = HEALTH_HEIGHT + BAR_GAP + POWER_HEIGHT
    local healthTop = math.max(
        OUTER_PADDING,
        math.min(height - totalBarHeight - OUTER_PADDING, 41 + ((height - BASE_HEIGHT) / 2))
    )
    local nameTop = math.max(OUTER_PADDING, healthTop - 14)

    BFBF.Media:ApplyScalableFrameArt(root, {
        width = width,
        height = height,
        panelLeft = barLeft - 3,
        panelRight = barRight + 1,
        dividerX = barLeft - 5,
    })

    root.Portrait:ClearAllPoints()
    root.Portrait:SetSize(portraitSize, portraitSize)
    root.Portrait:SetPoint("TOPLEFT", root, "TOPLEFT", PORTRAIT_LEFT, -portraitTop)

    root.Name:ClearAllPoints()
    root.Name:SetPoint("TOPLEFT", root, "TOPLEFT", barLeft + 3, -nameTop)
    root.Name:SetPoint("TOPRIGHT", root, "TOPRIGHT", -RIGHT_INSET - 24, -nameTop)
    root.Name:SetHeight(12)

    root.Level:ClearAllPoints()
    root.Level:SetSize(24, 14)
    root.Level:SetPoint("TOPRIGHT", root, "TOPRIGHT", -RIGHT_INSET, -nameTop)

    root.HealthBar:ClearAllPoints()
    root.HealthBar:SetSize(barWidth, HEALTH_HEIGHT)
    root.HealthBar:SetPoint("TOPLEFT", root, "TOPLEFT", barLeft, -healthTop)

    root.PowerBar:ClearAllPoints()
    root.PowerBar:SetSize(barWidth, POWER_HEIGHT)
    root.PowerBar:SetPoint("TOPLEFT", root.HealthBar, "BOTTOMLEFT", 0, -BAR_GAP)

    root.HealthText:ClearAllPoints()
    root.HealthText:SetAllPoints(root.HealthBar)

    root.PowerText:ClearAllPoints()
    root.PowerText:SetAllPoints(root.PowerBar)
end
