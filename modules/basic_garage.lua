-- a basic garage implementation

local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")

function findVehsIds()
	theLastID = 0
	exports.oxmysql:execute("SELECT id FROM vrp_user_vehicles ORDER BY id DESC LIMIT 1", {}, function(pvehicles)
		if #pvehicles > 0 then
			theLastID = tonumber(pvehicles[1].id)
		else
			theLastID = 0
		end
	end)
	Citizen.Wait(100)
	return theLastID
end

local cfg = module("cfg/garages")
local cfg_inventory = module("cfg/inventory")
local vehicle_groups = cfg.garage_types
local lang = vRP.lang
local veh_actions = {}
local garages = cfg.garages
local limit = cfg.limit or 100000000

function vRP.checkVehicleName(veh)
	for i, v in pairs(vehicle_groups) do
		local vehicle = v[veh]
        if vehicle then
			return tostring(vehicle[1]), tonumber(vehicle[2])
		end
	end
	return "STEARSA (Model: "..veh..")", 0
end

local garage_menus = {}

for group,vehicles in pairs(vehicle_groups) do
	local veh_type = vehicles._config.vtype or "default"

	local menu = {
		name=lang.garage.title({group}),
		css={top = "75px", header_color="rgba(255,125,0,0.75)"}
	}
	garage_menus[group] = menu

	local isbuy = vehicles._config.hasbuy or false
		if isbuy then
			menu[lang.garage.buy.title()] = {function(player,choice)
				local user_id = vRP.getUserId(player)
				if user_id ~= nil then
					-- build nested menu
					local kitems = {}
					local submenu = {name=lang.garage.title({lang.garage.buy.title()}), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
					submenu.onclose = function()
						vRP.openMenu(player,menu)
					end
					local choose = function(player, choice)
					local vname = kitems[choice]
					if vname then
						-- buy vehicle
						local vehicle = vehicles[vname]
						if vehicle and vRP.tryPayment(user_id,vehicle[2]) then
							vRP.givePlayerSpecialVeh(user_id, vname, vehicle[2])
							vRPclient.notify(player,{lang.money.paid({vehicle[2]})})
							vRP.closeMenu(player)
						else
							vRPclient.notify(player,{lang.money.not_enough()})
						end
					end
				end
	
				local _pvehicles = exports.oxmysql:executeSync("SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id", {user_id = user_id})
				Citizen.Wait(50)
				local pvehicles = {}
				for k,v in pairs(_pvehicles) do
					pvehicles[string.lower(v.vehicle)] = true
				end 

				for k,v in pairs(vehicles) do
					if k ~= "_config" and pvehicles[string.lower(k)] == nil then
						submenu[v[1]] = {choose,lang.garage.buy.info({v[2],v[3]})}
						kitems[v[1]] = k
					end
				end
				vRP.openMenu(player,submenu)
			end
		end,lang.garage.buy.description()}
	end

  	menu[lang.garage.owned.title()] = {function(player,choice)
    	local user_id = vRP.getUserId(player)
    	if user_id ~= nil then
      		-- build nested menu
      		local kitems = {}
      		local submenu = {name=lang.garage.title({lang.garage.owned.title()}), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
      		local choose = function(player, choice)
				local vname = kitems[choice]
				if vname then
					-- spawn vehicle
					local vehicle = vehicles[vname]
					if vehicle then
						local result = exports.oxmysql:executeSync("SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle", {user_id = user_id, vehicle = vname})
						vRP.closeMenu(player)
						vRPclient.spawnGarageVehicle(player,{result[1].veh_type,vname,result[1].vehicle_plate,json.decode(result[1].upgrades)})
					end
				end
      		end

			-- get player owned vehicles
			local pvehicles = exports.oxmysql:executeSync("SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id", {user_id = user_id})
			for k, v in pairs(pvehicles) do
				local vehicle = vehicles[v.vehicle]
				if vehicle then
						submenu[vehicle[1]] = {choose,vehicle[3]}
						kitems[vehicle[1]] = v.vehicle
				end
			end
        	vRP.openMenu(player,submenu)
   	 	end
  	end,lang.garage.owned.description()}

  	
  	local isSell = vehicles._config.tosell or false
  	if isSell then
  		menu[lang.garage.sell.title()] = {function(player,choice)
    		local user_id = vRP.getUserId(player)
    		if user_id ~= nil then
      			-- build nested menu
      			local kitems = {}
      			local submenu = {name=lang.garage.title({lang.garage.sell.title()}), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
				submenu.onclose = function()
					vRP.openMenu(player,menu)
				end
				local choose = function(player, choice)
					vRP.prompt(player, "Esti sigur?", "[STERGE si scrie 'Da' pentru a vinde masina]", function(player,answer)
						answer = tostring(answer)
						if(string.lower(answer) == "da")then
							local vname = kitems[choice]
							if vname then
								-- sell vehicle
								local vehicle = vehicles[vname]
								if vehicle then
									local price = math.ceil(vehicle[2]*cfg.sell_factor)
									local rows = exports.oxmysql:executeSync("SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle", {user_id = user_id, vehicle = vname})
									if #rows > 0 then -- has vehicle
										vRP.giveMoney(user_id,price)
										exports.oxmysql:execute("DELETE FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle", {user_id = user_id, vehicle = vname}, function()end)
										vRPclient.notify(player,{lang.money.received({vRP.formatMoney(price)})})
										local vehName, vehPrice = vRP.checkVehicleName(vname)
										vRPclient.despawnGarageVehicle(player,{veh_type,15})
										vRP.closeMenu(player)
									else
										vRPclient.notify(player,{lang.common.not_found()})
									end
								end
							end
						else
							vRPclient.notify(player, {"~r~Dunko: ~w~Trebuie sa scrii 'Da' pentru a vinde masina!"})
						end
					end)
				end

  				local _pvehicles = exports.oxmysql:executeSync("SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id", {user_id = user_id})
        		local pvehicles = {}
        		for k,v in pairs(_pvehicles) do
        		  	pvehicles[string.lower(v.vehicle)] = true
				end

        		-- for each existing vehicle in the garage group
        		for k, v in pairs(pvehicles) do
          		local vehicle = vehicles[k]
          		if vehicle then -- not already owned
            		local price = math.ceil((vehicle[2]*cfg.sell_factor)*1)
            		submenu[vehicle[1]] = {choose,lang.garage.buy.info({price,vehicle[3]})}
            		kitems[vehicle[1]] = k
          			end
				end
        		vRP.openMenu(player,submenu)
    		end
  		end,lang.garage.sell.description()}
	end

	menu[lang.garage.store.title()] = {function(player,choice)
		vRPclient.despawnGarageVehicle(player,{veh_type,15}) 
	  end, lang.garage.store.description()}
end

local function build_client_garages(source)
	local user_id = vRP.getUserId(source)
		if user_id ~= nil then
			for k,v in pairs(garages) do
				local gtype,x,y,z = table.unpack(v)
				local x = v[2].x
				local y = v[2].y
				local z = v[2].z
				local group = vehicle_groups[gtype]
				if group then
					local gcfg = group._config
					local garage_enter = function(player,area)
						local user_id = vRP.getUserId(source)
						if user_id ~= nil and vRP.hasPermissions(user_id,gcfg.permissions or {}) and gcfg.faction == nil and gcfg.vip == nil then
							local menu = garage_menus[gtype]
							if menu then
								vRP.openMenu(player,menu)
							end
						elseif (gcfg.faction ~= nil or gcfg.faction ~= "") and gcfg.vip == nil then
							if(vRP.isUserInFaction(user_id,gcfg.faction))then
								local menu = garage_menus[gtype]
								if menu then
									vRP.openMenu(player,menu)
								end
							end
						elseif (gcfg.vip ~= nil or gcfg.vip ~= 0) then
							if(vRP.getUserVipRank(user_id) == gcfg.vip)then
								local menu = garage_menus[gtype]
								if menu then
									vRP.openMenu(player,menu)
								end
							end
						end
					end

					-- leave
					local garage_leave = function(player,area)
						vRP.closeMenu(player)
						end
	
						vRPclient.addBlip(source,{x,y,z,gcfg.blipid,gcfg.blipcolor,lang.garage.title({gtype})})
						vRPclient.addMarker(source,{x,y,z-1,2.3,2.3,0.3,255,255,255,125,125})
	
						if(gcfg.icon ~= nil)then
							local iC1, iC2, iC3 = gcfg.iconColor[1], gcfg.iconColor[2], gcfg.iconColor[3]
							if(gtype == "VIP Garage 1")then
								vRPclient.addMarkerSign(source,{11,x,y,z-0.84,0.18,0.18,0.18,iC1, iC2, iC3,150,150,0,true,0})
							elseif(gtype == "VIP Garage 2")then
								vRPclient.addMarkerSign(source,{12,x,y,z-0.84,0.18,0.18,0.18,iC1, iC2, iC3,150,150,0,true,0})
							elseif(gtype == "VIP Garage 3")then
								vRPclient.addMarkerSign(source,{13,x,y,z-0.84,0.18,0.18,0.18,iC1, iC2, iC3,150,150,0,true,0})
							elseif(gtype == "VIP Garage 4")then
								vRPclient.addMarkerSign(source,{14,x,y,z-0.84,0.18,0.18,0.18,iC1, iC2, iC3,150,150,0,true,0})
							elseif(gtype == "VIP Garage 5")then
								vRPclient.addMarkerSign(source,{15,x,y,z-0.84,0.18,0.18,0.18,iC1, iC2, iC3,150,150,0,true,0})
							end
							vRPclient.addMarkerSign(source,{gcfg.icon,x,y,z-2.1,2.3,2.3,2.3,iC1, iC2, iC3,0,0,true,0,5})
						end
	
						vRP.setArea(source,"vRP:garage"..k,x,y,z,1,1.0,garage_enter,garage_leave)
					end
				end
			end
		end
  
  AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
	  build_client_garages(source)
	end
  end)

-- open trunk



-- open trunk



-- sell vehicle
veh_actions[lang.vehicle.sellTP.title()] = {function(playerID,player,vtype,name)
	if playerID ~= nil then
		vRPclient.getNearestPlayers(player,{15},function(nplayers)
			usrList = ""
			for k,v in pairs(nplayers) do
				usrList = usrList .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
			end
			if usrList ~= "" then
				vRP.prompt(player,"Players Nearby: " .. usrList .. "","",function(player,user_id) 
					user_id = user_id
					if user_id ~= nil and user_id ~= "" then 
						local target = vRP.getUserSource(tonumber(user_id))
						if target ~= nil then
							vRP.prompt(player,"Price $: ","",function(player,amount)
                if (tonumber(amount)) then
                  if tonumber(amount) > 0 then
					exports.oxmysql:execute('SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle',{['user_id'] = user_id,['vehicle'] = name},function(pvehicle)
                    --MySQL.query("vRP/muieAntonyx", {['user_id'] = user_id,['vehicle'] = name}, function(pvehicle, affected)
                      if #pvehicle > 0 then
                        vRPclient.notify(player,{"~r~Dunko: ~w~Player-ul are deja masina"})
                      else
                        --local tmpdata = vRP.getUserTmpTable(playerID)
                        --if tmpdata.rent_vehicles[name] == true then
                        --  vRPclient.notify(player,{"You cannot sell a rented vehicle!"})
                        --  return
                        --else
                          vRP.request(target,GetPlayerName(player).." wants to sell: " ..name.. " Price: $"..amount, 10, function(target,ok)
                            if ok then
                              local pID = vRP.getUserId(target)
                              local money = vRP.getMoney(pID)
                              if (tonumber(money) >= tonumber(amount)) then
                                vRPclient.despawnGarageVehicle(player,{vtype,15}) 
                                vRP.getUserIdentity(pID, function(identity)
									exports.oxmysql:execute("UPDATE vrp_user_vehicles SET user_id = @user_id WHERE user_id = @oldUser AND vehicle = @vehicle",{['user_id'] = user_id,['oldUser'] = playerID,['vehicle'] = name},function(OpunPeMamaLuAntonyXInPula) end)
                                end)
                                vRP.giveMoney(playerID, amount)
                                vRP.setMoney(pID,money-amount)
                                vRPclient.notify(player,{"You have successfully sold the vehicle to ".. GetPlayerName(target).." for $"..amount.."!"})
                                vRPclient.notify(target,{""..GetPlayerName(player).." has successfully sold you the car for $"..amount.."!"})
                              else
                                vRPclient.notify(player,{"".. GetPlayerName(target).." doesn't have enough money!"})
                                vRPclient.notify(target,{"You don't have enough money!"})
                              end
                            else
                              vRPclient.notify(player,{""..GetPlayerName(target).." has refused to buy the car."})
                              vRPclient.notify(target,{"You have refused to buy "..GetPlayerName(player).."'s car."})
                            end
                          end)
                        vRP.closeMenu(player)
                      end
                    end) 
                  else
                    vRPclient.notify(target,{"Nu mai mere bug asta boss.","Error"})
                  end
								else
									vRPclient.notify(player,{"The price of the car has to be a number."})
								end
							end)
						else
							vRPclient.notify(player,{"That ID seems invalid."})
						end
					else
						vRPclient.notify(player,{"No player ID selected."})
					end
				end)
			else
				vRPclient.notify(player,{"No player nearby."})
			end
		end)
	end
end, lang.vehicle.sellTP.description()}

-- lock/unlock
veh_actions[lang.vehicle.lock.title()] = {function(user_id,player,vtype,name)
  vRPclient.vc_toggleLock(player, {vtype})
end, lang.vehicle.lock.description()}

-- engine on/off
veh_actions[lang.vehicle.engine.title()] = {function(user_id,player,vtype,name)
  vRPclient.vc_toggleEngine(player, {vtype})
end, lang.vehicle.engine.description()}

local function ch_vehicle(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
	  -- check vehicle
	  vRPclient.getNearestOwnedVehicle(player,{7},function(ok,vtype,name)
		if ok then
		  -- build vehicle menu
		  vRP.buildMenu("vehicle", {user_id = user_id, player = player, vtype = vtype, vname = name}, function(menu)
			menu.name=lang.vehicle.title()
			menu.css={top="75px",header_color="rgba(0,0,0,0.2)"}
  
			for k,v in pairs(veh_actions) do
			  menu[k] = {function(player,choice) v[1](user_id,player,vtype,name) end, v[2]}
			end
  
			vRP.openMenu(player,menu)
		  end)
		else
		  vRPclient.notify(player,{lang.vehicle.no_owned_near()})
		end
	  end)
	end
  end

-- ask trunk (open other user car chest)
--[[local function ch_asktrunk(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
      vRPclient.notify(player,{lang.vehicle.asktrunk.asked()})
      vRP.request(nplayer,lang.vehicle.asktrunk.request(),15,function(nplayer,ok)
        if ok then -- request accepted, open trunk
          vRPclient.getNearestOwnedVehicle(nplayer,{7},function(ok,vtype,name)
            if ok then
              local chestname = "u"..nuser_id.."veh_"..string.lower(name)
              local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(name)] or cfg_inventory.default_vehicle_chest_weight

              -- open chest
              local cb_out = function(idname,amount)
                vRPclient.notify(nplayer,{lang.inventory.give.given({vRP.getItemName(idname),amount})})
              end

              local cb_in = function(idname,amount)
                vRPclient.notify(nplayer,{lang.inventory.give.received({vRP.getItemName(idname),amount})})
              end

              vRPclient.vc_openDoor(nplayer, {vtype,5})
              vRP.openChest(player, chestname, max_weight, function()
                vRPclient.vc_closeDoor(nplayer, {vtype,5})
              end,cb_in,cb_out)
            else
              vRPclient.notify(player,{lang.vehicle.no_owned_near()})
              vRPclient.notify(nplayer,{lang.vehicle.no_owned_near()})
            end
          end)
        else
          vRPclient.notify(player,{lang.common.request_refused()})
        end
      end)
    else
      vRPclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end
--]]

-- repair nearest vehicle
local function ch_repair(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    -- anim and repair
    if vRP.tryGetInventoryItem(user_id,"repairkit",1,true) then
      vRPclient.playAnim(player,{false,{task="WORLD_HUMAN_WELDING"},false})
      SetTimeout(15000, function()
        vRPclient.fixeNearestVehicle(player,{7})
        vRPclient.stopAnim(player,{false})
      end)
    end
  end
end

-- replace nearest vehicle
local function ch_replace(player,choice)
  vRPclient.replaceNearestVehicle(player,{7})
end

function vRP.givePlayerSpecialVeh(user_id, vehName, type)
    vehID = findVehsIds()+1
    if vehID < 10 then
        vehID = "0000"..vehID
    elseif vehID <= 99 and vehID > 9 then
        vehID = "000"..vehID
    elseif vehID <= 999 and vehID > 99 then
        vehID = "00"..vehID
    elseif vehID <= 9999 and vehID > 999 then
        vehID = "0"..vehID
    elseif vehID <= 99999 and vehID > 9999 then
        vehID = vehID
    end
    vRP.getUserIdentity(user_id, function(identity)
        exports.oxmysql:execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate,veh_type) VALUES(@user_id,@vehicle,@vehicle_plate,@veh_type)", {user_id = user_id, vehicle = vehName, vehicle_plate = thePlate, veh_type = type}, function()end)
    end)
end

function vRP.hasPlayerCar(user_id, vehName)
	hasCar = false
	local pvehicle = exports.oxmysql:executeSync("SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle", {user_id = user_id, vehicle = vehName})
	Citizen.Wait(50)
	if #pvehicle > 0 then
		hasCar = true
	else
		hasCar = false
	end
	return hasCar
end

vRP.registerMenuBuilder("main", function(add, data)
  local user_id = vRP.getUserId(data.player)
  if user_id ~= nil then
    -- add vehicle entry
    local choices = {}
    choices[lang.vehicle.title()] = {ch_vehicle}

	    -- add ask trunk
    -- choices[lang.vehicle.asktrunk.title()] = {ch_asktrunk}

    -- add repair functions
    if vRP.hasPermission(user_id, "vehicle.repair") then
      choices[lang.vehicle.repair.title()] = {ch_repair, lang.vehicle.repair.description()}
    end

    if vRP.hasPermission(user_id, "vehicle.replace") then
      choices[lang.vehicle.replace.title()] = {ch_replace, lang.vehicle.replace.description()}
    end

    add(choices)
  end
end)



RegisterServerEvent("garage:requestMods")
AddEventHandler("garage:requestMods", function(vname)
	local user_id = vRP.getUserId(source)
	local src = vRP.getUserSource(user_id)
	if src ~= nil then
		local rows = exports.oxmysql:executeSync("SELECT upgrades FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle AND upgrades IS NOT NULL", {user_id = user_id, vehicle = vname})
		if #rows > 0 then
			vRPclient.garage_setmods(src, {rows[1].upgrades})
		end
	end
end)