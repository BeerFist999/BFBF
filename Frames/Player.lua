local _, BFBF = ...

local Player = {}
BFBF.Frames.Player = Player

function Player:Create()
    local settings = BFBF.Settings:GetFrameData("Player")
    local root = CreateFrame("Frame", "BFBF_Player", UIParent)
    root.unit = "player"

    root:SetSize(settings.width, settings.height)
    root:SetPoint(settings.point, UIParent, settings.point, settings.x, settings.y)
    root:SetFrameStrata("MEDIUM")

    BFBF.Elements.Portrait:Create(root)
    BFBF.Elements.Health:Create(root)
    BFBF.Elements.Power:Create(root)
    BFBF.Elements.Text:Create(root)

    root.FrameArt = root:CreateTexture(nil, "ARTWORK")
    root.FrameArt:SetAtlas(BFBF.Media.atlas.playerFrame)

    root.ApplyLayout = function(frame)
        BFBF.Layouts.Player:Apply(frame)
    end
    root:SetScript("OnSizeChanged", root.ApplyLayout)
    root:ApplyLayout()
    BFBF.Settings:AttachFrameControls(root, "Player")
    root:Show()

    return root
end
