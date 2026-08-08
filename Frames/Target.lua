local _, BFBF = ...

local Target = {}
BFBF.Frames.Target = Target

function Target:Create()
    local defaults = BFBF.Defaults.Target
    local root = CreateFrame("Frame", "BFBF_Target", UIParent)
    root.unit = "target"

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

    root.FrameArt = root:CreateTexture(nil, "ARTWORK")
    root.FrameArt:SetAtlas(BFBF.Media.atlas.targetFrame)

    root.ApplyLayout = function(frame)
        BFBF.Layouts.Target:Apply(frame)
    end
    root:SetScript("OnSizeChanged", root.ApplyLayout)
    root:ApplyLayout()
    root:Hide()

    return root
end
