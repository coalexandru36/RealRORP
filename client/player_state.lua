
-- periodic player state update

local state_ready = false

AddEventHandler("playerSpawned",function() -- delay state recording
  state_ready = false
  
	CreateThread(function()
		Wait(30000)
		state_ready = true
	end)  
end)

CreateThread(function()
  while true do
    Wait(30000)

    if IsPlayerPlaying(PlayerId()) and state_ready then
      local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
      vRPserver.updatePos({x,y,z})
      vRPserver.updateHealth({tvRP.getHealth()})
      vRPserver.updateWeapons({tvRP.getWeapons()})
      vRPserver.updateCustomization({tvRP.getCustomization()})
    end
  end
end)

-- WEAPONS

-- def
local weapon_types = {
  {"WEAPON_KNIFE"},
  {"WEAPON_STUNGUN"},
  {"WEAPON_FLASHLIGHT"},
  {"WEAPON_VINTAGEPISTOL"},
  {"WEAPON_CARBINERIFLE_MK2"},
  {"WEAPON_NIGHTSTICK"},
  {"WEAPON_HAMMER"},
  {"WEAPON_NAVYREVOLVER"},
  {"WEAPON_PISTOL_MK2"},
  {"WEAPON_SWITCHBLADE"},
  {"WEAPON_MACHETE"},
  {"WEAPON_KNUCKLE"},
  {"WEAPON_MINISMG"},
  {"WEAPON_BAT"},
  {"WEAPON_HATCHET"},
  {"WEAPON_DOUBLEACTION"},
  {"WEAPON_GOLFCLUB"},
  {"WEAPON_CROWBAR"},
  {"WEAPON_GADGETPISTOL"},
  {"WEAPON_PISTOL","COMPONENT_AT_PI_SUPP_02","COMPONENT_AT_PI_FLSH","COMPONENT_PISTOL_VARMOD_LUXE"},
  {"WEAPON_COMBATPISTOL","COMPONENT_AT_PI_SUPP","COMPONENT_AT_PI_FLSH","COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER"},
  {"WEAPON_APPISTOL","COMPONENT_AT_PI_SUPP","COMPONENT_AT_PI_FLSH","COMPONENT_APPISTOL_VARMOD_LUXE"},
  {"WEAPON_PISTOL50","COMPONENT_AT_AR_SUPP_02","COMPONENT_AT_PI_FLSH","COMPONENT_PISTOL50_VARMOD_LUXE"},
  {"WEAPON_MICROSMG","COMPONENT_AT_AR_SUPP_02","COMPONENT_AT_PI_FLSH","COMPONENT_MICROSMG_VARMOD_LUXE"},
  {"WEAPON_SMG","COMPONENT_AT_PI_SUPP","COMPONENT_AT_AR_FLSH","COMPONENT_SMG_VARMOD_LUXE"},
  {"WEAPON_ASSAULTSMG","COMPONENT_AT_AR_SUPP_02","COMPONENT_AT_AR_FLSH","COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER"},
  {"WEAPON_ASSAULTRIFLE","COMPONENT_AT_AR_SUPP_02","COMPONENT_AT_AR_FLSH","COMPONENT_ASSAULTRIFLE_VARMOD_LUXE","COMPONENT_AT_AR_AFGRIP"},
  {"WEAPON_SPECIALCARABINE","COMPONENT_AT_AR_SUPP_02","COMPONENT_AT_AR_FLSH","COMPONENT_ASSAULTRIFLE_VARMOD_LUXE","COMPONENT_AT_AR_AFGRIP"},
  {"WEAPON_CARBINERIFLE","COMPONENT_AT_AR_SUPP","COMPONENT_AT_AR_FLSH","COMPONENT_CARBINERIFLE_VARMOD_LUXE","COMPONENT_AT_AR_AFGRIP"},
  {"WEAPON_ADVANCEDRIFLE","COMPONENT_AT_AR_SUPP","COMPONENT_AT_AR_FLSH","COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE"},
  {"WEAPON_SPECIALCARBINE","COMPONENT_AT_AR_SUPP","COMPONENT_AT_AR_FLSH","COMPONENT_SPECIALCARBINE_VARMOD_LUXE"},
  {"WEAPON_MG"},
  {"WEAPON_COMBATMG"},
  {"WEAPON_PUMPSHOTGUN","COMPONENT_AT_SR_SUPP","COMPONENT_AT_AR_FLSH","COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER"},
  {"WEAPON_SAWNOFFSHOTGUN"},
  {"WEAPON_ASSAULTSHOTGUN","COMPONENT_AT_AR_SUPP","COMPONENT_AT_AR_FLSH","COMPONENT_AT_AR_AFGRIP"},
  {"WEAPON_HEAVYSHOTGUN","COMPONENT_AT_AR_SUPP","COMPONENT_AT_AR_FLSH","COMPONENT_AT_AR_AFGRIP"},
  {"WEAPON_BULLPUPSHOTGUN","COMPONENT_AT_AR_SUPP_02","COMPONENT_AT_AR_FLSH"},
  {"WEAPON_STUNGUN"},
  {"WEAPON_SNIPERRIFLE","COMPONENT_AT_AR_SUPP_02"},
  {"WEAPON_HEAVYSNIPER"},
  {"WEAPON_COMBATMG_MK2"},
  {"WEAPON_REMOTESNIPER"},
  {"WEAPON_HEAVYSNIPER_MK2"},
  {"WEAPON_GUSENBERG"},
  {"WEAPON_GRENADELAUNCHER"},
  {"WEAPON_GRENADELAUNCHER_SMOKE"},
  {"WEAPON_RPG"},
  {"WEAPON_PASSENGER_ROCKET"},
  {"WEAPON_AIRSTRIKE_ROCKET"},
  {"WEAPON_STINGER"},
  {"WEAPON_MINIGUN"},
  {"WEAPON_GRENADE"},
  {"WEAPON_STICKYBOMB"},
  {"WEAPON_SMOKEGRENADE"},
  {"WEAPON_BZGAS"},
  {"WEAPON_MOLOTOV"},
  {"WEAPON_FIREEXTINGUISHER"},
  {"WEAPON_PETROLCAN"},
  {"WEAPON_DIGISCANNER"},
  {"WEAPON_BRIEFCASE"},
  {"WEAPON_BRIEFCASE_02"},
  {"WEAPON_BALL"},
  {"WEAPON_FLARE"}
}

