local cfg = {}
-- list of weapons for sale
-- for the native name, see https://wiki.fivem.net/wiki/Weapons (not all of them will work, look at client/player_state.lua for the real weapon list)
-- create groups like for the garage config
-- [native_weapon_name] = {display_name,body_price,ammo_price,description}
-- ammo_price can be < 1, total price will be rounded

-- _config: blipid, blipcolor, permissions (optional, only users with the permission will have access to the shop)

cfg.gunshop_types = {
  ["Magazin Arme"] = {
    _config = {blipid=110,blipcolor=1},
    ["WEAPON_MACHETE"] = {"Maceta",500,0,""},
    ["WEAPON_KNUCKLE"] = {"Pumnal",500,0,""},
    ["WEAPON_KNIFE"] = {"Cutit",500,0,""},
    ["WEAPON_FLASHLIGHT"] = {"Lanterna",500,0,""}
    },

  ["Hitman"] = {
    _config = {faction = "Hitman"},
    ["WEAPON_FLASHLIGHT"] = {"Lanterna",0,0,""},
    ["WEAPON_NIGHTSTICK"] = {"Baston",0,0,""},
    ["WEAPON_STUNGUN"] = {"Tazer",0,0,""},
    ["WEAPON_PUMPSHOTGUN"] = {"Shothgun",0,0,""},
    ["WEAPON_CARBINERIFLE_MK2"] = {"Carabina MK2",0,0,""},
    ["WEAPON_GUSENBERG"] = {"Gusen Berg",0,0,""},
    ["WEAPON_SMG"] = {"SMG",0,0,""},
    ["lanterna"] = {"Lanterna Arma",500,0,""},
    ["surpresor"] = {"Surpresor Arma",500,0,""},
    ["grip"] = {"Grip Arma",500,0,""},
    ["skins"] = {"Skin Arma",500,0,""},
    ["WEAPON_HEAVYSNIPER"] = {"Sniper",0,0,""},
  },
  ["DIICOT"] = {
    _config = {faction = "DIICOT",blipcolor = 57, blipid = 110},
    ["WEAPON_FLASHLIGHT"] = {"Lanterna",0,0,""},
    ["WEAPON_NIGHTSTICK"] = {"Baston",0,0,""},
    ["WEAPON_PISTOL_MK2"] = {"Pistol",0,0,""},
    ["weapon_combatpistol"] = {"Glock",0,0,""}, 
    ["WEAPON_STUNGUN"] = {"Tazer",0,0,""},
    ["WEAPON_PUMPSHOTGUN"] = {"Shothgun",0,0,""},
    ["WEAPON_CARBINERIFLE_MK2"] = {"Carabina MK2",0,0,""},
    ["weapon_specialcarbine"] = {"Special Carabina",0,0,""},
    ["WEAPON_CARBINERIFLE"] = {"Carabina",0,0,""},
    ["WEAPON_SMG"] = {"SMG",0,0,""},
    ["WEAPON_HEAVYSNIPER"] = {"Sniper",0,0,""},  
    ["WEAPON_ASSAULTRIFLE"] = {"AK-47",0,0,""},
    ["WEAPON_DOUBLEACTION"] = {"DOUBLEACTION",0,0,""},
    ["WEAPON_ASSAULTSHOTGUN"] = {"Shotgun automat",0,0,""},
    ["medkit"] = {"Medkit",0,0,""},
    ["WEAPON_GUSENBERG"] = {"Gusen Berg",0,0,""},
    ["lanterna"] = {"Lanterna Arma",500,0,""},
    ["surpresor"] = {"Surpresor Arma",500,0,""},
    ["grip"] = {"Grip Arma",500,0,""},
    ["skins"] = {"Skin Arma",500,0,""},
    ["body_armor"] = {"Armura", 0,0,""},
  },

   ["Gunshop Politie"] = {
    _config = {blipid=110,blipcolor=74, faction = "Politie"},
    ["WEAPON_FLASHLIGHT"] = {"Lanterna",0,0,""},
    ["WEAPON_NIGHTSTICK"] = {"Baston",0,0,""},
    ["WEAPON_PISTOL_MK2"] = {"Pistol",0,0,""},
    ["weapon_combatpistol"] = {"Glock",0,0,""}, 
    ["WEAPON_STUNGUN"] = {"Tazer",0,0,""},
    ["WEAPON_PUMPSHOTGUN"] = {"Shothgun",0,0,""},
    ["WEAPON_CARBINERIFLE_MK2"] = {"Carabina MK2",0,0,""},
    ["weapon_specialcarbine"] = {"Special Carabina",0,0,""},
    ["WEAPON_CARBINERIFLE"] = {"Carabina",0,0,""},
    ["WEAPON_SMG"] = {"SMG",0,0,""},
    ["WEAPON_HEAVYSNIPER"] = {"Sniper",0,0,""},  
    ["WEAPON_ASSAULTRIFLE"] = {"AK-47",0,0,""},
    ["WEAPON_DOUBLEACTION"] = {"DOUBLEACTION",0,0,""},
    ["WEAPON_ASSAULTSHOTGUN"] = {"Shotgun automat",0,0,""},
    ["medkit"] = {"Medkit",0,0,""},
    ["WEAPON_GUSENBERG"] = {"Gusen Berg",0,0,""},
    ["lanterna"] = {"Lanterna Arma",500,0,""},
    ["surpresor"] = {"Surpresor Arma",500,0,""},
    ["grip"] = {"Grip Arma",500,0,""},
    ["skins"] = {"Skin Arma",500,0,""},
    ["body_armor"] = {"Armura", 0,0,""},
  },
  ["Gunshop Groove"] = {
    _config = {blipid=110,blipcolor=74, faction = "Groove Street"},
    ["WEAPON_GADGETPISTOL"] = {"Perico Pistol",0,0,""},
    ["WEAPON_NAVYREVOLVER"] = {"Navy",0,0,""},
    ["WEAPON_NIGHTSTICK"] = {"Baston",0,0,""},
    ["WEAPON_PISTOL_MK2"] = {"Pistol",0,0,""},
    ["WEAPON_DOUBLEACTION"] = {"DOUBLEACTION",0,0,""},
    ["WEAPON_PUMPSHOTGUN"] = {"Shothgun",0,0,""},
    ["WEAPON_ASSAULTRIFLE"] = {"AK-47",0,0,""},
    ["WEAPON_GUSENBERG"] = {"Gusen Berg",0,0,""},
    ["WEAPON_SMG"] = {"SMG",0,0,""},
    ["body_armor"] = {"Armura", 0,0,""}
  },
   ["Gunshop Bloods"] = {
    _config = {blipid=110,blipcolor=74, faction = "Mafia Bloods"}, 
    ["WEAPON_GADGETPISTOL"] = {"Perico Pistol",0,0,""},
    ["WEAPON_NAVYREVOLVER"] = {"Navy",0,0,""},
    ["WEAPON_NIGHTSTICK"] = {"Baston",0,0,""},
    ["WEAPON_PISTOL_MK2"] = {"Pistol",0,0,""},
    ["WEAPON_DOUBLEACTION"] = {"DOUBLEACTION",0,0,""},
    ["WEAPON_PUMPSHOTGUN"] = {"Shothgun",0,0,""},
    ["WEAPON_ASSAULTRIFLE"] = {"AK-47",0,0,""},
    ["WEAPON_GUSENBERG"] = {"Gusen Berg",0,0,""},
    ["WEAPON_SMG"] = {"SMG",0,0,""},
    ["body_armor"] = {"Armura", 0,0,""}
  },
   ["Gunshop Vagos"] = {
    _config = {blipid=110,blipcolor=74, faction = "Los Vagos"}, 
    ["WEAPON_GADGETPISTOL"] = {"Perico Pistol",0,0,""},
    ["WEAPON_NAVYREVOLVER"] = {"Navy",0,0,""},
    ["WEAPON_NIGHTSTICK"] = {"Baston",0,0,""},
    ["WEAPON_PISTOL_MK2"] = {"Pistol",0,0,""},
    ["WEAPON_DOUBLEACTION"] = {"DOUBLEACTION",0,0,""},
    ["WEAPON_PUMPSHOTGUN"] = {"Shothgun",0,0,""},
    ["WEAPON_ASSAULTRIFLE"] = {"AK-47",0,0,""},
    ["WEAPON_GUSENBERG"] = {"Gusen Berg",0,0,""},
    ["WEAPON_SMG"] = {"SMG",0,0,""},
    ["body_armor"] = {"Armura", 0,0,""}
  }, 
  ["Gunshop Ballas"] = {
    _config = {blipid=110,blipcolor=74, faction = "Ballas"},
    ["WEAPON_NIGHTSTICK"] = {"Baston",0,0,""},
    ["WEAPON_PISTOL_MK2"] = {"Pistol",0,0,""},
    ["WEAPON_DOUBLEACTION"] = {"DOUBLEACTION",0,0,""},
    ["WEAPON_PUMPSHOTGUN"] = {"Shothgun",0,0,""},
    ["WEAPON_ASSAULTRIFLE"] = {"AK-47",0,0,""},
    ["WEAPON_GUSENBERG"] = {"Gusen Berg",0,0,""},
    ["WEAPON_SMG"] = {"SMG",0,0,""},
    ["body_armor"] = {"Armura", 0,0,""}
  },
  ["Gunshop Sindicat"] = {
    _config = {blipid=110,blipcolor=74, faction = "Sindicat"},
    ["WEAPON_GADGETPISTOL"] = {"Perico Pistol",0,0,""},
    ["WEAPON_NAVYREVOLVER"] = {"Navy",0,0,""},
    ["WEAPON_NIGHTSTICK"] = {"Baston",0,0,""},
    ["WEAPON_PISTOL_MK2"] = {"Pistol",0,0,""},
    ["WEAPON_DOUBLEACTION"] = {"DOUBLEACTION",0,0,""},
    ["WEAPON_GUSENBERG"] = {"Gusen Berg",0,0,""},
    ["WEAPON_PUMPSHOTGUN"] = {"Shothgun",0,0,""},
    ["WEAPON_ASSAULTRIFLE"] = {"AK-47",0,0,""},
    ["WEAPON_SMG"] = {"SMG",0,0,""},
    ["WEAPON_SNIPERRIFLE"] = {"Sniper",0,0,""},
    ["WEAPON_ASSAULTSHOTGUN"] = {"Assault Shotgun",0,0,""},
    ["body_armor"] = {"Armura", 0,0,""}
  },
  ["Smurd"] = {
    _config = {faction = "Smurd"},
    ["WEAPON_NIGHTSTICK"] = {"Nightstick",0,0,""},
    ["WEAPON_STUNGUN"] = {"Tazer",0,0,""}
  }
}
-- list of gunshops positions

