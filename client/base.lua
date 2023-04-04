cfg = module("cfg/client")

tvRP = {}
local players = {}-- keep track of connected players (server id)
local CreateThread = CreateThread
local Wait = Wait

_GPED = PlayerPedId()
_GCOORDS = vector3(0.0,0.0,0.0)
_GPLAYER = PlayerId()
_GVEHICLE = GetVehiclePedIsIn(_GPED,false)

-- bind client tunnel interface
Tunnel.bindInterface("vRP", tvRP)

-- get server interface
vRPserver = Tunnel.getInterface("vRP", "vRP")

-- add client proxy interface (same as tunnel interface)
Proxy.addInterface("vRP", tvRP)
local Wait = Citizen.Wait
local CreateThread = Citizen.CreateThread

-- functions
function tvRP.teleport(x, y, z)
    tvRP.unjail()-- force unjail before a teleportation
    SetEntityCoords(PlayerPedId(), x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
    vRPserver.updatePos({x, y, z})
end

-- return x,y,z
function tvRP.getPosition()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    return x, y, z
end

tvRP.subtitle = function(text, ms)
    ms = tonumber(ms)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(ms, 1)
end

local subtitle_ended = true
function tvRP.subtitleTimer(msg, secconds)
    while not subtitle_ended do Citizen.Wait(100) end
    subtitle_ended = false
    Citizen.CreateThread(function()
        while not subtitle_ended do
            Citizen.Wait(1)
            SetTextFont(6)
            SetTextProportional(0)
            SetTextScale(0.6, 0.6)
            SetTextColour(255, 255, 255, 255)
            SetTextDropShadow(0, 0, 0, 0, 255)
            SetTextEdge(1, 0, 0, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextCentre(1)
            SetTextEntry("STRING")
            AddTextComponentString(msg)
            DrawText(0.5, 0.8)
        end
    end)
    if not secconds then secconds = 3 end
    Citizen.Wait(secconds * 1000)
    subtitle_ended = true
end

local fontId = RegisterFontId('Freedom Font')
function tvRP.subtitleText(f)
    SetTextFont(fontId)
    SetTextProportional(0)
	SetTextScale(0.35,0.35)
    SetTextColour(255,255,255,255)
    SetTextDropShadow(0,0,0,0,255)
    SetTextEdge(1,0,0,0,255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(f)
    DrawText(0.5,0.95)
end

-- return false if in exterior, true if inside a building
function tvRP.isInside()
    local x, y, z = tvRP.getPosition()
    return not (GetInteriorAtCoords(x, y, z) == 0)
end

-- return vx,vy,vz
function tvRP.getSpeed()
    local vx, vy, vz = table.unpack(GetEntityVelocity(PlayerPedId()))
    return math.sqrt(vx * vx + vy * vy + vz * vz)
end

tvRP.formatMoney = function(amount)
    local left, num, right = string.match(tostring(amount), '^([^%d]*%d)(%d*)(.-)$')
    return left .. (num:reverse():gsub('(%d%d%d)', '%1.'):reverse()) .. right
end



AddEventHandler("playerSpawned", function(spawn)
	SetCanAttackFriendly(PlayerPedId(), true, false)
	NetworkSetFriendlyFireOption(true)
end)

local scopedWeapons =
    {
        100416529,
        205991906,
        3342088282
    }

function HashInTable(hash)
    for k, v in pairs(scopedWeapons) do
        if (hash == v) then
            return true
        end
    end
    
    return false
end

ClientPickupList = {"PICKUP_AMMO_BULLET_MP", "PICKUP_AMMO_FIREWORK", "PICKUP_AMMO_FIREWORK_MP", "PICKUP_AMMO_FLAREGUN", "PICKUP_AMMO_GRENADELAUNCHER", "PICKUP_AMMO_GRENADELAUNCHER_MP", "PICKUP_AMMO_HOMINGLAUNCHER", "PICKUP_AMMO_MG", "PICKUP_AMMO_MINIGUN", "PICKUP_AMMO_MISSILE_MP", "PICKUP_AMMO_PISTOL", "PICKUP_AMMO_RIFLE", "PICKUP_AMMO_RPG", "PICKUP_AMMO_SHOTGUN", "PICKUP_AMMO_SMG", "PICKUP_AMMO_SNIPER", "PICKUP_ARMOUR_STANDARD", "PICKUP_CAMERA", "PICKUP_CUSTOM_SCRIPT", "PICKUP_GANG_ATTACK_MONEY", "PICKUP_HEALTH_SNACK", "PICKUP_HEALTH_STANDARD", "PICKUP_MONEY_CASE", "PICKUP_MONEY_DEP_BAG", "PICKUP_MONEY_MED_BAG", "PICKUP_MONEY_PAPER_BAG", "PICKUP_MONEY_PURSE", "PICKUP_MONEY_SECURITY_CASE", "PICKUP_MONEY_VARIABLE", "PICKUP_MONEY_WALLET", "PICKUP_PARACHUTE", "PICKUP_PORTABLE_CRATE_FIXED_INCAR", "PICKUP_PORTABLE_CRATE_FIXED_INCAR_SMALL", "PICKUP_PORTABLE_CRATE_FIXED_INCAR_WITH_PASSENGERS", "PICKUP_PORTABLE_CRATE_UNFIXED", "PICKUP_PORTABLE_CRATE_UNFIXED_INAIRVEHICLE_WITH_PASSENGERS", "PICKUP_PORTABLE_CRATE_UNFIXED_INCAR", "PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL", "PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_WITH_PASSENGERS", "PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW", "PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE", "PICKUP_PORTABLE_PACKAGE", "PICKUP_PORTABLE_PACKAGE_LARGE_RADIUS", "PICKUP_SUBMARINE", "PICKUP_VEHICLE_ARMOUR_STANDARD", "PICKUP_VEHICLE_CUSTOM_SCRIPT", "PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW", "PICKUP_VEHICLE_CUSTOM_SCRIPT_NO_ROTATE", "PICKUP_VEHICLE_HEALTH_STANDARD", "PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW", "PICKUP_VEHICLE_MONEY_VARIABLE", "PICKUP_VEHICLE_WEAPON_APPISTOL", "PICKUP_VEHICLE_WEAPON_ASSAULTSMG", "PICKUP_VEHICLE_WEAPON_COMBATPISTOL", "PICKUP_VEHICLE_WEAPON_GRENADE", "PICKUP_VEHICLE_WEAPON_MICROSMG", "PICKUP_VEHICLE_WEAPON_MOLOTOV", "PICKUP_VEHICLE_WEAPON_PISTOL", "PICKUP_VEHICLE_WEAPON_PISTOL50", "PICKUP_VEHICLE_WEAPON_SAWNOFF", "PICKUP_VEHICLE_WEAPON_SMG", "PICKUP_VEHICLE_WEAPON_SMOKEGRENADE", "PICKUP_VEHICLE_WEAPON_STICKYBOMB", "PICKUP_WEAPON_ADVANCEDRIFLE", "PICKUP_WEAPON_APPISTOL", "PICKUP_WEAPON_ASSAULTRIFLE", "PICKUP_WEAPON_ASSAULTRIFLE_MK2", "PICKUP_WEAPON_ASSAULTSHOTGUN", "PICKUP_WEAPON_ASSAULTSMG", "PICKUP_WEAPON_AUTOSHOTGUN", "PICKUP_WEAPON_BAT", "PICKUP_WEAPON_BATTLEAXE", "PICKUP_WEAPON_BOTTLE", "PICKUP_WEAPON_BULLPUPRIFLE", "PICKUP_WEAPON_BULLPUPRIFLE_MK2", "PICKUP_WEAPON_BULLPUPSHOTGUN", "PICKUP_WEAPON_CARBINERIFLE", "PICKUP_WEAPON_CARBINERIFLE_MK2", "PICKUP_WEAPON_COMBATMG", "PICKUP_WEAPON_COMBATMG_MK2", "PICKUP_WEAPON_COMBATPDW", "PICKUP_WEAPON_COMBATPISTOL", "PICKUP_WEAPON_COMPACTLAUNCHER", "PICKUP_WEAPON_COMPACTRIFLE", "PICKUP_WEAPON_CROWBAR", "PICKUP_WEAPON_DAGGER", "PICKUP_WEAPON_DBSHOTGUN", "PICKUP_WEAPON_DOUBLEACTION", "PICKUP_WEAPON_FIREWORK", "PICKUP_WEAPON_FLAREGUN", "PICKUP_WEAPON_FLASHLIGHT", "PICKUP_WEAPON_GRENADE", "PICKUP_WEAPON_GRENADELAUNCHER", "PICKUP_WEAPON_GUSENBERG", "PICKUP_WEAPON_GolfClub", "PICKUP_WEAPON_HAMMER", "PICKUP_WEAPON_HATCHET", "PICKUP_WEAPON_HEAVYPISTOL", "PICKUP_WEAPON_HEAVYSHOTGUN", "PICKUP_WEAPON_HEAVYSNIPER", "PICKUP_WEAPON_HEAVYSNIPER_MK2", "PICKUP_WEAPON_HOMINGLAUNCHER", "PICKUP_WEAPON_KNIFE", "PICKUP_WEAPON_KNUCKLE", "PICKUP_WEAPON_MACHETE", "PICKUP_WEAPON_MACHINEPISTOL", "PICKUP_WEAPON_MARKSMANPISTOL", "PICKUP_WEAPON_MARKSMANRIFLE", "PICKUP_WEAPON_MARKSMANRIFLE_MK2", "PICKUP_WEAPON_MG", "PICKUP_WEAPON_MICROSMG", "PICKUP_WEAPON_MINIGUN", "PICKUP_WEAPON_MINISMG", "PICKUP_WEAPON_MOLOTOV", "PICKUP_WEAPON_MUSKET", "PICKUP_WEAPON_NIGHTSTICK", "PICKUP_WEAPON_PETROLCAN", "PICKUP_WEAPON_PIPEBOMB", "PICKUP_WEAPON_PISTOL", "PICKUP_WEAPON_PISTOL50", "PICKUP_WEAPON_PISTOL_MK2", "PICKUP_WEAPON_POOLCUE", "PICKUP_WEAPON_PROXMINE", "PICKUP_WEAPON_PUMPSHOTGUN", "PICKUP_WEAPON_PUMPSHOTGUN_MK2", "PICKUP_WEAPON_RAILGUN", "PICKUP_WEAPON_RAYCARBINE", "PICKUP_WEAPON_RAYMINIGUN", "PICKUP_WEAPON_RAYPISTOL", "PICKUP_WEAPON_REVOLVER", "PICKUP_WEAPON_REVOLVER_MK2", "PICKUP_WEAPON_RPG", "PICKUP_WEAPON_SAWNOFFSHOTGUN", "PICKUP_WEAPON_SMG", "PICKUP_WEAPON_SMG_MK2", "PICKUP_WEAPON_SMOKEGRENADE", "PICKUP_WEAPON_SNIPERRIFLE", "PICKUP_WEAPON_SNSPISTOL", "PICKUP_WEAPON_SNSPISTOL_MK2", "PICKUP_WEAPON_SPECIALCARBINE", "PICKUP_WEAPON_SPECIALCARBINE_MK2", "PICKUP_WEAPON_STICKYBOMB", "PICKUP_WEAPON_STONE_HATCHET", "PICKUP_WEAPON_STUNGUN", "PICKUP_WEAPON_SWITCHBLADE", "PICKUP_WEAPON_VINTAGEPISTOL", "PICKUP_WEAPON_WRENCH"}

function RemoveWeaponDrops()
    for alpha = 1, #ClientPickupList do
        N_0x616093ec6b139dd9(PlayerId(), GetHashKey(ClientPickupList[alpha]), false)
        RemoveAllPickupsOfType(GetHashKey(ClientPickupList[alpha]))
    end
end

AddEventHandler("playerSpawned", function()
    Wait(10000)
    RemoveWeaponDrops()
end)

itemsOnGround = {}
function KeyboardInput(TextEntry, ExampleText, MaxStringLenght, NoSpaces)
    AddTextEntry(GetCurrentResourceName() .. '_KeyboardHead', TextEntry)
    DisplayOnscreenKeyboard(1, GetCurrentResourceName() .. '_KeyboardHead', '', ExampleText, '', '', '', MaxStringLenght)
    
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        if NoSpaces == true then
            drawNotification('~y~NO SPACES!')
        end
        Wait(0)
    end
    
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        return result
    else
        Wait(500)
        return nil
    end
end


function tvRP.teleport(x, y, z)
    local targetPed = PlayerPedId()
    local targetVeh = GetVehiclePedIsUsing(targetPed)
    if (IsPedInAnyVehicle(targetPed)) then
        targetPed = targetVeh
    end
    SetEntityCoords(targetPed, x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
    vRPserver.updatePos({x, y, z})
end

function tvRP.getCamDirection()
    local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
    local pitch = GetGameplayCamRelativePitch()
    
    local x = -math.sin(heading * math.pi / 180.0)
    local y = math.cos(heading * math.pi / 180.0)
    local z = math.sin(pitch * math.pi / 180.0)
    
    -- normalize
    local len = math.sqrt(x * x + y * y + z * z)
    if len ~= 0 then
        x = x / len
        y = y / len
        z = z / len
    end
    
    return x, y, z
end

function tvRP.addPlayer(player)
    players[player] = true
end

function tvRP.removePlayer(player)
    players[player] = nil
end

function tvRP.getNearestPlayers(radius)
    local r = {}
    
    local ped = GetPlayerPed(i)
    local pid = PlayerId()
    local px, py, pz = tvRP.getPosition()
    
    --[[
    for i=0,GetNumberOfPlayers()-1 do
    if i ~= pid then
    local oped = GetPlayerPed(i)
    
    local x,y,z = table.unpack(GetEntityCoords(oped,true))
    local distance = GetDistanceBetweenCoords(x,y,z,px,py,pz,true)
    if distance <= radius then
    r[GetPlayerServerId(i)] = distance
    end
    end
    end
    --]]
    for k, v in pairs(players) do
        local player = GetPlayerFromServerId(k)
        
        if v and player ~= pid and NetworkIsPlayerConnected(player) then
            local oped = GetPlayerPed(player)
            local x, y, z = table.unpack(GetEntityCoords(oped, true))
            local distance = GetDistanceBetweenCoords(x, y, z, px, py, pz, true)
            if distance <= radius then
                r[GetPlayerServerId(player)] = distance
            end
        end
    end
    
    return r
end

function tvRP.getNearestPlayer(radius)
    local p = nil
    
    local players = tvRP.getNearestPlayers(radius)
    local min = radius + 10.0
    for k, v in pairs(players) do
        if v < min then
            min = v
            p = k
        end
    end
    
    return p
end

-- local notificari = {
--   ["Eroare"] = {callback = function(msg) tvRP.eroare(msg) end},
--   ["Succes"] = {callback = function(msg) tvRP.succes(msg) end},
--   ["Info"] = {callback = function(msg) tvRP.info(msg) end},
--   ["Warning"] = {callback = function(msg) tvRP.warning(msg) end},
-- }

-- function tvRP.succes(msg)
--     exports['vrp_notify']:Alert("Succes", msg, 5000, 'success')
-- end

-- function tvRP.info(msg)
--     exports['vrp_notify']:Alert("Info", msg, 5000, 'info')
-- end

-- function tvRP.eroare(msg)
--     exports['vrp_notify']:Alert("Eroare", msg, 5000, 'error')
-- end

-- function tvRP.warning(msg)
--     exports['vrp_notify']:Alert("Atentie", msg, 5000, 'warning')
-- end

-- function tvRP.notify(msg)
--   local function clearColors(str)
--     local idf = string.match(str, "~.~")
--     while idf do
--         str = str:gsub(idf, "")
--         idf = string.match(str, "~.~")
--     end

--     local idf = string.match(str, "Succes:")
--     while idf do
--         str = str:gsub(idf, "")
--         idf = string.match(str, "Succes:")
--     end

--     local idf = string.match(str, "Eroare:")
--     while idf do
--         str = str:gsub(idf, "")
--         idf = string.match(str, "Eroare:")
--     end

--     local idf = string.match(str, "Info:")
--     while idf do
--         str = str:gsub(idf, "")
--         idf = string.match(str, "Info:")
--     end

--     idf = string.match(str, "\\n")
--     while idf do
--         str = str:gsub(idf, " | ")
--         idf = string.match(str, "\\n")
--     end
    
--     return str
-- end
--     for k, v in pairs(notificari) do
--         if string.find(msg, k) then
--           msg = clearColors(msg)
--             v.callback(msg)
--         end
--     end
-- end

-- function tvRP.notify(msg)

--     local function clearColors(str)
--       local idf = string.match(str, "~.~")
--       while idf do
--           str = str:gsub(idf, "")
--           idf = string.match(str, "~.~")
--       end
  
--       idf = string.match(str, "\\n")
--       while idf do
--           str = str:gsub(idf, " | ")
--           idf = string.match(str, "\\n")
--       end
      
--       return str
--   end
  
--       msg = clearColors(msg) 
    
--     exports['vrp_notify']:Alert("Info", tostring(msg), 7000, 'info')
  
--     --TriggerEvent("hpy-notify:Alert", 5000, "Info", tostring(msg), 'info')
  
  
--   end
  
--   function tvRP.notifyPicture(icon, type, sender, title, text)
--       SetNotificationTextEntry("STRING")
--       AddTextComponentString(text)
--       SetNotificationMessage(icon, icon, true, type, sender, title, text)
--       DrawNotification(false, true)
--   end

-- function tvRP.notify(msg,type,timeout,position)  
--     if type == "success" then 
--       exports.bulletin:SendSuccess(msg, timeout, position, progress)
--     elseif type == "error" then
--       exports.bulletin:SendError(msg, timeout, position, progress)
--     elseif type == "info" then
--       exports.bulletin:SendInfo(msg, timeout, position, progress)
--     elseif type == "warning" then
--       exports.bulletin:SendWarning(msg, timeout, position, progress)
--     else
--       exports.bulletin:Send(msg, timeout, position, progress, theme)
--     end
  
--   end
  
--   function tvRP.notifyPic(icon,title,text,subject,position,timeout)  
--     exports.bulletin:SendAdvanced(text, title, subject, icon, timeout, position)
  
--   end
  
--   function tvRP.notifyPicture(icon, type, sender, title, text)
--       exports.bulletin:SendAdvanced(text, title, "", icon)
--   end

function tvRP.notify(msg)
    local function clearColors(str)
      local idf = string.match(str, "~.~")
      while idf do
          str = str:gsub(idf, "")
          idf = string.match(str, "~.~")
      end
      idf = string.match(str, "\\n")
      while idf do
          str = str:gsub(idf, " | ")
          idf = string.match(str, "\\n")
      end
      return str
    end
    msg = clearColors(msg)

    exports['utdNotify']:Alert("INFO", tostring(msg), 5000, 'info')
end

function tvRP.notifyPicture(icon, type, sender, title, text,r,g,b)
   SetNotificationTextEntry("STRING")
   AddTextComponentString(text)
   SetNotificationMessage(icon, icon, true, type, sender, title, text)
   if r and g and b ~= nil then
     SetNotificationBackgroundColor(r,g,b)
   end
   DrawNotification(false, true)
end

-- SCREEN
-- play a screen effect
-- name, see https://wiki.fivem.net/wiki/Screen_Effects
-- duration: in seconds, if -1, will play until stopScreenEffect is called
function tvRP.playScreenEffect(name, duration)
    if duration < 0 then -- loop
        StartScreenEffect(name, 0, true)
    else
        StartScreenEffect(name, 0, true)
        
        CreateThread(function()-- force stop the screen effect after duration+1 seconds
            Wait(math.floor((duration + 1) * 1000))
            StopScreenEffect(name)
        end)
    end
end

-- function play_drug_effect(player)
-- tvRP.playScreenEffectDrugs(cfg.drug_effect, -1)
-- end
-- function tvRP.playScreenEffectDrugs(name, duration)
-- if duration < 0 then -- loop
-- StartScreenEffect(name, 0, true)
-- else
-- StartScreenEffect(name, 0, true)
-- CreateThread(function() -- force stop the screen effect after 1 minute
-- Wait(60000)
-- StopScreenEffect(name)
-- end)
-- end
-- end
-- stop a screen effect
-- name, see https://wiki.fivem.net/wiki/Screen_Effects
function tvRP.stopScreenEffect(name)
    StopScreenEffect(name)
end

-- ANIM

-- animations dict and names: http://docs.ragepluginhook.net/html/62951c37-a440-478c-b389-c471230ddfc5.htm

local anims = {}
local anim_ids = Tools.newIDGenerator()

local inAnim = false

-- play animation (new version)
-- upper: true, only upper body, false, full animation
-- seq: list of animations as {dict,anim_name,loops} (loops is the number of loops, default 1) or a task def (properties: task, play_exit)
-- looping: if true, will infinitely loop the first element of the sequence until stopAnim is called

function tvRP.playAnim(upper, seq, looping, leaveVehicle)

	local ped = GetPlayerPed(-1)

	if leaveVehicle and IsPedInAnyVehicle(ped) then
		TaskLeaveVehicle(ped, GetVehiclePedIsIn(ped), 1)
		Citizen.Wait(500)
	end

	Citizen.CreateThread(function()
		
		Wait(250)
		Citizen.CreateThread(function()
			while inAnim do
				DisableControlAction(0, 37, false)
				Wait(1)
			end
		end)
		Wait(15000)
		inAnim = false
	end)
	if seq.task ~= nil then -- is a task (cf https://github.com/ImagicTheCat/vRP/pull/118)
		tvRP.stopAnim(true)

		inAnim = true
		
		if seq.task == "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" then -- special case, sit in a chair
			local x,y,z = tvRP.getPosition()
			TaskStartScenarioAtPosition(ped, seq.task, x, y, z-1, GetEntityHeading(ped), 0, 0, false)
		else
			TaskStartScenarioInPlace(ped, seq.task, 0, not seq.play_exit)
		end
	else -- a regular animation sequence
		tvRP.stopAnim(upper)

		inAnim = true

		local flags = 0
		if upper then flags = flags+48 end
		if looping then flags = flags+1 end

		Citizen.CreateThread(function()
			-- prepare unique id to stop sequence when needed
			local id = anim_ids:gen()
			anims[id] = true

			for k,v in pairs(seq) do
				local dict = v[1]
				local name = v[2]
				local loops = v[3] or 1

				for i=1,loops do
					if anims[id] then -- check animation working
						local first = (k == 1 and i == 1)
						local last = (k == #seq and i == loops)

						-- request anim dict
						RequestAnimDict(dict)
						local i = 0
						while not HasAnimDictLoaded(dict) and i < 1000 do -- max time, 10 seconds
							Citizen.Wait(10)
							RequestAnimDict(dict)
							i = i+1
						end

						-- play anim
						if HasAnimDictLoaded(dict) and anims[id] then
							local inspeed = 8.0001
							local outspeed = -8.0001
							if not first then inspeed = 2.0001 end
							if not last then outspeed = 2.0001 end

							TaskPlayAnim(ped,dict,name,inspeed,outspeed,-1,flags,0,0,0,0)
						end

						Citizen.Wait(0)
						while GetEntityAnimCurrentTime(ped,dict,name) <= 0.95 and IsEntityPlayingAnim(ped,dict,name,3) and anims[id] do
							Citizen.Wait(0)
						end
					end
				end
			end

			-- free id
			anim_ids:free(id)
			anims[id] = nil
		end)
	end
end

local importantAnim = false
function tvRP.setCanStop(set)
	importantAnim = not set
end

function tvRP.isInAnim()
	return inAnim
end

-- stop animation (new version)
-- upper: true, stop the upper animation, false, stop full animations
function tvRP.stopAnim(upper)
	anims = {} -- stop all sequences
	if not importantAnim then
		inAnim = false
		if upper then
			ClearPedSecondaryTask(GetPlayerPed(-1))
		else
			ClearPedTasks(GetPlayerPed(-1))
		end
	else
		tvRP.notify("Nu poti oprii aceasta animatie.")
	end
end

-- RAGDOLL
local ragdoll = false

-- set player ragdoll flag (true or false)
function tvRP.setRagdoll(flag)
    ragdoll = flag
    if ragdoll then
        CreateThread(function()
            while ragdoll do
                Wait(1000)
                SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
            end
        end)
    end
end

function tvRP.isRagdoll()
    return ragdoll
end

CreateThread(function()
	while true do
		_GPED = PlayerPedId()
		_GCOORDS = GetEntityCoords(_GPED)
        _GPLAYER = PlayerId()
        _GVEHICLE = GetVehiclePedIsIn(_GPED,false)
        SetRadarZoom(1100)
		Wait(1000)
	end
end)

-- CreateThread(function()
--     while not cacat do Wait(10)
--         if IsControlPressed('nush') then
--         end
--     end
-- end)

-- RegisterCommand('road', function()
--     if not cacat then
--         ExecuteCommand('e sitchair')
--         cacat = true
--     elseif cacat then
--         ExecuteCommand('e c')
--         cacat = false
--     end
-- end)

-- RegisterKeyMapping('road', 'pt road', 'keyboard', 'F2')

-- SOUND
-- some lists:
-- pastebin.com/A8Ny8AHZ
-- https://wiki.gtanet.work/index.php?title=FrontEndSoundlist
-- play sound at a specific position
function tvRP.playSpatializedSound(dict, name, x, y, z, range)
    PlaySoundFromCoord(-1, name, x + 0.0001, y + 0.0001, z + 0.0001, dict, 0, range + 0.0001, 0)
end

-- play sound
function tvRP.playSound(dict, name)
    PlaySound(-1, name, dict, 0, 0, 1)
end

--[[
-- not working
function tvRP.setMovement(dict)
if dict then
SetPedMovementClipset(PlayerPedId(),dict,true)
else
ResetPedMovementClipset(PlayerPedId(),true)
end
end
--]]
-- events
AddEventHandler("playerSpawned", function()
    TriggerServerEvent("vRPcli:playerSpawned")
end)

AddEventHandler("onPlayerDied", function(player, reason)
    TriggerServerEvent("vRPcli:playerDied")
end)

AddEventHandler("onPlayerKilled", function(player, killer, reason)
    TriggerServerEvent("vRPcli:playerDied")
end)

-- -- voice proximity computation
-- CreateThread(function()
--     while true do
--         Wait(500)
--         local ped = PlayerPedId()
--         local proximity = cfg.voice_proximity
        
--         if IsPedSittingInAnyVehicle(ped) then
--             local veh = GetVehiclePedIsIn(ped,false)
--             local hash = GetEntityModel(veh)
--             -- make open vehicles (bike,etc) use the default proximity
--             if IsThisModelACar(hash) or IsThisModelAHeli(hash) or IsThisModelAPlane(hash) then
--                 proximity = cfg.voice_proximity_vehicle
--             end
--         elseif tvRP.isInside() then
--             proximity = cfg.voice_proximity_inside
--         end
        
--         NetworkSetTalkerProximity(proximity + 0.0001)
--     end
-- end)

TriggerServerEvent('VRP:CheckID')

RegisterNetEvent('VRP:CheckIdRegister')
AddEventHandler('VRP:CheckIdRegister', function()
    TriggerEvent('playerSpawned', GetEntityCoords(PlayerPedId()))
end)


-- hasMouthCovered = false

-- function tvRP.coverMouth(state)
--     if (state == true) then
--         hasMouthCovered = true
--     else
--         hasMouthCovered = false
--     end
-- end

-- CreateThread(function()
--     while true do
--         Wait(500)
--         if (hasMouthCovered == false) then
--             local ped = PlayerPedId()
--             local proximity = cfg.voice_proximity
            
--             if IsPedSittingInAnyVehicle(ped) then
--                 local veh = GetVehiclePedIsIn(ped,false)
--                 local hash = GetEntityModel(veh)
--                 -- make open vehicles (bike,etc) use the default proximity
--                 if IsThisModelACar(hash) or IsThisModelAHeli(hash) or IsThisModelAPlane(hash) then
--                     proximity = cfg.voice_proximity_vehicle
--                 end
--             elseif tvRP.isInside() then
--                 proximity = cfg.voice_proximity_inside
--             end
--             NetworkSetTalkerProximity(proximity + 0.0001)
--         end
--     end
-- end)

CreateThread(function()
    while true do
        Wait(1800000)-- odata la jumatate de ora se adauga cate 0.50h in scoreboard, daca folositi scoreboard ca pe Wattz.
        vRPserver.updateHoursPlayed({0.50})
    end
end)

function DrawImage3D(name1, name2, x, y, z, width, height, rot, r, g, b, alpha)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)
    
    if onScreen then
        local width = (1 / dist) * width
        local height = (1 / dist) * height
        local fov = (1 / GetGameplayCamFov()) * 100
        local width = width * fov
        local height = height * fov
        
        local CoordFrom = GetEntityCoords(PlayerPedId(), true)
        local RayHandle = StartShapeTestRay(CoordFrom.x, CoordFrom.y, CoordFrom.z, x, y, z, -1, PlayerPedId(), 0)
        local _, _, _, _, object = GetShapeTestResult(RayHandle)
        if (object == 0) or (object == nil) then
            DrawSprite(name1, name2, _x, _y, width, height, rot, r, g, b, alpha)
        end
    end
end

local fontId = RegisterFontId('Freedom Font')
local disableShuffle = true
local isShuffing = false

function disableSeatShuffle(flag)
    disableShuffle = flag
end

AddEventHandler("gameEventTriggered", function(name, args)
    if name == "CEventNetworkPlayerEnteredVehicle" then
        local playerId = args[1] -- Player Id
        local vehicle = args[2] -- Vehicle Id
        local playerPed = GetPlayerPed(playerId)
        local ped = PlayerPedId()
        Citizen.CreateThread(function()
            if playerPed == _GPED then
                while GetVehiclePedIsIn(_GPED) == vehicle do
                    local hasVehicleDriver = GetPedInVehicleSeat(vehicle, -1) ~= 0
                    if not hasVehicleDriver then
                        if GetPedInVehicleSeat(vehicle, 0) == _GPED and disableShuffle then
                            SetTextFont(fontId)
                            SetTextProportional(0)
                            SetTextScale(0.4, 0.4)
                            SetTextColour(255, 255, 255, 255)
                            SetTextDropShadow(0, 0, 0, 0, 255)
                            SetTextEdge(1, 0, 0, 0, 255)
                            SetTextDropShadow()
                            SetTextCentre(1)
                            SetTextEntry("STRING")
                            AddTextComponentString("Apasa tasta ~b~H~w~ pentru a te pune pe scaunul soferului")
                            DrawText(0.5, 0.825)
                            
                            if IsDisabledControlJustPressed(0, 104) then
                                if GetPedInVehicleSeat(_GVEHICLE, 0) == ped then
                                    CreateThread(function()
                                        isShuffing = true
                                        while isShuffing do
                                            disableSeatShuffle(false)
                                            Citizen.Wait(5000)
                                            isShuffing = false
                                        end
                                        disableSeatShuffle(true)
                                    end)
                                end
                            end

                            if GetIsTaskActive(_GPED, 165) then
                                SetPedIntoVehicle(_GPED, _GVEHICLE, 0)
                            end
                        end
                    end

                    Citizen.Wait(1)
                    if hasVehicleDriver then
                        Citizen.Wait(29)
                    end 
                end
            end
        end)
    end
end)

checkTime = 60 --Minutes
deleteTime = 15 --Seconds

local enumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}

local function getEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end
        
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, enumerator)
        
        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next
        
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function getVehicles()
    return getEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

RegisterNetEvent("stergeMasini")
AddEventHandler("stergeMasini", function(sec)
    deleteAllVehs(sec)
end)

function deleteAllVehs(theTime)
    SetTimeout(theTime * 1000, function()
        theVehicles = getVehicles()
        for entity in theVehicles do
            local veh = entity
            if DoesEntityExist(veh) then
                if GetEntityModel(veh) ~= GetHashKey("rcbandito") then
                    if not IsEntityAttached(veh) then
                        if ((GetPedInVehicleSeat(veh, -1)) == false) or ((GetPedInVehicleSeat(veh, -1)) == nil) or ((GetPedInVehicleSeat(veh, -1)) == 0) then
                            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
                            
                            if (DoesEntityExist(veh)) then
                                DeleteEntity(veh)
                            end
                        end
                    end
                end
            end
        end
    end)
end
