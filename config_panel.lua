EsteticaPlusClassic = EsteticaPlusClassic or {}

-- Crear el panel principal de configuración
local panel = CreateFrame("Frame", "EsteticaPlusClassicConfigPanel", UIParent, "BackdropTemplate")
panel:SetSize(250, 140)
panel:SetPoint("CENTER")
panel:SetBackdrop({ bgFile = "Interface/Tooltips/UI-Tooltip-Background" })
panel:SetBackdropColor(0, 0, 0, 0.8)
panel:Hide()

-- Título
local title = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("TOP", 0, -10)
title:SetText("Estética+ Config")

-- Texto del marco activo
panel.selectedFrameText = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
panel.selectedFrameText:SetPoint("TOP", 0, -40)
panel.selectedFrameText:SetText("Marco activo: Ninguno")

-- Botón de Modo Edición
local editModeButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
editModeButton:SetSize(120, 25)
editModeButton:SetPoint("TOP", panel.selectedFrameText, "BOTTOM", 0, -10)
editModeButton:SetText("Modo Edición")

editModeButton:SetScript("OnClick", function()
    EsteticaPlusClassic.editing = not EsteticaPlusClassic.editing
    if EsteticaPlusClassic.editing then
        editModeButton:SetText("Salir Edición")
        print("|cffffcc00Estética+:|r Entrando a modo edición")
        if EsteticaPlusClassic.OnEnterEditMode then
            EsteticaPlusClassic:OnEnterEditMode()
        end
    else
        editModeButton:SetText("Modo Edición")
        print("|cffffcc00Estética+:|r Saliendo de modo edición")
        if EsteticaPlusClassic.OnExitEditMode then
            EsteticaPlusClassic:OnExitEditMode()
        end
    end
end)

-- Slider de escala
local scaleSlider = CreateFrame("Slider", "EsteticaPlusScaleSlider", panel, "OptionsSliderTemplate")
scaleSlider:SetWidth(200)
scaleSlider:SetHeight(20)
scaleSlider:SetPoint("TOP", 0, -70)
scaleSlider:SetMinMaxValues(0.5, 2)
scaleSlider:SetValueStep(0.1)
scaleSlider:SetValue(1)
scaleSlider:SetScript("OnValueChanged", function(self, value)
    if EsteticaPlusClassic.selectedFrame then
        EsteticaPlusClassic.selectedFrame:SetScale(value)
    end
end)

-- Crear el botón del minimapa
local function CreateMinimapButton()
    local button = CreateFrame("Button", "EsteticaPlusMinimapButton", Minimap)
    button:SetSize(24, 24)
    button:SetFrameStrata("MEDIUM")
    button:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -4, -4)
    button:SetMovable(true)
    button:EnableMouse(true)
    button:RegisterForDrag("LeftButton")
    button:SetClampedToScreen(true)
    button:SetScript("OnDragStart", button.StartMoving)
    button:SetScript("OnDragStop", button.StopMovingOrSizing)

    -- Icono
    local icon = button:CreateTexture(nil, "BACKGROUND")
    icon:SetTexture("Interface\\AddOns\\EsteticaPlusClassic\\icon.tga")
    icon:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask")
    icon:SetAllPoints()
    button.icon = icon

    -- Tooltip
    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 0, -4)
        GameTooltip:ClearLines()
        GameTooltip:AddLine("|cffffcc00Estética+ Config|r")
        GameTooltip:AddLine("Click para abrir/cerrar el panel", 1, 1, 1)
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function() GameTooltip:Hide() end)

    -- Acción al hacer clic
    button:SetScript("OnClick", function()
        if EsteticaPlusClassic.ConfigPanel:IsShown() then
            EsteticaPlusClassic.ConfigPanel:Hide()
        else
            EsteticaPlusClassic.ConfigPanel:Show()
            if not EsteticaPlusClassic.selectedFrame then
                EsteticaPlusScaleSlider:Hide()
            end
        end
    end)
end


CreateMinimapButton()
EsteticaPlusClassic.ConfigPanel = panel