local cfg = module("cfg/player_state")
local lang = vRP.lang
local cfg2 = module("cfg/police")

-- client -> server events
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	Debug.pbegin("playerSpawned_player_state")
	local player = source
	local data = vRP.getUserDataTable(user_id)
	local tmpdata = vRP.getUserTmpTable(user_id)
  
	if first_spawn then
		
		if data.position == nil and cfg.spawn_enabled then
            local x = cfg.spawn_position[1]+math.random()*cfg.spawn_radius*2-cfg.spawn_radius
            local y = cfg.spawn_position[2]+math.random()*cfg.spawn_radius*2-cfg.spawn_radius
            local z = cfg.spawn_position[3]+math.random()*cfg.spawn_radius*2-cfg.spawn_radius
            data.position = {x=x,y=y,z=z}
        end

		if data.position ~= nil then -- teleport to saved pos
			vRPclient.teleport(source,{data.position.x,data.position.y,data.position.z})
		end

		TriggerClientEvent('utdHud:client:updatePlayers',-1,GetNumPlayerIndices())
		TriggerClientEvent('utdHud:client:updateID',source,vRP.getUserId(source))
		TriggerClientEvent('utdHud:client:updatecash', source, vRP["formatMoney"](vRP["getMoney"](user_id)))
		TriggerClientEvent('utdHud:client:updatebank', source, vRP["formatMoney"](vRP["getBankMoney"](user_id)))

		if data.weapons ~= nil then
			vRPclient.giveWeapons(source,{data.weapons,true})

			if data.health ~= nil then -- set health
				vRPclient.setHealth(source,{data.health})
				SetTimeout(5000, function()
					vRPclient.isInComa(player,{}, function(in_coma)
						vRPclient.killComa(player,{})
					end)
				end)
			end
		end
		SetTimeout(15000,function()vRPclient.notify(player,{lang.common.welcome({tmpdata.last_login})})end)
	else
		vRP.setHunger(user_id,0)
		vRP.setThirst(user_id,0)
		
		if(vRP.tryFullPayment(user_id,1000))then
			vRPclient.notify(player, {"Ai platit $1.000 pentru taxa de spitalizare!"})
		end
		
		if (vRP.getInventoryItemAmount(user_id, "gunpermit_doc") == 0) then
			for k,v in pairs(cfg2.seizable_items) do
				local amount = vRP.getInventoryItemAmount(user_id,v)
				if amount > 0 then
					local item = vRP.items[v]
					if item then -- do transfer
						if vRP.tryGetInventoryItem(user_id,v,amount,false) then
							vRPclient.notify(player,{"Angajatii spitalului au predat politiei toate obiectele ilegale gasite asupra ta!"})
						end
					end
				end
			end
			for ky,vl in pairs(data.inventory) do
				local amount = vRP.getInventoryItemAmount(user_id,ky)
				if tonumber(amount) > 0 then
					if(string.match(ky, "wbody")) or (string.match(ky, "wammo"))then
						if vRP.tryGetInventoryItem(user_id,ky,amount,false) then
							vRPclient.notify(player,{"Angajatii spitalului au predat politiei toate obiectele ilegale gasite asupra ta!"})
						end
					end
				end
			end
			vRPclient.giveWeapons(player, {{}, true})
		else
			vRPclient.giveWeapons(player,{data.weapons, true})
			for k,v in pairs(cfg2.seizable_items) do -- transfer seizable items
				local amount = vRP.getInventoryItemAmount(user_id,v)
				if amount > 0 then
					local item = vRP.items[v]
					if item then -- do transfer
						if vRP.tryGetInventoryItem(user_id,v,amount,false) then
							vRPclient.notify(player,{"Angajatii spitalului au predat politiei toate obiectele ilegale gasite asupra ta!"})
						end
					end
				end
			end
		end

		if cfg.clear_phone_directory_on_death then
			data.phone_directory = {} -- clear phone directory after death
		end

		if cfg.lose_aptitudes_on_death then
			data.gaptitudes = {} -- clear aptitudes after death
		end


		-- disable handcuff
		vRPclient.setHandcuffed(player,{false})

		if cfg.spawn_enabled then -- respawn
			local x = cfg.spawn_death[1]+math.random()*cfg.spawn_radius*2-cfg.spawn_radius
			local y = cfg.spawn_death[2]+math.random()*cfg.spawn_radius*2-cfg.spawn_radius
			local z = cfg.spawn_death[3]+math.random()*cfg.spawn_radius*2-cfg.spawn_radius
			data.position = {x=x,y=y,z=z}
			vRPclient.teleport(source,{x,y,z})
		end
		TriggerClientEvent("raid_clothes:incarcaHainele", player)
	end
	Debug.pend()
