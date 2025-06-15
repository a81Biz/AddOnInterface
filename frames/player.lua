local EsteticaPlus = _G["EsteticaPlusClassic"]

local frame = PlayerFrame
EsteticaPlus:CrearMover("PlayerFrame", frame)

-- Restaurar posición si está guardada
local pos = EsteticaPlus.settings["PlayerFrame"]
if pos then
    frame:ClearAllPoints()
    frame:SetPoint(pos.point, UIParent, pos.relativePoint, pos.x, pos.y)
end
