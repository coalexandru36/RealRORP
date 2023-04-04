local cfg = {}

cfg.factions = {
	["Politie"] = {
		fType = "Lege",
		fSlots = 80,
		fRanks = {
			[1] = {rank = "Cadet", salary = 1500000}, 
			[2] = {rank = "Agent", salary = 2000000}, 
			[3] = {rank = "Agent Principal", salary = 600001},
			[4] = {rank = "Agent Sef", salary = 600001},  
			[5] = {rank = "Inspector", salary = 600001}, 
			[6] = {rank = "Comisar", salary = 600001}, 
			[7] = {rank = "Comisar Sef", salary = 600001}, 
			[8] = {rank = "Chestor", salary = 600001}, 
			[9] = {rank = "Chestor General", salary = 4000000}
		}
	},

	["DIICOT"] = {
		fType = "Lege",
		fSlots = 50,
		fRanks = {
			[1] = {rank = "Plutonier ajutant", salary = 600001}, 
			[2] = {rank = "Sergent", salary = 600001}, 
			[3] = {rank = "Sergent Major", salary = 600001},
			[4] = {rank = "Plutonier", salary = 600001},  
			[5] = {rank = "Maior", salary = 600001}, 
			[6] = {rank = "Colonel", salary = 600001}, 
			[7] = {rank = "Sub Locotenent", salary = 600001}, 
			[8] = {rank = "Locotenent", salary = 600001}, 
			[9] = {rank = "Capitan", salary = 600001}
		}
	},	
	

	["Jandarmerie"] = {
		fType = "Lege",
		fSlots = 50,
		fRanks = {
			[1] = {rank = "Plutonier ajutant", salary = 600001}, 
			[2] = {rank = "Sergent", salary = 600001}, 
			[3] = {rank = "Sergent Major", salary = 600001},
			[4] = {rank = "Plutonier", salary = 600001},  
			[5] = {rank = "Maior", salary = 600001}, 
			[6] = {rank = "Colonel", salary = 600001}, 
			[7] = {rank = "Sub Locotenent", salary = 600001}, 
			[8] = {rank = "Locotenent", salary = 600001}, 
			[9] = {rank = "Capitan", salary = 600001}
		}
	},	
	
	["Hitman"] = {
		fType = "Lege",
		fSlots = 50,
		coords = {-429.12826538086,1110.2768554688,327.68228149414},
		fRanks = {
			[1] = {rank = "Membru Hitman", salary = 650000}, 
			[2] = {rank = "Sageata", salary = 650000}, 
			[3] = {rank = "Co-Lider Hitman", salary = 650000},  
			[4] = {rank = "Lider Hitman", salary = 650000}
		}
	},		
	
	["Smurd"] = {
		fType = "Lege",
		fSlots = 50,
		fRanks = {
			[1] = {rank = "Asistent Medical", salary = 700001}, 
			[2] = {rank = "Medic Rezident", salary = 700001}, 
			[3] = {rank = "Medic Specialist", salary = 700001},  
			[4] = {rank = "Medic Chirurg", salary = 700001},  
			[5] = {rank = "Medic Instructor", salary = 700001},
			[6] = {rank = "Asistent General", salary = 700001},  
			[7] = {rank = "Director General", salary = 700001}
		}
	},	

	["Taxi"] = {
		fType = "lege",
		fBlip = 2;
		fColor = "#20ff00";
		fSlots = 22,
		coords = { }, -- Sa nu uiti de coords
		fRanks = {
			[1] = {rank = "Membru Taxi", salary = 650}, 
			[2] = {rank = "Co-Lider Taxi", salary = 650}, 
			[3] = {rank = "Lider Taxi", salary = 650}
		}
	},

	["Mecanic"] = {
		fType = "lege",
		fBlip = 2;
		fColor = "#20ff00";
		fSlots = 22,
		coords = { }, -- Sa nu uiti de coords
		fRanks = {
			[1] = {rank = "Membru Mecanic", salary = 650}, 
			[2] = {rank = "Co-Lider Mecanic", salary = 650}, 
			[3] = {rank = "Lider Mecanic", salary = 650}
		}
	},
	
	["Albaneza"] = {
		fType = "Mafie",
		fBlip = 2;
		fColor = "#20ff00";
		fSlots = 22,
		coords = { }, -- Sa nu uiti de coords
		fRanks = {
			[1] = {rank = "Membru Albaneza", salary = 650}, 
			[2] = {rank = "Co-Lider Albaneza", salary = 650}, 
			[3] = {rank = "Lider Albaneza", salary = 650}
		}
	},

	["Corleone"] = {
		fType = "Mafie",
		fBlip = 2;
		fColor = "#92df";
		fSlots = 22,
		coords = { }, -- Sa nu uiti de coords
		fRanks = {
			[1] = {rank = "Membru Corleone", salary = 650}, 
			[2] = {rank = "Co-Lider Corleone", salary = 650}, 
			[3] = {rank = "Lider Corleone", salary = 650}
		}
	},

	["Yakuza"] = {
		fType = "Mafie",
		fBlip = 2;
		fColor = "#000";
		fSlots = 22,
		coords = { }, -- Sa nu uiti de coords
		fRanks = {
			[1] = {rank = "Membru Yakuza", salary = 650}, 
			[2] = {rank = "Co-Lider Yakuza", salary = 650}, 
			[3] = {rank = "Lider Yakuza", salary = 650}
		}
	},


	["Clanul duduianu"] = {
		fType = "Mafie",
		fBlip = 2;
		fColor = "#000";
		fSlots = 22,
		coords = { }, -- Sa nu uiti de coords
		fRanks = {
			[1] = {rank = "Membru duduianu", salary = 650}, 
			[2] = {rank = "Co-Lider duduianu", salary = 650}, 
			[3] = {rank = "Lider duduianu", salary = 650}
		}
	},


	["Grove Street"] = {
		fType = "Mafie",
		fBlip = 2;
		fColor = "#20ff00";
		fSlots = 22,
		coords = {104.28762054443,-1940.7919921875,20.8037109375},
		fRanks = {
			[1] = {rank = "Membru Grove", salary = 650}, 
			[2] = {rank = "Co-Lider Grove", salary = 650}, 
			[3] = {rank = "Lider Grove", salary = 650}
		}
	},
	
	
	["Sons of Anarchy"] = {
		fType = "Mafie",
		fBlip = 40;
		fColor = "#000000";
		fSlots = 22,
		coords = {970.66778564453,-124.14839935303,74.353057861328},
		fRanks = {
			[1] = {rank = "Membru Anarchy", salary = 650}, 
			[2] = {rank = "Co-Lider Anarchy", salary = 650}, 
			[3] = {rank = "Lider Anarchy", salary = 650}
		}
	},
	
	["Los Vagos"] = {
		fType = "Mafie",
		fBlip = 40;
		fColor = "#ffff00";
		fSlots = 22,
		coords = {322.32550048828,-2036.8555908203,20.624660491943},
		fRanks = {
			[1] = {rank = "Membru Vagos", salary = 650}, 
			[2] = {rank = "Co-Lider Vagos", salary = 650}, 
			[3] = {rank = "Lider Vagos", salary = 650}
		}
	},
	
	["Bloods"] = {
		fType = "Mafie",
		fBlip = 40;
		fColor = "#ff0000";
		fSlots = 22,
		coords = {-1526.4305419922,90.569198608398,56.551887512207},
		fRanks = {
			[1] = {rank = "Membru Bloods", salary = 650}, 
			[2] = {rank = "Co-Lider Bloods", salary = 650}, 
			[3] = {rank = "Lider Bloods", salary = 650}
		}
	},
	
	["Crips"] = {
		fType = "Mafie",
		fBlip = 40;
		fColor = "#0095ff";
		fSlots = 22,
		coords = {962.36962890625,-668.66107177734,58.013229370117},
		fRanks = {
			[1] = {rank = "Membru Crips", salary = 650}, 
			[2] = {rank = "Co-Lider Crips", salary = 650}, 
			[3] = {rank = "Lider Crips", salary = 650}
		}
	},
	
	["Camorra"] = {
		fType = "Mafie",
		fBlip = 40;
		fColor = "#ff8000";
		fSlots = 22,
		coords = {13.633273124695,547.9462890625,176.10466003418},
		fRanks = {
			[1] = {rank = "Membru Camorra", salary = 650}, 
			[2] = {rank = "Co-Lider Camorra", salary = 650}, 
			[3] = {rank = "Lider Camorra", salary = 650}
		}
	}
}
	
return cfg