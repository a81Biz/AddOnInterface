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

    -- Cargar el botón del minimapa
    self:LoadModule("MinimapButton")
end

-- Evento al cargar el AddOn
local eventFrame = CreateFrame("Frame")
eventFrame:SetScript("OnEvent", function(self, event, addonName)
    if event == "ADDON_LOADED" and addonName == ADDON_NAME then
        EPC:OnInitialize()
    end
end)
eventFrame:RegisterEvent("ADDON_LOADED")