cfg.gunshops = {
  {"Magazin Arme", -328.19470214844,6080.841796875,31.454803466796},
  {"Magazin Arme", 1692.1423339844,3758.7919921875,34.705299377441},
  {"Magazin Arme", 252.09565734863,-49.758823394775,69.941047668457},
  {"Magazin Arme", -662.40515136719,-935.455078125,21.829216003418},
  {"Magazin Arme", -1117.6219482422,2698.3051757813,18.554151535034},
  {"Magazin Arme", 2567.6896972656,294.45748901367,108.73487091064},
  {"Magazin Arme", -3171.6066894531,1087.6853027344,20.838747024536},
  {"Magazin Arme", 16.584775924682,-1109.1478271484,29.797201156616},
  {"Magazin Arme", 810.12554931641,-2157.3581542969,29.619016647339},
  {"Magazin Arme", 842.5830078125,-1033.4282226563,28.194847106934},
  {"Gunshop Politie",481.20278930664,-996.16534423828,30.689647674561},
  {"Smurd",-826.47973632812,-1236.9044189453,7.3374314308167},
  {"DIICOT",133.15187072754,-769.9912109375,242.15194702148},
  {"Hitman",-1516.9765625,851.55517578125,181.59436035156},
  
  {"Gunshop Groove",81.681343078613,-1952.7518310547,20.918159484863},
  {"Gunshop Sindicat",-1828.0026855469,311.85501098633,89.71166229248}, 
  {"Gunshop Ballas",-1536.130859375,108.29172515869,56.779777526855},
  -- {"Gunshop Mafia Rusa",-982.33447265625,121.22615814208,55.853157043458},
  -- {"Gunshop Mafia Sinaloa",-413.54187011718,436.61920166016,112.40605926514},
  -- {"Gunshop Groove Street",89.780616760254,-1958.9884033204,20.923936843872},
  -- {"Gunshop Peaky Blinders",1389.4599609375,1132.1516113282,114.33444976806},
 {"Gunshop Vagos",-89.9253616333,818.49340820312,227.59754943848},
  -- {"Gunshop Ballas",-654.19409179688,889.9818725586,229.24406433106},
  -- {"Gunshop Mafia M6",-1142.1654052734,364.67401123046,71.31844329834},
 {"Gunshop Bloods",-2603.5295410156,1916.0617675782,163.4563446045},
  -- {"Gunshop Mafia Albaneza",-1889.3645019531,2051.3264160156,140.98580932617},
  -- {"Gunshop The Lost MC",976.90069580078,-103.83110046386,74.845184326172},
  -- {"Gunshop Cosa Nostra",-1141.7116699219,365.23901367188,71.318435668945},
  
  
}

return cfg