RegisterNetEvent("hpyHud:modGrafics")
AddEventHandler("hpyHud:modGrafics", function()
    if not active then
        active = true
        SetTimecycleModifier('MP_Powerplay_blend')
        SetExtraTimecycleModifier('reflection_correct_ambient')
        tvRP.notify("Ai ~g~pornit ~w~mod-ul de ~g~grafica")
    else
        active = false
        ClearTimecycleModifier()
        ClearExtraTimecycleModifier()
        tvRP.notify("Ai ~r~oprit ~w~modul de ~r~grafica")
    end
end)

RegisterNetEvent("hpyHud:fepesebust")
AddEventHandler("hpyHud:fpsboost", function()
    if not active then
        active = true
        SetTimecycleModifier("cinema")
        tvRP.notify("Ai pornit ~g~Fps Boost")
    else
        active = false
        ClearTimecycleModifier()
        tvRP.notify("Ai oprit ~r~Fps Boost")
    end
end)

AddEventHandler("playerSpawned",function()
  SendNUIMessage({
    act = "update_hud_bani",
    value = false
  })
end)

-- RegisterCommand('hud', function()
--   vRPserver.getInfo({}, function(bani,banca)
--     SendNUIMessage({
--       act = "update_hud_bani",
--       banicash = bani,
--       banibanca = banca,
--       value = true
--     })
--     tvRP.notify('Ai afisat hudul de bani')
--     Citizen.Wait(5000)
--     SendNUIMessage({
--       act = "update_hud_bani",
--       value = false
--     })
--     tvRP.notify('Ti-a fost dezactivat hudul de bani')
--   end)
-- end)

-- RegisterKeyMapping('hud', 'Afiseaza banii', 'keyboard', 'F4')



-- CreateThread(function()
--   while true do
--        local var1, var2 = GetStreetNameAtCoord(GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z)
--       local secondStreet = GetStreetNameFromHashKey(var1)
--       local theStreet = GetStreetNameFromHashKey(var2)

--       if secondStreet:len() < 2 then
--           secondStreet = "Necunoscută"
--       elseif theStreet:len() < 2 then
--           theStreet = "Necunoscută"
--       end

--       SendNUIMessage{
--           act = "update_zona",
--           firstStreet = theStreet,
--           secondStreet = secondStreet,
--       }

--       Wait(2000)
--   end
-- end)



RegisterNetEvent('utdHud:client:updatePlayers')
AddEventHandler('utdHud:client:updatePlayers', function(players)
  SendNUIMessage({
    act = "update_players",
    playerson = players
  })
end)

RegisterNetEvent('utdHud:client:updateID')
AddEventHandler('utdHud:client:updateID', function(id)
  SendNUIMessage({
    act = "update_id",
    idjucator = id
  })
end)

RegisterNetEvent('utdHud:client:updatecash')
AddEventHandler('utdHud:client:updatecash', function(cash)
  SendNUIMessage({
    act = "update_cash",
    banicash = cash
  })
end)

RegisterNetEvent('utdHud:client:updatebank')
AddEventHandler('utdHud:client:updatebank', function(bank)
  SendNUIMessage({
    act = "update_bank",
    banibanca = bank
  })
end)

function ShowMPMessage(message, subtitle, ms)
    CreateThread(function()
        local scaleform = RequestScaleformMovie("mp_big_message_freemode")
        while not HasScaleformMovieLoaded(scaleform) do
            Wait(0)
        end
        
        BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
        PushScaleformMovieMethodParameterString(message)
        PushScaleformMovieMethodParameterString(subtitle)
        PushScaleformMovieMethodParameterInt(0)
        EndScaleformMovieMethod()
        
        local time = GetGameTimer() + ms
        
        while (GetGameTimer() < time) do
            Wait(0)
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
        end
    end)
end

function tvRP.toggleInvisible()
    invisible = not invisible
    local ped = PlayerPedId()
    if invisible then
        SetEntityInvincible(ped, true)
        SetEntityVisible(ped, false, false)
    else
        SetEntityInvincible(ped, false)
        SetEntityVisible(ped, true, false)
    end
end

local logoFont = RegisterFontId('Freedom Font')

