local htmlEntities = module("lib/htmlEntities")

local cfg = module("cfg/identity")
local lang = vRP.lang

local sanitizes = module("cfg/sanitizes")

-- cbreturn user identity
function vRP.getUserIdentity(user_id, cbr)
  local task = Task(cbr)
  task({ vRP.usersDatas[user_id]["Identitate"] })
end

function vRP.generateStringNumber(format) -- (ex: DDDLLL, D => digit, L => letter)
  local abyte = string.byte("A")
  local zbyte = string.byte("0")

  local number = ""
  for i=1,#format do
    local char = string.sub(format, i,i)
    if char == "D" then number = number..string.char(zbyte+math.random(0,9))
    elseif char == "L" then number = number..string.char(abyte+math.random(0,25))
    else number = number..char end
  end

  return number
end

function vRP.updateIdentity(user_id, firstname,lastname,age)
  if user_id then
    vRP.usersDatas[user_id]["Identitate"].firstName = firstname;
    vRP.usersDatas[user_id]["Identitate"].lastName = lastname;
    vRP.usersDatas[user_id]["Identitate"].age = age;
    vRP.usersDatas[user_id]["Identitate"].inReg = 1;
  end
end


RegisterNetEvent("UG:UpdateFirstCharacter", function(firstname, lastname, age, sex, h)
  local uid = vRP["getUserId"](source);
  if not uid then return end;

  if sex == "f" then
    vRPclient["setDefaultSkin"](source,{"mp_f_freemode_01"})
  elseif sex == "m" then
    TriggerClientEvent('raid_clothes:butelie',source)
  end
  vRP.updateIdentity(uid, firstname,lastname,age);

  TriggerClientEvent("UG:OpenCreateCharacter", source, false)
end)

AddEventHandler('vRP:playerSpawn', function(user_id, s, fs)
  if not fs then return end;
  SetTimeout(5000, function()
    inreg = vRP.usersDatas[user_id]["Identitate"].inReg
    if inreg > 0 then
      TriggerClientEvent('UG:OpenCreateCharacter', s, false)
    else
      TriggerClientEvent('UG:OpenCreateCharacter', s, true)
    end
  end)
end)




vRP.registerMenuBuilder("jucator", function(add, data)
  local player = data.player

  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRP.getUserIdentity(user_id, function(identity)

      if identity then

        local choices = {}
        choices["Buletin"] = {function()
          local home = ""
          local number = ""
          TriggerClientEvent("ples-id:showBuletin", player, {nume = identity.firstName, prenume = identity.lastName, age = identity.age, adresa = "Str. "..home.." Nr. "..number, usr_id = user_id, target = player}) 
        
        end, content}  
        add(choices)
      end
    end)
  end
end)
