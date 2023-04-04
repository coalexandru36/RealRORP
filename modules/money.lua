local lang = vRP.lang
local cfg = module("cfg/money")

local playerMoney = {}

function vRP.setDiamante(user_id,value)

	if(playerMoney[user_id])then
		playerMoney[user_id].Diamante = value
	end
	exports["oxmysql"]:query("UPDATE vrp_users SET Diamante = @Diamante WHERE id = @user_id", {Diamante = value, user_id = user_id}, function()end)

	local source = vRP.getUserSource(user_id)
	if source ~= nil then
		-- vRPclient.setDivContent(source,{"Diamante",lang.money.Diamante({vRP.formatMoney(value)})})
		--TriggerClientEvent('utdHud:getInfo',source,'gift',value)
	end
end

function vRP.getDiamante(user_id)
	if(playerMoney[user_id])then
		return playerMoney[user_id].Diamante
	else
		return 0
	end
end

function vRP.takeDiamante(user_id,amount)
	local coins = vRP.getDiamante(user_id)
	local sallmane = coins - amount
	vRP.setDiamante(user_id,sallmane)
--	vRPclient.arataTranzactie(vRP.getUserSource(user_id), {"minus", amount})
end

function vRP.tryPaymentDiamante(user_id,amount)
	local Diamante = vRP.getDiamante(user_id)
	if (Diamante >= amount) and (amount >= 0) then
	  vRP.setDiamante(user_id,Diamante-amount)
	--  vRPclient.arataTranzactie(vRP.getUserSource(user_id), {"minus", amount})
	  return true
	else
	  return false
	end
end

function vRP.giveDiamante(user_id,amount)
	local Diamante = vRP.getDiamante(user_id)
	vRP.setDiamante(user_id,Diamante+amount)
--	vRPclient.arataTranzactie(vRP.getUserSource(user_id), {"plus", amount})
  end


-- function vRP.getDiamante(user_id)
-- 	if(playerMoney[user_id])then
-- 		return playerMoney[user_id].diamante
-- 	else
-- 		return 0
-- 	end
-- end

-- function vRP.setDiamante(user_id,value)
-- 	if(tonumber(value) >= 0)then
-- 		if(playerMoney[user_id])then
-- 			playerMoney[user_id].diamante = value
-- 		end
-- 		exports["oxmysql"]:query("UPDATE vrp_users SET diamante = @diamante WHERE id = @user_id", {diamante = value, user_id = user_id}, function()end)
		
-- 	end

-- 	-- update client display
-- 	local source = vRP.getUserSource(user_id)
-- 	if source ~= nil then
-- 	--	TriggerClientEvent('utdHud:client:updatecash', source, vRP["formatMoney"](value))
-- 	end
-- end

-- function vRP.tryPaymentDiamante(user_id,amount)
-- 	local diamante = vRP.getDiamante(user_id)
-- 	if (diamante >= amount) and (amount >= 0) then
-- 		vRP.setDiamante(user_id,diamante-amount)
-- 		return true
-- 	else
-- 		return false
-- 	end
-- end

-- function vRP.giveDiamante(user_id,amount)
--   local diamante = vRP.getDiamante(user_id)
--   vRP.setDiamante(user_id,diamante+amount)
-- end

-----------------------------------------------------
function vRP.getMoney(user_id)
	if(playerMoney[user_id])then
		return playerMoney[user_id].wallet
	else
		return 0
	end
end

function vRP.setMoney(user_id,value)
	if(tonumber(value) >= 0)then
		if(playerMoney[user_id])then
			playerMoney[user_id].wallet = value
		end
		exports["oxmysql"]:query("UPDATE vrp_users SET walletMoney = @wallet WHERE id = @user_id", {wallet = value, user_id = user_id}, function()end)
		
	end

	-- update client display
	local source = vRP.getUserSource(user_id)
	if source ~= nil then
		TriggerClientEvent('utdHud:client:updatecash', source, vRP["formatMoney"](value))
	end
end

function vRP.tryBankPayment(user_id, amount)
	local money = vRP.getBankMoney(user_id)
	if (money >= amount) and (amount >= 0) then 
		vRP.setBankMoney(user_id,money-amount)
		return true 
	else 
		return false 
	end
end

function vRP.tryPayment(user_id,amount)
	local money = vRP.getMoney(user_id)
	if (money >= amount) and (amount >= 0) then
		vRP.setMoney(user_id,money-amount)
		return true
	else
		return false
	end
end

function vRP.giveMoney(user_id,amount)
  local money = vRP.getMoney(user_id)
  vRP.setMoney(user_id,money+amount)
end

---- BANK MONEY

function vRP.getBankMoney(user_id)
	if(playerMoney[user_id])then
		return playerMoney[user_id].bank
	else
		return 0
	end
end


function vRP.givebankMoney(user_id,amount)
	local money = vRP.getBankMoney(user_id)
	local newAmount = money + amount
	vRP.setBankMoney(user_id,newAmount)
end

