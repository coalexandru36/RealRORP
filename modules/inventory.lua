local lang = vRP.lang
local cfg = module("cfg/inventory")

vRP.items = {}
function vRP.defInventoryItem(idname,name,description,choices,weight,canRemove)
  if weight == nil then
    weight = 0
  end
  local tcr = type(canRemove)
  if not (tcr == "boolean" or tcr == "nil") then canRemove = nil end

  local item = {name=name,description=description,choices=choices,weight=weight,canRemove=canRemove}
  vRP.items[idname] = item
end


function vRP.computeItemName(item,args)
  if type(item.name) == "string" then return item.name
  else return item.name(args) end
end

function vRP.computeItemDescription(item,args)
  if type(item.description) == "string" then return item.description
  else return item.description(args) end
end

function vRP.computeItemChoices(item,args)
  if item.choices ~= nil then
    return item.choices(args)
  else
    return {}
  end
end

function vRP.computeItemWeight(item,args)
  if type(item.weight) == "number" then return item.weight
  else return item.weight(args) end
end


function vRP.parseItem(idname)
  return splitString(idname,"|")
end

function table.empty(tbl)
  if not (type(tbl) == "table") then return true end;
  return not next(tbl);
end;

function vRP.computeItemRemove(item,args)
  if not item.canRemove then return end;
  if not (type(item.canRemove) == "boolean") then return item.canRemove(args) end;
  return item.canRemove;
end;

function vRP.getItemDetails(idname)
  if not idname then return end;
  local args = vRP.parseItem(idname);
  local item = vRP.items[args[1]];
  if not item then return nil, nil, nil, nil end;
  local name, weight, choices, canRemove = vRP.computeItemName(item,args), vRP.computeItemWeight(item,args), vRP.computeItemChoices(item, args), vRP.computeItemRemove(item,args);
  return name, weight, (not table.empty(choices) and true), (canRemove ~= nil and canRemove or true);
end;


-- return name, description, weight
function vRP.getItemDefinition(idname)
  local args = vRP.parseItem(idname)
  local item = vRP.items[args[1]]
  if item ~= nil then
    return vRP.computeItemName(item,args), vRP.computeItemDescription(item,args), vRP.computeItemWeight(item,args)
  end

  return nil,nil,nil
end

function vRP.getItemName(idname)
  local args = vRP.parseItem(idname)
  local item = vRP.items[args[1]]
  if item ~= nil then return vRP.computeItemName(item,args) end
  return args[1]
end

function vRP.getItemDescription(idname)
  local args = vRP.parseItem(idname)
  local item = vRP.items[args[1]]
  if item ~= nil then return vRP.computeItemDescription(item,args) end
  return ""
end

function vRP.getItemChoices(idname)
  local args = vRP.parseItem(idname)
  local item = vRP.items[args[1]]
  local choices = {}
  if item ~= nil then
    -- compute choices
    local cchoices = vRP.computeItemChoices(item,args)
    if cchoices then -- copy computed choices
      for k,v in pairs(cchoices) do
        choices[k] = v
      end
    end

  end

  return choices
end

function vRP.getItemWeight(idname)
  local args = vRP.parseItem(idname)
  local item = vRP.items[args[1]]
  if item ~= nil then return vRP.computeItemWeight(item,args) end
  return 0
end

-- compute weight of a list of items (in inventory/chest format)
function vRP.computeItemsWeight(items)
  local weight = 0

  for k,v in pairs(items) do
    local iweight = vRP.getItemWeight(k)
    weight = weight+iweight*v.amount
  end

  return weight
end

-- add item to a connected user inventory
function vRP.giveInventoryItem(user_id,idname,amount,notify)
  if notify == nil then notify = true end -- notify by default
  local player = vRP.getUserSource(user_id)
  local data = vRP.getUserDataTable(user_id)
  local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight(idname)*amount
  if not ( new_weight <= vRP.getInventoryMaxWeight(user_id) ) then
      return vRPclient.notify(player,{'~r~Ai inventar plin!'})
  end
  if data and amount > 0 then
    local entry = data.inventory[idname]
    if entry then -- add to entry
      entry.amount = entry.amount+amount
    else -- new entry
      data.inventory[idname] = {amount=amount}
    end

    -- if vRP.computeItemsWeight(data.inventory) > 15 then
    --   TriggerClientEvent("equipBackpack", source)
    -- else
    --   TriggerClientEvent("removeBackpack", source)
    -- end

    -- notify
    if notify then
      local player = vRP.getUserSource(user_id)
      if player ~= nil then
        vRPclient.notify(player,{lang.inventory.give.received({vRP.getItemName(idname),amount})})
      end
    end
  end
end