local function drawTxt(text, thePos, scale, r, g, b)
	SetTextDropShadow(1, 0, 0, 0, 50)
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, 255)
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(thePos)
end

local totalTickets = 0
local isAdmin = false

function tvRP.setAdmin()
    isAdmin = true
    Citizen.CreateThread(function ()
        while isAdmin do 
          Wait(2000)
            SendNUIMessage({act = "tickete", tickete = string.format("%02d", totalTickets), value = true})
        end
    end)
end

RegisterNetEvent("alpha:TicketsUpdate")
AddEventHandler("alpha:TicketsUpdate", function(ticketCounter)
    totalTickets = ticketCounter
end)

function tvRP.invisiblemod()
    invisiblehaha = not invisiblehaha
    local ped = PlayerPedId()
    if invisiblehaha then
        SetEntityInvincible(ped, true)
        SetEntityVisible(ped, false, false)
        tvRP.notify("Acum esti ~r~invizibil.")
    else
        SetEntityInvincible(ped, false)
        SetEntityVisible(ped, true, false)
        tvRP.notify("Acum esti ~g~vizibil.")
    end
end

function tvRP.isInvisible()
    return invisible
end

tvRP.SetNewWaypoint = function(x,y)
  SetNewWaypoint(x,y)
end

-- tvRP.adminAnnouncement = function(subtitle, message, ms)
--     ms = ms or 7000
--     local timer = true
--     Citizen.SetTimeout(ms, function()
--         timer = false
--     end)
--     CreateThread(function()
--         Wait(0)
--         function Initialize(scaleform)
--             local scaleform = RequestScaleformMovie(scaleform)
--             while not HasScaleformMovieLoaded(scaleform) do
--                 Wait(0)
--             end
--             PushScaleformMovieFunction(scaleform, "SHOW_WEAPON_PURCHASED")
--             PushScaleformMovieFunctionParameterString("~r~ANUNT ADMIN")
--             PushScaleformMovieFunctionParameterString(message)
--             PushScaleformMovieFunctionParameterString(subtitle)
--             PopScaleformMovieFunctionVoid()
--             Citizen.SetTimeout(ms, function()
--                 PushScaleformMovieFunction(scaleform, "SHARD_ANIM_OUT")
--                 PushScaleformMovieFunctionParameterInt(1)
--                 PushScaleformMovieFunctionParameterFloat(0.33)
--                 PopScaleformMovieFunctionVoid()
--                 Citizen.SetTimeout(6000, function()EndScaleformMovieMethod() end)
--             end)
--             return scaleform
--         end
--         scaleform = Initialize("mp_big_message_freemode")
--         while timer do
--             Wait(0)
--             DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 100, 0)
--         end
--     end)
-- end

local isFrozen = false

tvRP.setFreeze = function(bool, ignoreVisibility)
    isFrozen = bool
    local ped = PlayerPedId()
    if not ignoreVisibility then
      SetEntityVisible(ped, not bool)
    end
    FreezeEntityPosition(ped, isFrozen)
    SetEntityInvincible(ped, isFrozen)
end


function tvRP.adminAnnouncement(name,id,msg)
	SendNUIMessage({
    sendAdminAnnouncement = true,
    admAnnName = name,
    admAnnId = id,
    admAnnMessage = msg
  })
end

