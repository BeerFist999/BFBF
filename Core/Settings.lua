local _, BFBF = ...

local SettingsController = BFBF.Settings

local FRAME_KEYS = { "Player", "Target" }
local WIDTH_MIN, WIDTH_MAX = 150, 500
local HEIGHT_MIN, HEIGHT_MAX = 60, 200

local function getRoot(frameKey)
    return BFBF[frameKey .. "Frame"]
end

local function addDragIndicator(root)
    local indicator = {}

    local function addEdge(point, relativePoint, width, height, x, y)
        local edge = root:CreateTexture(nil, "OVERLAY")
        edge:SetColorTexture(1, 0.82, 0, 0.85)
        edge:SetSize(width, height)
        edge:SetPoint(point, root, relativePoint, x, y)
        edge:Hide()
        table.insert(indicator, edge)
    end

    addEdge("TOPLEFT", "TOPLEFT", 0, 2, 0, 0)
    indicator[1]:SetPoint("TOPRIGHT", root, "TOPRIGHT", 0, 0)
    addEdge("BOTTOMLEFT", "BOTTOMLEFT", 0, 2, 0, 0)
    indicator[2]:SetPoint("BOTTOMRIGHT", root, "BOTTOMRIGHT", 0, 0)
    addEdge("TOPLEFT", "TOPLEFT", 2, 0, 0, 0)
    indicator[3]:SetPoint("BOTTOMLEFT", root, "BOTTOMLEFT", 0, 0)
    addEdge("TOPRIGHT", "TOPRIGHT", 2, 0, 0, 0)
    indicator[4]:SetPoint("BOTTOMRIGHT", root, "BOTTOMRIGHT", 0, 0)

    return indicator
end

local function setIndicatorShown(indicator, shown)
    for _, edge in ipairs(indicator) do
        edge:SetShown(shown)
    end
end

function SettingsController:InitializeDatabase()
    BFBFDB = BFBFDB or {}

    for _, frameKey in ipairs(FRAME_KEYS) do
        local defaults = BFBF.Defaults[frameKey]
        local data = BFBFDB[frameKey] or {}

        if data.width == nil then
            data.width = defaults.width
        end
        if data.height == nil then
            data.height = defaults.height
        end
        if data.point == nil then
            data.point = defaults.point
        end
        if data.x == nil then
            data.x = defaults.x
        end
        if data.y == nil then
            data.y = defaults.y
        end

        BFBFDB[frameKey] = data
    end

    if BFBFDB.unlockFrames == nil then
        BFBFDB.unlockFrames = false
    end
end

function SettingsController:GetFrameData(frameKey)
    return BFBFDB[frameKey]
end

function SettingsController:ApplySize(frameKey)
    local root = getRoot(frameKey)
    if not root then
        return
    end

    local data = self:GetFrameData(frameKey)
    root:SetSize(data.width, data.height)
    root:ApplyLayout()
end

function SettingsController:ApplyPosition(frameKey)
    local root = getRoot(frameKey)
    if not root then
        return
    end

    local data = self:GetFrameData(frameKey)
    root:ClearAllPoints()
    root:SetPoint(data.point, UIParent, data.point, data.x, data.y)
end

function SettingsController:ApplyFrame(frameKey)
    self:ApplySize(frameKey)
    self:ApplyPosition(frameKey)
end

function SettingsController:ApplyAllFrames()
    for _, frameKey in ipairs(FRAME_KEYS) do
        self:ApplyFrame(frameKey)
    end
end

function SettingsController:SavePosition(frameKey)
    local root = getRoot(frameKey)
    local data = self:GetFrameData(frameKey)
    if not root or not data then
        return
    end

    if data.point == "BOTTOMRIGHT" then
        data.x = root:GetRight() - UIParent:GetRight()
    else
        data.x = root:GetLeft() - UIParent:GetLeft()
    end
    data.y = root:GetBottom() - UIParent:GetBottom()

    self:ApplyPosition(frameKey)
end

function SettingsController:AttachFrameControls(root, frameKey)
    root.frameKey = frameKey
    root:SetMovable(true)
    root:SetClampedToScreen(true)
    root:RegisterForDrag("LeftButton")
    root.DragIndicator = addDragIndicator(root)

    root:SetScript("OnDragStart", function(frame)
        if BFBFDB.unlockFrames then
            frame:StartMoving()
        end
    end)

    root:SetScript("OnDragStop", function(frame)
        frame:StopMovingOrSizing()
        if BFBFDB.unlockFrames then
            SettingsController:SavePosition(frame.frameKey)
        end
    end)

    self:UpdateFrameDragState(root)