-- try to get item from a connected user inventory
function vRP.tryGetInventoryItem(user_id,idname,amount,notify)
  if notify == nil then notify = true end -- notify by default

  local data = vRP.getUserDataTable(user_id)
  if data and amount > 0 then
    local entry = data.inventory[idname]
    if entry and entry.amount >= amount then -- add to entry
      entry.amount = entry.amount-amount

      -- remove entry if <= 0
      if entry.amount <= 0 then
        data.inventory[idname] = nil 
      end

      -- notify
      if notify then
        local player = vRP.getUserSource(user_id)
        if player ~= nil then
          vRPclient.notify(player,{lang.inventory.give.given({vRP.getItemName(idname),amount})})
        end
      end

      return true
    else
      -- notify
      if notify then
        local player = vRP.getUserSource(user_id)
        if player ~= nil then
          local entry_amount = 0
          if entry then entry_amount = entry.amount end
          vRPclient.notify(player,{lang.inventory.missing({vRP.getItemName(idname),amount-entry_amount})})
        end
      end
    end
  end

  return false
end

-- get user inventory amount of item
function vRP.getInventoryItemAmount(user_id,idname)
  local data = vRP.getUserDataTable(user_id)
  if data and data.inventory then
    local entry = data.inventory[idname]
    if entry then
      return entry.amount
    end
  end

  return 0
end

-- return user inventory total weight
function vRP.getInventoryWeight(user_id)
  local data = vRP.getUserDataTable(user_id)
  if data and data.inventory then
    return vRP.computeItemsWeight(data.inventory)
  end

  -- if vRP.computeItemsWeight(data.inventory) > 15 then
  --   TriggerClientEvent("equipBackpack", source)
  -- else
  --   TriggerClientEvent("removeBackpack", source)
  -- end

  return 0
end

-- return maximum weight of the user inventory
function vRP.getInventoryMaxWeight(user_id)
  return math.floor(vRP.expToLevel(vRP.getExp(user_id, "physical", "strength")))*cfg.inventory_weight_per_strength
end

-- clear connected user inventory
function vRP.clearInventory(user_id)
  local data = vRP.getUserDataTable(user_id)
  if data then
    data.inventory = {}
  end
end


-- init inventory
AddEventHandler("vRP:playerJoin", function(user_id,source,name,last_login)
  local data = vRP.getUserDataTable(user_id)
  if data.inventory == nil then
    data.inventory = {}

    -- if vRP.computeItemsWeight(data.inventory) > 15 then
    --   TriggerClientEvent("equipBackpack", source)
    -- else
    --   TriggerClientEvent("removeBackpack", source)
    -- end
  end
end)


function vRP.getItemChoSnowHud(idname)
  local args = vRP.parseItem(idname)
  local item = vRP.items[args[1]]
  local choices = {}
  if item ~= nil then
    -- compute choices
    local cchoices = vRP.computeItemChoices(item,args)
    if cchoices then -- copy computed choices
      for k,v in pairs(cchoices) do
        choices[k] = v
      end
    end
  end

  return choices
end


function vRP.giveItemHud(player, idname, amount)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    -- get nearest player
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
      if nplayer ~= nil then
        local nuser_id = vRP.getUserId(nplayer)
        if nuser_id ~= nil then
            -- weight check
            local new_weight = vRP.getInventoryWeight(nuser_id)+vRP.getItemWeight(idname)*amount
            if new_weight <= vRP.getInventoryMaxWeight(nuser_id) then
              if vRP.tryGetInventoryItem(user_id,idname,amount,true) then
                vRP.giveInventoryItem(nuser_id,idname,amount,true)

                vRPclient.playAnim(player,{true,{{"mp_common","givetake1_a",1}},false})
                vRPclient.playAnim(nplayer,{true,{{"mp_common","givetake2_a",1}},false})
              else
                vRPclient.notify(player,{lang.common.invalid_value()})
              end
            else
              vRPclient.notify(player,{lang.inventory.full()})
            end
        else
          vRPclient.notify(player,{lang.common.no_player_near()})
        end
      else
        vRPclient.notify(player,{lang.common.no_player_near()})
      end
    end)
  end
end


function tvRP.hasUserItem(idname,amount)
  local user_id = vRP.getUserId(source)
  local data = vRP.getUserDataTable(user_id)
  if data and amount > 0 then
    local entry = data.inventory[idname]
      return entry.amount >= amount
  end
end

function vRP.hasUserItem(user_id,idname,amount)
  local data = vRP.getUserDataTable(user_id)
  if data and amount > 0 then
    local entry = data.inventory[idname]
    if entry == nil then return false end;
      return entry.amount >= amount
  end
end

function vRP.getItemChoSnowHud(idname)
  local args = vRP.parseItem(idname)
  local item = vRP.items[args[1]]
  local choices = {}
  if item ~= nil then
    -- compute choices
    local cchoices = vRP.computeItemChoices(item,args)
    if cchoices then -- copy computed choices
      for k,v in pairs(cchoices) do
        choices[k] = v
      end
    end
  end

  return choices
end

-- load config items
local cfgItems = module("cfg/items")

for k,v in pairs(cfgItems.items) do
  vRP.defInventoryItem(k,v[1],v[2],v[3],v[4])
end