local EPC = _G["EsteticaPlusClassic"]

EPC.modules.PlayerFrame = {}

function EPC.modules.PlayerFrame:Initialize()
    print("[EPC] Iniciando marco del jugador...")

    self:CreatePlayerFrame()
end

function EPC.modules.PlayerFrame:CreatePlayerFrame()
    local frame = CreateFrame("Frame", "EPC_PlayerFrame", UIParent)
    frame:SetSize(200, 40)
    frame:SetPoint("CENTER", UIParent, "CENTER", -250, 0)

    -- -- Fondo del marco
    -- frame:SetBackdrop({
    --     bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    --     edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    --     tile = true, tileSize = 16, edgeSize = 16,
    --     insets = { left = 4, right = 4, top = 4, bottom = 4 }
    -- })
    -- frame:SetBackdropColor(0, 0, 0, 0.8)

    -- Barra de salud
    local healthBar = CreateFrame("StatusBar", nil, frame)
    healthBar:SetAllPoints(frame)
    healthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    healthBar:SetMinMaxValues(0, 100)
    healthBar:SetValue(100)
    healthBar:SetStatusBarColor(0, 1, 0)

    -- Texto del nombre
    local nameText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    nameText:SetPoint("LEFT", frame, "LEFT", 5, 0)
    nameText:SetText("Jugador")

    -- Texto de vida
    local healthText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    healthText:SetPoint("RIGHT", frame, "RIGHT", -5, 0)
    healthText:SetText("100%")

    -- Guardamos referencias
    self.playerFrame = frame
    self.playerHealthBar = healthBar
    self.playerNameText = nameText
    self.playerHealthText = healthText
end