local EPC = _G["EsteticaPlusClassic"]

EPC.modules.Mover = {}

function EPC.modules.Mover:Initialize()
    print("[EPC] Iniciando módulo Mover...")

    if EPC.modules.PlayerFrame and EPC.modules.PlayerFrame.playerFrame then
        self:RegisterMoveHandler(EPC.modules.PlayerFrame.playerFrame, "player")
    else
        print("|cffff9900[Mover] No se encontró PlayerFrame|r")
    end

    if EPC.modules.TargetFrame and EPC.modules.TargetFrame.targetFrame then
        self:RegisterMoveHandler(EPC.modules.TargetFrame.targetFrame, "target")
    else
        print("|cffff9900[Mover] No se encontró TargetFrame|r")
    end

    if EPC.modules.PetFrame and EPC.modules.PetFrame.petFrame then
        self:RegisterMoveHandler(EPC.modules.PetFrame.petFrame, "pet")
    else
        print("|cffff9900[Mover] No se encontró PetFrame|r")
    end
end

function EPC.modules.Mover:RegisterMoveHandler(frame, frameKey)
    if not frame then
        print("|cffff0000[ERROR - Mover] No se encontró el marco: " .. frameKey .. "|r")
        return
    end

    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")

    -- Cargar posición guardada
    local savedPos = EPC.db.positions[frameKey] or {
        point = "CENTER",
        relativeTo = "UIParent",
        relativePoint = "CENTER",
        xOfs = 0,
        yOfs = 0
    }

    frame:SetPoint(savedPos.point, savedPos.relativeTo, savedPos.relativePoint, savedPos.xOfs, savedPos.yOfs)

    -- Drag handler
    frame:SetScript("OnDragStart", function(f)
        f:StartMoving()
    end)

    frame:SetScript("OnDragStop", function(f)
        f:StopMovingOrSizing()

        -- Guardar nueva posición
        local point, _, relativePoint, xOfs, yOfs = f:GetPoint()
        EPC.db.positions[frameKey] = {
            point = point,
            relativeTo = "UIParent",
            relativePoint = relativePoint,
            xOfs = xOfs,
            yOfs = yOfs
        }

        print(string.format("|cff00ffcc[Mover] Posición guardada para %s|r", frameKey))
    end)
end