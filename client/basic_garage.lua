local vehicles = {}
vehBlip = nil

AddEventHandler('vrp_garages:setVehicle', function(vtype, vehicle)
    vehicles[vtype] = vehicle
end)

function tvRP.spawnGarageVehicle(vtype,name,veh_plate,tunning) -- vtype is the vehicle type (one vehicle per type allowed at the same time)

	local vehicle = vehicles[vtype]
	if vehicle and not IsVehicleDriveable(vehicle[3]) then -- precheck if vehicle is undriveable
	  -- despawn vehicle
	  SetVehicleHasBeenOwnedByPlayer(vehicle[3],false)
	  Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle[3], false, true) -- set not as mission entity
	  SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
	  Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
	  vehicles[vtype] = nil
	  TriggerEvent("vrp_garages:setVehicle", vtype, nil)
  end
  
	  vehicle = vehicles[vtype]
	  if vehicle == nil then
		  -- load vehicle model
		  local mhash = GetHashKey(name)
  
		  local i = 0
		  while not HasModelLoaded(mhash) and i < 10000 do
			  RequestModel(mhash)
			  Citizen.Wait(10)
			  i = i+1
		  end
  
		  -- spawn car
		  if HasModelLoaded(mhash) then
			  local x,y,z = tvRP.getPosition()
  
			  local nveh = CreateVehicle(mhash, x,y,z+0.5, 0.0, true, false)
			  NetworkFadeInEntity(nveh,0)
			  exports['vrp_tunning']:setTunning(nveh, tunning)
			  SetVehicleOnGroundProperly(nveh)
			  SetEntityInvincible(nveh,false)
			  SetPedIntoVehicle(PlayerPedId(),nveh,-1) -- put player inside
			  SetVehicleNumberPlateText(nveh, veh_plate)
			  Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true) -- set as mission entity
			  SetVehicleHasBeenOwnedByPlayer(nveh,true)
			  vehBlip = AddBlipForEntity(nveh)
			  SetBlipSprite(vehBlip, 225)
			  SetBlipColour(vehBlip, 69)
  
			  --Network vehicle set to allow migration by default
			  local nid = NetworkGetNetworkIdFromEntity(nveh)
			  --SetNetworkIdCanMigrate(nid,cfg.vehicle_migration)
  
			  vehicles[vtype] = {vtype,name,nveh} -- set current vehicule
			  TriggerEvent("vrp_garages:setVehicle", vtype, {vtype,name,nveh})
  
			  SetModelAsNoLongerNeeded(mhash)
		  end
	  else
		  DeleteEntity(vehicle[3])
	  end
  end