end)

function vRP.setPlayerJob(user_id, theJob)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		tmp.job = tostring(theJob)
	end
end

function vRP.sendStaffMessage(msg)
	for k, v in pairs(vRP.rusers) do
		local ply = vRP.getUserSource(tonumber(k))
		if vRP.isUserTrialHelper(k) and ply then
			TriggerClientEvent("chatMessage", ply, msg)
		end
	end
end

RegisterCommand("cleanup", function(player, args)
	if player == 0 then
	  local theSecs = parseInt(args[1]) or 10
	  TriggerClientEvent("chatMessage", -1, "Toate masinile neocupate vor fi sterse in ^5"..sec.." secunde^0")
	  vRP.sendStaffMessage({"^5".. vRP.getPlayerName(player) .." ^0a folosit comanda ^5/cleanup"})
	  vRPclient.cleanupAnnouncement(-1, {"Toate masinile neocupate se vor sterge in ~r~"..theSecs.."~w~ secunde!"})
	  TriggerClientEvent("stergeMasini", -1, theSecs)
	else
	  local user_id = vRP.getUserId(player)
	  if vRP.isUserSuperModerator(user_id) then
		local sec = parseInt(args[1]) or 10
		if sec >= 0 then
		TriggerClientEvent("chatMessage", -1, "Toate masinile neocupate vor fi sterse in ^5"..sec.." secunde^0")
        vRP.sendStaffMessage({"^5".. vRP.getPlayerName(player) .." ^0a folosit comanda ^5/cleanup"})
		vRPclient.cleanupAnnouncement(-1, {"Toate masinile neocupate se vor sterge in ~r~"..sec.."~w~ secunde!"})
		TriggerClientEvent("stergeMasini", -1, sec)
		end
	  end
	end
  end, false)

-- updates

AddEventHandler("vRP:playerLeave",function(user_id, player,reason) 
	local ped = GetPlayerPed(player)
	local pos = GetEntityCoords(ped)
	local data = vRP.getUserDataTable(user_id)
    if data ~= nil then
      data.position = {x = tonumber(pos[1]), y = tonumber(pos[2]), z = tonumber(pos[3])}
    end
	TriggerClientEvent('utdHud:client:updatePlayers',-1,GetNumPlayerIndices())
  end)

function tvRP.updatePos(x,y,z)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local data = vRP.getUserDataTable(user_id)
        if data ~= nil then -- don't save position if inside home slot
          data.position = {x = tonumber(x), y = tonumber(y), z = tonumber(z)}
        end
    end
end

function tvRP.updateWeapons(weapons)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    local data = vRP.getUserDataTable(user_id)
    if data ~= nil then
      data.weapons = weapons
    end
  end
end

function tvRP.updateCustomization(customization)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    local data = vRP.getUserDataTable(user_id)
    if data ~= nil then
      data.customization = customization
    end
  end
end

function tvRP.updateHealth(health)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    local data = vRP.getUserDataTable(user_id)
    if data ~= nil then
      data.health = health
    end
  end
end
