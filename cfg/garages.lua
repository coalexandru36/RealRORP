local cfg = {}
cfg.sell_factor = 0.5

cfg.garage_types = {
  	["Garaj Civil"] = {
		_config = {vtype="car",blipid=357,blipcolor=27,icon=30,iconColor={41,234,23},hasbuy=false,tosell=false},
		["ast"] = {"🚗Aston Martin Vanquish",0, ""},
		["db11"] = {"🚗Aston Martin DB11",0, ""},
		["r820"] = {"🚗Audi R8",0, ""},
		["rs7"] = {"🚗Audi RS7",0, ""},
		["audirs6tk"] = {"🚗Audi RS6",0, ""},
		["17m760i"] = {"🚗BMW M760i",0, ""},
		["745le"] = {"🚗BMW 745le",0, ""},
		["m6f13"] = {"🚗BMW M6f13",0, ""},
		["bugatti"] = {"🚗Bugatti Veyron",0, ""},
		["divo"] = {"🚗Bugatti Divo",0, ""},
		["bbentayga"] = {"🚗Bentley Bentayga",0, ""},
		["ben17"] = {"🚗Bentley SuperSport",0, ""},
		["contgt13"] = {"🚗Bentley Continental",0, ""},
		["c7"] = {"🚗Chevrolet Corvette",0, ""},
		["limoxts"] = {"🚗Cadilac XCL Limo",0, ""},
		  ["fct"] = {"🚗Ferrari California",0, ""},
		["gtc4"] = {"🚗Ferrari GTC Lusso",0, ""},
		["17jamb"] = {"🚗Ford Camper",0, ""},
		["gt17"] = {"🚗Ford GT",0, ""},
		["fgt"] = {"🚗Ford GT 2005",0, ""},
		["918"] = {"🚗Porsche 918 Spider",0, ""},
		["911t4s2"] = {"🚗Porsche 911 Targa 4S",0, ""},
		["lamboavj"] = {"🚗Lamborghini Aventador",0, ""},
		["lp610"] = {"🚗Lamborghini Huracan",70, ""},
		["rmodsian"] = {"🚗Lamborghini Sian",0, ""},
		["c63s"] = {"🚗Mercedes C63SAMG",0, ""},
		["g65amg"] = {"🚗Mercedes G65AMG",0, ""},
		  ["s500w222"] = {"🚗Mercedes S500",0, ""},
		["mers63c"] = {"🚗Mercedes S63C",0, ""},
		["amggtsmansory"] = {"🚗Mercedes GTS AMG",0, ""},
		  ["amggtrr20"] = {"🚗Mercedes GTR AMG",0, ""},
		["e63amg"] = {"🚗Mercedes E63AMG",0, ""},
		["brabus850"] = {"🚗Mercedes AMG850",0, ""},
		["19S63"] = {"🚗Mercedes Brabus 800",0, ""},
		["mp412c"] = {"🚗MClaren MP4",0, ""},
		["morgan"] = {"🚗Morgan Aero 8",0, ""},
		  ["tulenis"] = {"🚗Nissan Patrol Nismo",0, ""},
		["rmodpagani"] = {"🚗PaganiHuayra RoadSter",0, ""},
		["paganizonda"] = {"🚗Pagani Zonda",0, ""},
		["cullinan"] = {"🚗Rolls-Royce Cullinan",0, ""},
		["rrphantom"] = {"🚗Rolls-Royce Phantom",0, ""},
		["dawnonyx"] = {"🚗Rolls-Royce-Down Onyx",0, ""},
		["911turboS"] = {"🚗Porsche 911TurboS",0, ""},
		["agerars"] = {"🚗Koenigsegg Agera RS",0, ""},
		["regalia"] = {"🚗Quartz Regalia",0, ""},-----
		["a6avant"] = {"🚗Audi A6 Avant",0, ""},
		["rs318"] = {"🚗Audi RS3",0,""},
		  ["rs52018"] = {"🚗Audi RS5 2018",0, ""},
		["as7"] = {"🚗Audi Q7 ABT",0, ""},
		["audiq8"] = {"🚗Audi Q8 2019",0, ""},
		["a8fsi"] = {"🚗Audi A8 FSI",0, ""},
		["ttrs"] = {"🚗Audi TTRS",0, ""},
		["m3f80"] = {"🚗BMW M3f80",0, ""},
		["f82"] = {"🚗BMW M4",0, ""},
		["m4c"] = {"🚗BMW M4 Cabrio",0, ""},
		["m516"] = {"🚗BMW M5f10",0, ""},
		["x5m13"] = {"🚗BMW X5M",0, ""},
		["48is"] = {"🚗BMW X5 Custom",0, ""},
		["440i"] = {"🚗BMW 440i xDrive",0, ""},
		["530d"] = {"🚗BMW 530i xDrive",0, ""},
		["m2"] = {"🚗BMW M2",0, ""},
		["m3e92"] = {"🚗BMW M3E92",0, ""},
		["z3m"] = {"🚗BMW Z3M",0, ""},
		["czr2"] = {"🚗Chevrolet Colorado",0, ""},
		["16ss"] = {"🚗Chevrolet Camaro",0, ""},
		["can"] = {"🚗Can-Am Maverick",0, ""},
		["16challenger"] = {"🚗Dodge Challenger SRT",0, ""},
		["mgt"] = {"🚗Ford Mustang GT",0, ""},
		["fastback"] = {"🚗Ford Mustang 1967",0, ""},
		["f150"] = {"🚗Ford Raptor",0, ""},
		["wildtrak"] = {"🚗Ford Bronco",0, ""},
		["18macan"] = {"🚗Porsche Macan Turbo",0, ""},
		["gmc1500"] = {"🚗GMC Sierra",0, ""},
		["denalihd"] = {"🚗GMC Denali",0, ""},
		["jeep2012"] = {"🚗Jeep Wrangler",0, ""},
		["jp12"] = {"🚗Jeep Wrangler Rubicon",0, ""},
		["jeepg"] = {"🚗Jeep Gladiator",0, ""},
		["mlbrabus"] = {"🚗Mercedes ML Brabus",0, ""},
		["xclass"] = {"🚗Mercedes XClass",0, ""},
		["e400"] = {"🚗Mercedes E400",0, ""},
		["cls2015"] = {"🚗Mercedes CLS 2015",0, ""},
		["gl63"] = {"🚗Mercedes GL63 2016",0, ""},
		["cla45"] = {"🚗Mercedes CLA45 AMG",0, ""},
		["evo10"] = {"🚗Mitsubishi Evo 10",0, ""},
		["370z"] = {"🚗Nissan Nismo 370Z",0, ""},
		["rrst"] = {"🚗RangeRover SuperSport",0, ""},
		["fjcruiser"] = {"🚗Toyota Fj Cruiser",0, ""},
		["golf7gti"] = {"🚗VW Golf 7 GTI",0, ""},
		["xc60"] = {"🚗Volvo XC60",0, ""},
		["a8audi"] = {"🚗Audi A8 2005",0, ""},
		["c5rs6"] = {"🚗Audi A6 2003",0, ""},
		["b5s4"] = {"🚗Audi S4",0, ""},
		["e46"] = {"🚗BMW M3e46",0, ""},
		["m3e36"] = {"🚗BMW M3e36",0, ""},
		["850csi"] = {"🚗BMW 850csi",0, ""},
		["m3e30"] = {"🚗BMW M3e30",0, ""},
		["bmwe39"] = {"🚗BMW M5e39",0, ""},
		["M5E28"] = {"🚗BMW M5e28",0, ""},
		["e34"] = {"🚗BMW M5e34",0, ""},
		["m5e60"] = {"🚗BMW M5e60",0, ""},
		["bmwe90"] = {"🚗BMW E90",0, ""},
		["1310s"] = {"🚗Dacia 1310 Sport",0, ""},
		["logan"] = {"🚗Dacia Logan",0, ""},
		["daduster"] = {"🚗Dacia Duster",0, ""},
		["sandero08"] = {"🚗Dacia Sandero",0, ""},
		["sanderos"] = {"🚗Dacia Sandero Stepway",0, ""},
		["sandero"] = {"🚗Dacia Sandero",0, ""},
		["sanderos2"] = {"🚗Dacia Sandero Stepway",0, ""},
		["festivac"] = {"🚗Ford Festiva",0, ""},
		["ap2"] = {"🚗Honda S2000",0, ""},
		["civic"] = {"🚗Honda Civic",0, ""},
		["na6"] = {"🚗Mazda MX-5 Miata",0, ""},
		["benzc32"] = {"🚗Mercedes-Benz C32",0, ""},
		["w210amg"] = {"🚗Mercedes-Benz E55",0, ""},
		["MBW124"] = {"🚗Mercedes-Benz 300D",0, ""},
		["2dopelr3"] = {"🚗Opel Rekord",0, ""},
		["206c"] = {"🚗Peugeot 206",0, ""},
		["rrs08"] = {"🚗Range Rover",0, ""},
		["twizy"] = {"🚗Renault Twizy",0, ""},
		["R50"] = {"🚗VW TouaregR50",0, ""},
		["golf1"] = {"🚗VW Golf1",0, ""},
		["golf2"] = {"🚗VW Golf2",0, ""},
		["golfgti"] = {"🚗VW Golf5",0, ""},
		["celisupra"] = {"🚗Toyota CliSupra",0, ""},
		["yaris08hb"] = {"🚗Toyota Yaris HB",0, ""},
		["yaris08"] = {"🚗Toyota Yaris",0, ""},
		["tico"] = {"🚗Daewoo Tico",0, ""},
		["v242"] = {"🚗Volvo v242",0, ""},
		["volvo850r"] = {"🚗Volvo 850r",0, ""},
		["primo2"] = {"🚗Albany Primo",0, ""},
		["voodoo"] = {"🚗DeClasse Voodoo",0, ""},
		["virgo2"] = {"🚗Dundrary Virog",0, ""},
		["sabregt2"] = {"🚗Sabre Turbo",0, ""},
		["slamvan3"] = {"V🚗ampid Slamvan",0, ""},
		["minivan2"] = {"🚗Vapid MiniVan",0, ""},
		["chino2"] = {"🚗Vapid Chino",0, ""},
		["faction3"] = {"🚗Willard Faction Wheels",0, ""},
		["audquattros"] = {"🚗Audi Quattro 1983",0, ""},
		["850"] = {"🚗BMW 850MCSI",0, ""},
		["z2879"] = {"🚗Chevrolet Camaro z28",0, ""},
		["69charger"] = {"🚗Dodge Charger 69",0, ""},
		["tiburon"] = {"🚗Hyundai Tiburon",0, ""},
		["EK9"] = {"🚗Honda Civic",0, ""},
		["honcrx91"] = {"🚗Honda CRX",0, ""},
		["na1"] = {"🚗Honda NSXR",0, ""},
		["sunrise1"] = {"🚗Karin Sunrise",0, ""},
		["zr390"] = {"🚗Karin ZR390",0, ""},
		["deltaintegrale"] = {"🚗Lancia Delta",0, ""},
		["rx811"] = {"🚗Mazda RX-8 Custom",0, ""},
		["fd"] = {"🚗Mazda RX-7 Custom",0, ""},
		["eclipsegt09"] = {"🚗Mitsubishi EclipseRWD",0, ""},
		["eclipsegt06"] = {"🚗Mitsubishi Eclipse4X4",0, ""},
		["evo9mr"] = {"🚗Mitsubishi EVO9",0, ""},
		["cp9a"] = {"🚗Mitsubishi EVO6",0, ""},
		["mitsugto"] = {"🚗Mitsubishi GTO",0, ""},
		["skyline"] = {"🚗Nissan R34",0, ""},
		["bnr34"] = {"🚗Nissan R34 Nismo",0, ""},
		["bnr32"] = {"🚗Nissan R32",0, ""},
		["silvias15"] = {"🚗Nissan Silvia",0, ""},
		["nis13"] = {"🚗Nissan S13",0, ""},
		["gtr"] = {"🚗Nissan Nismo GTR",0, ""},
		["a80"] = {"🚗Toyota Supra",0, ""},
		["tsgr20"] = {"🚗Toyota Supra 2",0, ""},
		["mr2sw20"] = {"🚗Toyota MR2",0, ""},
		["subisti08"] = {"🚗Subaru VRX STI",0, ""},
		["brztuning"] = {"🚗Subaru BRZ",0, ""},
		["rsv4"] = {"🚗Aprilia RSV4",0, ""},
		["blazer6"] = {"🚗Atv Blazer",0, ""},
		["monsteratv"] = {"🚗ATV Monster",0, ""},
		["verus"] = {"🚗ATV Verus",0, ""},
		["bmws"] = {"🚗BMW S1000RR",0, ""},
		["diavel"] = {"🚗Ducati Diavel",0, ""},
		["cb500x"] = {"🚗Honda CB500X",0, ""},
		["bros60"] = {"🚗Honda Bros",0, ""},
		["goldwing"] = {"🚗Honda GoldWing",0, ""},
		["africat"] = {"🚗Honda Africat",0, ""},
		["hvrod"] = {"🚗Harley-Davidson Street",0, ""},
		["foxharley1"] = {"🚗Harley-Davidson SoftAil",0, ""},
		["foxharley2"] = {"🚗Harley-Davidson Touring",0, ""},
		["h2carb"] = {"🚗Kawasaki H2",0, ""},
		["z1000"] = {"🚗Kawasaki Z1000",0, ""},
		["ktmsm"] = {"🚗SXF450",0, ""},
		["stryder"] = {"🚗Spyder",0, ""},
		["tmsm"] = {"🚗TMF450",0, ""},
		["r1"] = {"🚗Yamaha R1",0, ""},
		["20r1"] = {"🚗Yamaha R1-2020",0, ""},
		["r6"] = {"🚗Yamaha R6",0, ""},
		["tmaxDX"] = {"🚗Yamaha TMax",0, ""},
		["r25"] = {"🚗Yamaha YZF-R25",0, ""},
		["s1000rr"] = {"🚗BMW S1000RR",0, "",1},
		["bmwm8"] = {"🚗BMW M8",0, "",1},
		["bmwm8rr"] = {"🚗BMW M8",0, "",1},
		["bmci"] = {"🚗BMW M5", 0,"",1},
		["z4bmw"] = {"🚗BMW Z4",0, "",2},
		["rmodx6"] = {"🚗BMW X6M",0, "",2},
		["rmodbmwi8"] = {"🚗BMW I8",0, "",2},
		["bmwm4"] = {"🚗BMW M4 2021",0, ""},
		["rmodm3e36"] = {"🚗BMW M3E36",0, ""},
		["chiron17"] = {"🚗Bugatti Chiron",0, ""},
		["16charger"] = {"🚗Dodge Charger",0, ""},
		["f812"] = {"🚗Ferrari F812",0, ""},
		["tdf"] = {"🚗Ferrari F12",0, ""},
		["pista"] = {"🚗Ferrari 488",0, ""},
		["aperta"] = {"🚗Ferrari LaFerrari",0, ""},
		["fxxk2"] = {"🚗Ferrari FXX-K",0, ""},
		["sf90"] = {"🚗Ferrari SF90",0, ""},
		["apollos"] = {"🚗Gumpert Apollo s",0, ""},
		["lp770r"] = {"🚗Lambo Centenario",0, ""},
		["urus"] = {"🚗Lamborghini Urus",0, ""},
		["rmodveneno"] = {"🚗Lamborghini Veneno",0, ""},
		["rmodlp570"] = {"🚗Lamborghini Gallardo",0, ""},
		["S63AMG"] = {"🚗Mercedes S63",0, ""},
		["S65F"] = {"🚗Mercedes S65F",0, ""},
		["amggtc"] = {"🚗Mercedes GTC",0, ""},
		["rmodgt63"] = {"🚗Mercedes GT63S",0, ""},
		["2018s650p"] = {"🚗Mercedes Maybah Limo",0, ""},
		["2018s650"] = {"🚗Mercedes Maybah S65",0, ""},
		["p1"] = {"🚗MClaren GT20",0, ""},
		["720spider"] = {"🚗MClaren 720Spider",0, ""},
		["senna"] = {"🚗MClaren Senna",0, ""},
		["rmodskyline"] = {"🚗Nissan GTR",0, ""},
		["models"] = {"🚗Tesla ModelS P90D",0, ""},
		["teslax"] = {"🚗Tesla ModelX",0, ""},
		["teslapd"] = {"🚗Tesla P",0, ""},
		["rmodsupra"] = {"🚗Toyota Supra",0, ""},
		["ph8m"] = {"🚗Rolls-Royce Phantom 8",0, ""},
		["avisa"] = {"🚗Submarin Avisa",0, ""},
		["longfin"] = {"🚗LongFin",0, ""},
		["rumpo3"] = {"🚗Dubita 1",0, ""},
		["terbyte"] = {"🚗Dubita 2",0, ""},
		["benson"] = {"🚗Dubita 3",0, ""},
		["wastelander"] = {"🚗Dubita 4",0, ""},
		["speedo"] = {"🚗Dubita 5",0, ""}
	},
	["Garaj Mecanic"] = {
		_config = {vtype="car",permissions={"mecanic.vehicle"},hasbuy=true},
		["towtruck"] = {"🚚Masina Mecanic", 0,""}
	},
	
	["Garaj Curier"] = {
		_config = {vtype="car",permissions={"curier.vehicle"},hasbuy=true},
		["pony"] = {"🚚Masina Curier", 0,""}
	},
	
	["Garaj Construcor"] = {
		_config = {vtype="car",permissions={"acces.constructor"},hasbuy=true},
		["boxville"] = {"🚚Masina Construcor", 0,""}
	},
	
	["Garaj Padurar"] = {
		_config = {vtype="car",permissions={"acces.padurar"},hasbuy=true},
		["hellion"] = {"🚚Masina Padurar", 0,""}
	},
	
	["Garaj Pizza"] = {
		_config = {vtype="car",permissions={"acces.pizza"},hasbuy=true},
		["faggio2"] = {"🛵Scuter Pizza", 0,""}
	},
	["Garaj Bronz"] = {
		_config = {vtype="car",hasbuy=true,tosell=false,vip=1},
		["vsgran"] = {"🚘Lamborghini V12 Vision GT",0, ""}, 
		["ocnlamtmc"] = {"🚘2017 Lamborghini Terzo Millennio",0, ""}, 
		["zentenario"] = {"🚘Zlayworks Lamborghini",0, ""}, 
		["rs7c8wb"] = {"🚘Audi RS7 2020",0, ""}
	},
	["Garaj Silver"] = {
		_config = {vtype="car",hasbuy=true,tosell=false,vip=2},
		["vsgran"] = {"🚘Lamborghini V12 Vision GT",0, ""}, 
		["ocnlamtmc"] = {"🚘2017 Lamborghini Terzo Millennio",0, ""}, 
		["zentenario"] = {"🚘Zlayworks Lamborghini",0, ""}, 
		["rs7c8wb"] = {"🚘Audi RS7 2020",0, ""}, 
		["mb300sl"] = {"🚘1955 Mercedes-Benz 300SL Gullwing",0, ""}, 
		["fleet78"] = {"🚘1978 Cadillac Fleetwood Brougham D'elegance",0, ""}, 
		["fastback"] = {"🚘Ford Mustang Fastback",0, ""},
		["impala72"] = {"🚘1972 Chevrolet Impala",0, ""}
	},
	["Garaj Gold"] = {
		_config = {vtype="car",hasbuy=true,tosell=false,vip=3},
		["vsgran"] = {"🚘Lamborghini V12 Vision GT",0, ""}, 
		["ocnlamtmc"] = {"🚘2017 Lamborghini Terzo Millennio",0, ""}, 
		["zentenario"] = {"🚘Zlayworks Lamborghini",0, ""}, 
		["rs7c8wb"] = {"🚘Audi RS7 2020",0, ""}, 
		["mb300sl"] = {"🚘1955 Mercedes-Benz 300SL Gullwing",0, ""}, 
		["fleet78"] = {"🚘1978 Cadillac Fleetwood Brougham D'elegance",0, ""}, 
		["fastback"] = {"🚘Ford Mustang Fastback",0, ""},
		["impala72"] = {"🚘1972 Chevrolet Impala",0, ""},
		["benze55"] = {"🚘Mercedes Benz E55 AMG",0, ""}, 
		["c6320"] = {"🚘2020 Mercedes-AMG C63s AMG",0, ""}, 
		["lumma"] = {"🚘2019 Lumma CLR G770",0, ""}
  	},
  	["Garaj Diamond"] = {
		_config = {vtype="car",hasbuy=true,tosell=false,vip=4},
		["vsgran"] = {"🚘Lamborghini V12 Vision GT",0, ""}, 
		["ocnlamtmc"] = {"🚘2017 Lamborghini Terzo Millennio",0, ""}, 
		["zentenario"] = {"🚘Zlayworks Lamborghini",0, ""}, 
		["rs7c8wb"] = {"🚘Audi RS7 2020",0, ""}, 
		["mb300sl"] = {"🚘1955 Mercedes-Benz 300SL Gullwing",0, ""}, 
		["fleet78"] = {"🚘1978 Cadillac Fleetwood Brougham D'elegance",0, ""}, 
		["fastback"] = {"🚘Ford Mustang Fastback",0, ""},
		["impala72"] = {"🚘1972 Chevrolet Impala",0, ""},
		["benze55"] = {"🚘Mercedes Benz E55 AMG",0, ""}, 
		["c6320"] = {"🚘2020 Mercedes-AMG C63s AMG",0, ""}, 
		["lumma"] = {"🚘2019 Lumma CLR G770",0, ""},
		["mansm8"] = {"🚘Sveps",0, ""}
  	},
  	["Garaj Supreme"] = {
    	_config = {vtype="car",hasbuy=true,tosell=false,vip=5},
		["vsgran"] = {"🚘Lamborghini V12 Vision GT",0, ""}, 
		["ocnlamtmc"] = {"🚘2017 Lamborghini Terzo Millennio",0, ""}, 
		["zentenario"] = {"🚘Zlayworks Lamborghini",0, ""}, 
		["rs7c8wb"] = {"🚘Audi RS7 2020",0, ""}, 
		["mb300sl"] = {"🚘1955 Mercedes-Benz 300SL Gullwing",0, ""}, 
		["fleet78"] = {"🚘1978 Cadillac Fleetwood Brougham D'elegance",0, ""}, 
		["fastback"] = {"🚘Ford Mustang Fastback",0, ""},
		["impala72"] = {"🚘1972 Chevrolet Impala",0, ""},
		["benze55"] = {"🚘Mercedes Benz E55 AMG",0, ""}, 
		["c6320"] = {"🚘2020 Mercedes-AMG C63s AMG",0, ""}, 
		["lumma"] = {"🚘2019 Lumma CLR G770",0, ""},
		["mansm8"] = {"🚘Sveps",0, ""}
	},

	["Garaj Politie - Elicopter"] = {
		_config = {vtype="car", blipid=43, blipcolor=42,  faction = "Politie", hasbuy = true},
		["supervolito"]= {"🚁Elicopter Politie", 0, ""}
	},
	  
	["Garaj Taxi"] = {
		_config = {vtype="car",blipid=198,blipcolor=60,permissions={"taxi.vehicle"},hasbuy=true,tosell=false},
		["taxi"] = {"🚖Masina Taxi", 0,""}
	},

	["Garaj Smurd - Elicopter"] = {
		_config = {vtype="car", blipid=43, blipcolor=47, faction = "Smurd", hasbuy = true},
		["frogger"] = {"🚁Elicopter Smurd", 0, ""}
	},

	["Garaj Hitman - Elicopter"] = {
		_config = {vtype="car", blipid=43, blipcolor=47, faction = "Hitman", hasbuy = true},
		["supervolito2"] = {"🚁Elicopterul Septar", 0, ""},
		["havok"] = {"🚁Hitman Silentios", 0, ""}
	},

	["Garaj Politie"] = {
		_config = {vtype="car", blipid=56, blipcolor=42, faction = "Politie", hasbuy = true},
		["police3"]= {"🚔Logan Politie", 0, ""},
		["police"]= {"🚔BMW E60 Politie", 0, ""},
		["sheriff"]= {"🚔VW Polo Politie", 0, ""},
		["police2"]= {"🚔Audi A4 Politie", 0, ""},
		["policet"]= {"🚔Duba Politie", 0, ""},
		["pranger"]= {"🚔Ford Focus Politie",0, ""},
		["fbi2"]= {"🚔Lexus Politie",0, ""},
		["fbi"]= {"🚔Bugatti Politie",0, ""}
	  },


	  	["Garaj Politie de Forniera"] = {
		_config = {vtype="car", blipid=523, blipcolor=42, faction = "Politie", hasbuy = true},

	  },
	  
	["Garaj Jandarmerie"] = {
		_config = {vtype="car",blipid=56,blipcolor=38,faction="Jandarmerie",hasbuy=true,tosell=false},
		["sheriff2"] = {"🚔Masian Jandarmerie 1", 0,""},
		["police4"]= {"🚔Masian Jandarmerie 2", 0,""},
		["riot"]= {"🚔Masian Jandarmerie 3", 0,""},
		["pd_i8"]= {"🚔Masian Jandarmerie 4", 0,""},
		["pd_h1alpha"]= {"🚔Masian Jandarmerie 5", 0,""}
	},
	  

	["Garaj DIICOT"] = {
		_config = {vtype="car",blipid=56,blipcolor=38,faction="DIICOT",hasbuy=true,tosell=false},
		["sheriff2"] = {"🚔Masian DIICOT 1", 0,""},
		["police4"]= {"🚔Masian DIICOT 2", 0,""},
		["riot"]= {"🚔Masian DIICOT 3", 0,""},
		["pd_i8"]= {"🚔Masian DIICOT 4", 0,""},
		["pd_h1alpha"]= {"🚔Masian DIICOT 5", 0,""}
	},


	["Garaj Smurd"] = {
		_config = {vtype="car",blipid=523,blipcolor=1,faction="Smurd", hasbuy = true, tosell = false},
		["skodaambo"] = {"🚑Ambulanta Skoda", 0, ""}
	},
	  
	["Garaj Hitman"] = {
		_config = {vtype="car",blipid=0,blipcolor=1,faction="Hitman", hasbuy = true, tosell = false},
		["g65amg"] = {"🚘Mercedes G Wagon", 0, ""},
		["bbentayga"] = {"🚘Bentley Bentayga", 0, ""},
		["bmwm8"] = {"🚘BMW M8", 0, ""},
		["bdivo"] = {"🚘Bugatti Divo", 0, ""}
	},
	  
	["Garaj Grove"] = {
		_config = {vtype="car",faction="Grove Street", hasbuy = true, tosell = false},
		["brabus500"] = {"🚘Mercedes Brabus 500", 0, ""},
		["bmwm8"] = {"🚘Bmw M8", 0, ""},
		["a80"] = {"🚘Toyota Supra", 0, ""}
	},
	  
	["Garaj Sons"] = {
		_config = {vtype="car",faction="Sons of Anarchy", hasbuy = true, tosell = false},
		["daemon2"] = {"🏍Motocicleta Demon", 0, ""},
		["nightblade"] = {"🏍Motocicleta Night Blade", 0, ""},
		["zombieb"] = {"🏍Motocicleta Zombieb", 0, ""}
	},
	  
	["Garaj Vagos"] = {
		_config = {vtype="car",faction="Los Vagos", hasbuy = true, tosell = false},
		["buccaneer2"] = {"🚘Masina Vagos 1", 0, ""},
		["faction2"] = {"🚘Masina Vagos 2", 0, ""},
		["moonbeam2"] = {"🚘Masina Vagos 3", 0, ""}
	},
	  
	["Garaj Albaneza"] = {
		_config = {vtype="car",faction="Albaneza", hasbuy = true, tosell = false},
		["brabus500"] = {"🚘Mercedes Brabus 500", 0, ""},
		["bmwm8"] = {"🚘Bmw M8", 0, ""},
		["a80"] = {"🚘Toyota Supra", 0, ""}
	},

	["Garaj Corleone"] = {
		_config = {vtype="car",faction="Corleone", hasbuy = true, tosell = false},
		["brabus500"] = {"🚘Mercedes Brabus 500", 0, ""},
		["bmwm8"] = {"🚘Bmw M8", 0, ""},
		["a80"] = {"🚘Toyota Supra", 0, ""}
	},


	
	["Garaj Clanul duduianu"] = {
		_config = {vtype="car",faction="Clanul duduianu", hasbuy = true, tosell = false},
		["brabus500"] = {"🚘Mercedes Brabus 500", 0, ""},
		["bmwm8"] = {"🚘Bmw M8", 0, ""},
		["a80"] = {"🚘Toyota Supra", 0, ""}
	},

		["Garaj Yakuza"] = {
		_config = {vtype="car",faction="Yakuza", hasbuy = true, tosell = false},
		["brabus500"] = {"🚘Mercedes Brabus 500", 0, ""},
		["bmwm8"] = {"🚘Bmw M8", 0, ""},
		["a80"] = {"🚘Toyota Supra", 0, ""}
	},

	  

	["Garaj Bloods"] = {
		_config = {vtype="car",faction="Bloods", hasbuy = true, tosell = false},
		["brabus500"] = {"🚘Mercedes Brabus 500", 0, ""},
		["bmwm8"] = {"🚘Bmw M8", 0, ""},
		["a80"] = {"🚘Toyota Supra", 0, ""}
	},

	["Garaj Crips"] = {
		_config = {vtype="car",faction="Crips", hasbuy = true, tosell = false},
		["brabus500"] = {"🚘Mercedes Brabus 500", 0, ""},
		["bmwm8"] = {"🚘Bmw M8", 0, ""},
		["a80"] = {"🚘Toyota Supra", 0, ""}
	},
	  
	["Garaj Coziana"] = {
		_config = {vtype="car",faction="Coziana", hasbuy = true, tosell = false},
		["brabus500"] = {"🚘Mercedes Brabus 500", 0, ""},
		["bmwm8"] = {"🚘Bmw M8", 0, ""},
		["a80"] = {"🚘Toyota Supra", 0, ""}
	}
}

