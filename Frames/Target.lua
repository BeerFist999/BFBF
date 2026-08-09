local _, BFBF = ...

local Target = {}
BFBF.Frames.Target = Target

function Target:Create()
    local settings = BFBF.Settings:GetFrameData("Target")
    local root = CreateFrame("Frame", "BFBF_Target", UIParent)
    root.unit = "target"

    root:SetSize(settings.width, settings.height)
    root:SetPoint(settings.point, UIParent, settings.point, settings.x, settings.y)
    root:SetFrameStrata("MEDIUM")
    root:SetClipsChildren(true)

    BFBF.Elements.Portrait:Create(root)
    BFBF.Elements.Health:Create(root)
    BFBF.Elements.Power:Create(root)
    BFBF.Elements.Text:Create(root)

    -- This exact Blizzard atlas remains the 232x100 baseline. Larger or
    -- shorter frames use the separate scalable composition below instead.
    root.FrameArt = root:CreateTexture(nil, "BACKGROUND")
    root.FrameArt:SetAtlas(BFBF.Media.atlas.targetFrame, TextureKitConstants.UseAtlasSize)

    root.FrameAccent = root:CreateTexture(nil, "BACKGROUND", nil, 1)
    root.FrameAccent:SetAtlas(BFBF.Media.atlas.targetType, TextureKitConstants.UseAtlasSize)
    BFBF.Media:CreateScalableFrameArt(root, "target")

    root.ApplyLayout = function(frame)
        BFBF.Layouts.Target:Apply(frame)
    end
    root:SetScript("OnSizeChanged", root.ApplyLayout)
    root:ApplyLayout()
    BFBF.Settings:AttachFrameControls(root, "Target")
    root:Hide()

    return root
end
