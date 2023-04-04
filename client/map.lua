-- BLIPS: see https://wiki.gtanet.work/index.php?title=Blips for blip id/color

-- TUNNEL CLIENT API

-- BLIP
markerNames = {}

function tvRP.addBlip(x,y,z,idtype,idcolor,text)
  local blip = AddBlipForCoord(x+0.001,y+0.001,z+0.001) -- solve strange gta5 madness with integer -> double
  SetBlipSprite(blip, idtype)
  SetBlipAsShortRange(blip, true)
  SetBlipColour(blip,idcolor)
  SetBlipScale(blip, 0.6) -- 0,7 e mic 0,9 e default
  if text ~= nil then
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
  end

  return blip
end

-- remove blip by native id
function tvRP.removeBlip(id)
  RemoveBlip(id)
end

function tvRP.addMarkerNames(theX, theY, theZ, theText, theFont, theScale)
	table.insert(markerNames, {x = theX, y = theY, z = theZ, text = theText, font = theFont, scale = theScale})
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

local named_blips = {}

-- set a named blip (same as addBlip but for a unique name, add or update)
-- return native id
function tvRP.setNamedBlip(name,x,y,z,idtype,idcolor,text)
  tvRP.removeNamedBlip(name) -- remove old one

  named_blips[name] = tvRP.addBlip(x,y,z,idtype,idcolor,text)
  return named_blips[name]
end

-- remove a named blip
function tvRP.removeNamedBlip(name)
  if named_blips[name] ~= nil then
    tvRP.removeBlip(named_blips[name])
    named_blips[name] = nil
  end
end

-- GPS

-- set the GPS destination marker coordinates
function tvRP.setGPS(x,y)
  SetNewWaypoint(x+0.0001,y+0.0001)
end

-- set route to native blip id
function tvRP.setBlipRoute(id)
  SetBlipRoute(id,true)
end

-- MARKER

local markers = {}
local marker_ids = Tools.newIDGenerator()
local named_markers = {}

-- add a circular marker to the game map
-- return marker id
function tvRP.addMarker(x,y,z,sx,sy,sz,r,g,b,a)
  local marker = {x=x,y=y,z=z,sx=sx,sy=sy,sz=sz,r=r,g=g,b=b,a=a}


  -- default values
  if marker.sx == nil then marker.sx = 2.0 end
  if marker.sy == nil then marker.sy = 2.0 end
  if marker.sz == nil then marker.sz = 0.7 end

  if marker.r == nil then marker.r = 0 end
  if marker.g == nil then marker.g = 155 end
  if marker.b == nil then marker.b = 255 end
  if marker.a == nil then marker.a = 200 end

  -- fix gta5 integer -> double issue
  marker.x = marker.x+0.001
  marker.y = marker.y+0.001
  marker.z = marker.z+0.001
  marker.sx = marker.sx+0.001
  marker.sy = marker.sy+0.001
  marker.sz = marker.sz+0.001

  local id = marker_ids:gen()
  markers[id] = marker

  return id
end

-- remove marker
function tvRP.removeMarker(id)
  if markers[id] ~= nil then
    markers[id] = nil
    marker_ids:free(id)
  end
end

-- set a named marker (same as addMarker but for a unique name, add or update)
-- return id
function tvRP.setNamedMarker(name,x,y,z,sx,sy,sz,r,g,b,a)
  tvRP.removeNamedMarker(name) -- remove old marker

  named_markers[name] = tvRP.addMarker(x,y,z,sx,sy,sz,r,g,b,a)
  return named_markers[name]
end

function tvRP.removeNamedMarker(name)
  if named_markers[name] ~= nil then
    tvRP.removeMarker(named_markers[name])
    named_markers[name] = nil
  end
end

local markerSigns = {}
local markerSign_id = Tools.newIDGenerator()
local named_markerSign = {}
function tvRP.addMarkerSign(Sid,x,y,z,sx,sy,sz,r,g,b,a,spin,bobble,rotate)
  local markerSign = {Sid=Sid,x=x,y=y,z=z,sx=sx,sy=sy,sz=sz,r=r,g=g,b=b,a=a,spin=spin,bobble=bobble,rotate=rotate}


  -- default values
  if markerSign.sx == nil then markerSign.sx = 2.0 end
  if markerSign.sy == nil then markerSign.sy = 2.0 end
  if markerSign.sz == nil then markerSign.sz = 0.7 end

  if markerSign.r == nil then markerSign.r = 0 end
  if markerSign.g == nil then markerSign.g = 155 end
  if markerSign.b == nil then markerSign.b = 255 end
  if markerSign.a == nil then markerSign.a = 200 end

  -- fix gta5 integer -> double issue
  markerSign.x = markerSign.x+0.001
  markerSign.y = markerSign.y+0.001
  markerSign.z = markerSign.z+0.001
  markerSign.sx = markerSign.sx+0.001
  markerSign.sy = markerSign.sy+0.001
  markerSign.sz = markerSign.sz+0.001

  local id = markerSign_id:gen()
  markerSigns[id] = markerSign

  return id
end

function tvRP.removeMarkerSign(id)
  if markerSigns[id] ~= nil then
    markerSigns[id] = nil
    markerSign_id:free(id)
  end
