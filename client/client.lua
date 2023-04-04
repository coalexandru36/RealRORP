local inEvent = false

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

AddEventHandler("vRP:pauseChange", function(paused)
  SendNUIMessage({act="pause_change", paused=paused})
end)

function tvRP.openMenuData(menudata)
  SendNUIMessage({act="open_menu", menudata = menudata})
end

function tvRP.closeMenu()
  SendNUIMessage({act="close_menu"})
end

function tvRP.prompt(title,default_text)
  SendNUIMessage({act="prompt",title=title,text=tostring(default_text)})
  SetNuiFocus(true, true)
  SetCursorLocation(0.5, 0.5)
end

function tvRP.request(id,text,icon)
  SendNUIMessage({act="request",id=id,text=tostring(text),icon = icon})
  tvRP.playSound("HUD_MINI_GAME_SOUNDSET","5_SEC_WARNING")
  SetNuiFocus(true, true)
  SetCursorLocation(0.5, 0.5)
end

function tvRP.areaRequest(hide, key, text)
  if hide then
    TriggerEvent("vRP:requestKey", false)
    return
  end

  TriggerEvent("vRP:requestKey", {key = key, text = text})
end

RegisterNetEvent("vRP:requestKey", function(data)
  if type(data) == "table" then

    SendNUIMessage({
      act = "keyRequest",
      request = "use",

      key = data.key,
      text = data.text,
    })

    return
  end

  SendNUIMessage({
    act = "keyRequest",
    request = "hide",
  })
end)

RegisterNUICallback("menu",function(data,cb)
  if data.act == "close" then
    vRPserver.closeMenu({data.id})
  elseif data.act == "valid" then
    vRPserver.validMenuChoice({data.id,data.choice,data.mod})
  end

  cb("www.Realism-rp.ro")
end)

RegisterNUICallback("prompt",function(data,cb)
  if string.len(data.result) <= 200 then
    SetNuiFocus(false, false)
    vRPserver.promptResult({data.result})
    cb("ok")
  else
    tvRP.notify("Ai depasit limita de caractere!", "error")
    cb("not_ok")
  end
end)

RegisterNUICallback("request",function(data,cb)
  vRPserver.requestResult({data.id,data.ok})
  SetNuiFocus(false, false)
  cb("ok")
end)

RegisterNUICallback("cfg",function(data,cb)
  SendNUIMessage({act="cfg",cfg=cfg.gui})
  cb("ok");
end)

Citizen.CreateThread(function()
  Wait(5000)
  SendNUIMessage({act="cfg", cfg=cfg.gui})
end)

function tvRP.setProgressBar(name,anchor,text,r,g,b,value)
  local pbar = {name=name,anchor=anchor,text=text,r=r,g=g,b=b,value=value}
  if pbar.value == nil then pbar.value = 0 end

  SendNUIMessage({act="set_pbar",pbar = pbar})
end

function tvRP.setProgressBarValue(name,value)
  SendNUIMessage({act="set_pbar_val", name = name, value = value})
end

function tvRP.setProgressBarText(name,text)
  SendNUIMessage({act="set_pbar_text", name = name, text = text})
end

function tvRP.removeProgressBar(name)
  SendNUIMessage({act="remove_pbar", name = name})
end

function tvRP.setDiv(name,css,content)
  SendNUIMessage({act="set_div", name = name, css = css, content = content})
end

function tvRP.setDivCss(name,css)
  SendNUIMessage({act="set_div_css", name = name, css = css})
end

function tvRP.setDivContent(name,content)
  SendNUIMessage({act="set_div_content", name = name, content = content})
end

function tvRP.removeDiv(name)
  SendNUIMessage({act="remove_div", name = name})
end

function tvRP.isPaused()
  return IsPauseMenuActive()
end

RegisterNUICallback("tog_off_nui", function(_, __)
  SetNuiFocus(false, false)
  __('ok')
end)

RegisterNUICallback("cancelEmote", function(_, __)
  ExecuteCommand("e c")
  __("www.Realism-rp.ro")
end)

