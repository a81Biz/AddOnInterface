local frame = PlayerFrame

local mover = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
mover:SetSize(frame:GetWidth(), frame:GetHeight())
mover:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
mover:SetBackdrop({ bgFile = "Interface/Tooltips/UI-Tooltip-Background" })
mover:SetBackdropColor(0, 1, 0, 0.5)
mover:SetFrameStrata("HIGH")
mover:SetFrameLevel(frame:GetFrameLevel() + 10)
mover:Hide()

mover:EnableMouse(true)
mover:SetMovable(true)
mover:RegisterForDrag("LeftButton")
mover:SetScript("OnDragStart", function(self) self:StartMoving() end)
mover:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local point, _, relativePoint, xOfs, yOfs = self:GetPoint()
    frame:ClearAllPoints()
    frame:SetPoint(point, UIParent, relativePoint, xOfs, yOfs)
end)

mover:SetScript("OnMouseDown", function()
    EsteticaPlusClassic.selectedFrame = frame
    if EsteticaPlusClassic.ConfigPanel and EsteticaPlusClassic.ConfigPanel.selectedFrameText then
        EsteticaPlusClassic.ConfigPanel.selectedFrameText:SetText("Marco activo: " .. (frame:GetName() or "Sin nombre"))
    end
end)

-- Función global para activarlo
function EsteticaPlusClassic_ToggleEditMode()
    if mover:IsShown() then
        mover:Hide()
    else
        mover:Show()
    end
end
