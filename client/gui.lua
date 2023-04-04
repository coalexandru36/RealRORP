-- pause
AddEventHandler("vRP:pauseChange", function(paused)
	SendNUIMessage({act="pause_change", paused=paused})
end)

-- MENU
function tvRP.openMenuData(menudata)
  SendNUIMessage({act="open_menu", menudata = menudata})
  SetNuiFocus(false)
  SetNuiFocus(false)
  vRPserver.promptResult()
end

function tvRP.closeMenu()
  SendNUIMessage({act="close_menu"})
  SetNuiFocus(false)
  SetNuiFocus(false)
  vRPserver.promptResult()
end

-- PROMPT
function tvRP.prompt(title,default_text)
  SendNUIMessage({act="prompt",title=title,text=tostring(default_text)})
  SetNuiFocus(true)
end

function tvRP.setPhonePos(posX,posY)
  SendNUIMessage({act="setMenuPos",pos={descPos={0,0},menuPos={posX,posY}} })
end


RegisterNUICallback("saveMenuPos",function(data,cb)
  -- saveMenuPos
  cb('ok')
  --print(data.menuPos[1],data.menuPos[2])
  TriggerServerEvent("saveMenuPos",data.menuPos[1],data.menuPos[2])
end)

function tvRP.request(id,text,time)
  SendNUIMessage({act="request",id=id,text=tostring(text),time = time})
  tvRP.playSound("HUD_MINI_GAME_SOUNDSET","5_SEC_WARNING")
end

-- gui menu events
RegisterNUICallback("menu",function(data,cb)
  if data.act == "close" then
	  vRPserver.closeMenu({data.id})
  elseif data.act == "valid" then
	  vRPserver.validMenuChoice({data.id,data.choice,data.mod})
  end
end)

-- gui prompt event
RegisterNUICallback("prompt",function(data,cb)
  if string.len(data.result) <= 300 then
	  if data.act == "close" then
		  SetNuiFocus(false)
		  SetNuiFocus(false)
		  vRPserver.promptResult({data.result})
	  end
  else
	  if data.act == "close" then
		  SetNuiFocus(false)
		  SetNuiFocus(false)
		  tvRP.notify("Limita de caractere atinsa")
	  end
  end
end)

-- gui request event
RegisterNUICallback("request",function(data,cb)
  if data.act == "response" then
	  vRPserver.requestResult({data.id,data.ok})
  end
end)

-- cfg
RegisterNUICallback("cfg",function(data,cb) -- if NUI loaded after
	SendNUIMessage({act="cfg",cfg=cfg.gui})
end)
SendNUIMessage({act="cfg",cfg=cfg.gui}) -- if NUI loaded before

