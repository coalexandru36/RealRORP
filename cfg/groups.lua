
local cfg = {}

cfg.groups = {


  ['Supporter'] = {
    _config = {onspawn = function(player) vRPclient.notify(player,{"Te-ai logat ca ~r~Supporter"}) end},  
    "emergency.revive",
    'supporter.menu'

  },

  ["sponsors"] = {

		_config = {onspawn = function(player) vRPclient.notify(player,{"Te-ai logat ca ~y~Sponsor"}) end},   
	  "emergency.revive",
    "vacar.job"
  },
  ["rainbowmenu"] = {
		_config = {onspawn = function(player) vRPclient.notify(player,{"Te-ai logat cu acces la ~r~RainbowMenu"}) end},   
    "vacar.job"
  },
  ["supporter32sd"] = {
		_config = {onspawn = function(player) vRPclient.notify(player,{"Te-ai logat cu acces la ~p~SupporterMenu"}) end},   
    "supporter.menu"
  },
	["youtuber"] = {
		_config = {onspawn = function(player) vRPclient.notify(player,{""}) end},
		"player.phone"
  },
	["Fisher"] = {
		_config = {onspawn = function(player) vRPclient.notify(player,{""}) end},
		"player.phone"
  },
	["Vacar"] = {
      _config = {onspawn = function(player) vRPclient.notify(player,{""}) end},   
      "vacar.job"
  },
  ["McDonald`s"] = {
      _config = {onspawn = function(player) vRPclient.notify(player,{"Te-ai logat ca lucrator la ~y~McDonald`s"}) end},   
      "McDonald`s.job",
      "mission.mcdonalds"
  },
  ["Pescar"] = {
      _config = {onspawn = function(player) vRPclient.notify(player,{""}) end},   
      "pescar.job"
  },
  ["Padurar"] = {
      _config = {onspawn = function(player) vRPclient.notify(player,{""}) end},   
      "padurar.job"
  },
  ["Gunoier"] = {
      _config = {onspawn = function(player) vRPclient.notify(player,{""}) end},   
      "gunoier.job"
  },
  ["rainbow"] = {
    _config = {onspawn = function(player) vRPclient.notify(player,{"Ai nume ~p~Rainbow"}) end},
    "player.phone"
  },

  ["gold"] = {
		_config = {onspawn = function(player) vRPclient.notify(player,{""}) end},
		"player.phone"
  },

  ["diamond"] = {
		_config = {onspawn = function(player) vRPclient.notify(player,{""}) end},
		"player.phone"
  },
  
  ["user"] = {
    "player.phone",
    "player.calladmin",
    "player.askid",
    "player.skip_coma",
    "police.seizable"
  },
  ["onduty"] = {
    _config = {onspawn = function(player) vRPclient.notify(player,{""}) end},
    "police.heist"
  },

  ["Fermier"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{""}) end
	},
	  "mission.reparare.garduri",
    "mission.plantat.rosii",
	  "plant.market"
  },

  ["Culegator"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{""}) end
	},
	  "mission.cules.via",
    "mission.cules.meri",
    "mission.vinseller.bun",
    "vin.bun"
  },

  ["Miner"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{""}) end
	},
    "miner.job"
  },

  ["Avocat"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{""}) end
	},
    "avocat.service"
  },

  ["smurd"] = {
    _config = { gtype = "job",
    onspawn = function(player) vRPclient.notify(player,{""}) end
    },
    "emergency.revive",
    "police.pc",
    "emergency.shop",
    "smurd.service",
    "emergency.cloakroom",
    "emscheck.revive",
    "emergency.vehicle",
    "emergency.market",
    "ems.whitelisted",
    "ems.loadshop",
    "police.menu_interaction",
    "asistent.paycheck",
  },

  ["Curva"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{""}) end
  },
    "mission.curva.femei",
    "curva.cloakroom",
	  "curva.service"
  },
  
  ["Electrician"] = {
		_config = {onspawn = function(player) vRPclient.notify(player,{""}) end},
		"elec.job"
  },
  
  ["McDonald"] = {
		_config = {onspawn = function(player) vRPclient.notify(player,{""}) end},
		"mcdonald.job"
  },

	["Traficant de Droguri"] = {
  	_config = { gtype = "job",
  	onspawn = function(player) vRPclient.notify(player,{""}) end
  	},
	"mission.drugseller.weed"
  },
  ["UPS"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{""}) end
	},
	  "harvest.parcels",
	  "ups.vehicle",
    "mission.delivery.parcels",
    "mission.delivery.cargo"
  },
  ["Somer"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{""}) end},
  },
  ["Livrari"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{""}) end
	},
	  "mission.delivery.food",
	  "delivery.vehicle"
  },
  ["Traficant Tigari Contrabanda"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{"Esti ~r~Traficant de Tigari"}) end
	},
  "contrabanda.tigari",
  "harvest.tigari"
},
["Traficant de Organe"] = {
  _config = { gtype = "job",
onspawn = function(player) vRPclient.notify(player,{"Esti ~r~Traficant de Organe"}) end
},
"mission.organe"
  },
  ["Specialist Arme"] = {
  _config = { gtype = "job",
onspawn = function(player) vRPclient.notify(player,{"Esti ~r~Traficant de Arme"}) end
  },
  "strange.armele"
  },
  ["Fan Courier"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{""}) end
  },
    "FanCourier.vehicle",
	  "mission.delivery.food"
  },
  ["Hacker"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{""}) end
	},
	  "hacker.job"
  },

  ["Fermier"] = {
    _config = { gtype = "job",
	onspawn = function(player) end},},
  
  ["Constructor"] = {
    _config = { gtype = "job",
	onspawn = function(player) end},},

  ["Tamplar"] = {
    _config = { gtype = "job",
	onspawn = function(player) end},},

  ["Tirist"] = {
    _config = { gtype = "job",
  onspawn = function(player) end},},
  
  ["Uber Eats"] = {
    _config = { gtype = "job",
  onspawn = function(player) end},},

  ["Sofer de Autobuz"] = {
    _config = { gtype = "job",
  onspawn = function(player) end},},

  ["Uber"] = {
    _config = { gtype = "job",
  onspawn = function(player) end},
    "uber.service"
  },
  ["Spalator"] = {_config = { gtype = "job",onspawn = function(player) vRPclient.notify(player,{"Lucrezi ca si Spalator",2000,4}) end},
"spalageamuri.mission",
},  -- Ore 0

