local cfg = module("cfg/factions")
local factions = cfg.factions

local PolitieJandarmerieFreq = {112, 114, 115}
local SmurdFreq = {113}

factionMembers = {}

function getFactionMembers()
	for i, v in pairs(factions) do
		exports.oxmysql:query("SELECT * FROM vrp_users WHERE faction = @faction", {['@faction'] = tostring(i)}, function (rows)
			factionMembers[tostring(i)] = rows
		end)		
	end
end

AddEventHandler("onResourceStart", function(rs)
	if(rs == "vrp")then
		Wait(1000)
		getFactionMembers()
	end
end)

function vRP.getFactions()
	factionsList = {}
	for i, v in pairs(factions) do
		factionsList[i] = v
	end
	return factionsList
end

function vRP.getUserFaction(user_id)
	local tmp = vRP.getUserDataTable(user_id)
	if tmp then
		theFaction = tmp.fName
		return theFaction
	end
end

function vRP.getFactionRanks(faction)
	local ngroup = factions[faction]
	if ngroup then
		local factionRanks = ngroup.fRanks
		return factionRanks
	end
end

function vRP.getFactionRankSalary(faction, rank)
	local ngroup = factions[faction]
	if ngroup then
		local factionRanks = ngroup.fRanks
		for i, v in pairs(factionRanks) do
			if (v.rank == rank)then
				return v.salary - 1
			end
		end
		return 0
	end
end

function vRP.getFactionSlots(faction)
	local ngroup = factions[faction]
	if ngroup then
		local factionSlots = ngroup.fSlots
		return factionSlots
	end
end

function vRP.getFactionType(faction)
	local ngroup = factions[faction]
	if ngroup then
		local factionType = ngroup.fType
		return tostring(factionType)
	end
end

function vRP.getFactionCoords(faction)
    local ngroup = factions[faction]
    if ngroup then
        local coords = ngroup.coords
        return coords
    end
end

function vRP.getFactionBlip(faction)
    local ngroup = factions[faction]
    if ngroup then
        local fBlip = ngroup.fBlip
        return fBlip
    end
end

function vRP.getFactionColor(faction)
    local ngroup = factions[faction]
    if ngroup then
        local fBlip = ngroup.color
        return fBlip
    end
end

function vRP.hasUserFaction(user_id)
	local tmp = vRP.getUserDataTable(user_id)
	if tmp then
		theFaction = tmp.fName
		if(theFaction == "user")then
			return false
		else
			return true
		end
	end
end

function vRP.isUserInFaction(user_id,group)
	local tmp = vRP.getUserDataTable(user_id)
	if tmp then
		theFaction = tmp.fName
		if(theFaction == group)then
			return true
		else
			return false
		end
	end
end

function vRP.setFactionLeader(user_id)
	local tmp = vRP.getUserDataTable(user_id)
	if tmp then
		tmp.fLeader = 1
		exports.oxmysql:query("UPDATE vrp_users SET isFactionLeader = @leader WHERE id = @user_id", {['@user_id'] = user_id, ['@leader'] = 1}, function()end)
	end
end

function vRP.setFactionNonLeader(user_id)
	local tmp = vRP.getUserDataTable(user_id)
	if tmp then
		tmp.fLeader = 0
		exports.oxmysql:query("UPDATE vrp_users SET isFactionLeader = @leader WHERE id = @user_id", {['@user_id'] = user_id, ['@leader'] = 0}, function()end)
	end
end

function vRP.setFactionCoLeader(user_id)
	local tmp = vRP.getUserDataTable(user_id)
	if tmp then
		tmp.fCoLeader = 1
		exports.oxmysql:query("UPDATE vrp_users SET isFactionCoLeader = @coleader WHERE id = @user_id", {['@user_id'] = user_id, ['@coleader'] = 1}, function()end)
	end
end

function vRP.setFactionNonCoLeader(user_id)
	local tmp = vRP.getUserDataTable(user_id)
	if tmp then
		tmp.fCoLeader = 0
		exports.oxmysql:query("UPDATE vrp_users SET isFactionCoLeader = @coleader WHERE id = @user_id", {['@user_id'] = user_id, ['@coleader'] = 0}, function()end)
	end
end

function vRP.isFactionLeader(user_id,group)
	local tmp = vRP.getUserDataTable(user_id)
	if tmp then
		theFaction = tmp.fName
		isLeader = tmp.fLeader
		if(theFaction == group) and (isLeader == 1)then
			return true
		else
			return false
		end
	end
end

function vRP.isFactionCoLeader(user_id,group)
	local tmp = vRP.getUserDataTable(user_id)
	if tmp then
		theFaction = tmp.fName
		isCoLeader = tmp.fCoLeader
		if(theFaction == group) and (isCoLeader == 1)then
			return true
		else
			return false
		end
	end
end

function vRP.getFactionRank(user_id)
	local tmp = vRP.getUserDataTable(user_id)
	if tmp then
		theRank = tmp.fRank
		return theRank
	end
end