function tvRP.garage_setmods(mods,farcolorat)
	local ped = GetPlayerPed(-1)
	  local veh = GetVehiclePedIsUsing(ped)
	  local a = string.find(mods, ":")
	local ct = 0
	ToggleVehicleMod(veh,22,1)
	SetVehicleXenonLightsColour(veh, farcolorat)
	  SetVehicleModKit(veh,0)
	  while mods ~= nil do
		  local b
		  if a ~= nil then
			  b = mods:sub(0,a-1)
			  mods = mods:sub(a+1)
			  a = string.find(mods, ":")
		  else
			  b = mods
			  mods = nil
		  end
		  local u = string.find(b, ",")
		  if ct == 0 then
			  local u1 = b:sub(0,u-1)
			  local u2 = b:sub(u+1)
			  SetVehicleColours(veh,tonumber(u1),tonumber(u2))
		  elseif ct == 1 then
			  local u1 = b:sub(0,u-1)
			  local u2 = b:sub(u+1)
			  SetVehicleExtraColours(veh,tonumber(u1),tonumber(u2))
		  elseif ct == 2 then
			  local u1 = b:sub(0,u-1)
			  local u2 = b:sub(u+1)
			  local spl = string.find(u2, ",")
			  local u3 = u2:sub(spl+1)
			  u2 = u2:sub(0,spl-1)
			  SetVehicleNeonLightsColour(veh,tonumber(u1),tonumber(u2),tonumber(u3))
		  elseif ct == 3 then
			  local bl = false
			  if tostring(b) == "true" then bl = true end
			  SetVehicleNeonLightEnabled(veh,0,bl)
			  SetVehicleNeonLightEnabled(veh,1,bl)
			  SetVehicleNeonLightEnabled(veh,2,bl)
			  SetVehicleNeonLightEnabled(veh,3,bl)
		  elseif ct == 4 then
			  local u1 = b:sub(0,u-1)
			  local u2 = b:sub(u+1)
			  local spl = string.find(u2, ",")
			  local u3 = u2:sub(spl+1)
			  u2 = u2:sub(0,spl-1)
			  SetVehicleTyreSmokeColor(veh,tonumber(u1),tonumber(u2),tonumber(u3))
		  elseif ct == 5 then
			  SetVehicleNumberPlateTextIndex(veh,tonumber(b))
		  elseif ct == 6 then
			  SetVehicleWindowTint(veh,tonumber(b))
		  elseif ct == 7 then
			  SetVehicleWheelType(veh,tonumber(b))
		  elseif ct == 8 then
			  local bl = false
			  if tostring(b) == "true" then bl = true end
			  SetVehicleTyresCanBurst(veh,bl)
		  elseif ct == 9 then
			  local c = string.find(b, ";")
			  while b ~= nil do
				  local d
				  if c ~= nil then
					  d = b:sub(0,c-1)
					  b = b:sub(c+1)
					  c = string.find(b, ";")
				  else
					  d = b
					  b = nil
				  end
				  
				  if d ~= nil then
					  local u = string.find(d, ",")
					  local u1 = d:sub(0,u-1)
					  local u2 = d:sub(u+1)
					  local spl = string.find(u2, ",")
					  local u3 = u2:sub(spl+1)
					  u2 = u2:sub(0,spl-1)
					  local bl = false
					  if tostring(u3) == "true" then bl = true end
					  if tonumber(u1) == 18 or tonumber(u1) == 22 or tonumber(u1) == 20 then
						  ToggleVehicleMod(veh,tonumber(u1),bl)
						  SetVehicleMod(veh,tonumber(u1),tonumber(u2),bl)
					  else
						  SetVehicleMod(veh,tonumber(u1),tonumber(u2),bl)
					  end
				  end
			  end
		  end
		  ct = ct+1
	  end
  end

function tvRP.despawnGarageVehicle(vtype,max_range)
	local vehicle = vehicles[vtype]
	if vehicle then
		local x,y,z = table.unpack(GetEntityCoords(vehicle[3],true))
		local px,py,pz = tvRP.getPosition()
    local healthCar = GetVehicleEngineHealth(vehicle[3])
    if GetDistanceBetweenCoords(x,y,z,px,py,pz,true) < max_range then -- check distance with the vehicule
   --   if vtype == "car" or "barca" or "elicopter" or "avion" or "vipbronze" or "vipbronze" then
        SetVehicleHasBeenOwnedByPlayer(vehicle[3],false)
        Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle[3], false, true) -- set not as mission entity
        SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
        vehicles[vtype] = nil
        vRPserver.getDamage({healthCar})
        if healthCar < 450.0 then
          vRPserver.damageInsert({vehicle[2], 1})
        elseif healthCar >= 650.0 and healthCar <= 750.0 then
          vRPserver.askDamage({vehicle[2]})
        elseif healthCar >= 950.0 then
          vRPserver.damageInsert({vehicle[2], 2})
        end
      return true
  --    end
		end
	end
  return false
end


function tvRP.getNearestVehicle(radius)
  local x,y,z = tvRP.getPosition()
  local ped = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ped) then
    return GetVehiclePedIsIn(ped, true)
  else

    local veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001, radius+0.0001, 0, 8192+4096+4+2+1)  -- boats, helicos
    if not IsEntityAVehicle(veh) then veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001, radius+0.0001, 0, 4+2+1) end -- cars
    return veh
  end
end

function tvRP.fixeNearestVehicle(radius)
  local veh = tvRP.getNearestVehicle(radius)
  if IsEntityAVehicle(veh) then
    SetVehicleFixed(veh)
  end
end

function tvRP.replaceNearestVehicle(radius)
  local veh = tvRP.getNearestVehicle(radius)
  if IsEntityAVehicle(veh) then
    SetVehicleOnGroundProperly(veh)
  end
end

-- try to get a vehicle at a specific position (using raycast)
function tvRP.getVehicleAtPosition(x,y,z)
  x = x+0.0001
  y = y+0.0001
  z = z+0.0001

  local ray = CastRayPointToPoint(x,y,z,x,y,z+4,10,GetPlayerPed(-1),0)
  local a, b, c, d, ent = GetRaycastResult(ray)
  return ent
