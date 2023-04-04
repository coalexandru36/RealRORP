local htmlEntities = module("lib/htmlEntities")
local Tools = module("lib/Tools")

local titles = { "Trial Helper", "Helper", "Lider Helper", "Moderator", "Super Moderators", "Lider Moderator", "Admin", "Super Admin", "Lider Admin", "Head Of Staff", "Supervizor", "Co Fondator", "Developer", "Fondator"}
local onduty = { 0 }
function vRP.getUserAdminLevel(user_id)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		adminLevel = tmp.adminLevel
	end
	return adminLevel or 0
end

function vRP.isAdmin(user_id)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		adminLevel = tmp.adminLevel
	end
	if (adminLevel > 0) then
		return true
	else
		return false
	end
end

function vRP.isUserTrialHelper(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 1)then
		return true
	else
		return false
	end
end

function vRP.isUserHelper(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 2)then
		return true
	else
		return false
	end
end

function vRP.isUserLiderHelper(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 3)then
		return true
	else
		return false
	end
end

function vRP.isUserModerator(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 4)then
		return true
	else
		return false
	end
end

function vRP.isUserSuperModerator(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 5)then
		return true
	else
		return false
	end
end

function vRP.isUserLiderModerator(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 6)then
		return true
	else
		return false
	end
end

function vRP.isUserAdministrator(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 7)then
		return true
	else
		return false
	end
end

function vRP.isUserSuperAdministrator(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 8)then
		return true
	else
		return false
	end
end

function vRP.isUserLiderAdministrator(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 9)then
		return true
	else
		return false
	end
end

function vRP.isUserHeadOfStaff(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 10)then
		return true
	else
		return false
	end
end

function vRP.isUserSupervizor(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 11)then
		return true
	else
		return false
	end
end

function vRP.isUserCoFondator(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 12)then
		return true
	else
		return false
	end
end

function vRP.isUserDeveloper(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 13)then
		return true
	else
		return false
	end
end

function vRP.isUserFondator(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 14)then
		return true
	else
		return false
	end
end


function vRP.getUserAdminTitle(user_id)
    local text = titles[vRP.getUserAdminLevel(user_id)] or "Admin"
    return text
end

function vRP.setUserAdminLevel(user_id,admin)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		tmp.adminLevel = admin
	end
	exports["oxmysql"]:query("UPDATE vrp_users SET adminLvl = @adminLevel WHERE id = @user_id", {user_id = user_id, adminLevel = admin})
end

function vRP.getOnlineAdmins()
	local oUsers = {}
	for k,v in pairs(vRP.rusers) do
		if vRP.isUserAdmin(tonumber(k)) then table.insert(oUsers, tonumber(k)) end
	end
	return oUsers
end

function vRP.getOnlineStaff()
    local onStaff = {}
    local users = vRP.getUsers()
    for k,v in pairs(users) do
        if vRP.isUserTrialHelper(tonumber(k)) then
            table.insert(onStaff, tonumber(k))
        end
    end
    return onStaff
end

function vRP.sendStaffMessage(msg)
	for k, v in pairs(vRP.rusers) do
		local ply = vRP.getUserSource(tonumber(k))
		if vRP.isUserTrialHelper(k) and ply then
			TriggerClientEvent("chatMessage", ply, msg)
		end
	end
end

local function ch_addgroup(player,choice)
	local user_id = vRP.getUserId(player)
	local numestaff = vRP.getPlayerName(player)
	
	if user_id ~= nil then
	  vRP.prompt(player,"User id: ","",function(player,id)
		id = parseInt(id)
		vRP.prompt(player,"Group to add: ","",function(player,group)
		  vRP.addUserGroup(id,group)
		  Wait(150)
		  vRP.sendStaffMessage("^5".. vRP.getPlayerName(player) .." ^0i-a dat add group lui ID ^5".. id .."^0 si a primit groupul ^5"..group)
		  vRPclient.notify(player,{"Grupa "..group.." a fost adaugata lui "..id})
		end)
	  end)
	end
end

local function ch_removegroup(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"ID: ","",function(player,id)	
			id = parseInt(id)
			nplayer = vRP.getUserSource(tonumber(id))
			if(tonumber(id)) and (id ~= "") and (id ~= nil)then
				if nplayer ~= nil then
					vRP.prompt(player,"Grad de scos: ","",function(player,group)
						if group ~= nil then
							vRP.removeUserGroup(id,group)
							vRPclient.notify(player,{"Grad-ul "..group.." a fost scos pentru id-ul "..id})
							vRP.sendStaffMessage("^5".. vRP.getPlayerName(player) .." ^0i-a dat remove group lui ID ^5".. id .." si i-a scos groupul ^5"..group)
						end
					end)
				else
					vRPclient.notify(player,{"Jucatorul nu este online!"})
				end
			else
				vRPclient.notify(player,{"ID-ul pare invalid!"})
			end
		end)
	end
end

local function ch_kick(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"ID: ","",function(player,id)
			id = parseInt(id)
      		local source = vRP.getUserSource(id)
      		if(tonumber(id) and (id ~= ""))then
				if(id == 1 or id == 2 or id == 3 or id == 0)then
					vRPclient.notify(player,{"Nu ai cum sa imi dai kick fraiere!"})
					if(source ~= nil)then
						TriggerClientEvent('chatMessage', -1, "Pripasul asta ^5"..vRP.getPlayerName(player).."^0 a incercat sa ii dea kick lui id 1,2,3")
					end
      			else
					vRP.prompt(player,"Motiv: ","",function(player,reason)
						if reason ~= "" then
							local source = vRP.getUserSource(id)
							if source ~= nil then
								TriggerClientEvent("chatMessage", -1, "^5"..vRP.getPlayerName(source).." ^0a primit kick de la ^5".. vRP.getPlayerName(player).."^0 pe motiv-ul ^5"..reason.."^0")
								vRP.kick(source,reason)
							else
          						vRPclient.notify(player,{"Jucatorul nu este online!"})
							end
						else
							vRPclient.notify(player,{"Trebuie sa completezi motivul."})
						end
        			end)
      			end
    		else
      			vRPclient.notify(player,{"ID-ul pare invalid!"})
			end
    	end)
	end
end