function vRP.factionRankUp(user_id)
	local theFaction = vRP.getUserFaction(user_id)
	local actualRank = vRP.getFactionRank(user_id)
	local ranks = factions[theFaction].fRanks
	local tmp = vRP.getUserDataTable(user_id)
	local rankName = tmp.fRank
	for i, v in pairs(ranks) do
		rankTitle = v.rank
		if(rankTitle == rankName)then
			if(i == #ranks)then
				return false
			else
				local theRank = tostring(ranks[i+1].rank)
				tmp.fRank = theRank
				exports.oxmysql:query("UPDATE vrp_users SET factionRank = @rank WHERE id = @user_id", {['@user_id'] = user_id, ['@rank'] = theRank}, function()end)
				return true
			end
		end
	end
end

function vRP.factionRankDown(user_id)
	local theFaction = vRP.getUserFaction(user_id)
	local actualRank = vRP.getFactionRank(user_id)
	local ranks = factions[theFaction].fRanks
	local tmp = vRP.getUserDataTable(user_id)
	local rankName = tmp.fRank
	for i, v in pairs(ranks) do
		rankTitle = v.rank
		if(rankTitle == rankName)then
			if(i == 1)then
				return false
			else
				local theRank = tostring(ranks[i-1].rank)
				tmp.fRank = theRank
				exports.oxmysql:query("UPDATE vrp_users SET factionRank = @rank WHERE id = @user_id", {['@user_id'] = user_id, ['@rank'] = tostring(ranks[i-1])}, function()end)
				return true
			end
		end
	end
end

function vRP.addUserFaction(user_id,theGroup)
	local player = vRP.getUserSource(user_id)
	if(player)then
		local ngroup = factions[theGroup]
		if ngroup then
			local factionRank = ngroup.fRanks[1].rank
			local tmp = vRP.getUserDataTable(user_id)
			if tmp then
				tmp.fName = theGroup
				tmp.fRank = factionRank
				tmp.fLeader = 0
				tmp.fCoLeader = 0
				exports.oxmysql:query("UPDATE vrp_users SET faction = @group, factionRank = @rank WHERE id = @user_id", {['@user_id'] = user_id, ['@group'] = theGroup, ['@rank'] = factionRank}, function()end)
				exports.oxmysql:query("SELECT * FROM vrp_users WHERE id = @user_id", {['@user_id'] = user_id}, function (rows)
				thePlayer = rows[1]
				table.insert(factionMembers[theGroup], thePlayer)
				end)
			end
		end
		if(theGroup == "Politie" or theGroup == "SWAT")then
			TriggerClientEvent('utk_oh:IsCop', player)
			for _, freq in pairs(PolitieJandarmerieFreq) do
				TriggerClientEvent("rp-radio:GivePlayerAccessToFrequency", player, freq)
			end
		else
			TriggerClientEvent('utk_oh:IsNOTCop', player)
		end
		if(theGroup == "Smurd")then
			for _, freq in pairs(SmurdFreq) do
				TriggerClientEvent("rp-radio:GivePlayerAccessToFrequency", player, freq)
			end
		end
	end
end

function vRP.getUsersByFaction(group)
	return factionMembers[group] or {}
end

function vRP.getOnlineUsersByFaction(group)
	local oUsers = {}

	for k,v in pairs(vRP.rusers) do
		if vRP.isUserInFaction(tonumber(k), group) then table.insert(oUsers, tonumber(k)) end
	end

	return oUsers
end

-- return number of online members by faction callback
function tvRP.getOnlineUsersByFaction(group)
	local factionUsers = vRP.getOnlineUsersByFaction(group)
	return #factionUsers
end

-- return faction of user callback
function tvRP.getUserFaction()
	local thePlayer = source
	if thePlayer ~= nil then
		local user_id = vRP.getUserId(thePlayer)
		if user_id ~= nil then
			if(vRP.hasUserFaction(user_id))then
				local theFaction = vRP.getUserFaction(user_id)
				return theFaction
			else
				return "Civil"
			end
		end
	end
end

-- return if is user in a government faction callback
function tvRP.isUserInGovernmentFaction()
	local thePlayer = source
	if thePlayer ~= nil then
		local user_id = vRP.getUserId(source)
		if user_id ~= nil then
			if vRP.isUserInFaction(user_id,"Politie") or vRP.isUserInFaction(user_id,"SWAT") or vRP.isUserInFaction(user_id,"Smurd") then
				return true
			end
		end
	end
end

function vRP.removeUserFaction(user_id,theGroup)
	local player = vRP.getUserSource(user_id)
	if(player)then
		local tmp = vRP.getUserDataTable(user_id)
		if tmp then
			for i, v in pairs(factionMembers[theGroup])do
				if(v.id == user_id)then
					tmp.fName = "user"
					tmp.fRank = 'none'
					tmp.fLeader = 0
					tmp.fCoLeader = 0
					exports.oxmysql:query("UPDATE vrp_users SET faction = @group, factionRank = @rank, isFactionLeader = 0, isFactionCoLeader = 0 WHERE id = @user_id", {['@user_id'] = user_id, ['@group'] = "user", ['@rank'] = "none"}, function()end)
					table.remove(factionMembers[theGroup], i)
				end
			end
		end
		if(theGroup == "Politie" or theGroup == "SWAT")then
			TriggerClientEvent('utk_oh:IsCop', player)
			for _, freq in pairs(PolitieJandarmerieFreq) do
				TriggerClientEvent("rp-radio:GivePlayerAccessToFrequency", player, freq)
			end
		else
			TriggerClientEvent('utk_oh:IsNOTCop', player)
		end
		if(theGroup == "Smurd")then
			for _, freq in pairs(SmurdFreq) do
				TriggerClientEvent("rp-radio:GivePlayerAccessToFrequency", player, freq)
			end
		end
	else
		for i, v in pairs(factionMembers[theGroup])do
			if(v.id == user_id)then
				table.remove(factionMembers[theGroup], i)
				exports.oxmysql:query("UPDATE vrp_users SET faction = @group, factionRank = @rank, isFactionLeader = 0, isFactionCoLeader = 0 WHERE id = @user_id", {['@user_id'] = user_id, ['@group'] = "user", ['@rank'] = "none"}, function()end)
			end
		end
	end
end

function vRP.removeFactionFromUserFully(user_id,faction)
	local theFaction = ""
	if faction ~= nil then
		theFaction = tostring(faction)
	else
		theFaction = vRP.getUserFaction(user_id)
	end
	if(theFaction ~= "user")then
		vRP.removeUserFaction(user_id,theFaction)
		if(vRP.hasGroup(user_id,"onduty"))then
			vRP.removeUserGroup(user_id,"onduty")
		end
	end
	if(theFaction == "Politie" or theFaction == "SWAT" or theFaction == "Smurd")then
		vRP.setCustomizationDefault(user_id)
	end
	--vRP.sendToDiscord("RemoveFaction","REMOVE FACTION SYSTEM","Jucatorul "..vRP.getPlayerName(vRP.getUserSource(user_id)).." a fost scos din factiunea "..faction)
end

-- FACTION MENU
local function ch_leaveGroup(player,choice)
	local user_id = vRP.getUserId(player)
	local theFaction = vRP.getUserFaction(user_id)
	if user_id ~= nil then
		vRPclient.notify(player,{"Ai parasit factiunea ~r~"..theFaction.."!"})
		vRP.removeFactionFromUserFully(user_id,theFaction)
		vRP.openMainMenu(player)
	end
end

local function ch_offduty(player,choice)
	local user_id = vRP.getUserId(player)
	local theFaction = vRP.getUserFaction(user_id)
	if user_id ~= nil then
		if(vRP.hasUserFaction(user_id))then
			vRPclient.notify(player,{"~w~Te-ai Pus ~r~OFF ~w~Duty In Factiunea ~b~"..theFaction.."!"})
			if(vRP.hasGroup(user_id,"onduty"))then
				vRP.removeUserGroup(user_id,"onduty")
			end
			TriggerClientEvent("chatMessage", -1, "[^6Realism^0] ^1["..user_id.."] "..vRP.getPlayerName(player).."^0 S-a Pus ^1OFF ^0Duty In Factiunea ^3"..theFaction)
		end
		vRP.openMainMenu(player)
	end
end

local function ch_onduty(player,choice)
	local user_id = vRP.getUserId(player)
	local theFaction = vRP.getUserFaction(user_id)
	if user_id ~= nil then
		if(vRP.hasUserFaction(user_id))then
			vRPclient.notify(player,{"~w~Te-ai Pus ~g~ON ~w~Duty In Factiunea ~b~"..theFaction.."!"})
			vRP.addUserGroup(user_id,"onduty")
			TriggerClientEvent("chatMessage", -1, "[^6Realism^0] ^1["..user_id.."] "..vRP.getPlayerName(player).."^0 S-a Pus ^2ON ^0Duty In Factiunea ^3"..theFaction)
		end
		vRP.openMainMenu(player)
	end
end

local function ch_inviteFaction(player,choice)
	local user_id = vRP.getUserId(player)
	local theFaction = vRP.getUserFaction(user_id)
	local members = vRP.getUsersByFaction(theFaction)
	local fSlots = factions[theFaction].fSlots
	if user_id ~= nil and vRP.isFactionLeader(user_id,theFaction) or vRP.isFactionCoLeader(user_id,theFaction) then
		vRP.prompt(player,"Jucator ID: ","",function(player,id)
			id = parseInt(id)
			if(tonumber(id)) and (id > 0) and (id ~= "") and (id ~= nil)then
				if(tonumber(#members) < tonumber(fSlots))then
					local target = vRP.getUserSource(id)
					if(target)then
						if(vRP.hasUserFaction(id))then
							vRPclient.notify(player,{"~r~"..vRP.getPlayerName(target).." este deja intr-o factiune!"})
							return
						else
							vRPclient.notify(player,{"~w~L-ai adaugat pe ~g~"..vRP.getPlayerName(target).." ~w~in ~g~"..theFaction.."!"})
							vRPclient.notify(target,{"~w~Ai fost adaugat in ~g~"..theFaction.."!"})
							vRP.addUserFaction(id,theFaction)
							vRP.addUserGroup(id,"onduty")
						end
					else
						vRPclient.notify(player,{"~r~Nu s-a gasit nici un jucator online cu ID-ul "..id.."!"})
					end
				else
					vRPclient.notify(player,{"~r~Maximul de jucatori in factiune a fost atins! Sloturi: "..fSlots})
				end
			else
				vRPclient.notify(player,{"~r~Acest ID este invalid"})
			end
		end)
	end
end

local function ch_excludeFaction(player,choice)
	local user_id = vRP.getUserId(player)
	local theFaction = vRP.getUserFaction(user_id)
	if user_id ~= nil and vRP.isFactionLeader(user_id,theFaction) or vRP.isFactionCoLeader(user_id,theFaction) then
		vRP.prompt(player,"Jucator ID: ","",function(player,id)
			id = parseInt(id)
			if(tonumber(id)) and (id > 0) and (id ~= "") and (id ~= nil)then
				local target = vRP.getUserSource(id)
				if(target)then
					vRPclient.notify(player,{"~w~L-ai scos pe ~g~"..vRP.getPlayerName(target).." ~w~din ~g~"..theFaction.."~w~!"})
					vRPclient.notify(target,{"~w~Ai fost scos din ~g~"..theFaction.."!"})
				else
					vRPclient.notify(player,{"~w~L-ai scos pe ID ~g~"..id.." ~w~din ~g~"..theFaction.."~w~!"})
				end
				vRP.removeFactionFromUserFully(id,theFaction)
			else
				vRPclient.notify(player,{"~r~Acest ID este invalid"})
			end
		end)
	end
end

local function ch_promoteLeader(player,choice)
	local user_id = vRP.getUserId(player)
	local theFaction = vRP.getUserFaction(user_id)
	if user_id ~= nil and vRP.isFactionLeader(user_id,theFaction) then
		vRP.prompt(player,"Jucator ID: ","",function(player,id)
			id = parseInt(id)
			if(tonumber(id)) and (id > 0) and (id ~= "") and (id ~= nil)then
				local target = vRP.getUserSource(id)
				if(target)then
					if(vRP.isUserInFaction(id,theFaction))then
						if(vRP.isFactionLeader(id,theFaction))then
							vRPclient.notify(player,{"~w~L-ai retrogradat pe ~g~"..vRP.getPlayerName(target).." ~w~la ~g~Membru!"})
							vRPclient.notify(target,{"~w~Ai fost retrogradat la ~g~Membru ~w~in factiunea ~g~"..theFaction.."!"})
							vRP.setFactionNonLeader(id)
							Wait(450)
							vRP.openMainMenu(player)
						else
							vRPclient.notify(player,{"~w~L-ai promovat pe ~g~"..vRP.getPlayerName(target).." ~w~la ~g~Lider!"})
							vRPclient.notify(player,{"~w~Functia Lider ti s-a fost scoasa ~g~pentru ca ai dat Liderul Altcuiva!"})
							vRPclient.notify(target,{"~w~Ai fost promovat la ~g~Lider ~w~in factiunea ~g~"..theFaction.."!"})
							vRP.setFactionLeader(id)
							vRP.setFactionNonLeader(user_id)
							Wait(450)
							vRP.openMainMenu(player)
						end
					else
						vRPclient.notify(player,{"~w~Jucatorul ~g~"..vRP.getPlayerName(target).." ~w~nu este membru in factiunea ~g~"..theFaction.."!"})
					end
				else
					vRPclient.notify(player,{"~r~Nu s-a gasit nici un jucator online cu ID-ul "..id.."!"})
				end
			else
				vRPclient.notify(player,{"~r~Acest ID este invalid"})
			end
		end)
	end
end

local function ch_promoteCoLeader(player,choice)
	local user_id = vRP.getUserId(player)
	local theFaction = vRP.getUserFaction(user_id)
	if user_id ~= nil and vRP.isFactionCoLeader(user_id,theFaction) then
		vRP.prompt(player,"Jucator ID: ","",function(player,id)
			id = parseInt(id)
			if(tonumber(id)) and (id > 0) and (id ~= "") and (id ~= nil)then
				local target = vRP.getUserSource(id)
				if(target)then
					if(vRP.isUserInFaction(id,theFaction))then
						if(vRP.isFactionCoLeader(id,theFaction))then
							vRPclient.notify(player,{"~w~L-ai retrogradat pe ~g~"..vRP.getPlayerName(target).." ~w~la ~g~Membru!"})
							vRPclient.notify(target,{"~w~Ai fost retrogradat la ~g~Membru ~w~in factiunea ~g~"..theFaction.."!"})
							vRP.setFactionNonCoLeader(id)
							Wait(450)
							vRP.openMainMenu(player)
						else
							vRPclient.notify(player,{"~w~L-ai promovat pe ~g~"..vRP.getPlayerName(target).." ~w~la ~g~Co-Lider!"})
							vRPclient.notify(player,{"~w~Functia Co-Lider ti s-a fost scoasa ~g~pentru ca ai dat Co-Liderul Altcuiva!"})
							vRPclient.notify(target,{"~w~Ai fost promovat la ~g~Co-Lider ~w~in factiunea ~g~"..theFaction.."!"})
							vRP.setFactionCoLeader(id)
							vRP.setFactionNonCoLeader(user_id)
							Wait(450)
							vRP.openMainMenu(player)
						end
					else
						vRPclient.notify(player,{"~w~Jucatorul ~g~"..vRP.getPlayerName(target).." ~w~nu este membru in factiunea ~g~"..theFaction.."!"})
					end
				else
					vRPclient.notify(player,{"~r~Nu s-a gasit nici un jucator online cu ID-ul "..id.."!"})
				end
			else
				vRPclient.notify(player,{"~r~Acest ID este invalid"})
			end
		end)
	end
end

local function ch_promoteMember(player,choice)
	local user_id = vRP.getUserId(player)
	local theFaction = vRP.getUserFaction(user_id)
	if user_id ~= nil and vRP.isFactionLeader(user_id,theFaction) then
		vRP.prompt(player,"Jucator ID: ","",function(player,id)
			id = parseInt(id)
			if(tonumber(id)) and (id > 0) and (id ~= "") and (id ~= nil)then
				local target = vRP.getUserSource(id)
				if(target)then
					if(vRP.isUserInFaction(id,theFaction))then
						local oldRank = vRP.getFactionRank(id)
						if(vRP.factionRankUp(id))then
							SetTimeout(1000, function()
								local newRank = vRP.getFactionRank(id)
								vRPclient.notify(player,{"~w~L-ai promovat pe ~g~"..vRP.getPlayerName(target).." ~w~ de la ~r~"..oldRank.." ~w~la ~g~"..newRank.."!"})
								vRPclient.notify(target,{"~w~Ai fost promovat de la ~r~"..oldRank.." ~w~la ~g~"..newRank.." ~w~in factiunea ~g~"..theFaction.."!"})
							end)
						else
							vRPclient.notify(player,{"~g~"..vRP.getPlayerName(target).." ~w~are deja cel mai mare rank!"})
						end
					else
						vRPclient.notify(player,{"~w~Jucatorul ~g~"..vRP.getPlayerName(target).." ~w~nu este membru in factiunea ~g~"..theFaction.."!"})
					end
				else
					vRPclient.notify(player,{"~r~Nu s-a gasit nici un jucator online cu ID-ul "..id.."!"})
				end
			else
				vRPclient.notify(player,{"~r~Acest ID este invalid"})
			end
		end)
	end
end

local function ch_demoteMember(player,choice)
	local user_id = vRP.getUserId(player)
	local theFaction = vRP.getUserFaction(user_id)
	if user_id ~= nil and vRP.isFactionLeader(user_id,theFaction) then
		vRP.prompt(player,"Jucator ID: ","",function(player,id)
			id = parseInt(id)
			if(tonumber(id)) and (id > 0) and (id ~= "") and (id ~= nil)then
				local target = vRP.getUserSource(id)
				if(target)then
					if(vRP.isUserInFaction(id,theFaction))then
						local oldRank = vRP.getFactionRank(id)
						if(vRP.factionRankDown(id))then
							SetTimeout(1000, function()
								local newRank = vRP.getFactionRank(id)
								vRPclient.notify(player,{"~w~L-ai retrogradat pe ~g~"..vRP.getPlayerName(target).." ~w~ de la ~r~"..oldRank.." ~w~la ~g~"..newRank.."!"})
								vRPclient.notify(target,{"~w~Ai fost retrogradat la ~r~"..oldRank.." ~w~la ~g~"..newRank.." ~w~in factiunea ~g~"..theFaction.."!"})
							end)
						else
							vRPclient.notify(player,{"~g~"..vRP.getPlayerName(target).." ~w~are deja cel mai mic rank!"})
						end
					else
						vRPclient.notify(player,{"~w~Jucatorul ~g~"..vRP.getPlayerName(target).." ~w~nu este membru in factiunea ~g~"..theFaction.."!"})
					end
				else
					vRPclient.notify(player,{"~r~Nu s-a gasit nici un jucator online cu ID-ul "..id.."!"})
				end
			else
				vRPclient.notify(player,{"~r~Acest ID este invalid"})
			end
		end)
	end
end

local function ch_memberList(player,choice)
	return true
end

local function ch_membersList(player,choice)
	vRP.openMainMenu(player)
	SetTimeout(1000, function()
		vRP.buildMenu("Lista Membrii", {player = player}, function(menu2)
			menu2.name = "Lista Membrii"
			menu2.css={top="75px",header_color="rgba(200,0,0,0.75)"}
			menu2.onclose = function(player) vRP.openMainMenu(player) end
			local user_id = vRP.getUserId(player)
			local theFaction = vRP.getUserFaction(user_id)
			local members = vRP.getUsersByFaction(theFaction)
			for i, v in pairs(members) do
				if(v.isFactionLeader == 1)then
					isMLeader = "Lider"
				elseif(v.isFactionCoLeader == 1)then
					isMLeader = "Co-Lider"
				else
					isMLeader = "Membru"
				end
				local userID = v.id
				local rank = v.factionRank
				local lLogin = v.last_login
				lastLogin = {}
				for lasLogin in lLogin:gmatch("%S+") do
				   table.insert(lastLogin, lasLogin)
				end
				menu2[v.username] = {ch_memberList, "ID: <font color='green'>"..userID.."</font><br/>Rank: <font color='green'>"..rank.."</font><br/>Statut: <font color='green'>"..isMLeader.."</font><br/>Ultima Logare: <font color='red'>"..lastLogin[3].."</font>"}
			end
			vRP.openMenu(player,menu2)
		end)
	end)
end

local function ch_laveFaction(player,choice)
	vRP.openMainMenu(player)
	SetTimeout(500, function()
		vRP.buildMenu("Esti sigur?", {player = player}, function(menu1)
			menu1.name = "Esti sigur?"
			menu1.css={top="75px",header_color="rgba(200,0,0,0.75)"}
			menu1.onclose = function(player) vRP.openMainMenu(player) end
			menu1["Da"] = {ch_leaveGroup, "Paraseste factiunea"}
			menu1["Nu"] = {function(player) vRP.openMainMenu(player) end}
			vRP.openMenu(player,menu1)
		end)
	end)
end

local function ch_Off_Duty(player,choice)
	vRP.openMainMenu(player)
	SetTimeout(500, function()
		vRP.buildMenu("Esti sigur?", {player = player}, function(menu1)
			menu1.name = "Esti sigur?"
			menu1.css={top="75px",header_color="rgba(200,0,0,0.75)"}
			menu1.onclose = function(player) vRP.openMainMenu(player) end
			menu1["Da"] = {ch_offduty, "Punete Off Duty"}
			menu1["Nu"] = {function(player) vRP.openMainMenu(player) end}
			vRP.openMenu(player,menu1)
		end)
	end)
end

local function ch_On_Duty(player,choice)
	vRP.openMainMenu(player)
	SetTimeout(500, function()
		vRP.buildMenu("Esti sigur?", {player = player}, function(menu1)
			menu1.name = "Esti sigur?"
			menu1.css={top="75px",header_color="rgba(200,0,0,0.75)"}
			menu1.onclose = function(player) vRP.openMainMenu(player) end
			menu1["Da"] = {ch_onduty, "Punete On Duty"}
			menu1["Nu"] = {function(player) vRP.openMainMenu(player) end}
			vRP.openMenu(player,menu1)
		end)
	end)
end

local function ch_dummySalary(player,choice)
	return false
end

local function ch_ranksAndSalary(player,choice)
	vRP.openMainMenu(player)
	local user_id = vRP.getUserId(player)
	local theFaction = vRP.getUserFaction(user_id)
	local ranks = vRP.getFactionRanks(theFaction)
	SetTimeout(500, function()
		vRP.buildMenu("Rankuri & Salarii", {player = player}, function(rsMenu)
			rsMenu.name = "Rankuri & Salarii"
			rsMenu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
			rsMenu.onclose = function(player) vRP.openMainMenu(player) end
			for i, v in pairs(ranks) do
				facRank = v.rank
				local salary = vRP.getFactionRankSalary(theFaction, facRank)
				rsMenu["["..i.."] "..facRank] = {ch_dummySalary, "Salariu: <font color='green'>$"..salary.."</font>"}
			end
			vRP.openMenu(player,rsMenu)
		end)
	end)
end

vRP.registerMenuBuilder("main", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id ~= nil then
		local choices = {}
		local tmp = vRP.getUserDataTable(user_id)
		if tmp then
			if(vRP.hasUserFaction(user_id))then
				local theFaction = vRP.getUserFaction(user_id)
				local rank = vRP.getFactionRank(user_id)
				local leader = vRP.isFactionLeader(user_id,theFaction)
				local coleader = vRP.isFactionCoLeader(user_id,theFaction)
				local members = vRP.getUsersByFaction(theFaction)
				local fType = vRP.getFactionType(theFaction)
				local fSlots = vRP.getFactionSlots(theFaction)
				local salary = vRP.getFactionRankSalary(theFaction, rank) or 0
				if(leader)then
					isLeader = "Lider"
				elseif(coleader)then
					isLeader = "Co-Lider"
				else
					isLeader = "Membru"
				end
				if(vRP.hasGroup(user_id,"onduty"))then
					Duty = "ON"
				else
					Duty = "OFF"
				end
				if(salary > 0)then
					if(#members == fSlots)then
						infoText = "Nume: <font color='red'>"..theFaction.."</font><br/>Membrii: <font color='red'>"..#members.."</font>/<font color='red'>"..fSlots.."</font><br/>Tip: <font color='green'>"..fType.."</font><br/>Rank: <font color='green'>"..rank.."</font><br/>Duty: <font color='green'>"..Duty.."</font><br/>Salariu: <font color='yellow'>$"..salary.."</font><br/>Statut: <font color='green'>"..isLeader.."</font>"
					else
						infoText = "Nume: <font color='red'>"..theFaction.."</font><br/>Membrii: <font color='green'>"..#members.."</font>/<font color='red'>"..fSlots.."</font><br/>Tip: <font color='green'>"..fType.."</font><br/>Rank: <font color='green'>"..rank.."</font><br/>Duty: <font color='green'>"..Duty.."</font><br/>Salariu: <font color='yellow'>$"..salary.."</font><br/>Statut: <font color='green'>"..isLeader.."</font>"
					end
				else
					if(#members == fSlots)then
						infoText = "Nume: <font color='red'>"..theFaction.."</font><br/>Membrii: <font color='red'>"..#members.."</font>/<font color='red'>"..fSlots.."</font><br/>Tip: <font color='green'>"..fType.."</font><br/>Rank: <font color='green'>"..rank.."</font><br/>Statut: <font color='green'>"..isLeader.."</font>"
					else
						infoText = "Nume: <font color='red'>"..theFaction.."</font><br/>Membrii: <font color='green'>"..#members.."</font>/<font color='red'>"..fSlots.."</font><br/>Tip: <font color='green'>"..fType.."</font><br/>Rank: <font color='green'>"..rank.."</font><br/>Statut: <font color='green'>"..isLeader.."</font>"	
					end
				end
				choices["Meniu Factiune"] = {function(player,choice)
					vRP.buildMenu(theFaction, {player = player}, function(menu)
						menu.name = theFaction
						menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
						menu.onclose = function(player) vRP.openMainMenu(player) end -- nest menu
						if(leader or coleader)then
							menu["Invita Membru"] = {ch_inviteFaction, "Invita membru in factiune"}
							menu["Exclude Membru"] = {ch_excludeFaction, "Exclude membru din factiune"}
						end
						if(leader)then
							menu["Promoveaza Lider"] = {ch_promoteLeader, "Promoveaza/Retrogradeaza membru la Lider/Membru"}
							menu["Promoveaza Membru"] = {ch_promoteMember, "Promoveaza membru la un rank mai mare"}
							menu["Retrogradeaza Membru"] = {ch_demoteMember, "Retrogradeaza membru la un rank mai mic"}
						end
						if(coleader)then
							menu["Promoveaza Co-Lider"] = {ch_promoteCoLeader, "Promoveaza/Retrogradeaza membru la Co-Lider/Membru"}
						end
						if(fType == "Lege")then
							if(vRP.hasGroup(user_id,"onduty"))then
								menu["Punete Off Duty"] = {ch_Off_Duty, "Punete Off Duty In Factiunea "..theFaction}
							else
								menu["Punete On Duty"] = {ch_On_Duty, "Punete On Duty In Factiunea "..theFaction}
							end
						end
						menu["Lista Membrii"] = {ch_membersList, "Lista membrii "..theFaction}
						menu["Rankuri & Salarii"] = {ch_ranksAndSalary, "Rankuri si Salarii"}
						menu["Paraseste Factiunea"] = {ch_laveFaction, "Paraseste factiunea "..theFaction}
						vRP.openMenu(player,menu)
					end)
				end, infoText}
			end
		end
		add(choices)
	end
end)

AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
	local tmp = vRP.getUserDataTable(user_id)
	if tmp then
		local rows = exports.oxmysql:querySync("SELECT faction, isFactionLeader, isFactionCoLeader, factionRank FROM vrp_users WHERE id = @user_id", {['@user_id'] = user_id})
		theFaction = tostring(rows[1].faction)
		isLeader = tonumber(rows[1].isFactionLeader)
		isCoLeader = tonumber(rows[1].isFactionCoLeader)
		factionRank = tostring(rows[1].factionRank)
		tmp.fName = theFaction
		tmp.fRank = factionRank
		tmp.fLeader = isLeader
		tmp.fCoLeader = isCoLeader
	end
end)

local function ch_addfaction(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"Jucator ID: ","",function(player,id)
			id = parseInt(id)
			if(tonumber(id)) and (id > 0) and (id ~= "") and (id ~= nil)then
				local theTarget = vRP.getUserSource(id)
				if(theTarget)then
					vRP.prompt(player,"Factiune: ","",function(player,group)
						group = tostring(group)
						if(group ~= "") and (group ~= nil)then
							vRP.prompt(player,"Lider(1), Co-Lider(2), Membru(0): ","",function(player,lider)
								lider = parseInt(lider)
								if(tonumber(lider)) and (lider == 0 or lider == 1 or lider == 2) and (lider ~= "") and (lider ~= nil)then
									if(lider == 1) then
										vRP.addUserFaction(id,group)
										vRP.addUserGroup(id,"onduty")
										Citizen.Wait(500)
										vRP.setFactionLeader(id)
										vRPclient.notify(player,{"Jucatorul "..vRP.getPlayerName(theTarget).." a fost adaugat ca Lider in factiunea "..group})
									elseif(lider == 2) then
										vRP.addUserFaction(id,group)
										vRP.addUserGroup(id,"onduty")
										Citizen.Wait(500)
										vRP.setFactionCoLeader(id)
										vRPclient.notify(player,{"Jucatorul "..vRP.getPlayerName(theTarget).." a fost adaugat ca Co-Lider in factiunea "..group})
									else
										vRP.addUserFaction(id,group)
										vRP.addUserGroup(id,"onduty")
										vRPclient.notify(player,{"Jucatorul "..vRP.getPlayerName(theTarget).." a fost adaugat in factiunea "..group})
									end
								--	vRP.sendToDiscord("AddFaction","ADD FACTION SYSTEM","Jucatorul "..vRP.getPlayerName(theTarget).." a fost adaugat in factiunea "..group)
								else
									vRPclient.notify(player,{"~r~Trebuie sa pui 1 sau 0 pentru a alege daca este Lider sau Nu!"})
								end
							end)
						else
							vRPclient.notify(player,{"~r~Factiunea pe care ai pus-o este invalida!"})
						end
					end)
				else
					vRPclient.notify(player,{"~r~Nu s-a gasit nici un jucator online cu ID-ul "..id.."!"})
				end
			else
				vRPclient.notify(player,{"~r~Acest ID este invalid"})
			end
		end)
	end
end

local function ch_removefaction(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"Jucator ID: ","",function(player,id)
			id = parseInt(id)
			if(tonumber(id)) and (id > 0) and (id ~= "") and (id ~= nil)then
				local theTarget = vRP.getUserSource(id)
				if theTarget == player then
					local rows = exports.oxmysql:querySync("SELECT faction FROM vrp_users WHERE id = @user_id", {['@user_id'] = id})
					if #rows > 0 then
						local faction = rows[1].faction
						if faction ~= "user" then
							vRP.removeFactionFromUserFully(id,faction)
							vRPclient.notify(player,{faction.." scos lui ID "..id})
							
						end
					end					
				else
					local theFaction = vRP.getUserFaction(id)
					if(theFaction == "user")then
						vRPclient.notify(player,{"Jucatorul cu ID-ul "..id.." nu este intr-o factiune"})
					else
						vRP.removeFactionFromUserFully(id,theFaction)
						vRPclient.notify(player,{theFaction.." scos lui "..vRP.getPlayerName(theTarget)})
					end
				end
			else
				vRPclient.notify(player,{"~r~Acest ID este invalid"})
			end
		end)
	end
end

local function ch_factionleader(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"Jucator ID: ","",function(player,id)
			id = parseInt(id)
			if(tonumber(id)) and (id > 0) and (id ~= "") and (id ~= nil)then
				local theTarget = vRP.getUserSource(id)
				if(theTarget)then
					vRP.prompt(player,"Lider(1), Co-Lider(2): ","",function(player,lider)
						lider = parseInt(lider)
						if(tonumber(lider)) and (lider == 1 or lider == 2) and (lider ~= "") and (lider ~= nil)then
							local theFaction = vRP.getUserFaction(id)
							if(theFaction == "user")then
								vRPclient.notify(player,{vRP.getPlayerName(theTarget).." nu este in nici o factiune!"})
							else
								if(lider == 1) then
									vRP.setFactionLeader(id)
									vRPclient.notify(player,{vRP.getPlayerName(theTarget).." a fost adaugat ca Lider in factiunea "..theFaction})
								else
									vRP.setFactionCoLeader(id)
									vRPclient.notify(player,{vRP.getPlayerName(theTarget).." a fost adaugat ca, CoLider in factiunea "..theFaction})
								end
							end
						else
							vRPclient.notify(player,{"~r~Trebuie sa pui 1 sau 0 pentru a alege daca este Lider/Co-Lider sau Nu!"})
						end
					end)
				else
					vRPclient.notify(player,{"~r~Nu s-a gasit nici un jucator online cu ID-ul "..id.."!"})
				end
			else
				vRPclient.notify(player,{"~r~Acest ID este invalid"})
			end
		end)
	end
end

vRP.registerMenuBuilder("admin", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id ~= nil then
		local choices = {}
			if vRP.isUserSuperAdministrator(user_id) then
				choices["Add Faction Co/Leader"] = {ch_factionleader, "Adauga/Scoate Lider/Co-Lider Unui Jucator Drintr-o Factiune"}
			end
			if vRP.isUserAdministrator(user_id) then
				choices["Add Faction"] = {ch_addfaction, "Adauga Un Jucator In Factiune"}
				choices["Remove Faction"] = {ch_removefaction, "Scoate Un Jucator Din Factiune"}
			end
		add(choices)
	end
end)

RegisterCommand('f', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if(vRP.hasUserFaction(user_id))then
		local theFaction = vRP.getUserFaction(user_id)
		if(args[1] == nil)then
			TriggerClientEvent('chatMessage', source, "^3SYNTAXA: /"..rawCommand.." [Mesaj]") 
		else
			local fMembers = vRP.getOnlineUsersByFaction(tostring(theFaction))
			for i, v in ipairs(fMembers) do
				local player = vRP.getUserSource(tonumber(v))
				TriggerClientEvent('chatMessage', player, "^5["..theFaction.."] ^7| " .. GetPlayerName(source) .. ": " ..  rawCommand:sub(3))
			end
		end
	end
end)