local keytable = {
  ["k"] = {
      commandname = "gui_openmainmenu",
      description = "Deschide meniul principal K",
      func = function() if (not tvRP.isInEvent()) and (not tvRP.isInComa() or not cfg.coma_disable_menu) and (not tvRP.isHandcuffed() or not cfg.handcuff_disable_menu) then vRPserver.openMainMenu({}) end end
  },
  ["up"] = {
    commandname = "gui_menuup",
    description = "Key UP",
    func = function() 
      SendNUIMessage({act="event",event="UP"})
      CreateThread(function()
        local timer = 0
        while IsControlPressed(table.unpack(cfg.controls.phone.up)) do
          Wait(0)
        -- Add 1 to the timer
          timer = timer + 1
        -- If the timer is 60 or more, stop the loop (60 ticks/frames = +/- 1second)
          if timer > 30 then
            Wait(90)
            SendNUIMessage({act="event",event="UP"})
          end
        end
      end)
     end
  },
  ["down"] = {
    commandname = "gui_menudown",
    description = "Key DOWN",
    func = function() 
      SendNUIMessage({act="event",event="DOWN"}) 
      CreateThread(function()
        local timer = 0
        while IsControlPressed(table.unpack(cfg.controls.phone.down)) do
          Wait(0)
          timer = timer + 1
          if timer > 30 then
          Wait(25)
          SendNUIMessage({act="event",event="DOWN"})
          end
        end
      end)
    end
  },
  ["left"] = {
    commandname = "gui_menuleft",
    description = "Key LEFT",
    func = function() SendNUIMessage({act="event",event="LEFT"}) end
  },
  ["right"] = {
    commandname = "gui_menuright",
    description = "Key RIGHT",
    func = function() SendNUIMessage({act="event",event="RIGHT"}) end
  },
  ["return"] = {
    commandname = "gui_menuselect",
    description = "Key SELECT",
    func = function() SendNUIMessage({act="event",event="SELECT"}) end
  },
  ["back"] = {
    commandname = "gui_menuback",
    description = "Key BACK",
    func = function() SendNUIMessage({act="event",event="CANCEL"})end
  },
  ["F5"] = {
    commandname = "gui_menuF5",
    description = "Accepta request",
    func = function() SendNUIMessage({act="event",event="F5"}) end
  },
  ["F6"] = {
    commandname = "gui_menuF6",
    description = "Respinge request",
    func = function() SendNUIMessage({act="event",event="F6"}) end
  }
}

for k,v in pairs(keytable) do
  RegisterCommand(v.commandname, v.func)
  RegisterKeyMapping(v.commandname, v.description, 'keyboard', k)
end

RegisterNetEvent("fp-utils:progressBar", function(data, cb)
  -- SendNUIMessage({
  --   act = "_progressbar",
  --   time = data.duration,
  --   text = data.text,
  -- })

  -- CreateThread(function()
  --   local theAnim = data.anim
  --   if theAnim and not tvRP.isInComa() then
  --     if theAnim.scenario then
  --       TaskStartScenarioInPlace(GPED, theAnim.scenario:upper(), 0, false)
  --     else
  --       RequestAnimDict(theAnim.dict)
  --       while not HasAnimDictLoaded(theAnim.dict) do
  --         Wait(1)
  --       end

  --       TaskPlayAnim(GPED, theAnim.dict, theAnim.name, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
  --     end

  --     Wait(data.duration)
  --     ClearPedTasksImmediately(GPED)
  --   end
  -- end)

  data.anim = data.anim or {}

  exports.progressbars:Custom({
      Async = true,
      Duration = data.duration,        -- Duration of the progress
      Label = data.text,
      Animation = {
          scenario = data.anim.scenario, -- https://pastebin.com/6mrYTdQv
          animationDictionary = data.anim.dict, -- https://alexguirre.github.io/animations-list/
          animationName = data.anim.name,
      },

      DisableControls = data.disableControls,
      onComplete = cb,
  })
end)

RegisterNUICallback("activateFocus", function(_, cb)
  if _.state or _.state == nil then
    SetNuiFocus(true, true)
  else
    SetNuiFocus(false, false)
  end

  cb('ok')
end)

RegisterNUICallback("frontendSound", function(data, cb)
  PlaySoundFrontend(-1, data.dict, data.sound, 1)
  cb("www.Realism-rp.ro")
end)