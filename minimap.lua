-- minimap.lua
-- Ícono flotante en el minimapa para abrir/cerrar el panel de configuración

local EsteticaPlus = _G["EsteticaPlusClassic"]

function EsteticaPlus:InicializarMinimap()
    if not LibStub then
        print(">> LibStub no encontrado. El ícono del minimapa no se podrá mostrar.")
        return
    end

    local LDB = LibStub("LibDataBroker-1.1", true)
    if not LDB then
        print(">> LibDataBroker-1.1 no encontrado. El ícono del minimapa no se podrá mostrar.")
        return
    end

    -- Definición del objeto de datos del minimapa
    local ldbButton = LDB:NewDataObject("EsteticaPlusClassic", {
        type = "data source",
        text = "Estetica+",
        icon = "Interface\\AddOns\\EsteticaPlusClassic\\media\\icon.blp",
        OnClick = function(_, button)
            if button == "LeftButton" then
                EsteticaPlus:ToggleEditMode()
            elseif button == "RightButton" then
                if not EsteticaPlus.ConfigPanel:IsShown() then
                    EsteticaPlus.ConfigPanel:Show()
                else
                    EsteticaPlus.ConfigPanel:Hide()
                end
            end
        end,
        OnTooltipShow = function(tooltip)
            tooltip:AddLine("EsteticaPlusClassic")
            tooltip:AddLine("Click izquierdo: Modo edición")
            tooltip:AddLine("Click derecho: Mostrar configuración")
        end,
    })

    -- Registrar el ícono en el minimapa
    if LibStub("LibDBIcon-1.0", true) then
        local icon = LibStub("LibDBIcon-1.0")
        EsteticaPlusDB = EsteticaPlusDB or { minimap = { hide = false } }
        icon:Register("EsteticaPlusClassic", ldbButton, EsteticaPlusDB.minimap)
    end
end
