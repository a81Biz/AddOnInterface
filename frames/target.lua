local EsteticaPlus = _G["EsteticaPlusClassic"]

local frame = TargetFrame
EsteticaPlus:CrearMover("TargetFrame", frame)

local pos = EsteticaPlus.settings["TargetFrame"]
if pos then
    frame:ClearAllPoints()
    frame:SetPoint(pos.point, UIParent, pos.relativePoint, pos.x, pos.y)
end
