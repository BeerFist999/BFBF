local _, BFBF = ...

local Events = BFBF.Events
local eventFrame = CreateFrame("Frame")
Events.frame = eventFrame

local function refreshFrame(root)
    if not root then
        return
    end

    if root.unit == "target" then
        root:SetShown(UnitExists(root.unit))
    end

    if not root:IsShown() then
        return
    end

    BFBF.Elements.Portrait:Update(root)
    local healthCurrent, healthMaximum = BFBF.Elements.Health:Update(root)
    local powerCurrent, powerMaximum = BFBF.Elements.Power:Update(root)
    BFBF.Elements.Text:Update(root, healthCurrent, healthMaximum, powerCurrent, powerMaximum)
end

function Events:RefreshAll()
    refreshFrame(BFBF.PlayerFrame)
    refreshFrame(BFBF.TargetFrame)
end

function Events:RefreshUnit(unit)
    if BFBF.PlayerFrame and unit == "player" then
        refreshFrame(BFBF.PlayerFrame)
    end
    if BFBF.TargetFrame and unit == "target" then
        refreshFrame(BFBF.TargetFrame)
    end
end

function Events:Start()
    if self.started then
        return
    end

    self.started = true
    eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
    eventFrame:RegisterEvent("UNIT_HEALTH")
    eventFrame:RegisterEvent("UNIT_MAXHEALTH")
    eventFrame:RegisterEvent("UNIT_POWER_UPDATE")
    eventFrame:RegisterEvent("UNIT_DISPLAYPOWER")
    eventFrame:RegisterEvent("UNIT_NAME_UPDATE")
    eventFrame:RegisterEvent("UNIT_LEVEL")
end

eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:SetScript("OnEvent", function(_, event, unit)
    if event == "PLAYER_LOGIN" then
        BFBF:Initialize()
    elseif event == "PLAYER_ENTERING_WORLD" then
        Events:RefreshAll()
    elseif event == "PLAYER_TARGET_CHANGED" then
        Events:RefreshUnit("target")
    elseif unit == "player" or unit == "target" then
        Events:RefreshUnit(unit)
    end
end)