-- try to fix missing cfg issue (cf: https://github.com/ImagicTheCat/vRP/issues/89)
for i=1,5 do
	SetTimeout(5000*i, function() SendNUIMessage({act="cfg",cfg=cfg.gui}) end)
end

-- PROGRESS BAR

-- create/update a progress bar
function tvRP.setProgressBar(name,anchor,text,r,g,b,value)
  local pbar = {name=name,anchor=anchor,text=text,r=r,g=g,b=b,value=value}

  -- default values
  if pbar.value == nil then pbar.value = 0 end

  SendNUIMessage({act="set_pbar",pbar = pbar})
end

-- set progress bar value in percent
function tvRP.setProgressBarValue(name,value)
	SendNUIMessage({act="set_pbar_val", name = name, value = value})
end

-- set progress bar text
function tvRP.setProgressBarText(name,text)
	SendNUIMessage({act="set_pbar_text", name = name, text = text})
end

-- remove a progress bar
function tvRP.removeProgressBar(name)
	SendNUIMessage({act="remove_pbar", name = name})
end

-- DIV

-- set a div
-- css: plain global css, the div class is "div_name"
-- content: html content of the div
function tvRP.setDiv(name,css,content)
  if name == -1 then return end;
	SendNUIMessage({act="set_div", name = name, css = css, content = content})
end

-- set the div css
function tvRP.setDivCss(name,css)
  if name == -1 then return end;
	SendNUIMessage({act="set_div_css", name = name, css = css})
end

-- set the div content
function tvRP.setDivContent(name,content)
  if name == -1 then return end;
	SendNUIMessage({act="set_div_content", name = name, content = content})
end

-- execute js for the div
-- js variables: this is the div
function tvRP.divExecuteJS(name,js)
	SendNUIMessage({act="div_execjs", name = name, js = js})
end

-- remove the div
function tvRP.removeDiv(name)
	SendNUIMessage({act="remove_div", name = name})
end

-- CONTROLS/GUI
local paused = false

function tvRP.isPaused()
	return paused
end

function tvRP.setPhonePos(posX,posY)
		  SendNUIMessage({act="setMenuPos",pos={descPos={0,0},menuPos={posX,posY}} })
end

tastaBlocata = false
function tvRP.disableMeniu(bool)
	tastaBlocata = bool
end

isChangingPos = false
menuLeftRight = 0
menuTopBottom = 0
function tvRP.setPosition(type)
    if type == 1 then
        isChangingPos = true
        TriggerEvent("chatMessage","^5^0Apasa pe ^5sageti ^0pentru a muta pozitia telefonului")
        TriggerEvent("chatMessage","^5^0Apasa ^5backspace ^0pentru a salva pozitia telefonului")
        CreateThread(function()
            while true do
                Wait(0)
                if IsControlPressed(0,174) then
                    menuLeftRight = menuLeftRight - 1
                    SendNUIMessage({act="event",event="RPLeft",menu=1})
                    Wait(25)
                elseif IsControlPressed(0,175) then
                    menuLeftRight = menuLeftRight + 1
                    SendNUIMessage({act="event",event="RPRight",menu=1})
                    Wait(25)
                elseif IsControlPressed(0,173) then -- down
                    menuTopBottom = menuTopBottom + 1
                    SendNUIMessage({act="event",event="RPDown",menu=1})
                    Wait(25)
                elseif IsControlPressed(0,172) then -- up
                    menuTopBottom = menuTopBottom - 1
                    SendNUIMessage({act="event",event="RPUp",menu=1})
                    Wait(25)
                elseif IsControlJustPressed(0,177) and isChangingPos then
                    --TriggerServerEvent("saveMenuPos",menuTopBottom,menuLeftRight)
          			SendNUIMessage({act="saveMenuPos"})
                    tvRP.notify("~w~Telefonul a fost mutat si salvat cu succes")
                    isChangingPos = false
                    break
                end
            end
        end)
    end
end

local shiftBlocat = false
function tvRP.disableTastaShift(bool)
  shiftBlocat = bool
  CreateThread(function()
	  while true do
		  if shiftBlocat then
			  DisableControlAction(0, 21, true)
			  DisableControlAction(0, 61, true)
			  DisableControlAction(0, 131, true)
			  DisableControlAction(0, 155, true)
			  DisableControlAction(0, 209, true)
			  DisableControlAction(0, 254, true)
			  DisableControlAction(0, 340, true)
			  DisableControlAction(0, 352, true)
		  else
			  break
		  end
		  Wait(0)
	  end
  end)
end


function tvRP.announce(background,content)
  if annState then
    SendNUIMessage({act="announce",background=background,content=content})
  end
end


--===========HOTKEYS===========--

isChangingPos = false

local keytable = {
  ["k"] = {
      commandname = "gui_openmainmenu",
      description = "Deschide meniul principal K",
      func = function() if (not tvRP.isInEvent()) and (not tvRP.isInComa() or not cfg.coma_disable_menu) and (not tvRP.isHandcuffed() or not cfg.handcuff_disable_menu) and not isChangingPos then vRPserver.openMainMenu({}) end end
  },
  ["up"] = {
    commandname = "gui_menuup",
    description = "Key UP",
    func = function() 
      if not isChangingPos then
        SendNUIMessage({act="event",event="UP"})
        CreateThread(function()
          local timer = 0
          while IsControlPressed(table.unpack(cfg.controls.phone.up)) do
            Wait(0)
            timer = timer + 1
            if timer > 30 then
            Wait(25)
            SendNUIMessage({act="event",event="UP"})
            end
          end
        end)
      end
     end
  },
  ["down"] = {
    commandname = "gui_menudown",
    description = "Key DOWN",
    func = function() 
      if not isChangingPos then
        SendNUIMessage({act="event",event="DOWN"}) 
        CreateThread(function()
          local timer = 0
          while IsControlPressed(table.unpack(cfg.controls.phone.down)) do
            Wait(0)
            timer = timer + 1
            if timer > 30 then
            Wait(25)
            SendNUIMessage({act="event",event="DOWN"})
            end
          end
        end)
      end
    end
  },
  ["left"] = {
    commandname = "gui_menuleft",
    description = "Key LEFT",
    func = function() if not isChangingPos then SendNUIMessage({act="event",event="LEFT"}) end end
  },
  ["right"] = {
    commandname = "gui_menuright",
    description = "Key RIGHT",
    func = function() if not isChangingPos then SendNUIMessage({act="event",event="RIGHT"}) end end
  },
  ["return"] = {
    commandname = "gui_menuselect",
    description = "Key SELECT",
    func = function() if not isChangingPos then SendNUIMessage({act="event",event="SELECT"}) end end
  },
  ["back"] = {
    commandname = "gui_menuback",
    description = "Key BACK",
    func = function() if not isChangingPos then SendNUIMessage({act="event",event="CANCEL"}) end end
  },
  ["F5"] = {
    commandname = "gui_menuF5",
    description = "Accepta apel",
    func = function() if not isChangingPos then SendNUIMessage({act="event",event="F5"}) end end
  },
  ["F6"] = {
    commandname = "gui_menuF6",
    description = "Respinge Apel",
    func = function() if not isChangingPos then SendNUIMessage({act="event",event="F6"}) end end
  }
}

for k,v in pairs(keytable) do
  RegisterCommand(v.commandname, function()
    v.func()
  end, false)
  RegisterKeyMapping(v.commandname, v.description, 'keyboard', k)
end



local vRPbm = Proxy.getInterface("vRP_basic_menu")


function loadAnimDict(a) while not HasAnimDictLoaded(a) do RequestAnimDict(a)Wait(5) end end

function tvRP.canHandleAnim()
	if (not IsPedInAnyVehicle(_GPED, false)) and (not IsPedSwimming(_GPED)) and (not IsPedShooting(_GPED)) and (not IsPedJumping(_GPED)) and (not IsPedInParachuteFreeFall(_GPED)) and (not IsPauseMenuActive()) and (not tvRP.isInComa()) then
        return true
    end
    return false
end

-- RegisterCommand('+ragdoll', function()
--     if tvRP.canHandleAnim() then
--         tvRP.setRagdoll(true)
--     end
-- end)

-- RegisterCommand('-ragdoll', function()
--     if tvRP.canHandleAnim() then
--         tvRP.setRagdoll(false)
--     end
-- end)
RegisterCommand('+handsup', function()
    if tvRP.canHandleAnim() then
        RequestAnimDict("missminuteman_1ig_2")
        while not HasAnimDictLoaded("missminuteman_1ig_2") do
            Wait(50)
        end
        TaskPlayAnim(_GPED, "missminuteman_1ig_2", "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
    end
end)

RegisterCommand('-handsup', function()
    if tvRP.canHandleAnim() then
        ClearPedTasks(_GPED)
    end
end)

RegisterCommand('lockcar', function()
      local ok, vtype, name = tvRP.getNearestOwnedVehicle(5)
      if ok then
          tvRP.vc_toggleLock(vtype)
          tvRP.playSound("HUD_MINI_GAME_SOUNDSET","5_SEC_WARNING")
      else
          tvRP.notify("~r~Nicio masina personala in aproprierea ta.")
      end 
end)

RegisterKeyMapping("lockcar", "Incuie-ti masina personala", "keyboard", "F3")

local crouched = false
local ton = false
RegisterCommand("crouch", function()
    local ped = PlayerPedId()
    if DoesEntityExist(ped) and not IsEntityDead(ped) then
        RequestAnimSet( "move_ped_crouched" )
        while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
            Citizen.Wait( 100 )
        end 
        if not crouched then
            SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
            SetPedStrafeClipset(ped, "move_ped_crouched_strafing")
            crouched = true
        else
            ResetPedMovementClipset( ped, 0 )
            ResetPedStrafeClipset(ped)
            crouched= false
        end
    end
    if not ton then
        ton = true
        CreateThread(function()
            local stime = GetGameTimer()
            while true do Wait(7)
                if GetGameTimer() > stime+5000 then
                    ton = false
                    break
                end
                if GetPedStealthMovement(PlayerPedId()) then
                    SetPedStealthMovement(PlayerPedId(),false)
                end
            end
        end)
    end
end)

RegisterKeyMapping("crouch", "Crouch", "keyboard", "lcontrol")


local mp_pointing = false

local function startPointing()
    local ped = _GPED
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = _GPED
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(_GPED)
end

RegisterCommand('+pointFinger', function()
    if tvRP.canHandleAnim() then
        local ped = _GPED
        mp_pointing = true
        startPointing()
        while mp_pointing do
            local camPitch = GetGameplayCamRelativePitch()
            if camPitch < -70.0 then
                camPitch = -70.0
            elseif camPitch > 42.0 then
                camPitch = 42.0
            end
            camPitch = (camPitch + 70.0) / 112.0
            
            local camHeading = GetGameplayCamRelativeHeading()
            local cosCamHeading = Cos(camHeading)
            local sinCamHeading = Sin(camHeading)
            if camHeading < -180.0 then
                camHeading = -180.0
            elseif camHeading > 180.0 then
                camHeading = 180.0
            end
            camHeading = (camHeading + 180.0) / 360.0
            
            local blocked = 0
            local nn = 0
            
            local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
            local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
            nn, blocked, coords, coords = GetRaycastResult(ray)
            
            Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
            Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
            Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
            Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)
            SetCurrentPedWeapon(_GPED, GetHashKey("WEAPON_UNARMED"), true)
            if not IsPedOnFoot(_GPED) then
                CancelEvent();
                mp_pointing = false
            end
            Wait(1)
        end
    end
end)
RegisterCommand('-pointFinger', function()
    if tvRP.canHandleAnim() then
        mp_pointing = false
        stopPointing()
    end
end)

RegisterKeyMapping("+pointFinger", "Arata cu degetul", "keyboard", "B")
-- RegisterKeyMapping('+ragdoll', 'Prefa-te mort', 'keyboard', 'Z')
RegisterKeyMapping('+handsup', 'Ridica mainile', 'keyboard', 'X')

RegisterCommand("k", function(...)
    if (DoesEntityExist(_GPED) and not IsEntityDead(_GPED) and tvRP.canHandleAnim()) then
        loadAnimDict("random@arrests")
        loadAnimDict("random@arrests@busted")
        if (IsEntityPlayingAnim(_GPED, "random@arrests@busted", "idle_a", 3)) then
            TaskPlayAnim(_GPED, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
            Wait(3000)
            TaskPlayAnim(_GPED, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0)
        else
            TaskPlayAnim(_GPED, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
            Wait(4000)
            TaskPlayAnim(player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
            Wait(500)
            TaskPlayAnim(_GPED, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
            Wait(1000)
            TaskPlayAnim(_GPED, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0)
        end
        
        while IsEntityPlayingAnim(_GPED, "random@arrests@busted", "idle_a", 3) do
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
            DisableControlAction(0, 21, true)
            Wait(1)
        end
    end
end)
























local function GetPlayers()
    local players = {}

  for _, player in ipairs(GetActivePlayers()) do
    table.insert(players, player)
  end

    return players
end

local function GetClosestPlayer(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = _GPED
    local plyCoords = _GCOORDS

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
  if closestDistance <= radius then
    return closestPlayer
  else
    return nil
  end
end

local hostageAllowedWeapons = {
  "WEAPON_PISTOL",
  "WEAPON_COMBATPISTOL",
  "WEAPON_SNSPISTOL",
  "WEAPON_APPISTOL",
  "WEAPON_PISTOL50",
  "WEAPON_HEAVYPISTOL",
  --etc add guns you want
}

local holdingHostageInProgress = false

local function drawNativeNotification(text)
    SetTextComponentFormat('STRING')
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local function takeHostage()
  ClearPedSecondaryTask(_GPED)
  DetachEntity(_GPED, true, false)
  for i=1, #hostageAllowedWeapons do
    if HasPedGotWeapon(_GPED, GetHashKey(hostageAllowedWeapons[i]), false) then
      if GetAmmoInPedWeapon(_GPED, GetHashKey(hostageAllowedWeapons[i])) > 0 then
        canTakeHostage = true 
        foundWeapon = GetHashKey(hostageAllowedWeapons[i])
        break
      end           
    end
  end

  if not canTakeHostage then 
    drawNativeNotification("Ai nevoie de un pistol cu gloante pentru a lua pe cineva ostatic!")
  end

  if not holdingHostageInProgress and canTakeHostage then   
    local player = PlayerPedId()  
    --lib = 'misssagrab_inoffice'
    --anim1 = 'hostage_loop'
    --lib2 = 'misssagrab_inoffice'
    --anim2 = 'hostage_loop_mrk'
    lib = 'anim@gangops@hostage@'
    anim1 = 'perp_idle'
    lib2 = 'anim@gangops@hostage@'
    anim2 = 'victim_idle'
    distans = 0.11 --Higher = closer to camera
    distans2 = -0.24 --higher = left
    height = 0.0
    spin = 0.0    
    length = 100000
    controlFlagMe = 49
    controlFlagTarget = 49
    animFlagTarget = 50
    attachFlag = true 
    local closestPlayer = GetClosestPlayer(2)
    target = GetPlayerServerId(closestPlayer)
    if closestPlayer ~= nil then
      SetCurrentPedWeapon(_GPED, foundWeapon, true)
      holdingHostageInProgress = true
      holdingHostage = true 
      TriggerServerEvent('TakeHostage:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,attachFlag)
    else
      drawNativeNotification("Nimeni nu este langa tine !")
    end 
  end
  canTakeHostage = false 
end 

RegisterCommand("th", function()
    
  if vRPbm.isInAJail() then
      return
  end

  if (not IsPedInAnyVehicle(_GPED, false)) and (not IsPedSwimming(_GPED)) and (not IsPedRunning()) and (not IsPedShooting(_GPED)) and (not IsPedJumping(_GPED)) and (not IsPedUsingAnyScenario(_GPED)) and (not IsPedInParachuteFreeFall(_GPED)) and (not IsPauseMenuActive()) and (not tvRP.isInComa()) then
  
      if not tvRP.isHandcuffed() and not tvRP.isInComa() and not tvRP.isInSafezone() then
          takeHostage()
      else
          tvRP.notify("Nu poti sa folosesti aceasta animatie mort, incatusat sau in safezone.")
      end
  else
      tvRP.notify("Nu poti sa folosesti aceasta animatie acum.")
      return 
  end

end)

RegisterNetEvent('cmg3_animations:syncTarget')
AddEventHandler('cmg3_animations:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag,animFlagTarget,attach)
  local playerPed = _GPED
  local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
  if holdingHostageInProgress then 
    holdingHostageInProgress = false 
  else 
    holdingHostageInProgress = true
  end
  beingHeldHostage = true 
  Citizen.CreateThread(function()
    while beingHeldHostage do 
        DisableControlAction(0,21,true) -- disable sprint
        DisableControlAction(0,24,true) -- disable attack
        DisableControlAction(0,25,true) -- disable aim
        DisableControlAction(0,47,true) -- disable weapon
        DisableControlAction(0,58,true) -- disable weapon
        DisableControlAction(0,263,true) -- disable melee
        DisableControlAction(0,264,true) -- disable melee
        DisableControlAction(0,257,true) -- disable melee
        DisableControlAction(0,140,true) -- disable melee
        DisableControlAction(0,141,true) -- disable melee
        DisableControlAction(0,142,true) -- disable melee
        DisableControlAction(0,143,true) -- disable melee
        DisableControlAction(0,75,true) -- disable exit vehicle
        DisableControlAction(27,75,true) -- disable exit vehicle  
        DisableControlAction(0,22,true) -- disable jump
        DisableControlAction(0,32,true) -- disable move up
        DisableControlAction(0,268,true)
        DisableControlAction(0,33,true) -- disable move down
        DisableControlAction(0,269,true)
        DisableControlAction(0,34,true) -- disable move left
        DisableControlAction(0,270,true)
        DisableControlAction(0,35,true) -- disable move right
        DisableControlAction(0,271,true)
  
        DisableControlAction(0, 36, true) -- crouch
        DisableControlAction(0, 20, true) -- prone
      Wait(0)
    end
  end)
  RequestAnimDict(animationLib)

  while not HasAnimDictLoaded(animationLib) do
    Citizen.Wait(10)
  end
  if spin == nil then spin = 180.0 end
  if attach then 
    AttachEntityToEntity(_GPED, targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
  else 
  end
  
  if controlFlag == nil then controlFlag = 0 end
  
  if animation2 == "victim_fail" then 
    SetEntityHealth(_GPED,0)
    DetachEntity(_GPED, true, false)
    TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
    beingHeldHostage = false 
    holdingHostageInProgress = false 
  elseif animation2 == "shoved_back" then 
    holdingHostageInProgress = false 
    DetachEntity(_GPED, true, false)
    TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
    beingHeldHostage = false 
  else
    TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false) 
  end
end)

local function releaseHostage()
  local player = PlayerPedId()  
  lib = 'reaction@shove'
  anim1 = 'shove_var_a'
  lib2 = 'reaction@shove'
  anim2 = 'shoved_back'
  distans = 0.11 --Higher = closer to camera
  distans2 = -0.24 --higher = left
  height = 0.0
  spin = 0.0    
  length = 100000
  controlFlagMe = 120
  controlFlagTarget = 0
  animFlagTarget = 1
  attachFlag = false
  local closestPlayer = GetClosestPlayer(2)
  target = GetPlayerServerId(closestPlayer)
  if closestPlayer ~= nil then
    TriggerServerEvent('TakeHostage:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,attachFlag)
  end
end 

local function killHostage()
  local player = PlayerPedId()  
  lib = 'anim@gangops@hostage@'
  anim1 = 'perp_fail'
  lib2 = 'anim@gangops@hostage@'
  anim2 = 'victim_fail'
  distans = 0.11 --Higher = closer to camera
  distans2 = -0.24 --higher = left
  height = 0.0
  spin = 0.0    
  length = 0.2
  controlFlagMe = 168
  controlFlagTarget = 0
  animFlagTarget = 1
  attachFlag = false
  local closestPlayer = GetClosestPlayer(2)
  target = GetPlayerServerId(closestPlayer)
  if closestPlayer ~= nil then
    TriggerServerEvent('TakeHostage:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,attachFlag)
  end 
end 

RegisterNetEvent('cmg3_animations:syncMe')
AddEventHandler('cmg3_animations:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
  local playerPed = _GPED
  CreateThread(function()
    while holdingHostage do
        if GetEntityHealth(_GPED) <= 120 or IsPedInAnyVehicle(_GPED, true) then
            holdingHostage = false
            holdingHostageInProgress = false
            local closestPlayer = GetClosestPlayer(2)
            target = GetPlayerServerId(closestPlayer)
            TriggerServerEvent("TakeHostage:stop",target)
            Wait(100)
            releaseHostage()
          end 
          DisableControlAction(0, 24, true) -- disable attack
          DisableControlAction(0, 25, true) -- disable aim
          DisableControlAction(0, 47, true) -- disable weapon
          DisableControlAction(0, 58, true) -- disable weapon
          DisablePlayerFiring(_GPED, true)
          local playerCoords = GetEntityCoords(_GPED)
          DrawText3D(playerCoords.x, playerCoords.y, playerCoords.z, "Apasa ~g~[G]~w~ pentru a elibera, ~r~[H]~w~ pentru a ucide")
          if IsDisabledControlJustPressed(0, 47) then --release
            holdingHostage = false
            holdingHostageInProgress = false 
            local closestPlayer = GetClosestPlayer(2)
            target = GetPlayerServerId(closestPlayer)
            TriggerServerEvent("TakeHostage:stop",target)
            Wait(100)
            releaseHostage()
          elseif IsDisabledControlJustPressed(0, 74) then --kill
            holdingHostage = false
            holdingHostageInProgress = false    
            local closestPlayer = GetClosestPlayer(2)
            target = GetPlayerServerId(closestPlayer)
            TriggerServerEvent("TakeHostage:stop",target)       
            killHostage()
          end
        Wait(1)
    end
  end)
  ClearPedSecondaryTask(_GPED)
  RequestAnimDict(animationLib)
  while not HasAnimDictLoaded(animationLib) do
    Citizen.Wait(10)
  end
  if controlFlag == nil then controlFlag = 0 end
  TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
  if animation == "perp_fail" then 
    SetPedShootsAtCoord(_GPED, 0.0, 0.0, 0.0, 0)
    holdingHostageInProgress = false 
  end
  if animation == "shove_var_a" then 
    Wait(900)
    ClearPedSecondaryTask(_GPED)
    holdingHostageInProgress = false 
  end
end)

RegisterNetEvent('cmg3_animations:cl_stop')
AddEventHandler('cmg3_animations:cl_stop', function()
  holdingHostageInProgress = false
  beingHeldHostage = false 
  holdingHostage = false 
  ClearPedSecondaryTask(_GPED)
  DetachEntity(_GPED, true, false)
end)

local function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(0.19, 0.19)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end




local carryingBackInProgress = false
local carryAnimNamePlaying = ""
local carryAnimDictPlaying = ""
local carryControlFlagPlaying = 0

RegisterCommand("cara", function(source, args)
  
  if vRPbm.isInAJail() then
      return
  end
  
  if (not IsPedInAnyVehicle(_GPED, false)) and (not IsPedSwimming(_GPED)) and (not IsPedRunning()) and (not IsPedShooting(_GPED)) and (not IsPedJumping(_GPED)) and (not IsPedUsingAnyScenario(_GPED)) and (not IsPedInParachuteFreeFall(_GPED)) and (not IsPauseMenuActive()) and (not tvRP.isInComa()) then
      if not carryingBackInProgress then
          if not tvRP.isHandcuffed() and not tvRP.isInComa() then
              local player = _GPED
              if not IsPedInAnyVehicle(player, true) then
                  local closestPlayer = GetClosestPlayer(3)
                  if closestPlayer ~= -1 and closestPlayer ~= nil then
                      carryingBackInProgress = true
                      lib = 'missfinale_c2mcs_1'
                      anim1 = 'fin_c2_mcs_1_camman'
                      lib2 = 'nm'
                      anim2 = 'firemans_carry'
                      distans = 0.15
                      distans2 = 0.27
                      height = 0.63
                      spin = 0.0
                      length = 100000
                      controlFlagMe = 49
                      controlFlagTarget = 33
                      animFlagTarget = 1
                      target = GetPlayerServerId(closestPlayer)
                      TriggerServerEvent('Carry:sync', closestPlayer, lib, lib2, anim1, anim2, distans, distans2, height, target, length, spin, controlFlagMe, controlFlagTarget, animFlagTarget)
                      
                  else
                      drawNativeNotification("No one nearby to carry!")
                  end
              else
                  tvRP.notify("Nu poti sa ridici pe cineva din masina!")
              end
          else
              tvRP.notify("Nu poti sa folosesti aceasta animatie mort/incatusat!")
          end
      else
          carryingBackInProgress = false
          ClearPedSecondaryTask(_GPED)
          DetachEntity(_GPED, true, false)
          local closestPlayer = GetClosestPlayer(3)
          target = GetPlayerServerId(closestPlayer)
          if target ~= 0 then
              TriggerServerEvent("Carry:stop", target)
          end
      end
      
      Citizen.CreateThread(function()
          while carryingBackInProgress do
              if not IsEntityPlayingAnim(_GPED, carryAnimDictPlaying, carryAnimNamePlaying, 3) then
                  TaskPlayAnim(_GPED, carryAnimDictPlaying, carryAnimNamePlaying, 8.0, -8.0, 100000, carryControlFlagPlaying, 0, false, false, false)
              end
              Citizen.Wait(0)
          end
      end)
  else
      tvRP.notify("Nu poti sa folosesti aceasta animatie acum.")
      return 
  end
end, false)

RegisterNetEvent('Carry:syncTarget')
AddEventHandler('Carry:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length, spin, controlFlag)
  local playerPed = _GPED
  local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
  carryingBackInProgress = true
  RequestAnimDict(animationLib)
  
  while not HasAnimDictLoaded(animationLib) do
      Citizen.Wait(10)
  end
  if spin == nil then spin = 180.0 end
  AttachEntityToEntity(_GPED, targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
  if controlFlag == nil then controlFlag = 0 end
  TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
  carryAnimNamePlaying = animation2
  carryAnimDictPlaying = animationLib
  carryControlFlagPlaying = controlFlag
  Citizen.CreateThread(function()
      while carryingBackInProgress do
          if not IsEntityPlayingAnim(_GPED, carryAnimDictPlaying, carryAnimNamePlaying, 3) then
              TaskPlayAnim(_GPED, carryAnimDictPlaying, carryAnimNamePlaying, 8.0, -8.0, 100000, carryControlFlagPlaying, 0, false, false, false)
          end
          Citizen.Wait(0)
      end
  end)
end)

RegisterNetEvent('Carry:syncMe')
AddEventHandler('Carry:syncMe', function(animationLib, animation, length, controlFlag, animFlag)
  local playerPed = _GPED
  RequestAnimDict(animationLib)
  
  while not HasAnimDictLoaded(animationLib) do
      Citizen.Wait(10)
  end
  Wait(500)
  if controlFlag == nil then controlFlag = 0 end
  TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
  carryAnimNamePlaying = animation
  carryAnimDictPlaying = animationLib
  carryControlFlagPlaying = controlFlag
end)

RegisterNetEvent('Carry:cl_stop')
AddEventHandler('Carry:cl_stop', function()
  carryingBackInProgress = false
  ClearPedSecondaryTask(_GPED)
  DetachEntity(_GPED, true, false)
end)

function GetPlayers()
  local players = {}
  
  for i = 0, 255 do
      if NetworkIsPlayerActive(i) then
          table.insert(players, i)
      end
  end
  
  return players
end

function GetClosestPlayer(radius)
  local players = GetPlayers()
  local closestDistance = -1
  local closestPlayer = -1
  local ply = _GPED
  local plyCoords = _GCOORDS
  
  for index, value in ipairs(players) do
      local target = GetPlayerPed(value)
      if (target ~= ply) then
          local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
          local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
          if (closestDistance == -1 or closestDistance > distance) then
              closestPlayer = value
              closestDistance = distance
          end
      end
  end
  if closestDistance <= radius then
      return closestPlayer
  else
      return nil
  end
end

function drawNativeNotification(text)
  SetTextComponentFormat('STRING')
  AddTextComponentString(text)
  DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
  while true do
      while tonumber(_GVEHICLE) ~= 0 do
          if GetPedInVehicleSeat(_GVEHICLE, -1) == _GPED then
              if GetEntitySpeed(_GVEHICLE) < 70 / 3.6 then
                  SetPlayerCanDoDriveBy(_GPLAYER, true)
              else
                  SetPlayerCanDoDriveBy(_GPLAYER, false)
              end
          else
              SetPlayerCanDoDriveBy(_GPLAYER, true)
          end
          Citizen.Wait(150)
      end
      Citizen.Wait(1000)
  end
end)