-- minimap_button.lua

local EPC = _G["EsteticaPlusClassic"]

EPC.modules.MinimapButton = {}

function EPC.modules.MinimapButton:Initialize()
    print("[EPC] Iniciando botón del minimapa...")

    self:CreateMinimapButton()
end

function EPC.modules.MinimapButton:CreateMinimapButton()
    local minimapButton = CreateFrame("Button", "EPC_MinimapButton", Minimap, "BackdropTemplate")
    minimapButton:SetSize(24, 24)
    minimapButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 3, -3)

    -- Icono del botón (circular)
    local icon = minimapButton:CreateTexture(nil, "OVERLAY")
    icon:SetTexture("Interface\\AddOns\\EsteticaPlusClassic\\media\\icon.tga") -- Ruta al icono
    icon:SetAllPoints(minimapButton)
    icon:SetTexCoord(0, 1, 0, 1) -- Coordenadas de textura para forma circular

    -- Fondo circular
    minimapButton:SetBackdrop({
        bgFile = "Interface\\Minimap\\UI-Minimap-Background",
        edgeFile = "Interface\\Minimap\\UI-Minimap-Ring",
        tile = true,
        tileSize = 64,
        edgeSize = 64,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })
    minimapButton:SetBackdropColor(0, 0, 0, 0) -- Transparente
    minimapButton:SetBackdropBorderColor(1, 1, 1, 1) -- Borde blanco

    -- Eventos del botón
    minimapButton:RegisterForClicks("LeftButtonUp")
    minimapButton:SetScript("OnClick", function()
        if EPC.modules.ConfigPanel and EPC.modules.ConfigPanel.ShowConfigPanel then
            EPC.modules.ConfigPanel:ShowConfigPanel()
        else
            print("|cffff0000[ERROR] Panel de configuración no disponible|r")
        end
    end)

    -- Mostrar el botón
    minimapButton:Show()

    -- Guardar referencia global
    EPC.minimapButton = minimapButton
end

function EPC.modules.MinimapButton:Toggle(show)
    if show then
        EPC.minimapButton:Show()
    else
        EPC.minimapButton:Hide()
    end
end