end

-- return ok,vtype,name
function tvRP.getNearestOwnedVehicle(radius)
  local px,py,pz = tvRP.getPosition()
  for k,v in pairs(vehicles) do
    local x,y,z = table.unpack(GetEntityCoords(v[3],true))
    local dist = GetDistanceBetweenCoords(x,y,z,px,py,pz,true)
    if dist <= radius+0.0001 then return true,v[1],v[2] end
  end

  return false,"",""
end

-- return ok,x,y,z
function tvRP.getAnyOwnedVehiclePosition()
  for k,v in pairs(vehicles) do
    if IsEntityAVehicle(v[3]) then
      local x,y,z = table.unpack(GetEntityCoords(v[3],true))
      return true,x,y,z
    end
  end

  return false,0,0,0
end

-- return x,y,z
function tvRP.getOwnedVehiclePosition(vtype)
  local vehicle = vehicles[vtype]
  local x,y,z = 0,0,0

  if vehicle then
    x,y,z = table.unpack(GetEntityCoords(vehicle[3],true))
  end

  return x,y,z
end

-- return ok, vehicule network id
function tvRP.getOwnedVehicleId(vtype)
  local vehicle = vehicles[vtype]
  if vehicle then
    return true, NetworkGetNetworkIdFromEntity(vehicle[3])
  else
    return false, 0
  end
end

-- eject the ped from the vehicle
function tvRP.ejectVehicle()
  local ped = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ped) then
    local veh = GetVehiclePedIsIn(ped,false)
    TaskLeaveVehicle(ped, veh, 4160)
  end
end

-- vehicle commands
function tvRP.vc_openDoor(vtype, door_index)
  local vehicle = vehicles[vtype]
  if vehicle then
    SetVehicleDoorOpen(vehicle[3],door_index,0,false)
  end
end

function tvRP.vc_closeDoor(vtype, door_index)
  local vehicle = vehicles[vtype]
  if vehicle then
    SetVehicleDoorShut(vehicle[3],door_index)
  end
end

function tvRP.vc_detachTrailer(vtype)
  local vehicle = vehicles[vtype]
  if vehicle then
    DetachVehicleFromTrailer(vehicle[3])
  end
end

function tvRP.vc_detachTowTruck(vtype)
  local vehicle = vehicles[vtype]
  if vehicle then
    local ent = GetEntityAttachedToTowTruck(vehicle[3])
    if IsEntityAVehicle(ent) then
      DetachVehicleFromTowTruck(vehicle[3],ent)
    end
  end
end

function tvRP.vc_detachCargobob(vtype)
  local vehicle = vehicles[vtype]
  if vehicle then
    local ent = GetVehicleAttachedToCargobob(vehicle[3])
    if IsEntityAVehicle(ent) then
      DetachVehicleFromCargobob(vehicle[3],ent)
    end
  end
end

function tvRP.vc_toggleEngine(vtype)
  local vehicle = vehicles[vtype]
  if vehicle then
    local running = Citizen.InvokeNative(0xAE31E7DF9B5B132E,vehicle[3]) -- GetIsVehicleEngineRunning
    SetVehicleEngineOn(vehicle[3],not running,true,true)
    if running then
      SetVehicleUndriveable(vehicle[3],true)
    else
      SetVehicleUndriveable(vehicle[3],false)
    end
  end
end

function tvRP.vc_toggleLock(vtype)
  local vehicle = vehicles[vtype]
  if vehicle then

    local dict = "anim@mp_player_intmenu@key_fob@"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

    local veh = vehicle[3]


    if not IsPedInAnyVehicle(PlayerPedId(), true) then
      TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
    end
    
    SetVehicleLights(veh, 2)
    Citizen.Wait(150)
    SetVehicleLights(veh, 0)
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10.0, "carLock", 0.8)
    Citizen.Wait(150)
    SetVehicleLights(veh, 2)
    Citizen.Wait(150)
    SetVehicleLights(veh, 0)

    local locked = GetVehicleDoorLockStatus(veh) >= 2

    if locked then
      SetVehicleDoorsLockedForAllPlayers(veh, false)
      SetVehicleDoorsLocked(veh,1)
      SetVehicleDoorsLockedForPlayer(veh, PlayerId(), false)

      tvRP.notify("~g~Succes: ~w~Masina descuiata")
    else
      SetVehicleDoorsLocked(veh,2)
      SetVehicleDoorsLockedForAllPlayers(veh, true)
      tvRP.notify("~g~Succes: ~w~Masina incuiata")
    end
  end