cfg.garages = {
	------------------GarajeCivili-------------------
	{"Garaj Civil",vector3(-53.582969665527,-1116.9268798828,26.434259414673)},
	{"Garaj Civil",vector3(31.825389862061,-866.00390625,30.492776870728)},
	{"Garaj Civil",vector3(365.94711303711,-951.28503417969,29.388269424438)},
	{"Garaj Civil",vector3(279.30551147461,-605.13568115234,43.06233215332)},
	{"Garaj Civil",vector3(-59.5022315979,-216.25215148926,45.444934844971)},
	{"Garaj Civil",vector3(-270.06246948242,26.195772171021,54.752532958984)},
	{"Garaj Civil",vector3(-915.044921875,-166.4584197998,41.876266479492)},
	{"Garaj Civil",vector3(-1472.5925292969,-508.10949707031,32.806838989258)},
	{"Garaj Civil",vector3(-1168.6774902344,-883.40228271484,14.121684074402)},
	{"Garaj Civil",vector3(-824.21875,-1194.7072753906,6.717273235321)},
	{"Garaj Civil",vector3(6.5519828796387,-1735.8408203125,29.30294418335)},
	{"Garaj Civil",vector3(-615.88525390625,-916.13037109375,23.740264892578)},
	{"Garaj Civil",vector3(882.60223388672,-32.095386505127,78.764083862305)},
	{"Garaj Civil",vector3(-398.06268310547,1203.4661865234,325.64175415039)},
	{"Garaj Civil",vector3(-2332.599609375,299.90960693359,169.46717834473)},
	{"Garaj Civil",vector3(-3153.8427734375,1088.9350585938,20.705974578857)},
	{"Garaj Civil",vector3(2579.5541992188,428.4111328125,108.45568084717)},
	{"Garaj Civil",vector3(-53.51770401001,1950.1163330078,190.18603515625)},
	{"Garaj Civil",vector3(107.15341186523,-140.3162689209,54.748355865479)},
	{"Garaj Civil",vector3(-1152.5139160156,2679.9360351562,18.093893051147)},
	{"Garaj Civil",vector3(-1905.4874267578,2021.349609375,140.78750610352)},
	{"Garaj Civil",vector3(1088.2888183594,2544.865234375,54.729866027832)},
	{"Garaj Civil",vector3(1778.8939208984,3299.1013183594,41.399150848389)},
	{"Garaj Civil",vector3(2059.6833496094,3450.841796875,43.806247711182)},
	{"Garaj Civil",vector3(1843.4968261719,3705.8854980469,33.6418800354)},
	{"Garaj Civil",vector3(1982.9816894531,3752.759765625,32.17427444458)},
	{"Garaj Civil",vector3(1301.7877197266,3632.7041015625,33.060897827148)},
	{"Garaj Civil",vector3(917.93499755859,3566.5949707031,33.764602661133)},
	{"Garaj Civil",vector3(2487.3295898438,4960.1064453125,44.834869384766)},
	{"Garaj Civil",vector3(2150.1477050781,4797.3842773438,41.14278793335)},
	{"Garaj Civil",vector3(-1577.3062744141,5164.8559570312,19.514127731323)},
	{"Garaj Civil",vector3(-578.91015625,5324.404296875,70.265563964844)},
	{"Garaj Civil",vector3(1580.5119628906,6449.1215820312,25.043111801147)},
	{"Garaj Civil",vector3(122.64204406738,6595.0546875,32.006736755371)},
	{"Garaj Civil",vector3(-97.066253662109,6396.6069335938,31.452472686768)},
	{"Garaj Civil",vector3(-225.07167053223,6344.17578125,32.426048278809)},
	{"Garaj Civil",vector3(-435.37316894531,6031.9262695312,31.340549468994)},
	{"Garaj Civil",vector3(-131.99102783203,6283.7880859375,31.350006103516)},
	{"Garaj Civil",vector3(-260.85083007812,6062.7065429688,31.575939178467)},
	{"Garaj Civil", vector3(-515.37115478516,-295.03372192383,35.233329772949)},
	{"Garaj Civil", vector3(217.458984375,-1381.7780761719,30.560190200806)},
	--{"Garaj Civil", vector3( )},
--	{"Garaj Civil", vector3( )},
	---------------------GarajPolitie---------------------------
	{"Garaj Politie",vector3(438.48699951172,-1026.646484375,28.789037704468)},
	{"Garaj Politie - Elicopter",vector3(449.12677001953,-981.17956542969,43.691650390625)},
	-------------------GarajSmurd-----------------------------
	{"Garaj Smurd - Elicopter",vector3(352.11456298828,-588.45739746094,74.165664672852)},
	{"Garaj Smurd",vector3(-848.86981201172,-1226.055053711,6.7024207115174)},
	-------------------GarajJandarmerie/Diicot------------------------------
	{"Garaj Jandarmerie",vector3(621.29956054688,26.60101890564,88.405258178711)},
	{"Garaj DIICOT",vector3(452.30883789062,-1014.9467773438,28.469942092896)},
	-------------------GarajMafie-------------------------------
	{"Garaj Grove",vector3(113.9087677002,-1947.5241699219,20.602085113525)},
	{"Garaj Sons",vector3(974.04333496094,-139.99638366699,74.257652282715)},
	{"Garaj Vagos",vector3(322.32550048828,-2036.8555908203,20.624660491943)},
	{"Garaj Bloods",vector3(-1528.9378662109,83.394706726074,56.652297973633)},
	{"Garaj Crips",vector3(947.27593994141,-668.73590087891,58.01148223877)},
	{"Garaj Coziana",vector3(14.738004684448,548.75482177734,176.22062683105)},
	{"Garaj Hitman",vector3(-811.82855224609,187.4485168457,72.474586486816)},
	{"Garaj Hitman - Elicopter",vector3(-772.84930419922,146.95768737793,67.474182128906)},
	----------------------GarajVip---------------------------
	{"Garaj Bronz",vector3(-337.53796386719,-751.15185546875,33.968509674072)},
	{"Garaj Silver",vector3(-334.55108642578,-751.48602294922,33.968509674072 )},
	{"Garaj Gold",vector3(-331.73519897461,-751.32305908203,33.96851348877)},
	{"Garaj Diamond",vector3(-328.92727661133,-751.05340576172,33.96851348877)},
	{"Garaj ",vector3(-323.51977539062,-752.87609863281,33.968509674072)},
	----------------------GarajJob------------------------------
	{"Garaj Mecanic",vector3(1754.3375244141,3323.6818847656,41.201061248779)},
	{"Garaj Curier",vector3(63.758033752441,117.36722564697,79.098999023438)},
	{"Garaj Taxi",vector3(914.93853759766,-170.92727661133,74.340774536133)},
	{"Garaj Construcor",vector3(904.25360107422,3589.50390625,33.240493774414)},
	{"Garaj Padurar",vector3(-832.78460693359,5414.8173828125,34.425567626953)},
	{"Garaj Pizza",vector3(-1170.923828125,-880.25427246094,14.113284111023)},
}

return cfg
