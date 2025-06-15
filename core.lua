EsteticaPlusClassic = {}
local addonName = ...

-- Referencia global al panel (puede estar en otro archivo)
local configPanel = EsteticaPlus_ConfigPanel

-- Crear el ícono manual flotante en el minimapa
local minimapButton = CreateFrame("Button", "EsteticaPlusMinimapButton", Minimap)
minimapButton:SetSize(32, 32)
minimapButton:SetFrameStrata("MEDIUM")
minimapButton:SetPoint("TOPLEFT", Minimap, "BOTTOMLEFT", 0, -5)

-- Textura personalizada del ícono
minimapButton.texture = minimapButton:CreateTexture(nil, "BACKGROUND")
minimapButton.texture:SetTexture("Interface\\AddOns\\EsteticaPlusClassic\\icon.tga")
minimapButton.texture:SetAllPoints(minimapButton)

-- Permitir moverlo
minimapButton:SetMovable(true)
minimapButton:EnableMouse(true)
minimapButton:RegisterForDrag("LeftButton")
minimapButton:SetScript("OnDragStart", minimapButton.StartMoving)
minimapButton:SetScript("OnDragStop", minimapButton.StopMovingOrSizing)

-- Abrir el panel con clic izquierdo
minimapButton:SetScript("OnClick", function(_, button)
    if button == "LeftButton" then
        if configPanel:IsShown() then
            configPanel:Hide()
        else
            configPanel:Show()
        end
    end
end)

-- Tooltip simple
minimapButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:AddLine("Estética+")
    GameTooltip:AddLine("Clic izquierdo para abrir configuración", 1, 1, 1)
    GameTooltip:Show()
end)
minimapButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