end

function tvRP.garage_setmods(mods,farcolorat)
	local ped = GetPlayerPed(-1)
	  local veh = GetVehiclePedIsUsing(ped)
	  local a = string.find(mods, ":")
	local ct = 0
	ToggleVehicleMod(veh,22,1)
	SetVehicleXenonLightsColour(veh, farcolorat)
	  SetVehicleModKit(veh,0)
	  while mods ~= nil do
		  local b
		  if a ~= nil then
			  b = mods:sub(0,a-1)
			  mods = mods:sub(a+1)
			  a = string.find(mods, ":")
		  else
			  b = mods
			  mods = nil
		  end
		  local u = string.find(b, ",")
		  if ct == 0 then
			  local u1 = b:sub(0,u-1)
			  local u2 = b:sub(u+1)
			  SetVehicleColours(veh,tonumber(u1),tonumber(u2))
		  elseif ct == 1 then
			  local u1 = b:sub(0,u-1)
			  local u2 = b:sub(u+1)
			  SetVehicleExtraColours(veh,tonumber(u1),tonumber(u2))
		  elseif ct == 2 then
			  local u1 = b:sub(0,u-1)
			  local u2 = b:sub(u+1)
			  local spl = string.find(u2, ",")
			  local u3 = u2:sub(spl+1)
			  u2 = u2:sub(0,spl-1)
			  SetVehicleNeonLightsColour(veh,tonumber(u1),tonumber(u2),tonumber(u3))
		  elseif ct == 3 then
			  local bl = false
			  if tostring(b) == "true" then bl = true end
			  SetVehicleNeonLightEnabled(veh,0,bl)
			  SetVehicleNeonLightEnabled(veh,1,bl)
			  SetVehicleNeonLightEnabled(veh,2,bl)
			  SetVehicleNeonLightEnabled(veh,3,bl)
		  elseif ct == 4 then
			  local u1 = b:sub(0,u-1)
			  local u2 = b:sub(u+1)
			  local spl = string.find(u2, ",")
			  local u3 = u2:sub(spl+1)
			  u2 = u2:sub(0,spl-1)
			  SetVehicleTyreSmokeColor(veh,tonumber(u1),tonumber(u2),tonumber(u3))
		  elseif ct == 5 then
			  SetVehicleNumberPlateTextIndex(veh,tonumber(b))
		  elseif ct == 6 then
			  SetVehicleWindowTint(veh,tonumber(b))
		  elseif ct == 7 then
			  SetVehicleWheelType(veh,tonumber(b))
		  elseif ct == 8 then
			  local bl = false
			  if tostring(b) == "true" then bl = true end
			  SetVehicleTyresCanBurst(veh,bl)
		  elseif ct == 9 then
			  local c = string.find(b, ";")
			  while b ~= nil do
				  local d
				  if c ~= nil then
					  d = b:sub(0,c-1)
					  b = b:sub(c+1)
					  c = string.find(b, ";")
				  else
					  d = b
					  b = nil
				  end
				  
				  if d ~= nil then
					  local u = string.find(d, ",")
					  local u1 = d:sub(0,u-1)
					  local u2 = d:sub(u+1)
					  local spl = string.find(u2, ",")
					  local u3 = u2:sub(spl+1)
					  u2 = u2:sub(0,spl-1)
					  local bl = false
					  if tostring(u3) == "true" then bl = true end
					  if tonumber(u1) == 18 or tonumber(u1) == 22 or tonumber(u1) == 20 then
						  ToggleVehicleMod(veh,tonumber(u1),bl)
						  SetVehicleMod(veh,tonumber(u1),tonumber(u2),bl)
					  else
						  SetVehicleMod(veh,tonumber(u1),tonumber(u2),bl)
					  end
				  end
			  end
		  end
		  ct = ct+1
	  end
end

RegisterNetEvent('vrp_garages:setVehicle')
AddEventHandler('vrp_garages:setVehicle', function(vtype, vehicle)
  vehicles[vtype] = vehicle
end)