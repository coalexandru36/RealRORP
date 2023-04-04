function tvRP.setFriendlyFire(flag)
  NetworkSetFriendlyFireOption(flag)
  SetCanAttackFriendly(PlayerPedId(), flag, flag)
end

function tvRP.setPolice(flag)
  local player = PlayerId()
  SetPoliceIgnorePlayer(player, not flag)
  SetDispatchCopsForPlayer(player, flag)
end

function tvRP.varyHealth(variation)
  local ped = PlayerPedId()
  
  local n = math.floor(GetEntityHealth(ped) + variation)
  SetEntityHealth(ped, n)
end

function tvRP.varyArmour(var)
  local ped = PlayerPedId()
  local n = math.floor(GetPedArmour(ped) + var)
  SetPedArmour(ped, n)
end

function tvRP.getHealth()
  return GetEntityHealth(PlayerPedId())
end

function tvRP.setHealth(health)
  local n = math.floor(health)
  SetEntityHealth(PlayerPedId(), n)
  Citizen.SetTimeout(1000, function()    
      SetEntityHealth(PlayerPedId(), n)
      if n <= 105 then
          doComaTick();
      end
  end)
end

local CreateThread = Citizen.CreateThread
local Wait = Citizen.Wait

-- impact thirst and hunger when the player is running (every 5 seconds)
CreateThread(function()
  while true do
    Wait(5000)
    if IsPlayerPlaying(PlayerId()) then
      local ped = PlayerPedId()
      -- variations for one minute
      local vthirst = 0
      local vhunger = 0

      -- on foot, increase thirst/hunger in function of velocity
      if IsPedOnFoot(ped) then
        local factor = math.min(tvRP.getSpeed(),10)

        vthirst = vthirst+1*factor
        vhunger = vhunger+0.5*factor
      end

      -- in melee combat, increase
      if IsPedInMeleeCombat(ped) then
        vthirst = vthirst+10
        vhunger = vhunger+5
      end

      -- injured, hurt, increase
      if IsPedHurt(ped) or IsPedInjured(ped) then
        vthirst = vthirst+2
        vhunger = vhunger+1
      end

      -- do variation
      if vthirst ~= 0 then
        print(vthirst/12.0)
        vRPserver.varyThirst({vthirst/12.0})
      end

      if vhunger ~= 0 then
        print(vhunger/12.0)
        vRPserver.varyHunger({vhunger/12.0})
      end
    end
  end
end)

-- local snTurfs = Proxy.getInterface("snTurfs")

-- RegisterCommand('mata', function()
--   print('gata boss')
--   SendNUIMessage({
--     action = "updateDeathscreen",
--     event = "showDeathscreen"
--   })
-- end)

local GetEntityHealth = GetEntityHealth
local IsEntityDead = IsEntityDead
local SetEntityHealth = SetEntityHealth
local NetworkResurrectLocalPlayer = NetworkResurrectLocalPlayer
local in_coma = false
local coma_left = cfg.coma_duration*60
-- local once = false 
-- RegisterNetEvent('snTurfs:reset', function() once = false; end)

function doComaTick()
  if in_coma then return end
  in_coma = true
  coma_left = cfg.coma_duration*60
  SetEntityHealth(PlayerPedId(), cfg.coma_threshold - 1)
  vRPserver.updateHealth({cfg.coma_threshold - 1})
 -- tvRP.playScreenEffect(cfg.coma_effect, -1)
  CreateThread(function()
      CreateThread(function()
          while in_coma do
              coma_left = coma_left - 1
              if coma_left == 0 then
                  in_coma = false
                  break
              end
              Wait(1000)
          end
      end)
      while in_coma and GetEntityHealth(PlayerPedId()) <= cfg.coma_threshold do
          if IsEntityDead(PlayerPedId()) then
              local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
              NetworkResurrectLocalPlayer(x, y, z, true, true, false)
              Wait(0)
          end
          in_coma = true
          SetEntityHealth(PlayerPedId(), cfg.coma_threshold)
          SetEntityInvincible(PlayerPedId(), true)
          tvRP.ejectVehicle()
          if not tvRP.isRagdoll() then
              tvRP.setRagdoll(true)
          end

          -- drawTxt("Ai murit! Te respawnezi in ~r~"..coma_left.." ~s~secunde", 4, 1, 0.5, 0.85, 0.8, 255, 255, 255, 255)
          -- drawTxt("Necesiti ajutorul unui echipaj medical, ~g~K- Telefon - Servicii - Smurd", 4, 1, 0.5, 0.90, 0.5, 255, 255, 255, 155)
          -- drawTxt("Daca consideri ca ai murit non roleplay, ~o~K- Admin - Admin Ticket", 4, 1, 0.5, 0.925, 0.5, 255, 255, 255, 155)
          SendNUIMessage({
            action = "updateDeathscreen",
            event = "showDeathscreen"
          })

          SendNUIMessage({
            action = "updateDeathscreen",
            event = "update",
            seconds = coma_left
          })

          --if coma_left <= cfg.coma_duration*60 / 4 then
            if coma_left <= cfg.coma_duration*60 / 4 then
              SendNUIMessage({
                action = "updateDeathscreen",
                event = "canRespawn"
              })
              --drawTxt("Apasa ~r~E ~s~pentru a primii respawn", 4, 1, 0.5, 0.80, 0.6, 255, 255, 255, 255)
              if IsDisabledControlJustPressed(0, 38) then
                  SetEntityHealth(PlayerPedId(), 0)
                  break
              end
          end
        Wait(1)
      end
      if GetEntityHealth(PlayerPedId()) > cfg.coma_threshold then
          in_coma = false
          SetEntityInvincible(PlayerPedId(), false)
          tvRP.setRagdoll(false)
          SendNUIMessage({
            action = "updateDeathscreen",
            event = "closeDeathscreen"
          })
         -- tvRP.stopScreenEffect(cfg.coma_effect)
      else
          in_coma = false
          SetEntityHealth(PlayerPedId(), 0)
          SetEntityInvincible(PlayerPedId(), true)
          tvRP.setRagdoll(false)
          SendNUIMessage({
            action = "updateDeathscreen",
            event = "closeDeathscreen"
          })
          -- tvRP.stopScreenEffect(cfg.coma_effect)
          exports['vrp']:spawnPlayer()
          CancelEvent();
      end
  end)
end

AddEventHandler("gameEventTriggered", function(name, args)
  if name == "CEventNetworkEntityDamage" then
      local victim = args[1]
      local attacker = args[2]
      local victimDied = args[3]
      local health = GetEntityHealth(PlayerPedId())
      if not in_coma then
          if victim == PlayerPedId() and victimDied then
              if health <= cfg.coma_threshold then
                  doComaTick();
              end
          end
      end
  end
end)

function tvRP.isInComa()
  return in_coma
end

function tvRP.killComa()
  if in_coma then
      coma_left = 0
  end
end


CreateThread(function()
  while true do
    Wait(100)
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0)
  end
end)
