local _, BFBF = ...

local Player = {}
BFBF.Frames.Player = Player

function Player:Create()
    local defaults = BFBF.Defaults.Player
    local root = CreateFrame("Frame", "BFBF_Player", UIParent)
    root.unit = "player"

    root:SetSize(defaults.width, defaults.height)
    root:SetPoint(defaults.point, UIParent, defaults.relativePoint, defaults.offsetX, defaults.offsetY)
    root:SetFrameStrata("MEDIUM")

    root.Background = root:CreateTexture(nil, "BACKGROUND")
    root.Background:SetTexture(BFBF.Media.statusBarTexture)
    root.Background:SetVertexColor(unpack(BFBF.Media.backgroundColor))

    BFBF.Elements.Portrait:Create(root)
    BFBF.Elements.Health:Create(root)
    BFBF.Elements.Power:Create(root)
    BFBF.Elements.Text:Create(root)

    root.ApplyLayout = function(frame)
        BFBF.Layouts.Player:Apply(frame)
    end
    root:SetScript("OnSizeChanged", root.ApplyLayout)
    root:ApplyLayout()
    root:Show()

    return root
end