["Miner"] = {_config = { gtype = "job",onspawn = function(player) vRPclient.notify(player,{"Lucrezi ca si Miner",2000,4}) end},
"acces.miner"
},  -- ore 15

["Taximetrist"] = {_config = { gtypew = "job",onspawn = function(player) vRPclient.notify(player,{"Esti Taximetrist..",2000,4}) end},
"acces.taxi"
},  -- ore 5

["Pescar"] = {_config = { gtype = "job",onspawn = function(player) vRPclient.notify(player,{"Lucrezi ca si Pescar",2000,4}) end},
"acces.pescar"
}, 
["santierist"] = {_config = { gtype = "job",onspawn = function(player) vRPclient.notify(player,{"Lucrezi ca si Santierist",2000,4}) end},
"acces.santierist"
},   -- ore 10

["Pescar Avansat"] = {_config = { gtype = "job",onspawn = function(player) vRPclient.notify(player,{"Lucrezi ca si Pescar Avansat",2000,4}) end},
"acces.pescar2"
},  -- ore 10

["Traficant De Droguri"] = {_config = { gtype = "job",onspawn = function(player) vRPclient.notify(player,{"Lucrezi ca si Traficant De Droguri",2000,4}) end},
"acces.droguri"
},  -- ore 10

["Constructor"] = {_config = { gtype = "job",onspawn = function(player) vRPclient.notify(player,{"Lucrezi ca si Constructor",2000,4}) end},
"acces.constructor"
},  -- ore 10

["Spalator"] = {_config = { gtype = "job",onspawn = function(player) vRPclient.notify(player,{"Lucrezi ca si Spalator",2000,4}) end},
"acces.spalator"
},  -- ore 3


["Constructor Avansat"] = {_config = { gtype = "job",onspawn = function(player) vRPclient.notify(player,{"Lucrezi ca si Constructor",2000,4}) end},
"acces.constructor"
},  -- ore 3

["Culegator"] = {_config = { gtype = "job",onspawn = function(player) vRPclient.notify(player,{"Lucrezi ca si Culegator",2000,4}) end},
"acces.culegator"
},  -- ore 3

["Padurar"] = {_config = { gtype = "job",onspawn = function(player) vRPclient.notify(player,{"Lucrezi ca si Padurar",2000,4}) end},
"acces.padurar"
},  -- ore 5

["Curier"] = {
_config = { gtype = "job",onspawn = function(player) vRPclient.notify(player,{"Lucrezi ca si courier! Vezi ca ai colete de livrat!"}) end
},  -- ore 7
"acces.postop",
"curier.vehicle"
},

["Gunoier"] = {_config = { gtype = "job",onspawn = function(player) vRPclient.notify(player,{"Lucrezi ca si Gunoier!",2000,4}) end},
"acces.gunoier"
},  -- ore 10

["Livrari Pizza"] = {
_config = { gtype = "job",onspawn = function(player) vRPclient.notify(player,{"Lucrezi la Pizza Han! Vezi ca ai pizza."}) end
},
"acces.pizza"
},  -- ore 


["Sofer Autobuz"] = {
_config = { gtype = "job",onspawn = function(player) vRPclient.notify(player,{"Lucrezi la Sofer Autobuz !",2000,4}) end
}, -- 10
"acces.sofer"
},
--[[ JOBURI LEGALE ]]--

["Mecanic"] = {
  "acces.mecanic",
  "mechanic.perm",
  "mecanic.vehicle"
},

["Taxi"] = {
  "acces.taxi",
  "taxi.perm",
  "taxi.vehicle"

  }
}

cfg.users = {
  [1] = {
    "user"
  }
}

cfg.selectors = {
  ["Traficant de Tigari"] = {
    _config = {x = 4995.7705078125, y = -5750.201171875, z = 14.840495109558},
    "Traficant Tigari Contrabanda",
    "Somer"
  },
  ["Traficant de Arme"] = {
    _config = {x = 4962.1313476563, y = -5107.6611328125, z = 2.9820656776428},
    "Specialist Arme",
    "Somer"
  },
  ["Traficant de Organe"] = {
    _config = {x = -1748.5264892578, y = 5330.8388671875, z = 11.918627738953},
    "Traficant de Organe",
    "Somer"
  },  
  ["Hacker"] = {
    _config = {x = -2194.4760742188, y = 249.60688781738, z = 174.60681152344},
    "Hacker",
    "Somer"
  }
}

return cfg
