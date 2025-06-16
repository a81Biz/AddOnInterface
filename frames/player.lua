local frame = PlayerFrame
local mover = CreateFrame("Frame", "EsteticaPlus_PlayerMover", UIParent)

mover:SetSize(frame:GetWidth(), frame:GetHeight())
mover:SetPoint("CENTER", frame, "CENTER", 0, 0)
mover:SetFrameStrata("HIGH")
mover:EnableMouse(true)
mover:SetMovable(true)
mover:Hide()

-- Fondo verde transparente
mover.texture = mover:CreateTexture(nil, "BACKGROUND")
mover.texture:SetAllPoints()
mover.texture:SetColorTexture(0, 1, 0, 0.3)

-- Nombre
mover.text = mover:CreateFontString(nil, "OVERLAY", "GameFontNormal")
mover.text:SetText("PlayerFrame")
mover.text:SetPoint("CENTER")

-- Eventos
mover:SetScript("OnMouseDown", function(self, button)
  if button == "LeftButton" then
    self:StartMoving()
  elseif button == "RightButton" then
    EsteticaPlus.moverActivo = frame
    EsteticaPlus.configPanel:MostrarControles("PlayerFrame", frame)
  end
end)

mover:SetScript("OnMouseUp", function(self)
  self:StopMovingOrSizing()
  local point, _, relativePoint, xOfs, yOfs = self:GetPoint()
  frame:ClearAllPoints()
  frame:SetPoint(point, UIParent, relativePoint, xOfs, yOfs)
end)

-- Activación desde el sistema general
EsteticaPlus.frames["PlayerFrame"] = {
  mover = mover,
  frame = frame,
  Escalar = function(scale)
    frame:SetScale(scale)
    mover:SetScale(scale)
  end
}