end

function SettingsController:UpdateFrameDragState(root)
    local unlocked = BFBFDB.unlockFrames
    root:EnableMouse(unlocked)
    setIndicatorShown(root.DragIndicator, unlocked)
end

function SettingsController:SetUnlockFrames(unlocked)
    BFBFDB.unlockFrames = unlocked

    for _, frameKey in ipairs(FRAME_KEYS) do
        local root = getRoot(frameKey)
        if root then
            self:UpdateFrameDragState(root)
        end
    end
end

function SettingsController:ResetSize(frameKey)
    local defaults = BFBF.Defaults[frameKey]
    local data = self:GetFrameData(frameKey)
    data.width = defaults.width
    data.height = defaults.height
    self:ApplySize(frameKey)
    Settings.NotifyUpdate("BFBF_" .. frameKey .. "Width")
    Settings.NotifyUpdate("BFBF_" .. frameKey .. "Height")
end

function SettingsController:ResetPosition(frameKey)
    local defaults = BFBF.Defaults[frameKey]
    local data = self:GetFrameData(frameKey)
    data.point = defaults.point
    data.x = defaults.x
    data.y = defaults.y
    self:ApplyPosition(frameKey)
end

function SettingsController:ResetAll()
    for _, frameKey in ipairs(FRAME_KEYS) do
        self:ResetSize(frameKey)
        self:ResetPosition(frameKey)
    end
end

local function addButton(layout, name, label, callback, tooltip)
    layout:AddInitializer(CreateSettingsButtonInitializer(name, label, callback, tooltip, true))
end

function SettingsController:RegisterFrameSettings(category, layout, frameKey)
    local data = self:GetFrameData(frameKey)

    local function registerSlider(field, label, minimum, maximum, defaultValue)
        local variable = "BFBF_" .. frameKey .. field:gsub("^%l", string.upper)
        local setting = Settings.RegisterAddOnSetting(
            category,
            variable,
            field,
            data,
            Settings.VarType.Number,
            label,
            defaultValue
        )
        setting:SetValueChangedCallback(function()
            self:ApplySize(frameKey)
        end)

        local options = Settings.CreateSliderOptions(minimum, maximum, 1)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)
        Settings.CreateSlider(category, setting, options, label)
    end

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(frameKey .. " Frame"))
    registerSlider("width", "Width", WIDTH_MIN, WIDTH_MAX, BFBF.Defaults[frameKey].width)
    registerSlider("height", "Height", HEIGHT_MIN, HEIGHT_MAX, BFBF.Defaults[frameKey].height)
    addButton(layout, "BFBF_Reset" .. frameKey .. "Size", "Reset Size", function()
        self:ResetSize(frameKey)
    end, "Restore Blizzard default width and height.")
    addButton(layout, "BFBF_Reset" .. frameKey .. "Position", "Reset Position", function()
        self:ResetPosition(frameKey)
    end, "Restore the default BFBF frame position.")
end

function SettingsController:InitializePanel()
    if self.panelInitialized then
        return
    end

    self.panelInitialized = true

    local category = Settings.RegisterVerticalLayoutCategory("BFBF")
    Settings.RegisterAddOnCategory(category)

    local generalCategory, generalLayout = Settings.RegisterVerticalLayoutSubcategory(category, "General")
    local playerCategory, playerLayout = Settings.RegisterVerticalLayoutSubcategory(category, "Player Frame")
    local targetCategory, targetLayout = Settings.RegisterVerticalLayoutSubcategory(category, "Target Frame")

    local unlockSetting = Settings.RegisterAddOnSetting(
        generalCategory,
        "BFBF_UnlockFrames",
        "unlockFrames",
        BFBFDB,
        Settings.VarType.Boolean,
        "Unlock Frames",
        false
    )
    unlockSetting:SetValueChangedCallback(function(_, value)
        self:SetUnlockFrames(value)
    end)
    Settings.CreateCheckbox(generalCategory, unlockSetting, "Allow Player and Target frames to be moved with the left mouse button.")
    addButton(generalLayout, "BFBF_ResetAll", "Reset All", function()
        self:ResetAll()
    end, "Restore both BFBF frames to their default size and position.")

    self:RegisterFrameSettings(playerCategory, playerLayout, "Player")
    self:RegisterFrameSettings(targetCategory, targetLayout, "Target")

    Settings.RegisterAddOnCategory(generalCategory)
    Settings.RegisterAddOnCategory(playerCategory)
    Settings.RegisterAddOnCategory(targetCategory)
end