function tvRP.getWeaponTypes()
  return weapon_types
end

function tvRP.getWeapons()
  local player = PlayerPedId()

  local ammo_types = {} -- remember ammo type to not duplicate ammo amount

  local weapons = {}
  for k,v in pairs(weapon_types) do
    local hash = GetHashKey(v[1])
    if HasPedGotWeapon(player,hash) then
      local weapon = {}
      weapons[v[1]] = weapon

      local atype = Citizen.InvokeNative(0x7FEAD38B326B9F74, player, hash)
      if ammo_types[atype] == nil then
        ammo_types[atype] = true
        weapon.ammo = GetAmmoInPedWeapon(player,hash)
      else
        weapon.ammo = 0
      end
      if v[2] ~= nil then
        if HasPedGotWeaponComponent(player,hash, GetHashKey(tostring(v[2]))) == 1 then
          weapon.supressor = tostring(v[2])
        else
          weapon.supressor = "nu"
        end
      end
      if v[3] ~= nil then
        if HasPedGotWeaponComponent(player,hash, GetHashKey(tostring(v[3]))) == 1 then
          weapon.flash = tostring(v[3])
        else
          weapon.flash = "nu"
        end
      end
      if v[4] ~= nil then
        if HasPedGotWeaponComponent(player,hash, GetHashKey(tostring(v[4]))) == 1 then
          weapon.yusuf = tostring(v[4])
        else
          weapon.yusuf = "nu"
        end
      end
      if v[5] ~= nil then
        if HasPedGotWeaponComponent(player,hash, GetHashKey(tostring(v[5]))) == 1 then
          weapon.grip = tostring(v[5])
        else
          weapon.grip = "nu"
        end
      end
    end
  end

  return weapons
end

function formatMoney(amount)
  local left,num,right = string.match(tostring(amount),'^([^%d]*%d)(%d*)(.-)$')
  return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

function tvRP.setArmour(armour,vest)
  local ped = PlayerPedId()

  if vest then
  	RequestAnimDict("clothingtie")
    while not HasAnimDictLoaded("clothingtie") do
      Wait(1) 
    end
	  TaskPlayAnim(ped, "clothingtie", "try_tie_negative_a", 3.0, 3.0, 2000, 01, 0, false, false, false)

  	local model = GetEntityModel(ped)

    if model == maleModel then
      SetPedComponentVariation(ped, 9, 6, 1, 2)  --Bulletproof Vest
    elseif model == femaleModel then
        SetPedComponentVariation(ped, 9, 6, 1, 2)
    end
  end
  
  local n = math.floor(armour)
  SetPedArmour(ped, n)
