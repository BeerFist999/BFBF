local _, BFBF = ...

BFBF.Media.statusBarTexture = "Interface\\TargetingFrame\\UI-StatusBar"
BFBF.Media.backgroundColor = { 0.08, 0.08, 0.08, 0.85 }
BFBF.Media.healthColor = { 0.20, 0.80, 0.20, 1 }
BFBF.Media.font = "GameFontNormalSmall"

-- Blizzard-owned atlases are used only as visual resources on BFBF's own
-- frames. BFBF never references or changes Blizzard's unit-frame objects.
BFBF.Media.atlas = {
    playerFrame = "UI-HUD-UnitFrame-Player-PortraitOn",
    targetFrame = "UI-HUD-UnitFrame-Target-PortraitOn",
    targetType = "UI-HUD-UnitFrame-Target-PortraitOn-Type",
    playerHealth = "UI-HUD-UnitFrame-Player-PortraitOn-Bar-Health",
    targetHealth = "UI-HUD-UnitFrame-Target-PortraitOn-Bar-Health",
    playerPower = "UI-HUD-UnitFrame-Player-PortraitOn-Bar-Mana",
    targetPower = "UI-HUD-UnitFrame-Target-PortraitOn-Bar-Mana",
    playerPortraitMask = "UI-HUD-UnitFrame-Player-Portrait-Mask",
    targetPortraitMask = "CircleMask",
}