local function ch_ban(source,choice)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		vRP.prompt(source,"ID (BAN PERMANENT): ","",function(player,id)

      		id = tonumber(id)
			  local sursa = vRP.getUserSource(id)
      		if(tonumber(id) and (id ~= ""))then
				if(id == 1 or id == 2 or id == 3 or id == 0 or id == -1)then
					if(source ~= nil)then
						TriggerClientEvent('chatMessage', -1, "Pripasul asta ^5"..vRP.getPlayerName(player).."^0 a incercat sa ii dea ban la shefii lui")
					end
      			else
					vRP.prompt(source,"Motiv: ","",function(player,reason)
						if reason ~= "" then
							if source ~= nil then
								theFaction = vRP.getUserFaction(id)
								if(theFaction ~= "user")then
									vRP.removeUserFaction(id,theFaction)
									vRP.removeUserGroup(id,"onduty")
								end
								TriggerClientEvent("chatMessage", -1, "^5"..vRP.getPlayerName(sursa).." ^0[^5"..id.."^0] ^0a fost banat permanent de catre ^5"..vRP.getPlayerName(player).."^0[5"..user_id.."^0] Motiv: ^5"..reason.."^0")
								local embed = {
									{
									  ["color"] = 0xADD8E6,
									  ["type"] = "rich",                    
									  ["author"] = {
										["name"] = GetPlayerName(player).."["..user_id.."]"
									  } ,                                               
									  ["description"] = "i-a dat ban online lui **"..GetPlayerName(sursa).."["..id.."]**: **"..reason.."**",
									  ["footer"] = {
										["text"] = os.date("%d/%m/%y").." - "..os.date("%H:%M")
									  }
									}
								}
					  			PerformHttpRequest('https://discord.com/api/webhooks/1079810815613468722/GV3qHzc3wg0QzU9hOIDcWBduLjgd9pnP_EyGMlDSGERM4_cTsG16qKGQDckFIFzFjbU_', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' }) 								
								vRP.ban(sursa,reason,player) 
							else
								local rows = exports["oxmysql"]:executeSync("SELECT username FROM vrp_users WHERE id = @user_id", {user_id = id})
								TriggerClientEvent("chatMessage", -1, "^5"..tostring(rows[1].username).." ("..id..") ^0a fost banat permanent de ^5"..vRP.getPlayerName(player).."^0(^5"..user_id.."^0): ^5"..reason.."^0")
								local embed = {
									{
									  ["color"] = 0xADD8E6,
									  ["type"] = "rich",                    
									  ["author"] = {
										["name"] = GetPlayerName(player).."["..user_id.."]"
									  } ,                                               
									  ["description"] = "i-a dat ban online lui **"..tostring(rows[1].username).."["..id.."]**: **"..reason.."**",
									  ["footer"] = {
										["text"] = os.date("%d/%m/%y").." - "..os.date("%H:%M")
									  }
									}
								}
								  PerformHttpRequest('https://discord.com/api/webhooks/1079810815613468722/GV3qHzc3wg0QzU9hOIDcWBduLjgd9pnP_EyGMlDSGERM4_cTsG16qKGQDckFIFzFjbU_', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' }) 
								vRP.setBanned(id,true,reason,player)
							end
						else
							vRPclient.notify(player,{"Trebuie sa completezi motivul."})
						end
       		 		end)
      			end
    		else
      			vRPclient.notify(player,{"ID-ul pare invalid!"})
    		end
    	end)
	end
end

local function ch_banTemp(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"Jucator ID de BANAT TEMPORAR: ","",function(player,id)
      		id = parseInt(id)
			  local sursa = vRP.getUserSource(id)
      		local source = vRP.getUserSource(id)
      		if(tonumber(id) and (id ~= ""))then
				if(id == 1 or id == 2 or id == 3 or id == 0 or id == -1)then
					vRPclient.notify(player,{"Nu ai cum sa banezi id-urile astea"})
					if(source ~= nil) then
						vRPclient.notify(source,{""..vRP.getPlayerName(player).." ~w~a incercat sa te baneze!"})
					end
      			else
					vRP.prompt(player,"Motiv: ","",function(player,reason)
						if reason ~= "" then
							vRP.prompt(player,"Timp (zile): ","",function(player,timp)
								timp = parseInt(timp)
								if tonumber(timp) and (timp ~= "") then
									if (timp >= 2) and (timp <= 90) then
										local expireDate = vRP.getBannedExpiredDate(timp)
										local source = vRP.getUserSource(id)
										if source ~= nil then
											if(timp == 90)then
												theFaction = vRP.getUserFaction(id)
												if(theFaction ~= "user")then
													vRP.removeUserFaction(id,theFaction)
												end
											end
											TriggerClientEvent("chatMessage", -1, "^5"..vRP.getPlayerName(sursa).." ^0[^5"..id.."^0] a fost banat temporar de catre ^5"..vRP.getPlayerName(player).." ^0[5"..user_id.."^0]: ^0pentru ^5"..timp.." zile^0: ^5"..reason.."^0")
											vRP.banTemp(sursa,reason,player,timp)
										else
											exports["oxmysql"]:query("SELECT username FROM vrp_users WHERE id = @user_id", {user_id = id}, function(rows)
											TriggerClientEvent("chatMessage", -1, "^5"..tostring(rows[1].username).." ^0[^5"..id.."^0] ^0a fost banat temporar de catre ^5"..vRP.getPlayerName(player).." ^0[5"..user_id.."^0]: ^0pentru ^5"..timp.." zile^0: ^5"..reason.."^0")											
											vRP.setBannedTemp(id,true,reason,player,timp)
											local embed = {
												{
												  ["color"] = 0xADD8E6,
												  ["type"] = "rich",                    
												  ["author"] = {
													["name"] = GetPlayerName(player).."["..user_id.."]"
												  } ,                                               
												  ["description"] = "i-a dat ban temporar lui **"..tostring(rows[1].username).."["..id.."]**: **"..reason.."**: **"..timp.." zile**",
												  ["footer"] = {
													["text"] = os.date("%d/%m/%y").." - "..os.date("%H:%M")
												  }
												}
											}
											  PerformHttpRequest('https://discord.com/api/webhooks/1079810815613468722/GV3qHzc3wg0QzU9hOIDcWBduLjgd9pnP_EyGMlDSGERM4_cTsG16qKGQDckFIFzFjbU_', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' }) 
											end)
										end
									else
										vRPclient.notify(player,{"~w~Maxim 90 de zile (3 luni)"})
									end
								else
									vRPclient.notify(player,{"~w~Timp-ul nu poate fi gol"})
								end
							end)
						else
							vRPclient.notify(player,{"~w~Motiv-ul nu poate fi gol"})
						end
       		 		end)
      			end
    		else
      			vRPclient.notify(player,{"~w~Acest ID este INVALID!"})
    		end
    	end)
	end
end

local adminTickets = {}
local totalTickets = 0

local function task_check_tickets()
    SetTimeout(1500, function ()
        local total = 0
        local actualTime = os.time()
        for k,v in pairs(adminTickets) do
            if v.expire < actualTime then
                adminTickets[k] = nil
                totalTickets = totalTickets - 1
                TriggerClientEvent("alpha:TicketsUpdate", -1, totalTickets)
                local player = vRP.getUserSource(k)
                if player then
                    vRPclient.notify(player,{'Nici un membru staff nu ti-a acceptat ticket-ul! Acum poti face alt ticket.'})
                end
            else
                total = total + 1
            end
        end
        totalTickets = total
        task_check_tickets()
    end)
end
task_check_tickets()

local function ch_adminTicket(player)
	local user_id = vRP.getUserId(player)
		vRP.prompt(player, "Support Team", "Scrie DA pentru a creea un ticket", function(player,answer)
			answer = tostring(answer)
			if(string.lower(answer) == "da") then
		vRP.closeMenu(player)
		if not adminTickets[user_id] then
			adminTickets[user_id] = {
				expire = os.time() + 300,
				playerName = GetPlayerName(player)
			}
			totalTickets = totalTickets + 1
			TriggerClientEvent("alpha:TicketsUpdate",-1,totalTickets)
			
			vRPclient.notify(player,{'~w~Ai facut un ticket, asteapta ca un membru staff sa iti raspunda.'})

		elseif adminTickets[user_id].expire < os.time() then
			adminTickets[user_id] = nil
			ch_adminTicket(player)
		else
			vRPclient.notify(player,{'Ai facut deja un ticket, asteapta sa vina cineva.'})
		end
	else
		vRPclient.notify(player,{'Trebuie sa scrii "Da" pentru a creea ticket'})
	end
end)
end

RegisterCommand('calladmin', function(player, args, msg)
	local user_id = vRP.getUserId(player)
		vRP.prompt(player, "Support Team", "Scrie DA pentru a creea un ticket", function(player,answer)
			answer = tostring(answer)
			if(string.lower(answer) == "da") then
		vRP.closeMenu(player)
		if not adminTickets[user_id] then
			adminTickets[user_id] = {
				expire = os.time() + 300,
				playerName = GetPlayerName(player)
			}
			totalTickets = totalTickets + 1
			TriggerClientEvent("alpha:TicketsUpdate",-1,totalTickets)
			
			vRPclient.notify(player,{'~w~Ai facut un ticket, asteapta ca un membru staff sa iti raspunda.'})

		elseif adminTickets[user_id].expire < os.time() then
			adminTickets[user_id] = nil
			ch_adminTicket(player)
		else
			vRPclient.notify(player,{'Ai facut deja un ticket, asteapta sa vina cineva.'})
		end
	else
		vRPclient.notify(player,{'Trebuie sa scrii "Da" pentru a creea ticket'})
	end
end)
end)

RegisterCommand('tickete', function(source, args, msg)
    local user_id = vRP.getUserId({source})
    if vRP.isUserFondator({user_id}) then 
        exports.oxmysql:execute("SELECT raport, id FROM vrp_users WHERE raport != 0", {},function (rows)
            local name = GetPlayerName(source)
            local time = os.date("%d/%m/%Y")
            local content = "<em><span id='dexotest'><b>RAPORT STAFF ("..time..")</b></span><br></em>"
            for i, v in pairs(rows) do
                content = content .. "<br/><em>[" .. name .. " | ID: #" .. v.id .. "] - Un total de " .. v.raport .. " tickete <span id='dexotime'>ACEST PANOU SE VA INCHIDE IN 20 SECUNDE</span></em>"
            end
            vRPclient.setDiv(source,{"dexo_ticket",".div_dexo_ticket{ background-color: rgba(0,0,0,0.5); border-radius:8px; text-shadow: 0 0 2px #ffffff, 0 0 14px #ffffff; color: white; font-weight: bold; width: 800px; padding: 10px; margin: auto; margin-top: 150px;border: 1px solid #ebc934; } #dexotest { color:yellow;text-shadow: 0 0 2px #ebc934, 0 0 14px #ebc934; } #dexotime { position:absolute; top:50%;left:38%;text-align: center; }",content})
            Wait(20000)
            vRPclient.removeDiv(source,{"dexo_ticket"})
        end)
    end
end)

local function takeTicket(player,args)
	local user_id = vRP.getUserId(player)
	local isAdmin = vRP.isUserTrialHelper(user_id)
	if isAdmin then
		if args[1] then
			local nuser_id = parseInt(args[1])
			if adminTickets[nuser_id] then
				adminTickets[nuser_id] = nil
				local nplayer = vRP.getUserSource(nuser_id)
				if nplayer then
					totalTickets = totalTickets - 1
					TriggerClientEvent("alpha:TicketsUpdate", -1, totalTickets)
					vRPclient.getPosition(nplayer,{},function(x,y,z)
						vRPclient.teleport(player,{x,y,z})
						vRPclient.notify(player,{"Ai acceptat un ticket"})
						vRPclient.notify(nplayer,{""..GetPlayerName(player).." ["..user_id.."]~w~ a venit la ticket-ul tau."})
						vRP.sendStaffMessage("Ticketul lui ^5"..nuser_id.." ^0a fost luat de ^5"..GetPlayerName(player).." ")
						exports["oxmysql"]:query("UPDATE vrp_users SET raport = raport + 1 WHERE id = "..user_id,{})
					end)
				else
					TriggerClientEvent('chatMessage', player, "Jucator-ul nu mai este conectat")
				end
			else
				TriggerClientEvent('chatMessage', player, "Jucator-ul nu are niciun ticket activ")
			end
		else
			local nuser_id = 0
			for k,v in pairs(adminTickets) do
				if v.expire > os.time() then
					nuser_id = k
				end
			end
			if nuser_id > 0 then
				adminTickets[nuser_id] = nil

				totalTickets = totalTickets - 1
				TriggerClientEvent("alpha:TicketsUpdate", -1, totalTickets)

				local nplayer = vRP.getUserSource(nuser_id)
				if nplayer then
					vRPclient.getPosition(nplayer,{},function(x,y,z)
						vRPclient.teleport(player,{x,y,z})
						vRPclient.notify(player,{"Ai acceptat un ticket"})
						vRPclient.notify(nplayer,{""..GetPlayerName(player).." ["..user_id.."]~w~ a venit la ticket-ul tau."})
						vRP.sendStaffMessage("Ticketul lui ^5"..nuser_id.." ^0a fost luat de ^5"..GetPlayerName(player).." ")
						exports["oxmysql"]:query("UPDATE vrp_users SET raport = raport + 1 WHERE id = "..user_id,{})
					end)
				else
					TriggerClientEvent('chatMessage', player, "Jucator-ul nu mai este conectat")
				end
			else
				TriggerClientEvent('chatMessage', player, "Nu exista ^5tickete^0 in ^5asteptare^0")
			end
		end
	else
		TriggerClientEvent('chatMessage', player, "Nu ai acces la aceasta comanda")
	end
end

RegisterCommand("tk",takeTicket)

AddEventHandler("vRP:playerLeave",function(user_id,player)
	if adminTickets[user_id] then
		adminTickets[user_id] = nil
		totalTickets = totalTickets - 1
		TriggerClientEvent("alpha:TicketsUpdate", -1, totalTickets)
	end
end)

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local isAdmin = vRP.isUserTrialHelper(user_id)
	if first_spawn then
		if isAdmin then
			vRPclient.setAdmin(source,{})
		end
	end
end)

local function ch_checkplayer(player, choice)
	check_menu = {name="Check Player",css={top="75px", header_color="rgba(0,125,255,0.75)"}}
	vRP.prompt(player, "User ID:", "", function(player, user_id)
		user_id = tonumber(user_id)
		usrID = vRP.getUserId(player)
		if(user_id == 1) and (user_id ~= 2) and (user_id ~= 3) and (user_id ~= 0) and (user_id ~= -1) then
			vRPclient.notify(player, {"Nu ai cum sa dai check pe id 1,2 si 3"})
			return
		else
			theTarget = vRP.getUserSource(user_id)
			if(theTarget)then
				user_id = vRP.getUserId(theTarget)
				wallet = vRP.getMoney(user_id)
				ore = vRP.getUserHoursPlayed(user_id)
				bank = vRP.getBankMoney(user_id)
				steamID = GetPlayerIdentifier(theTarget) or "Invalid"
				rsLicense = GetPlayerIdentifier(theTarget, 1) or "Invalid"
				theIP = GetPlayerEndpoint(theTarget) or "Invalid"
				vRP.sendStaffMessage("^5".. vRP.getPlayerName(player) .." ^0a folosit check player")
			
				check_menu["[1] Bani"] = {function() end, "Buzunar: <font color='red'>$"..vRP.formatMoney(wallet).."</font><br>Banca: <font color='red'>$"..vRP.formatMoney(bank)}
				check_menu["[2] Ore"] = {function() end, "Ore: <font color='red'>"..ore.."</font>"}
				check_menu["[3] Nume"] = {function() end, "Nume: <font color='red'>"..GetPlayerName(theTarget).."</font>"}
				check_menu["[4] Vehicule"] = {function(player, choice) playerVehs(player,user_id) end, "Vezi masinile jucatorilui"}
				vRP.closeMenu(player)
				SetTimeout(200, function()
					vRP.openMenu(player, check_menu)
				end)
			end
		end
	end)
end

local function ch_food(player,choice)
    local user_id = vRP.getUserId(player)
    vRP.setThirst(user_id,-100)
  vRP.setHunger(user_id,-100)
end

local function ch_unban(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      vRP.prompt(player,"Jucator ID de DEBANAT: ","",function(player,id)
            id = tonumber(id)
          if id then
              local rows = exports['oxmysql']:executeSync("SELECT username, banned, bannedTemp, bannedReason FROM vrp_users WHERE id = @user_id", {user_id = id})
              if #rows > 0 then
                  if(rows[1].banned == true) or (rows[1].bannedTemp > 0)then

                      local banReason = rows[1].bannedReason
                      vRP.request(player,'Vrei sa-i dai unban lui ID: ' .. id .. '? Motiv ban: ' .. banReason, 60, function(player,ok)
                        if ok then 
                            local unbannedBy = "["..user_id.."] "..vRP.getPlayerName(player)
                            local unbannedPlayer = "["..id.."] "..tostring(rows[1].username)
                            TriggerClientEvent('chatMessage', -1, "^1"..unbannedBy.." ^0l-a ^5debanat ^0pe ^5"..unbannedPlayer)
                            vRP.setBannedTemp(id,false,"","",0)
							local embed = {
								{
								  ["color"] = 0xADD8E6,
								  ["type"] = "rich",                    
								  ["author"] = {
									["name"] = GetPlayerName(player).."["..user_id.."]",
								  } ,                                               
								  ["description"] = "I-a dat unban lui **"..tostring(rows[1].username).."["..id.."]**",
								  ["footer"] = {
									["text"] = os.date("%d/%m/%y").." - "..os.date("%H:%M")
								  }
								}
							}
							  PerformHttpRequest('https://discord.com/api/webhooks/1079810815613468722/GV3qHzc3wg0QzU9hOIDcWBduLjgd9pnP_EyGMlDSGERM4_cTsG16qKGQDckFIFzFjbU_', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' }) 
                        end
                      end)
  
                  else
					  vRPclient.notify(player,{"~r~Acest jucator nu este banat!"})
                  end
              else
                  vRPclient.notify(player,{"~r~Acest jucator nu exista!"})
              end
          else
                vRPclient.notify(player,{"~r~Acest ID este INVALID!"})
           end
      end)
    end
end

local function ch_coords(player,choice)
  	vRPclient.getPosition(player,{},function(x,y,z)
    	vRP.prompt(player,"Coordonate",x..","..y..","..z,function(player,choice) end)
  	end)
end

local function ch_tptoplace(player,choice)
	local user_id = vRP.getUserId(source)
	vRP.prompt(player,"ID: ","",function(player,id) 
		local id = parseInt(id)
    vRP.prompt(player,"Unde vrei sa te teleportezi","[1] showroom, [2] spawn, [3] politie, [4] spital",function(player,raspuns) 
			tp = parseInt(raspuns)
			if id ~= nil then
				local thePlayer = vRP.getUserSource(id)
				if thePlayer ~= nil then
					if tp == 1 then
						vRPclient.notify(player,{"L-ai teleportat pe "..GetPlayerName(thePlayer).." la "})
						vRPclient.notify(thePlayer,{"Ai fost teleporat la Showroom de catre adminul "..GetPlayerName(player)})
						vRPclient.teleport(thePlayer,{-38.905174255371,-1110.2645263672,26.438343048096})
					elseif tp == 2 then
						vRPclient.notify(player,{"L-ai teleportat pe "..GetPlayerName(thePlayer).." la Spawn"})
						vRPclient.notify(thePlayer,{"Ai fost teleporat la Spawn de catre adminul "..GetPlayerName(player)})
						vRPclient.teleport(thePlayer,{-541.79254150391,-209.90585327148,37.649803161621})
					elseif tp == 3 then
						vRPclient.notify(player,{"L-ai teleportat pe "..GetPlayerName(thePlayer).." la Politie"})
						vRPclient.notify(thePlayer,{"Ai fost teleporat la Politie de catre adminul "..GetPlayerName(player)})
						vRPclient.teleport(thePlayer,{426.77401733398,-981.39434814453,30.710090637207})
					elseif tp == 4 then
						vRPclient.notify(player,{"L-ai teleportat pe "..GetPlayerName(thePlayer).." la Spital"})
						vRPclient.notify(thePlayer,{"Ai fost teleporat la Spital de catre adminul "..GetPlayerName(player)})
						vRPclient.teleport(thePlayer,{-828.13500976562,-1219.505859375,6.9341225624084})
					end
				else
					vRPclient.notify(player,{"~w~Jucatorul nu este online!"})
				end
			else
				vRPclient.notify(player,{"~w~Jucatorul nu este online!"})
			end
		end)
	end)
end

local function ch_createGarage(player,choice)
		local user_id = vRP.getUserId(player)
		if user_id then
			vRP.prompt(player,"Tip Garaj: ","",function(player,gType)
				gType = tostring(gType)
				if(gType ~= "") and (gType ~= nil)then
					vRPclient.getPosition(player,{},function(x,y,z)
						x, y, z = x, y, z
						vRP.spawnCreatedGarage(x, y, z, gType)
						vRPclient.notify(player, {"~g~Succes: ~g~Garaj creeat de tip: ~y~"..gType})
					end)
				end
			end)
		end
end

local function ch_tptome(player,choice)
	local id = vRP.getUserId(player)
  	vRPclient.getPosition(player,{},function(x,y,z)
    	vRP.prompt(player,"ID:","",function(player,user_id) 
     		local tplayer = vRP.getUserSource(tonumber(user_id))
			local target = vRP.getUserSource(user_id)
			local numestaff = vRP.getPlayerName(player)
      		if tplayer ~= nil then
        		vRPclient.teleport(tplayer,{x,y,z})
				vRP.sendStaffMessage("^5".. numestaff .." ^0a dat tptome lui ^5".. user_id)
      		end
    	end)
  	end)
end
 
local function ch_tpto(player,choice)
	local id = vRP.getUserId(player)
  	vRP.prompt(player,"ID:","",function(player,user_id) 
    	local tplayer = vRP.getUserSource(tonumber(user_id))
		local numestaff = vRP.getPlayerName(player)
    	if tplayer ~= nil then
      		vRPclient.getPosition(tplayer,{},function(x,y,z)
        		vRPclient.teleport(player,{x,y,z})
				vRPclient.teleport(player,{x,y,z})
				vRP.sendStaffMessage("^5".. numestaff .." ^0a dat tpto la ID ^5".. user_id)
      		end)
    	end
  	end)
end

local function ch_tptocoords(player,choice)
	local user_id = vRP.getUserId(player)
	vRP.prompt(player,"Coordonate X,Y,Z:","",function(player,fcoords) 
  local coords = {}
  for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
		table.insert(coords,tonumber(coord))
  end

	  local x,y,z = 0,0,0
	  if coords[1] ~= nil then x = coords[1] end
	  if coords[2] ~= nil then y = coords[2] end
	  if coords[3] ~= nil then z = coords[3] end

	  vRPclient.teleport(player,{x,y,z})
	end)
end

local function ch_takemoney(player,choice)
	local ID = vRP.getUserId(player)
	vRP.prompt(player, "ID:", "", function(player, user_id)
		user_id = tonumber(user_id)
		local target = vRP.getUserSource(user_id)
		if target ~= nil then
			vRP.prompt(player, "Suma: ", "", function(player, amount)
				amount = parseInt(amount)
				local tBani = tonumber(vRP.getMoney(user_id))
				if(tonumber(amount))then
					amount = tonumber(amount)
					if(tBani >= amount)then
						vRP.takeMoney(user_id,amount)
						vRPclient.notify(player,{"~w~I-ai luat lui ~r~"..vRP.getPlayerName(target).." ~w~suma de ~r~".. vRP.formatMoney(amount) .." ~w~(de) €."})
						vRPclient.notify(target, {"~r~".. vRP.getPlayerName(player) .."~w~ ti-a luat ~r~".. vRP.formatMoney(amount) .." ~w~(de) €."})
						vRP.sendStaffMessage("^5".. vRP.getPlayerName(player) .." ^0i-a dat take-money lui ^5".. vRP.getPlayerName(target) .." ^0[^5"..target.."^0] si i-a luat: ^5"..amount.." ^0Bani")
					else
						vRPclient.notify(player, {"~w~Jucatorul are doar ~b~"..vRP.formatMoney(tBani).." ~w~€."})
					end
				else
					vRPclient.notify(player, {"~w~Suma introdusa trebuie sa fie formata doar din numere."})
				end
			end)
		else
			vRPclient.notify(player, {"~w~Jucatorul nu este online."})
		end
	end)
end

-- local function ch_takegiftpoints(player,choice)
-- 	local ID = vRP.getUserId(player)
-- 	vRP.prompt(player, "ID:", "", function(player, user_id)
-- 		user_id = tonumber(user_id)
-- 		local target = vRP.getUserSource(user_id)
-- 		if target ~= nil then
-- 			vRP.prompt(player, "Suma: ", "", function(player, amount)
-- 				amount = parseInt(amount)
-- 				local tBani = tonumber(vRP.getGiftPoints(user_id))
-- 				if(tonumber(amount))then
-- 					amount = tonumber(amount)
-- 					if(tBani >= amount)then
-- 						vRP.takeCoins(user_id,amount)
-- 						vRPclient.notify(player,{"Succes ~w~I-ai luat lui ~r~"..vRP.getPlayerName(target).." ~w~suma de ~r~".. vRP.formatMoney(amount) .." ~w~(de) GiftPoints."})
-- 						vRPclient.notify(target, {"~w~".. vRP.getPlayerName(player) .." ti-a luat ~r~".. vRP.formatMoney(amount) .." ~w~(de) GiftPoints."})
-- 						vRP.sendStaffMessage("^5".. vRP.getPlayerName(player) .." ^0i-a luat Ice-coins lui ^5".. vRP.getPlayerName(target) .." ("..target .."), si i-a luat ^5"..amount)
-- 					else
-- 						vRPclient.notify(player, {"~w~Jucatorul are doar ~b~"..vRP.formatMoney(tBani).." ~w~€."})
-- 					end
-- 				else
-- 					vRPclient.notify(player, {"~w~Suma introdusa trebuie sa fie formata doar din numere."})
-- 				end
-- 			end)
-- 		else
-- 			vRPclient.notify(player, {"~w~Jucatorul nu este online."})
-- 		end
-- 	end)
-- end

local function ch_giveDiamante(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
	  vRP.prompt(player,"ID:","",function(player,nplayer) 
		  if nplayer ~= "" or nplayer ~= nil then
			  target = vRP.getUserSource(tonumber(nplayer))
			  if target then
				  vRP.prompt(player,"Suma:","",function(player,amount) 
					  amount = parseInt(amount)
					  vRP.giveDiamante(tonumber(nplayer), amount)
					  vRPclient.notify(player,{"I-ai dat lui "..vRP.getPlayerName(target)..", ".. vRP.formatMoney(amount) .." (de) diamante"})
					  vRP.sendStaffMessage("^5".. vRP.getPlayerName(player) .." ^0i-a dat diamante lui ^5".. vRP.getPlayerName(target) .." ^0[^5"..target .."^0] si i-a dat ^5"..amount.. " ^0Diamante")
				  end)
			  else
				  vRPclient.notify(player,{"~w~Jucatorul nu a fost gasit."})
			  end
		  end
	  end)
	end
  end

local function ch_giveitem(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"ID:","",function(player,userID)
			userID = tonumber(userID)
			theTarget = vRP.getUserSource(userID)
			if(theTarget)then
				vRP.prompt(player,"Nume item:","",function(player,idname) 
					idname = idname or ""
					vRP.prompt(player,"Cantitate:","",function(player,amount) 
						amount = parseInt(amount)
						vRP.giveInventoryItem(userID, idname, amount, true)
					end)
				end)
			end
		end)
	end
end

local function ch_takeitem(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"ID:","", function(player,userID)
			userID = tonumber(userID)
			theTarget = vRP.getUserSource(userID)
			if(TheTarget) then
				vRP.prompt(player,"Nume item:","", function(player,idname)
					idname = idname or ""
					vRP.prompt(player,"Cantitate:","", function(player, amount)
						amount = parseInt(amount)
						vRP.tryGetInventoryItem(userID, idname, amount, true)
					end)	
				end)
			end
		end)
	end
end
local cfg_inventory = module("cfg/inventory")

function playerVehs(player,user_id)
	check_menu2 = {name="Vehicule",css={top="75px", header_color="rgba(0,125,255,0.75)"}}
	local theVehicles = exports["oxmysql"]:executeSync("SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id", {user_id = user_id})
	for i, v in pairs(theVehicles) do
		vehName, vehPrice = vRP.checkVehicleName(v.vehicle)
		check_menu2[vehName] = {function(player, choice) 
			local chestname = "u"..user_id.."veh_"..string.lower(v.vehicle)
			local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(v.vehicle)] or cfg_inventory.default_vehicle_chest_weight
			
			vRP.adminCheckInventory(player, chestname, max_weight)
		end, "Model: <font color='green'>"..v.vehicle.."</font><br>Placuta: "..v.vehicle_plate.."<br>"}
	end
	vRP.closeMenu(player)
	SetTimeout(400, function()
		vRP.openMenu(player, check_menu2)
	end)
end

local function ch_noclip(player, choice)
	local user_id = vRP.getUserId(player)
  	vRPclient.toggleNoclip(player, {})
end

RegisterCommand('invisiblemod', function(player, args)
	if vRP.isUserFondator(user_id) then 
  	vRPclient.invisiblemod(player, {})
  	vRPclient.notify(player,{"~w~Invisible Mod"})
  end
end)

AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
	local rows = exports["oxmysql"]:executeSync("SELECT adminLvl FROM vrp_users WHERE id = @user_id", {user_id = user_id})
	local adminLevel = tonumber(rows[1].adminLvl)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		tmp.adminLevel = adminLevel
	end
end)

local function ch_addAdmin(player,choice)
	local user_id = vRP.getUserId(player)
	local numestaff = vRP.getPlayerName(player)
	local adminlvl = vRP.getUserAdminTitle(user_id)
	if user_id ~= nil then
		vRP.prompt(player,"ID:","",function(player,id) 
			id = parseInt(id)
			local target = vRP.getUserSource(id)
			if(target)then
				vRP.prompt(player,"Admin Rank:","",function(player,rank) 
					rank = parseInt(rank)
					if(tonumber(rank))then
						if(rank <= 8) and (0 < rank)then
							if(target) then
								vRP.setUserAdminLevel(id,rank)
								Wait(150)
								vRPclient.notify(player,{"~w~I-ai dat up lui ~r~"..vRP.getPlayerName(target).." ~w~la ~r~"..vRP.getUserAdminTitle(id).."~w~!"})
								vRPclient.notify(target,{"~w~Ai primit up la ~r~"..vRP.getUserAdminTitle(id).." ~w~de catre ~r~"..vRP.getPlayerName(player)})
								vRP.sendStaffMessage("[Realism] ^5".. numestaff .." ^0i-a dat admin lui ^5".. vRP.getPlayerName(target) .." ^0[^5"..target .."^0] si i-a dat gradul: ^5"..vRP.getUserAdminLevel(id))
								exports["oxmysql"]:query("INSERT INTO vrp_logs (`user_id`,`text`,`tip`,`data`) VALUES (@user_id,@text,@tip,@data)", {user_id = user_id, text = "A fost adaugat ca "..vRP.getUserAdminTitle(id), tip = "Normal", data = os.date("%Y-%m-%d %H:%M:%S")}, function()end)
								  local embed = {
									{
									  ["color"] = 0xADD8E6,
									  ["type"] = "rich",                    
									  ["author"] = {
										["name"] = GetPlayerName(player).."["..user_id.."]"
									  },                       
									  ["description"] = "I-a dat admin lui **"..GetPlayerName(target).."[".. id .."]**: **"..rank.."**",
									  ["footer"] = {
										["text"] = os.date("%d/%m/%y").." - "..os.date("%H:%M")
									  }
									}
								}
								  PerformHttpRequest('https://discord.com/api/webhooks/1079810815613468722/GV3qHzc3wg0QzU9hOIDcWBduLjgd9pnP_EyGMlDSGERM4_cTsG16qKGQDckFIFzFjbU_', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' })
							else
								exports["oxmysql"]:query("UPDATE vrp_users SET adminLvl = @adminLevel WHERE id = @user_id", {user_id = id, adminLevel = rank}, function()end)
								vRPclient.notify(player,{"~w~I-ai dat up lui ~r~"..id.." ~w~la grad-ul ~r~"..rank.."~w~!"})
							end
						elseif(rank == 0)then
							if(target)then
								local embed = {
									{
									  ["color"] = 0xADD8E6,
									  ["type"] = "rich",                    
									  ["author"] = {
										["name"] = GetPlayerName(player).."["..user_id.."]",
									  },                       
									  ["description"] = "I-a scos admin-ul lui **"..GetPlayerName(target).."[".. id .."]**",
									  ["footer"] = {
										["text"] = os.date("%d/%m/%y").." - "..os.date("%H:%M")
									  }
									}
								}
								  PerformHttpRequest('https://discord.com/api/webhooks/1079810815613468722/GV3qHzc3wg0QzU9hOIDcWBduLjgd9pnP_EyGMlDSGERM4_cTsG16qKGQDckFIFzFjbU_', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' })
								  exports["oxmysql"]:query("INSERT INTO vrp_logs (`user_id`,`text`,`tip`,`data`) VALUES (@user_id,@text,@tip,@data)", {user_id = user_id, text = "A fost scos din staff el avand gradul de "..vRP.getUserAdminTitle(id), tip = "Normal", data = os.date("%Y-%m-%d %H:%M:%S")}, function()end)
								vRP.setUserAdminLevel(id,rank)
								Wait(150)
								vRPclient.notify(target,{"~w~Staff-ul ti-a fost scos de catre ~r~"..vRP.getPlayerName(player).."~w~!"})
								vRPclient.notify(player,{"~w~I-ai scos staff-ul lui ~r~"..vRP.getPlayerName(target)})
							else
								exports["oxmysql"]:query("UPDATE vrp_users SET adminLvl = @adminLevel WHERE id = @user_id", {user_id = id, adminLevel = rank}, function()end)
								vRPclient.notify(player,{"~w~I-ai scos functia staff lui ~r~"..id})
							end
						end
					end
				end)
			else
				vRPclient.notify(player,{"~w~Acest ID nu a fost gasit."})
			end
		end)
	end
end

local function ch_ann(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id then
		vRP.prompt(player,"Anunt:","",function(player,msg) 
			msg = tostring(msg)
			if(msg ~= "" and msg ~= nil)then
				vRPclient.notify(-1, {"Succes: "..GetPlayerName(player).." ~b~a dat un anunt administrativ!"})
				local name = (GetPlayerName(player) or "")
				SetTimeout(5000, function()
					vRPclient.adminAnnouncement(-1, {name, user_id, msg})
				end)
			end
		end)
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

-- local function ch_givevip(player,choice)
--     local user_id = vRP.getUserId(player)
--     if user_id ~= nil then
--         vRP.prompt(player,"User Id:","",function(player,id)
--             local id = parseInt(id)
--             if id ~= nil then
--                 local target = vRP.getUserSource(id)
--                 if target then
--                     local name = GetPlayerName(target) 
--                     vRP.prompt(player,"Vip:","",function(player,vip)
--                         local vip = parseInt(vip)
--                         if vip > 0 then
--                             vRP.prompt(player,"Durata: (-1 = permanent)","",function(player,time)
--                                 time = parseInt(time)
--                                 if time ~= nil then
--                                     vRP.setUserVip(id,vip,time)
--                                     local vipTitle = vRP.getUserVipTitle(id)
--                                     vRPclient.notify(player,{"~w~I-ai dat ~g~"..vipTitle.." ~w~lui ~g~"..name..""})
--                                     vRPclient.notify(target,{"~w~Ai primit ~g~"..vipTitle})
--                                 end
--                             end)
--                         else
--                             vRP.setUserVip(id,0,-1)
--                             vRPclient.notify(player,{"~w~I-ai scos VIP-ul lui ~r~"..name..""})
--                             vRPclient.notify(target,{"~r~VIP-ul ti-a fost scos!"})
--                         end
--                     end)
--                 else
--                     vRPclient.notify(player,{'~r~Acest jucator nu a fost gasit!'})
--                 end
--             else
--                 vRPclient.notify(player,{"Acest jucator nu a fost gasit!"})
--             end
--         end)
--     end
-- end
local function ch_addSponsor(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id  then
        vRP.prompt(player,"USER ID:","",function(player,id)
            local id = parseInt(id)
            if id and id > 0 then
                local target = vRP.getUserSource(id)
                if target then
                    local name = GetPlayerName(target) 
                    vRP.prompt(player,"Sponsor(0 = Remove , 1 = Add):","",function(player,vip)
                        local vip = parseInt(vip)
                        if vip > 0 then
                            vRP.prompt(player,"Durata: (-1 = permanent)","",function(player,time)
                                time = parseInt(time)
                                if time then
                                    vRP.setSponsor(id,1,time)
                                    vRPclient.notify(player,{"~w~I-ai dat ~g~Sponsor ~w~lui ~g~"..name..""})
                                    vRPclient.notify(target,{"~w~Ai primit ~g~Sponsor ~w~pentru ~y~"..time.." ~w~de zile !"})
                                end
                            end)
                        else
                            vRP.setSponsor(id,0,-1)
                            vRPclient.notify(player,{"~w~I-ai scos Sponsor-ul lui ~r~"..name..""})
                            vRPclient.notify(target,{"~r~Sponsor-ul ti-a fost scos!"})
                        end
                    end)
                else
                    vRPclient.notify(player,{'~r~Acest jucator nu a fost gasit!'})
                end
            else
                vRPclient.notify(player,{"Acest jucator nu a fost gasit!"})
            end
        end)
    end
end

local function ch_givemoney(player,choice)
	local ID = vRP.getUserId(player)
	vRP.prompt(player, "ID:", "", function(player, user_id)
		user_id = tonumber(user_id)
		local target = vRP.getUserSource(user_id)
		if target ~= nil then
		vRP.prompt(player,"Suma:","",function(player,amount) 
			amount = parseInt(amount)
				if(tonumber(amount) ~= nil) and (tonumber(amount) ~= "")then
					if(tonumber(amount) > 0) and (tonumber(amount) <= 100000000)then
						vRP.giveMoney(user_id, amount)
						vRP.sendStaffMessage("^5[Realism] ^0Admin-ul ^5".. vRP.getPlayerName(player) .." ^0i-a dat givemoney lui ^5".. vRP.getPlayerName(target) .." ^0[^5"..target .."^0], i-a oferit suma de: ^5"..vRP.formatMoney(amount).."^0")
						vRPclient.notify(player,{"I-ai dat lui "..vRP.getPlayerName(target).." suma de ".. vRP.formatMoney(amount) .." (de) €."})
						vRPclient.notify(target, {"".. vRP.getPlayerName(player) .." ti-a dat ".. vRP.formatMoney(amount) .." (de) €."})
					else
						vRPclient.notify(player, {"~w~Maxim 100.000.000 coco"})
					end
				else
					vRPclient.notify(player, {"~w~Suma introdusa trebuie sa fie formata doar din numere"})
				end
			end)
		else
			vRPclient.notify(player, {"~w~Jucatorul nu este online."})
		end
	end)
end

-- Hotkey Open Admin Menu 2/2
function tvRP.openAdminMenu()
  vRP.openAdminMenu(source)
end

vRP.registerMenuBuilder("main", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id ~= nil then
	  local choices = {}
  
	  -- build admin menu
	  choices["Admin"] = {function(player,choice)
		vRP.buildMenu("admin", {player = player}, function(menu)
		  menu.name = "Admin"
		  menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
		  menu.onclose = function(player) vRP.closeMenu(player) end -- nest menu

		  if user_id == 1 or user_id == 2 or user_id == 3 then
			menu["Give Money"] = {ch_givemoney}
			menu["Give item"] = {ch_giveitem}
			 menu["Give Diamante"] = {ch_giveDiamante}
			menu["Take item"] = {ch_takeitem}
			--menu["Take GiftPoints"] = {ch_takegiftpoints}
			menu["Take money"] = {ch_takemoney}
		  end
  
		  if vRP.isUserFondator(user_id) then
			  menu["Add/Remove SPONSOR"] = {ch_addSponsor}
			  menu["Add/Remove VIP"] = {function(player, choice) 
				vRPclient.executeCommand(player, {"+addVip"})
			end}
			  menu["Creeaza Garaj"] = {ch_createGarage}
			end	
		  if vRP.isUserHeadOfStaff(user_id) then
			  menu["Add/Remove Admin"] = {ch_addAdmin}
			  menu["Anunt Admin"] = {ch_ann}
		  end
		  if vRP.isUserSuperAdministrator(user_id) then
			  menu["Add group"] = {ch_addgroup}
			  menu["Remove group"] = {ch_removegroup}
			  menu["Unban"] = {ch_unban}
		  end
		  if vRP.isUserAdministrator(user_id) then
			  menu["Check Player"] = {ch_checkplayer}
			  menu["Coords"] = {ch_coords}
			  menu["TpToCoords"] = {ch_tptocoords}
			  menu["Ban Permanent"] = {ch_ban}
		  end
		  if vRP.isUserSuperModerator(user_id) then
			  menu["Noclip"] = {ch_noclip}
		  end
		  if vRP.isUserModerator(user_id) then
			  menu["Ban Temporar"] = {ch_banTemp}
		  end
		  if vRP.isUserHelper(user_id) then
			  menu["Kick"] = {ch_kick}
		  end
		  if vRP.isUserTrialHelper(user_id) then
			  menu["TpTo"] = {ch_tpto}
			  menu["TpToMe"] = {ch_tptome}
			  menu["TpToPlace"] = {ch_tptoplace}
		  end
		  menu["Admin Ticket"] = {ch_adminTicket}
  
		  vRP.openMenu(player,menu)
		end)
	  end}
  
	  add(choices)
	end
  end)

tvRP.getInfo = function()
	local user_id = vRP.getUserId(source)
	local money = vRP.getMoney(user_id)
	local banca = vRP.getBankMoney(user_id)
	return vRP.formatMoney(money), vRP.formatMoney(banca)
end


function tvRP.tryPayTreatment()
	local player = source;
	local user_id = vRP.getUserId(player);
	if not user_id or not vRP.tryPayment(user_id, 500) then return end;
	return true;
end;

-- vRP.registerMenuBuilder("main", function(add, data)
-- 	local user_id = vRP.getUserId(data.player)
-- 	if user_id ~= nil then
-- 	  local choices = {}
-- 	  choices["GPS"] = {function(player,choice)
-- 		vRP.buildMenu('gps', {player=player}, function(locations)
-- 			locations.name = 'GPS'
-- 			locations.css={
-- 				top = "75px",
-- 				header_color="rgba(226, 87, 36, 0.75)"
-- 			}
-- 			for j,n in pairs(cfg.gpsLocations)do
-- 				locations[j] = {function(player,choice)
-- 					local x,y,z = table.unpack(n.pos)
-- 					-- TriggerClientEvent("setNW",player,x,y)
-- 					vRPclient.SetNewWaypoint(player,{x,y})
-- 					vRP.closeMenu(player)
-- 					vRPclient.notify(player,{"Ti-a fost marcat drumul catre ~y~"..j}) 
-- 				end,(n.description or '')}
-- 			end
-- 			vRP.openMenu(player,locations)
-- 		end)
-- 	end, "Aici poti gasi toate locatiile importante de pe server!"}
-- 	  add(choices)
-- 	end
-- end)

tvRP.isUserStaff = function()
	local user_id = vRP.getUserId(source)
	if vRP.isUserTrialHelper(user_id) then
		return true
	else
		return false
	end
	
end
RegisterCommand('tickete', function(source, args, msg)
    local user_id = vRP.getUserId({source})
    if vRP.isUserHeadOfStaff({user_id}) then 
        exports.oxmysql:execute("SELECT `raport`, `id` FROM `vrp_users` WHERE `raport` != 0", {},function (rows)
            local name = GetPlayerName(source)
            local time = os.date("%d/%m/%Y")
            local content = "<em><span id='dexotest'><b>RAPORT STAFF ("..time..")</b></span><br></em>"
            for i, v in pairs(rows) do
                content = content .. "<br/><em>[" .. name .. " | ID: #" .. v.id .. "] - Un total de " .. v.raport .. " tickete <span id='dexotime'>ACEST PANOU SE VA INCHIDE IN 20 SECUNDE</span></em>"
            end
            vRPclient.setDiv(source,{"anubis_ticket",".div_anubis_ticket{ background-color: rgba(0,0,0,0.5); border-radius:8px; text-shadow: 0 0 2px #ffffff, 0 0 14px #ffffff; color: white; font-weight: bold; width: 800px; padding: 10px; margin: auto; margin-top: 150px;border: 1px solid #ebc934; } #dexotest { color:yellow;text-shadow: 0 0 2px #ebc934, 0 0 14px #ebc934; } #dexotime { position:absolute; top:50%;left:38%;text-align: center; }",content})
            Wait(20000)
            vRPclient.removeDiv(source,{"anubis_ticket"})
        end)
    end
end)