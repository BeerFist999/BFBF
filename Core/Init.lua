local addonName, BFBF = ...

BFBF.name = addonName
BFBF.Frames = BFBF.Frames or {}
BFBF.Elements = BFBF.Elements or {}
BFBF.Layouts = BFBF.Layouts or {}
BFBF.Media = BFBF.Media or {}
BFBF.Events = BFBF.Events or {}
BFBF.Settings = BFBF.Settings or {}

function BFBF:Initialize()
    if self.initialized then
        return
    end

    self.initialized = true
    self.Settings:InitializeDatabase()
    self.PlayerFrame = self.Frames.Player:Create()
    self.TargetFrame = self.Frames.Target:Create()

    self.Settings:InitializePanel()
    self.Events:Start()
    self.Events:RefreshAll()
end