function tvRP.setDefaultSkin(model, saveWeapons)
    SetEntityInvincible(PlayerPedId(), true)
    if IsModelInCdimage(model) and IsModelValid(model) then
      RequestModel(model)
      while (not HasModelLoaded(model)) do
        Wait(0)
      end
      if saveWeapons then
        weapons = tvRP.getWeapons()
      end
      local health = tvRP.getHealth()
      SetPlayerModel(PlayerId(), model)
      if saveWeapons then
        if weapons then
          tvRP.giveWeapons(weapons, false)
        end
      end
      tvRP.setHealth(health)
      SetModelAsNoLongerNeeded(model)
      FreezePedCameraRotation(PlayerPedId(), true)
      if model ~= nil then
        if(model == 'mp_f_freemode_01' or model == 'mp_m_freemode_01')then
          SetPedHeadBlendData(PlayerPedId(), 0, 0, 0, 15, 0, 0, 0, 1.0, 0, false)
          SetPedComponentVariation(PlayerPedId(), 11, 3, 0, 0)
          SetPedComponentVariation(PlayerPedId(), 8, 0, 1, 0)
          SetPedComponentVariation(PlayerPedId(), 6, 1, 2, 0)
          SetPedComponentVariation(PlayerPedId(), 4, 55, 1, 0)
          SetPedComponentVariation(PlayerPedId(), 3, 1, 0, 0)
          SetPedHeadOverlayColor(PlayerPedId(), 1, 1, 0, 0)
          SetPedHeadOverlayColor(PlayerPedId(), 2, 1, 0, 0)
          SetPedHeadOverlayColor(PlayerPedId(), 4, 2, 0, 0)
          SetPedHeadOverlayColor(PlayerPedId(), 5, 2, 0, 0)
          SetPedHeadOverlayColor(PlayerPedId(), 8, 2, 0, 0)
          SetPedHeadOverlayColor(PlayerPedId(), 10, 1, 0, 0)
          SetPedHeadOverlay(PlayerPedId(), 1, 0, 0.0)
          SetPedHairColor(PlayerPedId(), 1, 1)
        end
      end
    end
    SetEntityInvincible(PlayerPedId(),false)
    TriggerServerEvent('esk_tattoo:loadTattoos')
  end

-- tvRP.bonusAnnouncement = function(subtitle, message, ms)
--     ms = ms or 7000
--     local timer = true
--     Citizen.SetTimeout(ms, function()
--         timer = false
--     end)
--     CreateThread(function()
--         Wait(0)
--         function Initialize(scaleform)
--             local scaleform = RequestScaleformMovie(scaleform)
--             while not HasScaleformMovieLoaded(scaleform) do
--                 Wait(0)
--             end
--             PushScaleformMovieFunction(scaleform, "SHOW_WEAPON_PURCHASED")
--             PushScaleformMovieFunctionParameterString("~p~Bonus")
--             PushScaleformMovieFunctionParameterString(message)
--             PushScaleformMovieFunctionParameterString(subtitle)
--             PopScaleformMovieFunctionVoid()
--             Citizen.SetTimeout(ms, function()
--                 PushScaleformMovieFunction(scaleform, "SHARD_ANIM_OUT")
--                 PushScaleformMovieFunctionParameterInt(1)
--                 PushScaleformMovieFunctionParameterFloat(0.33)
--                 PopScaleformMovieFunctionVoid()
--                 Citizen.SetTimeout(6000, function()EndScaleformMovieMethod() end)
--             end)
--             return scaleform
--         end
--         scaleform = Initialize("mp_big_message_freemode")
--         while timer do
--             Wait(0)
--             DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 100, 0)
--         end
--     end)
-- end

function tvRP.bonusAnnouncement(msg)
	ShowMPMessage("~b~BONUS", msg, 10000)
end

-- tvRP.bonusAnnouncement2 = function(subtitle, message, ms)
--     ms = ms or 7000
--     local timer = true
--     Citizen.SetTimeout(ms, function()
--         timer = false
--     end)
--     CreateThread(function()
--         Wait(0)
--         function Initialize(scaleform)
--             local scaleform = RequestScaleformMovie(scaleform)
--             while not HasScaleformMovieLoaded(scaleform) do
--                 Wait(0)
--             end
--             PushScaleformMovieFunction(scaleform, "SHOW_WEAPON_PURCHASED")
--             PushScaleformMovieFunctionParameterString("~r~Bonus")
--             PushScaleformMovieFunctionParameterString(message)
--             PushScaleformMovieFunctionParameterString(subtitle)
--             PopScaleformMovieFunctionVoid()
--             Citizen.SetTimeout(ms, function()
--                 PushScaleformMovieFunction(scaleform, "SHARD_ANIM_OUT")
--                 PushScaleformMovieFunctionParameterInt(1)
--                 PushScaleformMovieFunctionParameterFloat(0.33)
--                 PopScaleformMovieFunctionVoid()
--                 Citizen.SetTimeout(6000, function()EndScaleformMovieMethod() end)
--             end)
--             return scaleform
--         end
--         scaleform = Initialize("mp_big_message_freemode")
--         while timer do
--             Wait(0)
--             DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 100, 0)
--         end
--     end)
-- end

