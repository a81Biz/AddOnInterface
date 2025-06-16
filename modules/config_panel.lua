local EPC = _G["EsteticaPlusClassic"]

EPC.modules.ConfigPanel = {}

function EPC.modules.ConfigPanel:Initialize()
    print("[EPC] Iniciando módulo ConfigPanel...")

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

    -- Título del panel
    local titleText = configPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    titleText:SetPoint("TOP", configPanel, "TOP", 0, -10)
    titleText:SetText("Estética Plus Classic")

    -- Botón para resetear posiciones
    local resetBtn = CreateFrame("Button", nil, configPanel)
    resetBtn:SetSize(150, 22)
    resetBtn:SetPoint("TOPLEFT", configPanel, "TOPLEFT", 10, -40)

    -- Fondo del botón
    resetBtn.texture = resetBtn:CreateTexture(nil, "BACKGROUND")
    resetBtn.texture:SetAllPoints(resetBtn)
    resetBtn.texture:SetColorTexture(0.2, 0.2, 0.2, 1) -- Gris oscuro

    -- Texto del botón
    resetBtn.text = resetBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    resetBtn.text:SetPoint("CENTER")
    resetBtn.text:SetText("Resetear Posiciones")

    -- Efectos hover
    resetBtn:SetScript("OnEnter", function(self)
        self.texture:SetColorTexture(0.3, 0.3, 0.3, 1)
    end)
    resetBtn:SetScript("OnLeave", function(self)
        self.texture:SetColorTexture(0.2, 0.2, 0.2, 1)
    end)

    -- Acción al hacer clic
    resetBtn:SetScript("OnClick", function()
        EPC.db.positions = {} -- Borra todas las posiciones guardadas
        print("|cff00ffcc[Config] Posiciones restablecidas|r")
    end)

    -- Botón para entrar/salir del modo edición
    local editModeBtn = CreateFrame("Button", nil, configPanel)
    editModeBtn:SetSize(150, 22)
    editModeBtn:SetPoint("TOPLEFT", resetBtn, "BOTTOMLEFT", 0, -10)

    -- Fondo del botón
    editModeBtn.texture = editModeBtn:CreateTexture(nil, "BACKGROUND")
    editModeBtn.texture:SetAllPoints(editModeBtn)
    editModeBtn.texture:SetColorTexture(0.2, 0.2, 0.2, 1) -- Gris oscuro

    -- Texto del botón
    editModeBtn.text = editModeBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    editModeBtn.text:SetPoint("CENTER")
    editModeBtn.text:SetText(EPC.db.editMode and "Salir del Modo Edición" or "Entrar al Modo Edición")

    -- Efectos hover
    editModeBtn:SetScript("OnEnter", function(self)
        self.texture:SetColorTexture(0.3, 0.3, 0.3, 1)
    end)
    editModeBtn:SetScript("OnLeave", function(self)
        self.texture:SetColorTexture(0.2, 0.2, 0.2, 1)
    end)

    -- Acción al hacer clic
    editModeBtn:SetScript("OnClick", function()
        EPC:ToggleEditMode()
        editModeBtn.text:SetText(EPC.db.editMode and "Salir del Modo Edición" or "Entrar al Modo Edición")
    end)

    -- Guardar referencia
    self.configPanel = configPanel
end

function EPC.modules.ConfigPanel:ShowConfigPanel()
    if not self.configPanel then
        self:CreateConfigPanel()
    end
    self.configPanel:Show()
end