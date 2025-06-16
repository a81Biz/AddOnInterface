EsteticaPlusClassic = EsteticaPlusClassic or {}
EsteticaPlus = EsteticaPlus or {}
EsteticaPlus.frames = {}
EsteticaPlus.activo = false
EsteticaPlus.moverActivo = nil

local function cargarFrames()
  local cargar = {
    "frames/player.lua",
    "frames/target.lua"
    -- Agregar más aquí conforme avancen
  }

  for _, path in ipairs(cargar) do
    RunScript('LoadAddOn("' .. path .. '")')
  end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(_, event, arg1)
  if arg1 == "EsteticaPlusClassic" then
    if not EsteticaPlusDB then
      EsteticaPlusDB = {}
    end

    -- Cargar los módulos directamente
    cargarFrames()

    print("Estética+ Classic cargado correctamente.")
  end
end)