end

function tvRP.setNamedSign(name,Sid,x,y,z,sx,sy,sz,r,g,b,a)
  tvRP.removeNamedSign(name) -- remove old marker

  named_markerSign[name] = tvRP.addMarkerSign(Sid,x,y,z,sx,sy,sz,r,g,b,a)
  return named_markerSign[name]
end

function tvRP.removeNamedSign(name)
  if named_markerSign[name] ~= nil then
    tvRP.removeMarkerSign(named_markerSign[name])
    named_markerSign[name] = nil
  end
end

local function DrawText3D(x,y,z, text, scl, font) 
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

  local scale = (1/dist)*scl
  local fov = (1/GetGameplayCamFov())*100
  local scale = scale*fov
  
  if onScreen then
    SetTextScale(0.0*scale, 1.1*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    -- SetTextScale(0.0, 0.55)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
  end
end

-- markers draw loop
Citizen.CreateThread(function()
  while true do
      for k,v in pairs(markers) do
          while Vdist2(GetEntityCoords(GetPlayerPed(-1)),  v.x, v.y, v.z) <= 25.0 do
              -- DrawMarker(2,v.x,v.y,v.z+1,0,0,0,0,0,0,v.sx,v.sy,v.sz,v.r,v.g,v.b,v.a,0,0,0,0)
              DrawMarker(2, v.x,v.y,v.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.5, 0.40, v.r,v.g,v.b,v.a, false, false, false, true, false, false, false)
              -- DrawMarker(2, v.x,v.y,v.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.sx,v.sy,v.sz, v.r,v.g,v.b,v.a, false, false, false, true, false, false, false)
              Wait(0)
          end
      end
      Wait(750)
  end
end)
Citizen.CreateThread(function()
  while true do
      for k,v in pairs(markerNames) do
          while Vdist2(GetEntityCoords(GetPlayerPed(-1)),  v.x, v.y, v.z) <= 25.0 do
              -- DrawMarker(2,v.x,v.y,v.z+1,0,0,0,0,0,0,v.sx,v.sy,v.sz,v.r,v.g,v.b,v.a,0,0,0,0)
              DrawMarker(2, v.x,v.y,v.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.5, 0.40, v.r,v.g,v.b,v.a, false, false, false, true, false, false, false)
              -- DrawMarker(2, v.x,v.y,v.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.sx,v.sy,v.sz, v.r,v.g,v.b,v.a, false, false, false, true, false, false, false)
              Wait(0)
          end
      end
      Wait(750)
  end
end)
Citizen.CreateThread(function()
  while true do
      for k,v in pairs(markerSigns) do
          while Vdist2(GetEntityCoords(GetPlayerPed(-1)),  v.x, v.y, v.z) <= 25.0 do
              -- DrawMarker(2,v.x,v.y,v.z+1,0,0,0,0,0,0,v.sx,v.sy,v.sz,v.r,v.g,v.b,v.a,0,0,0,0)
              DrawMarker(2, v.x,v.y,v.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.5, 0.40, v.r,v.g,v.b,v.a, false, false, false, true, false, false, false)
              -- DrawMarker(2, v.x,v.y,v.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.sx,v.sy,v.sz, v.r,v.g,v.b,v.a, false, false, false, true, false, false, false)
              Wait(0)
          end
      end
      Wait(750)
  end
end)
-- AREA

local areas = {}

-- create/update a cylinder area
function tvRP.setArea(name,x,y,z,radius,height)
  local area = {x=x+0.001,y=y+0.001,z=z+0.001,radius=radius,height=height}

  -- default values
  if area.height == nil then area.height = 6 end

  areas[name] = area
end

-- remove area
function tvRP.removeArea(name)
  if areas[name] ~= nil then
    areas[name] = nil
  end
end

-- areas triggers detections
CreateThread(function()
  while true do
    Wait(1000)

    local px,py,pz = tvRP.getPosition()

    for k,v in pairs(areas) do
      -- detect enter/leave
      local player_in = #(vector3(px,py,pz) - vector3(v.x,v.y,v.z)) <= v.radius and math.abs(pz-v.z) <= v.height

      if v.player_in and not player_in then -- was in: leave
        vRPserver.leaveArea({k})
      elseif not v.player_in and player_in then -- wasn't in: enter
        vRPserver.enterArea({k})
      end

      v.player_in = player_in -- update area player_in
    end
  end
end)

-- DOOR

-- set the closest door state
-- doordef: .model or .modelhash
-- locked: boolean
-- doorswing: -1 to 1
function tvRP.setStateOfClosestDoor(doordef, locked, doorswing)
  local x,y,z = tvRP.getPosition()
  local hash = doordef.modelhash
  if hash == nil then
    hash = GetHashKey(doordef.model)
  end

  SetStateOfClosestDoorOfType(hash,x,y,z,locked,doorswing+0.0001)
end

function tvRP.openClosestDoor(doordef)
  tvRP.setStateOfClosestDoor(doordef, false, 0)
end

function tvRP.closeClosestDoor(doordef)
  tvRP.setStateOfClosestDoor(doordef, true, 0)
end