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

    BFBF.Elements.Portrait:Create(root)
    BFBF.Elements.Health:Create(root)
    BFBF.Elements.Power:Create(root)
    BFBF.Elements.Text:Create(root)

    root.FrameArt = root:CreateTexture(nil, "ARTWORK")
    root.FrameArt:SetAtlas(BFBF.Media.atlas.targetFrame)

    root.FrameAccent = root:CreateTexture(nil, "ARTWORK", nil, 1)
    root.FrameAccent:SetAtlas(BFBF.Media.atlas.targetType, TextureKitConstants.UseAtlasSize)

    root.ApplyLayout = function(frame)
        BFBF.Layouts.Target:Apply(frame)
    end
    root:SetScript("OnSizeChanged", root.ApplyLayout)
    root:ApplyLayout()
    root:Hide()

    return root
end
