local f = CreateFrame("Frame", "EsteticaPlusClassic_ConfigPanel", UIParent, "BasicFrameTemplateWithInset")
f:SetSize(300, 200)
f:SetPoint("CENTER")
f:Hide()

f.title = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
f.title:SetPoint("TOP", f, "TOP", 0, -10)
f.title:SetText("Configuración EsteticaPlusClassic")