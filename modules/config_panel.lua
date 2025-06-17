-- config_panel.lua

local EPC = _G["EsteticaPlusClassic"]

EPC.modules.ConfigPanel = {}

function EPC.modules.ConfigPanel:Initialize()
    print("[EPC] Iniciando panel de configuración...")
    self:CreateConfigPanel()
end

function EPC.modules.ConfigPanel:CreateConfigPanel()
    local configPanel = CreateFrame("Frame", "EPC_ConfigPanel", UIParent, "BackdropTemplate")
    configPanel:SetSize(300, 200)
    configPanel:SetPoint("CENTER")
    configPanel:Hide()

    -- Fondo del panel
    configPanel:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    configPanel:SetBackdropColor(0, 0, 0, 0.8)

    -- Título
    local titleText = configPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    titleText:SetPoint("TOP", configPanel, "TOP", 0, -10)
    titleText:SetText("Estética Plus Classic")

    -- Botón Resetear posiciones
    local resetBtn = CreateFrame("Button", nil, configPanel)
    resetBtn:SetSize(150, 22)
    resetBtn:SetPoint("TOPLEFT", configPanel, "TOPLEFT", 10, -40)
    resetBtn:SetText("Resetear Posiciones")
    resetBtn:SetNormalFontObject("GameFontNormalSmall")
    resetBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
    resetBtn:SetScript("OnClick", function()
        EPC.db.positions = {} -- Reiniciar posiciones guardadas
        print("|cff00ffcc[Config] Posiciones restablecidas|r")
    end)

    -- Botón Modo Edición
    local editModeBtn = CreateFrame("Button", nil, configPanel)
    editModeBtn:SetSize(150, 22)
    editModeBtn:SetPoint("TOPLEFT", resetBtn, "BOTTOMLEFT", 0, -10)
    editModeBtn:SetText(EPC.db.editMode and "Salir del Modo Edición" or "Entrar al Modo Edición")
    editModeBtn:SetNormalFontObject("GameFontNormalSmall")
    editModeBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
    editModeBtn:SetScript("OnClick", function()
        EPC.modules.ConfigPanel:ToggleEditMode()
        editModeBtn:SetText(EPC.db.editMode and "Salir del Modo Edición" or "Entrar al Modo Edición")
    end)

    -- Guardar referencias
    self.configPanel = configPanel
    self.editModeBtn = editModeBtn
end

function EPC.modules.ConfigPanel:ShowConfigPanel()
    if not self.configPanel then
        self:CreateConfigPanel()
    end
    self.configPanel:Show()
end

function EPC.modules.ConfigPanel:ToggleEditMode()
    local isEditMode = not EPC.db.editMode
    EPC.db.editMode = isEditMode

    if isEditMode then
        print("|cff00ffcc[Config] Modo Edición Activado|r")
    else
        print("|cff00ffcc[Config] Modo Edición Desactivado|r")
    end

    -- Mostrar/Ocultar marcos verdes
    for _, frame in pairs({
        EPC.modules.PlayerFrame and EPC.modules.PlayerFrame.playerFrame,
        EPC.modules.TargetFrame and EPC.modules.TargetFrame.targetFrame,
        EPC.modules.PetFrame and EPC.modules.PetFrame.petFrame
    }) do
        if frame then
            if isEditMode and not frame.showEditBox then
                frame.showEditBox = CreateFrame("Frame", nil, frame, "BackdropTemplate")
                frame.showEditBox:SetAllPoints(frame)
                frame.showEditBox:SetBackdrop({
                    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
                    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
                    tile = true, tileSize = 16, edgeSize = 16,
                    insets = { left = 4, right = 4, top = 4, bottom = 4 }
                })
                frame.showEditBox:SetBackdropColor(0, 0, 0, 0)
                frame.showEditBox:SetBackdropBorderColor(0, 1, 0, 1) -- Verde
            end

            if frame.showEditBox then
                if isEditMode then
                    frame.showEditBox:Show()
                else
                    frame.showEditBox:Hide()
                end
            end
        end
    end
end