function vRP.setBankMoney(user_id,value)
	if(playerMoney[user_id])then
		playerMoney[user_id].bank = value
	end
	exports["oxmysql"]:query("UPDATE vrp_users SET bankMoney = @bank WHERE id = @user_id", {bank = value, user_id = user_id}, function()end)
	
	-- update client display
	local source = vRP.getUserSource(user_id)
	if source ~= nil then
		-- TriggerClientEvent('utdHud:getInfo',source,'bank',value)
		TriggerClientEvent('utdHud:client:updatebank', source, vRP["formatMoney"](value))
	end
end

function vRP.tryWithdraw(user_id,amount)
	local money = vRP.getBankMoney(user_id)
	if amount > 0 and money >= amount then
		vRP.setBankMoney(user_id,money-amount)
		vRP.giveMoney(user_id,amount)
		return true
	else
		return false
	end
end

function vRP.tryDeposit(user_id,amount)
	if amount > 0 and vRP.tryPayment(user_id,amount) then
		vRP.givebankMoney(user_id,amount)
		return true
	else
		return false
	end
end

function vRP.tryFullPayment(user_id,amount)
	if (tonumber(amount)) and (amount >= 0)then
		local money = vRP.getMoney(user_id)
		if money >= amount then 
			return vRP.tryPayment(user_id, amount)
		else 
			if vRP.tryWithdraw(user_id, amount-money) then 
				return vRP.tryPayment(user_id, amount)
			end
		end
	end
	return false
end

function vRP.takeMoney(user_id,amount)
	local money = vRP.getMoney(user_id)
	local newAmount = money - amount
	vRP.setMoney(user_id,newAmount)
end


----PLAYER JOIN SI ALTELE

AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
	local rows = exports['oxmysql']:executeSync("SELECT bankMoney, walletMoney, Diamante FROM vrp_users WHERE id = @user_id", {user_id = user_id})
	if #rows > 0 then
		playerMoney[user_id] = {bank = rows[1].bankMoney, wallet = rows[1].walletMoney, Diamante = rows[1].Diamante}
	end
end)

AddEventHandler("vRP:playerLeave",function(user_id,source)
	playerMoney[user_id] = nil
end)

vRP.registerMenuBuilder("main", function(add, data)
  local user_id = vRP.getUserId(data.player)
  if user_id ~= nil then
    local choices = {}

    -- build admin menu
    choices["Jucator"] = {function(player,choice)
      vRP.buildMenu("jucator", {player = player}, function(menu)
        menu.name = "Jucator"
        menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
        menu.onclose = function(player) vRP.closeMenu(player) end -- nest menu

        vRP.openMenu(player,menu)
      end)
    end}

    add(choices)
  end
end)


local function ch_give(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
      if nplayer ~= nil then
        local nuser_id = vRP.getUserId(nplayer)
        if nuser_id ~= nil then
          vRP.prompt(player,lang.money.give.prompt(),"",function(player,amount)
            local amount = parseInt(amount)
            if amount > 0 and vRP.tryPayment(user_id,amount) then
              vRP.giveMoney(nuser_id,amount)
              vRPclient.notify(player,{lang.money.given({amount})})
              vRPclient.notify(nplayer,{lang.money.received({amount})})
			  local embed = {
				{
				  ["color"] = 0xcf0000,
				  ["description"] = "**"..GetPlayerName(player).."["..user_id.."]** i-a dat jucatorului **"..GetPlayerName(nplayer).."["..nuser_id.."]** suma de bani din mana **"..amount.."$**."
				}
			  }
			PerformHttpRequest('https://discord.com/api/webhooks/935231340276760707/cj7SO0yCYx5vb8QyFPh62Qgjc2G1sy1-sBrorHifuy9NsUpmkZ009e4sKetInP53dEw_', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' }) 
			-- PerformHttpRequest('https://discord.com/api/webhooks/935231340276760707/cj7SO0yCYx5vb8QyFPh62Qgjc2G1sy1-sBrorHifuy9NsUpmkZ009e4sKetInP53dEw_', function(err, text, headers) end, 'POST', json.encode({content = "**"..GetPlayerName(player).."["..user_id.."]** i-a dat jucatorului **"..GetPlayerName(nplayer).."["..nuser_id.."]** suma de bani din mana **"..amount.."$**."}), { ['Content-Type'] = 'application/json' })
            else
              vRPclient.notify(player,{lang.money.not_enough()})
            end
          end)
        else
          vRPclient.notify(player,{lang.common.no_player_near()})
        end
      else
        vRPclient.notify(player,{lang.common.no_player_near()})
      end
    end)
  end
end

vRP.registerMenuBuilder("main", function(add, data)
  local user_id = vRP.getUserId(data.player)
  if user_id ~= nil then
    local choices = {}
    choices[lang.money.give.title()] = {ch_give, lang.money.give.description()}
    add(choices)
  end
end)


-- AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
-- 	if first_spawn then
-- 		vRPclient.updateHudNUI(source,{"money",vRP.formatMoney(vRP.getMoney(user_id))})
-- 		vRPclient.updateHudNUI(source,{"bankmoney",vRP.formatMoney(vRP.getBankMoney(user_id))})
-- 		vRPclient.updateHudNUI(source,{"Diamante",vRP.formatMoney(vRP.getDiamante(user_id))})
-- 	end
-- end)
