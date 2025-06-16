local EPC = _G["EsteticaPlusClassic"]

EPC.modules.UnitFrame = {}

function EPC.modules.UnitFrame:Initialize()
    print("[EPC] Cargando marcos personalizados...")

    self:CreatePlayerFrame()
    self:CreateTargetFrame()
    self:CreatePetFrame()
end

function EPC.modules.UnitFrame:CreatePlayerFrame()
    local frame = CreateFrame("Frame", "EPC_PlayerFrame", UIParent)
    frame:SetSize(200, 40)
    frame:SetPoint("CENTER", UIParent, "CENTER", -250, 100)
    frame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    frame:SetBackdropColor(0, 0, 0, 0.8)

    -- Barra de vida
    local healthBar = CreateFrame("StatusBar", nil, frame)
    healthBar:SetAllPoints(frame)
    healthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    healthBar:SetMinMaxValues(0, 100)
    healthBar:SetValue(100)
    healthBar:SetStatusBarColor(0, 1, 0)

    self.playerFrame = frame
end

-- Puedes hacer lo mismo para target, pet, party, etc.