function tvRP.bonusAnnouncement2(msg)
	ShowMPMessage("~b~BONUS", msg, 10000)
end

-- tvRP.paydayAnnouncement = function(subtitle, message, ms)
--     ms = ms or 7000
--     local timer = true
--     Citizen.SetTimeout(ms, function()
--         timer = false
--     end)
--     CreateThread(function()
--         Wait(0)
--         function Initialize(scaleform)
--             local scaleform = RequestScaleformMovie(scaleform)
--             while not HasScaleformMovieLoaded(scaleform) do
--                 Wait(0)
--             end
--             PushScaleformMovieFunction(scaleform, "SHOW_WEAPON_PURCHASED")
--             PushScaleformMovieFunctionParameterString("~b~PAYDAY")
--             PushScaleformMovieFunctionParameterString(message)
--             PushScaleformMovieFunctionParameterString(subtitle)
--             PopScaleformMovieFunctionVoid()
--             Citizen.SetTimeout(ms, function()
--                 PushScaleformMovieFunction(scaleform, "SHARD_ANIM_OUT")
--                 PushScaleformMovieFunctionParameterInt(1)
--                 PushScaleformMovieFunctionParameterFloat(0.33)
--                 PopScaleformMovieFunctionVoid()
--                 Citizen.SetTimeout(6000, function()EndScaleformMovieMethod() end)
--             end)
--             return scaleform
--         end
--         scaleform = Initialize("mp_big_message_freemode")
--         while timer do
--             Wait(0)
--             DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 100, 0)
--         end
--     end)
-- end

function tvRP.paydayAnnouncement(msg)
	ShowMPMessage("~b~PAYDAY", msg, 10000)
end

-- tvRP.eventAnnouncement2 = function(subtitle, message, ms)
--     ms = ms or 7000
--     local timer = true
--     Citizen.SetTimeout(ms, function()
--         timer = false
--     end)
--     CreateThread(function()
--         Wait(0)
--         function Initialize(scaleform)
--             local scaleform = RequestScaleformMovie(scaleform)
--             while not HasScaleformMovieLoaded(scaleform) do
--                 Wait(0)
--             end
--             PushScaleformMovieFunction(scaleform, "SHOW_WEAPON_PURCHASED")
--             PushScaleformMovieFunctionParameterString("~r~EVENT OPRIT")
--             PushScaleformMovieFunctionParameterString(message)
--             PushScaleformMovieFunctionParameterString(subtitle)
--             PopScaleformMovieFunctionVoid()
--             Citizen.SetTimeout(ms, function()
--                 PushScaleformMovieFunction(scaleform, "SHARD_ANIM_OUT")
--                 PushScaleformMovieFunctionParameterInt(1)
--                 PushScaleformMovieFunctionParameterFloat(0.33)
--                 PopScaleformMovieFunctionVoid()
--                 Citizen.SetTimeout(6000, function()EndScaleformMovieMethod() end)
--             end)
--             return scaleform
--         end
--         scaleform = Initialize("mp_big_message_freemode")
--         while timer do
--             Wait(0)
--             DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 100, 0)
--         end
--     end)
-- end

function tvRP.eventAnnouncement2(msg)
	ShowMPMessage("~b~EVENT OPRIT", msg, 10000)
end

