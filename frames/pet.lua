local EPC = _G["EsteticaPlusClassic"]

EPC.modules.PetFrame = {}

function EPC.modules.PetFrame:Initialize()
    print("[EPC] Iniciando marco de la mascota...")

    self:CreatePetFrame()
end

function EPC.modules.PetFrame:CreatePetFrame()
    local frame = CreateFrame("Frame", "EPC_PetFrame", UIParent)
    frame:SetSize(150, 30)
    frame:SetPoint("CENTER", UIParent, "CENTER", -250, -50)

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
    healthBar:SetStatusBarColor(0, 1, 0)

    local nameText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    nameText:SetPoint("LEFT", frame, "LEFT", 5, 0)
    nameText:SetText("Mascota")

    local healthText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    healthText:SetPoint("RIGHT", frame, "RIGHT", -5, 0)
    healthText:SetText("100%")

    self.petFrame = frame
    self.petHealthBar = healthBar
    self.petNameText = nameText
    self.petHealthText = healthText
end