end

-- tvRP.updateHudMare = function(playerson)
--   SendNUIMessage({act="update_hud_mare", playerson = playerson})
-- end

-- tvRP.updateHudNUI = function(cemodifica,value)
--   if cemodifica == "hunger" then
--     SendNUIMessage({act="update_hud_status", modificare = {cemodifica,math.ceil(100-value)}})
--   elseif cemodifica == "thirst" then 
--     SendNUIMessage({act="update_hud_status", modificare = {cemodifica,math.ceil(100-value)}})
--   elseif cemodifica == "money" then 
--     SendNUIMessage({act="update_hud_bani", modificare = {cemodifica,value}})
--   elseif cemodifica == "bankmoney" then 
--     SendNUIMessage({act="update_hud_bani", modificare = {cemodifica,value}})
--   elseif cemodifica == "giftpoints" then 
--     SendNUIMessage({act="update_hud_bani", modificare = {cemodifica,value}})
--   elseif cemodifica == "payday" then 
--     SendNUIMessage({act="update_hud_payday", modificare = {cemodifica,"PAYDAY "..value}})
--   elseif cemodifica == "tickets" then 
--     SendNUIMessage({act="update_hud_tickets", modificare = {cemodifica,value.." <span style = 'color: rgb(32, 167, 205)'>Tickete</span>"}})
--   elseif cemodifica == "safezone" then 
--     SendNUIMessage({act="update_hud_safezone", value = value})
--   end
-- end

