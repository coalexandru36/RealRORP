
local cfg = {}

cfg.pcs = {
 	{633.58892822266,8.898265838623,82.628051757813}
}

cfg.trackveh = {
  	min_time = 300,
  	max_time = 600,
  	service = "Politie",
}

cfg.wanted = {
  	blipid = 458,
  	blipcolor = 38,
  	service = "Politie",
}

cfg.seizable_items = {
	"drug_cansativa",
	"drug_cocaalka",
	"drug_unprocpcp",
	"drug_lyseracid",
	"lockpick_tools",
	"heroine",
	"pcp",
	"amphetamine",
	"subutex",
	"thc",
	"praf_pusca",
	"dmt",
	"erva",
	"mushroom",
	"body_armor",
	"cannabis",
	"filter",
	"cigarette",
	"dirty_money",
	"secure_card",
	"cocaina",
	"stack_cocaina",
	"lsd",
	"DB",
	"seeds",
	"harness",
	"iarba",
	"lockpick",
	"bijuterii",
	"cristalcocaina",
	"cristalheroina",
	"stack_iarba",
	"metanfetamina",
	"stack_metanfetamina",
	"credit",
	"credit_cards",
	"weed",
	"benzoilmetilecgonina",
	"pills",
	"M4A1",
	"AK47",
	"rinichi",
	"inima",
	"ficat",
	"horn",
	"ivory",
	"fur",
	"furs",
	"fake_id",
}

cfg.seizable_weapons = {
	"WEAPON_APPISTOL",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTSMG",
	"WEAPON_CARBINERIFLE",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_COMBATPISTOL",
	"WEAPON_FLARE",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_SMG",
	"WEAPON_NIGHTSTICK",
	"WEAPON_PETROLCAN",
	"WEAPON_MICROSMG",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_AIRSTRIKE_ROCKET",
	"WEAPON_KNIFE",
	"WEAPON_MG",
	"WEAPON_BAT",
	"WEAPON_STICKYBOMB",
	"WEAPON_SMOKEGRENADE",
	"WEAPON_MOLOTOV",
	"WEAPON_PISTOL",
	"WEAPON_ASSAULTSMG",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_MINIGUN",
	"WEAPON_GRENADE",
	"WEAPON_BZGAS",
	"AMMO_PISTOL",
	"AMMO_MG",
	"AMMO_SMG",
	"AMMO_RIFLE",
	"AMMO_SHOTGUN",
	"AMMO_SNIPER",
	"AMMO_SNIPER_REMOTE",
	"AMMO_PETROLCAN",
	"AMMO_MINIGUN",
	"AMMO_GRENADELAUNCHER",
	"AMMO_STICKYBOMB",
	"AMMO_SMOKEGRENADE",
	"AMMO_BZGAS",
	"AMMO_FLARE",
	"AMMO_MOLOTOV"
}

cfg.fines = {
  	[",Nuditate:"] = 5000,
  	[",Burnout / drift:"] = 5000,
  	[",Viteza:"] = 5000,
  	[",Parcare neregulamentara:"] = 5000,
  	[",Conducere imprudenta:"] = 5000,
  	[",Geamuri Fumurii:"] = 5000,
  	[",Neoane:"] = 5000,
  	[",Blocarea soselei:"] = 5000,
  	[",Traversare ilegala:"] = 5000,
  	[",Nerespectarea culorii rosie:"] = 5000,
  	[",Deranjarea linistii publice:"] = 5000,
  	[",Fuga de politie:"] = 5000,
  	[",Vandalism:"] = 5000,
  	[",Furt auto:"] = 5000,
  	[",Abuzul liniei de urgenta:"] = 5000,
  	[",Conducerea fara permis:"] = 5000,
  	[",Esecul identificarii:"] = 5000,
  	[",Conducerea unui autovehicul neinmatriculat:"] = 5000,
  	[",Fara asigurare:"] = 5000,
  	[",Posesie roti antiglont:"] = 5000,
  	[".Crima:"] = 5000,
  	[".Tentativa de omor:"] = 5000,
  	[".Asalt cu o arma mortala:"] = 5000,
  	[".Posesia unei arme de calibru mare:"] = 5000,
  	[".Posesia unei arme de foc:"] = 5000,
  	[".Posesia unei arme albe:"] = 5000,
  	["/Tentativa unui jaf la banca:"] = 5000,
  	["/Jefuirea unei banci:"] = 25000,
  	["/Jefuirea unui civil:"] = 15000,
  	["/Rapirea unui civil:"] = 10000,
  	["/Rapirea unui om al legii:"] = 15000,
  	["?Folosirea claxonului intr-un mod nejustificat:"] = 5000,
  	["?Neconformarea oridinelor:"] = 7000,
  	["?Oferire mita:"] = 6000,
  	["?Rezistenta la arest:"] = 5500,
  	["?Ofensarea unui om al legii:"] = 5000
}

return cfg