-- tvRP.eventAnnouncement = function(subtitle, message, ms)
--     ms = ms or 7000
--     local timer = true
--     Citizen.SetTimeout(ms, function()
--         timer = false
--     end)
--     CreateThread(function()
--         Wait(0)
--         function Initialize(scaleform)
--             local scaleform = RequestScaleformMovie(scaleform)
--             while not HasScaleformMovieLoaded(scaleform) do
--                 Wait(0)
--             end
--             PushScaleformMovieFunction(scaleform, "SHOW_WEAPON_PURCHASED")
--             PushScaleformMovieFunctionParameterString("~g~EVENT PORNIT")
--             PushScaleformMovieFunctionParameterString(message)
--             PushScaleformMovieFunctionParameterString(subtitle)
--             PopScaleformMovieFunctionVoid()
--             Citizen.SetTimeout(ms, function()
--                 PushScaleformMovieFunction(scaleform, "SHARD_ANIM_OUT")
--                 PushScaleformMovieFunctionParameterInt(1)
--                 PushScaleformMovieFunctionParameterFloat(0.33)
--                 PopScaleformMovieFunctionVoid()
--                 Citizen.SetTimeout(6000, function()EndScaleformMovieMethod() end)
--             end)
--             return scaleform
--         end
--         scaleform = Initialize("mp_big_message_freemode")
--         while timer do
--             Wait(0)
--             DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 100, 0)
--         end
--     end)
-- end

function tvRP.eventAnnouncement(msg)
	ShowMPMessage("~b~EVENT PORNIT", msg, 10000)
end

-- tvRP.cleanupAnnouncement = function(subtitle, message, ms)
--     ms = ms or 7000
--     local timer = true
--     Citizen.SetTimeout(ms, function()
--         timer = false
--     end)
--     CreateThread(function()
--         Wait(0)
--         function Initialize(scaleform)
--             local scaleform = RequestScaleformMovie(scaleform)
--             while not HasScaleformMovieLoaded(scaleform) do
--                 Wait(0)
--             end
--             PushScaleformMovieFunction(scaleform, "SHOW_WEAPON_PURCHASED")
--             PushScaleformMovieFunctionParameterString("~r~CLEANUP")
--             PushScaleformMovieFunctionParameterString(message)
--             PushScaleformMovieFunctionParameterString(subtitle)
--             PopScaleformMovieFunctionVoid()
--             Citizen.SetTimeout(ms, function()
--                 PushScaleformMovieFunction(scaleform, "SHARD_ANIM_OUT")
--                 PushScaleformMovieFunctionParameterInt(1)
--                 PushScaleformMovieFunctionParameterFloat(0.33)
--                 PopScaleformMovieFunctionVoid()
--                 Citizen.SetTimeout(6000, function()EndScaleformMovieMethod() end)
--             end)
--             return scaleform
--         end
--         scaleform = Initialize("mp_big_message_freemode")
--         while timer do
--             Wait(0)
--             DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 100, 0)
--         end
--     end)
-- end

function tvRP.eventAnnouncement(msg)
	ShowMPMessage("~b~EVENT PORNIT", msg, 10000)
end

local noclip = false
local invisible = false
local noclip_speed = 3.0

function tvRP.tryToggleNoclip()
  TriggerServerEvent("noclip:tryToToggle")
end

function tvRP.toggleNoclip()
  noclip = not noclip
  local ped = PlayerPedId()
  if noclip then
  SetEntityInvincible(ped, true)
  SetEntityVisible(ped, false, false)
	tvRP.notify("~g~Succes: ~w~Foloseste tastele ~b~SHIFT ~w~si ~b~CTRL ~w~pentru a regla viteza")
  else
    SetEntityInvincible(ped, false)
    SetEntityVisible(ped, true, true)
  end
end

Citizen.CreateThread(function()
    while true do
      Citizen. Wait(5)
      if noclip then
        local ped = PlayerPedId()
        local x,y,z = tvRP.getPosition()
        local dx,dy,dz = tvRP.getCamDirection()
        local speed = noclip_speed
  
        -- reset velocity
        SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)
  
        -- forward
        if IsControlPressed(0,32) then 
          if 		IsControlPressed(0,21) then speed = 10.0
          elseif 	IsControlPressed(0,210) then speed = 1.0 end
  
          x = x+speed*dx
          y = y+speed*dy
          z = z+speed*dz
        end
  
        -- backward
        if IsControlPressed(0,269) then 
          if 		IsControlPressed(0,21) then speed = 10.0 
          elseif 	IsControlPressed(0,210) then speed = 1.0 end
  
          x = x-speed*dx
          y = y-speed*dy
          z = z-speed*dz
        end
  
        SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
      end
    end
  end)
  
  function tvRP.isNoclip()
    return noclip
  end