local showTransactions = false
local onScreenEffects = {}
local function formatMoney(amount)
    local left,num,right = string.match(tostring(amount),'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

local function filtern(t, cb) 
    local j = 1 
    for i, v in ipairs(t) do 
        if cb(v) then 
            t[j] = v 
            j = j + 1 
        end 
    end 
    while t[j] ~= nil do 
        t[j] = nil 
        j = j + 1 
    end 
    return t 
end
  
function showIncome()
    if showTransactions then return end
    showTransactions = true
    hasIncome = GetGameTimer() + 15000
    while hasIncome > GetGameTimer() and showTransactions do
        RequestStreamedTextureDict("MPHud")
        for i, e in pairs(onScreenEffects) do
            local sw, sh = GetScreenResolution()
            local w = 18.0
            local h = 18.0
            local sY = e.yFade
            
            SetDrawOrigin(e.x, e.y, e.z, 0)
            SetTextFont(4)
            SetTextColour(255, 255, 255, 255)
            SetTextScale(0.42, 0.42)
            SetTextDropShadow(2, 2, 0, 0, 0)
            SetTextOutline()
            SetTextEntry("STRING")
            SetTextColour(e.r,e.g,e.b,e.a)
            AddTextComponentString(e.text)
            DrawText(8 / sw, (-10.0 - sY) / sh)
            DrawSprite("MPHud", e.sprite, 0.0, -sY / sh, w / sw, h / sh, 0.0, 255, 255, 255, 255)
            ClearDrawOrigin()
            
            if e.fadeAfter <= 0 then 
                e.yFade = e.yFade * 1.4
            end
            e.ticks = e.ticks - 1
            e.fadeAfter = e.fadeAfter - 1
        end
        onScreenEffects = filtern(onScreenEffects, function(e) return e.ticks > 0 end)
        Wait(1)
    end
    showTransactions = false
end
  
function IncomeMoney(amount, transactionType)
    local text = ""
    local r,g,b,a = 255,255,255,255
    if transactionType then
        text = "~g~+"..formatMoney(amount).."$"
        r,g,b = 0,255,0
    else
        text = "~r~-"..formatMoney(amount).."$"
        r,g,b = 255,0,0
    end

    onScreenEffects[#onScreenEffects + 1] = {
        x = _GCOORDS.x + GetRandomFloatInRange(-0.5, 0.5), 
        y = _GCOORDS.y + GetRandomFloatInRange(-0.5, 0.5), 
        z = _GCOORDS.z + GetRandomFloatInRange(-0.5, 0.5),
        sprite = "mp_anim_cash",
        text = text,
        yFade = 1.0,
        r = r,
        g = g,
        b = b,
        a = a,
        fadeAfter = 80,
        ticks = 140
    }
    PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    showIncome()
end

function tvRP.arataTranzactie(tip, amount, gType)
    pos = GetEntityCoords(GetPlayerPed(-1))
    local bani = tonumber(amount)
    if tip == "plus" then
        IncomeMoney(formatMoney(bani), true)
    else
        IncomeMoney(formatMoney(bani), false)
    end
end

function tvRP.giveWeapons(weapons,clear_before)
  local player = PlayerPedId()

  -- give weapons to player

  if clear_before then
    RemoveAllPedWeapons(player,true)
  end

  for k,weapon in pairs(weapons) do
    local hash = GetHashKey(k)
    local ammo = weapon.ammo or 0
    GiveWeaponToPed(player, hash, ammo, false)
    if weapon.supressor ~= "nu" and weapon.supressor ~= nil then
      GiveWeaponComponentToPed(PlayerPedId(), hash, GetHashKey(weapon.supressor))
    end
    if weapon.flash ~= "nu" and weapon.flash ~= nil then
      GiveWeaponComponentToPed(PlayerPedId(), hash, GetHashKey(weapon.flash))
    end
    if weapon.yusuf ~= "nu" and weapon.yusuf ~= nil then
      GiveWeaponComponentToPed(PlayerPedId(), hash, GetHashKey(weapon.yusuf))
    end
    if weapon.grip ~= "nu" and weapon.grip ~= nil then
      GiveWeaponComponentToPed(PlayerPedId(), hash, GetHashKey(weapon.grip))
    end
  end
end

--[[
function tvRP.dropWeapon()
  SetPedDropsWeapon(PlayerPedId())
end
--]]

-- PLAYER CUSTOMIZATION

-- parse part key (a ped part or a prop part)
-- return is_proppart, index
local function parse_part(key)
  if type(key) == "string" and string.sub(key,1,1) == "p" then
    return true,tonumber(string.sub(key,2))
  else
    return false,tonumber(key)
  end
end

function tvRP.getDrawables(part)
  local isprop, index = parse_part(part)
  if isprop then
    return GetNumberOfPedPropDrawableVariations(PlayerPedId(),index)
  else
    return GetNumberOfPedDrawableVariations(PlayerPedId(),index)
  end
end

function tvRP.getDrawableTextures(part,drawable)
  local isprop, index = parse_part(part)
  if isprop then
    return GetNumberOfPedPropTextureVariations(PlayerPedId(),index,drawable)
  else
    return GetNumberOfPedTextureVariations(PlayerPedId(),index,drawable)
  end
end

function tvRP.getCustomization()
  local ped = PlayerPedId()

  local custom = {}

  custom.modelhash = GetEntityModel(ped)

  -- ped parts
  for i=0,20 do -- index limit to 20
    custom[i] = {GetPedDrawableVariation(ped,i), GetPedTextureVariation(ped,i), GetPedPaletteVariation(ped,i)}
  end

  -- props
  for i=0,10 do -- index limit to 10
    custom["p"..i] = {GetPedPropIndex(ped,i), math.max(GetPedPropTextureIndex(ped,i),0)}
  end

  return custom
end

-- partial customization (only what is set is changed)
-- partial customization (only what is set is changed)
function tvRP.setCustomization(custom) -- indexed [drawable,texture,palette] components or props (p0...) plus .modelhash or .model
  local exit = TUNNEL_DELAYED() -- delay the return values

  CreateThread(function() -- new thread
    if custom then
      local ped = PlayerPedId()
      local mhash = nil

      -- model
      if custom.modelhash ~= nil then
        mhash = custom.modelhash
      elseif custom.model ~= nil then
        mhash = GetHashKey(custom.model)
      end

      if mhash ~= nil then
        local i = 0
        while not HasModelLoaded(mhash) and i < 10000 do
          RequestModel(mhash)
          Wait(10)
        end

        if HasModelLoaded(mhash) then
          -- changing player model remove weapons, so save it
          local weapons = tvRP.getWeapons()
          SetPlayerModel(PlayerId(), mhash)
          tvRP.giveWeapons(weapons,true)
          SetModelAsNoLongerNeeded(mhash)
        end
      end

      ped = PlayerPedId()

      -- parts
      for k,v in pairs(custom) do
        if k ~= "model" and k ~= "modelhash" then
          local isprop, index = parse_part(k)
          if isprop then
            if v[1] < 0 then
              ClearPedProp(ped,index)
            else
              SetPedPropIndex(ped,index,v[1],v[2],v[3] or 2)
            end
          else
            SetPedComponentVariation(ped,index,v[1],v[2],v[3] or 2)
          end
        end
      end
    end

    exit({})
  end)
end