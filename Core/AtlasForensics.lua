local addonName = ...

local AtlasForensics = {}
local captureFrame = CreateFrame("Frame")

local atlasNames = {
    Player = "UI-HUD-UnitFrame-Player-PortraitOn",
    Target = "UI-HUD-UnitFrame-Target-PortraitOn",
    PlayerType = "UI-HUD-UnitFrame-Player-PortraitOn-Type",
    TargetType = "UI-HUD-UnitFrame-Target-PortraitOn-Type",
    PlayerHealth = "UI-HUD-UnitFrame-Player-PortraitOn-Bar-Health",
    TargetHealth = "UI-HUD-UnitFrame-Target-PortraitOn-Bar-Health",
    PlayerMana = "UI-HUD-UnitFrame-Player-PortraitOn-Bar-Mana",
    TargetMana = "UI-HUD-UnitFrame-Target-PortraitOn-Bar-Mana",
    PlayerPortraitMask = "UI-HUD-UnitFrame-Player-Portrait-Mask",
    CircleMask = "CircleMask",
}

local function copyValue(value, seen)
    local valueType = type(value)

    if valueType == "number" or valueType == "string" or valueType == "boolean" then
        return value
    end

    if valueType == "table" then
        seen = seen or {}
        if seen[value] then
            return { __type = "cycle" }
        end

        local copy = {}
        seen[value] = true
        for key, nestedValue in pairs(value) do
            local keyType = type(key)
            if keyType == "number" or keyType == "string" then
                copy[key] = copyValue(nestedValue, seen)
            end
        end
        seen[value] = nil
        return copy
    end

    -- Atlas metadata is expected to contain serializable values. Preserve
    -- vector-like userdata without converting it to a string, so the
    -- SavedVariables serializer remains valid if rawSize is userdata.
    if valueType == "userdata" then
        local copy = { __type = "userdata" }
        local successX, x = pcall(function()
            return value.x
        end)
        local successY, y = pcall(function()
            return value.y
        end)

        if successX and type(x) == "number" then
            copy.x = x
        end
        if successY and type(y) == "number" then
            copy.y = y
        end
        return copy
    end

    return { __type = valueType }
end

function AtlasForensics:Capture()
    local results = {}

    for key, atlasName in pairs(atlasNames) do
        local entry = {
            atlasName = atlasName,
        }
        local info = C_Texture and C_Texture.GetAtlasInfo and C_Texture.GetAtlasInfo(atlasName)

        if info then
            entry.info = copyValue(info)
        else
            entry.available = false
        end

        results[key] = entry
    end

    BFBFAtlasForensics = results
end

SLASH_BFBFATLAS1 = "/bfbfatlas"
SlashCmdList.BFBFATLAS = function()
    AtlasForensics:Capture()
    DEFAULT_CHAT_FRAME:AddMessage("BFBF Atlas Forensics captured.")
end

captureFrame:RegisterEvent("ADDON_LOADED")
captureFrame:SetScript("OnEvent", function(_, _, loadedAddonName)
    if loadedAddonName ~= addonName then
        return
    end

    AtlasForensics:Capture()
    captureFrame:UnregisterEvent("ADDON_LOADED")
end)
