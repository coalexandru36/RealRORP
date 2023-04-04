
-- this module define some police tools and functions

local handcuffed = false
local cop = false

function tvRP.toggleInEvent()
  inEvent = not inEvent
end

function tvRP.setInEvent(flag)
  if inEvent ~= flag then
    tvRP.toggleInEvent()
  end
end

function tvRP.isInEvent()
  return inEvent
end

-- set player as cop (true or false)
--[[function tvRP.setCop(flag)
  cop = flag
  SetPedAsCop(PlayerPedId(),flag)
end]]

-- HANDCUFF
local handcuffed = false
local cop = false
function tvRP.setCop(flag)
    cop = flag
    SetPedAsCop(_GPED, flag)
end
function tvRP.toggleHandcuff()
    handcuffed = not handcuffed
    
    SetEnableHandcuffs(PlayerPedId(), handcuffed)
    if handcuffed then
        tvRP.playAnim(true, {{"mp_arresting", "idle", 1}}, true)
    else
        tvRP.stopAnim(true)
        SetPedStealthMovement(PlayerPedId(), false, "")
    end
    CreateThread(function()
        CreateThread(function()
            while handcuffed do
                tvRP.playAnim(true, {{"mp_arresting", "idle", 1}}, true)
                Wait(15000)
            end
            tvRP.stopAnim(true)
        end)
        while handcuffed do
            SetPedStealthMovement(PlayerPedId(), true, "")
            DisableControlAction(0, 21, true)-- disable sprint
            DisableControlAction(0, 24, true)-- disable attack
            DisableControlAction(0, 25, true)-- disable aim
            DisableControlAction(0, 47, true)-- disable weapon
            DisableControlAction(0, 58, true)-- disable weapon
            DisableControlAction(0, 263, true)-- disable melee
            DisableControlAction(0, 264, true)-- disable melee
            DisableControlAction(0, 257, true)-- disable melee
            DisableControlAction(0, 140, true)-- disable melee
            DisableControlAction(0, 141, true)-- disable melee
            DisableControlAction(0, 142, true)-- disable melee
            DisableControlAction(0, 143, true)-- disable melee
            DisableControlAction(0, 75, true)-- disable exit vehicle
            DisableControlAction(27, 75, true)-- disable exit vehicle
            Wait(0)
        end
    end)
end

function tvRP.setHandcuffed(flag)
    if handcuffed ~= flag then
        tvRP.toggleHandcuff()
    end
end

function tvRP.isHandcuffed()
    return handcuffed
end

-- (experimental, based on experimental getNearestVehicle)
function tvRP.putInNearestVehicleAsPassenger(radius)
    local veh = tvRP.getNearestVehicle(radius)
    
    if IsEntityAVehicle(veh) then
        for i = 1, math.max(GetVehicleMaxNumberOfPassengers(veh), 3) do
            if IsVehicleSeatFree(veh, i) then
                SetPedIntoVehicle(_GPED, veh, i)
                return true
            end
        end
    end
    
    return false
end

function tvRP.putInNetVehicleAsPassenger(net_veh)
    local veh = NetworkGetEntityFromNetworkId(net_veh)
    if IsEntityAVehicle(veh) then
        for i = 1, GetVehicleMaxNumberOfPassengers(veh) do
            if IsVehicleSeatFree(veh, i) then
                SetPedIntoVehicle(_GPED, veh, i)
                return true
            end
        end
    end
end

function tvRP.putInVehiclePositionAsPassenger(x, y, z)
    local veh = tvRP.getVehicleAtPosition(x, y, z)
    if IsEntityAVehicle(veh) then
        for i = 1, GetVehicleMaxNumberOfPassengers(veh) do
            if IsVehicleSeatFree(veh, i) then
                SetPedIntoVehicle(_GPED, veh, i)
                return true
            end
        end
    end
end


local arrst					= false
local arest_on				= false

local variabila3			= 'mp_arrest_paired'
local variabila2 			= 'cop_p2_back_left'
local variabila1			= 'crook_p2_back_left'

RegisterNetEvent('mita:arrestonway')
AddEventHandler('mita:arrestonway', function(target)
	arest_on = true
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	RequestAnimDict(variabila3)
	while not HasAnimDictLoaded(variabila3) do
		Citizen.Wait(10)
	end

	AttachEntityToEntity(_GPED, targetPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
	TaskPlayAnim(_GPED, variabila3, variabila1, 8.0, -8.0, 5500, 33, 0, false, false, false)

	Citizen.Wait(950)
	DetachEntity(_GPED, true, false)
	arest_on = false
end) 


RegisterNetEvent('radu:arrest')
AddEventHandler('radu:arrest', function()
	RequestAnimDict(variabila3)
	while not HasAnimDictLoaded(variabila3) do
		Citizen.Wait(10)
	end

	TaskPlayAnim(_GPED, variabila3, variabila2, 8.0, -8.0, 5500, 33, 0, false, false, false)
	Citizen.Wait(3000)
	arrst = false
end)


-- JAIL

local jail = nil

-- jail the player in a no-top no-bottom cylinder 
function tvRP.jail(x,y,z,radius)
  tvRP.teleport(x,y,z) -- teleport to center
  jail = {x+0.0001,y+0.0001,z+0.0001,radius+0.0001}
  CreateThread(function()
    while jail do
      local x,y,z = table.unpack(GetEntityCoords(_GPED))

      local dx = x-jail[1]
      local dy = y-jail[2]
      local dist = math.sqrt(dx*dx+dy*dy)

      if dist >= jail[4] then
        local ped = _GPED
        SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001) -- stop player

        -- normalize + push to the edge + add origin
        dx = dx/dist*jail[4]+jail[1]
        dy = dy/dist*jail[4]+jail[2]

        -- teleport player at the edge
        SetEntityCoordsNoOffset(ped,dx,dy,z,true,true,true)
      end
      Wait(5)
    end
  end)
end

-- unjail the player
function tvRP.unjail()
  jail = nil
end

function tvRP.isJailed()
  return jail ~= nil
end
