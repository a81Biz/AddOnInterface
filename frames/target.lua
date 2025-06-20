local EPC = _G["EsteticaPlusClassic"]

EPC.modules.TargetFrame = {}

function EPC.modules.TargetFrame:Initialize()
    print("[EPC] Iniciando marco del objetivo...")

    self:CreateTargetFrame()
end

function EPC.modules.TargetFrame:CreateTargetFrame()
    local frame = CreateFrame("Frame", "EPC_TargetFrame", UIParent)
    frame:SetSize(200, 40)
    frame:SetPoint("CENTER", UIParent, "CENTER", 250, 0)

    frame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    frame:SetBackdropColor(0, 0, 0, 0.8)

    local healthBar = CreateFrame("StatusBar", nil, frame)
    healthBar:SetAllPoints(frame)
    healthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    healthBar:SetMinMaxValues(0, 100)
    healthBar:SetValue(100)
    healthBar:SetStatusBarColor(0, 1,