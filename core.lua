local ADDON_NAME = "EsteticaPlusClassic"
local EPC = {} -- Espacio de nombres global
_G[ADDON_NAME] = EPC

EPC.modules = {} -- Módulos del AddOn
EPC.db = {}      -- Base de datos local

-- === FUNCIÓN PARA CARGAR DATOS GUARDADOS ===
function EPC:GetSavedData()
    if not EsteticaPlusClassicDB then
        EsteticaPlusClassicDB = {}
    end
    return EsteticaPlusClassicDB
end

-- Función auxiliar para cargar módulos
function EPC:LoadModule(name)
    if self.modules[name] and self.modules[name].Initialize then
        self.modules[name]:Initialize()
    end
end

-- Inicialización general
function EPC:OnInitialize()
    print("|cff00ffcc[EsteticaPlusClassic] Iniciando AddOn...|r")

    self.db = self:GetSavedData() or {
        scale = 1.0,
        positions = {},
        showMana = true,
        editMode = false,
    }

    -- Cargar módulos de marcos PRIMERO
    self:LoadModule("PlayerFrame")
    self:LoadModule("TargetFrame")
    self:LoadModule("PetFrame")

    -- Luego cargar módulos dependientes
    self:LoadModule("Mover")
    self:LoadModule("ConfigPanel")
    self:LoadModule("EdicionIndividual")
end

-- Evento al cargar el AddOn
local eventFrame = CreateFrame("Frame")
eventFrame:SetScript("OnEvent", function(self, event, addonName)
    if event == "ADDON_LOADED" and addonName == ADDON_NAME then
        EPC:OnInitialize()
    end
end)
eventFrame:RegisterEvent("ADDON_LOADED")

-- === BOTÓN DEL MINIMAPA ===
local minimapButton = CreateFrame("Button", "EPC_MinimapButton", Minimap)
minimapButton:SetSize(24, 24) -- Tamaño del botón
minimapButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 3, -3)

-- Icono del botón (circular)
local icon = minimapButton:CreateTexture(nil, "OVERLAY")
icon:SetTexture("Interface\\AddOns\\EsteticaPlusClassic\\media\\icon.tga") -- Ruta al icono
icon:SetAllPoints(minimapButton)
icon:SetTexCoord(0, 1, 0, 1) -- Coordenadas de textura para mantener la forma circular

-- Fondo circular
minimapButton:SetBackdrop({
    bgFile = "Interface\\Minimap\\UI-Minimap-Background",
    edgeFile = "Interface\\Minimap\\UI-Minimap-Ring",
    tile = true, tileSize = 64, edgeSize = 64,
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

-- Mostrar/ocultar el botón según sea necesario
function EPC:ToggleMinimapButton(show)
    if show then
        minimapButton:Show()
    else
        minimapButton:Hide()
    end
end

-- Inicializar el botón
EPC:ToggleMinimapButton(true)

-- Función para alternar el modo edición
function EPC:ToggleEditMode()
    local isEditMode = not EPC.db.editMode
    EPC.db.editMode = isEditMode

    if isEditMode then
        print("|cff00ffcc[Config] Modo Edición Activado|r")

        -- Mostrar marcos verdes alrededor de los unit frames
        for _, frameRef in pairs({ 
            EPC.modules.PlayerFrame and EPC.modules.PlayerFrame.playerFrame, 
            EPC.modules.TargetFrame and EPC.modules.TargetFrame.targetFrame, 
            EPC.modules.PetFrame and EPC.modules.PetFrame.petFrame 
        }) do

            if frameRef then
                local frame = frameRef

                if not frame.showEditBox then
                    -- Crear el marco con BackdropTemplate
                    frame.showEditBox = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
                    frame.showEditBox:SetFrameStrata("TOOLTIP")
                    frame.showEditBox:SetSize(frame:GetWidth(), frame:GetHeight())
                    frame.showEditBox:SetPoint("CENTER", frame, "CENTER")

                    -- Comprobar si SetBackdrop está disponible
                    if frame.showEditBox.SetBackdrop then
                        frame.showEditBox:SetBackdrop({
                            bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
                            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
                            tile = true, tileSize = 16, edgeSize = 16,
                            insets = { left = 4, right = 4, top = 4, bottom = 4 }
                        })
                        frame.showEditBox:SetBackdropColor(0, 0, 0, 0) -- Fondo transparente
                        frame.showEditBox:SetBackdropBorderColor(0, 1, 0, 1) -- Borde verde
                    else
                        print("|cffff0000[ERROR] No se pudo aplicar SetBackdrop en el marco|r")
                    end
                end

                if frame.showEditBox then
                    frame.showEditBox:Show()
                end
            end
        end

    else
        print("|cff00ffcc[Config] Modo Edición Desactivado|r")

        -- Ocultar marcos verdes
        for _, frameRef in pairs({ 
            EPC.modules.PlayerFrame and EPC.modules.PlayerFrame.playerFrame, 
            EPC.modules.TargetFrame and EPC.modules.TargetFrame.targetFrame, 
            EPC.modules.PetFrame and EPC.modules.PetFrame.petFrame 
        }) do

            if frameRef and frameRef.showEditBox then
                frameRef.showEditBox:Hide()
            end
        end
    end
end