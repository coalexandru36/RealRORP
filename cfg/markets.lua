local cfg = {}

cfg.market_types = {
    ["Magazin Set Chimie"] = {
        _config = {},
        ["chem_set"] = 10,
    },
    ["Magazin Carduri"] = {
        _config = {blipid = 59, blipcolor=47, tipfactiune == "Mafie"},
        ["secure_card"] = 1000000,
    },
    ["Echipament Mecanic"] = { 
        _config = {blipid = 446, blipcolor=47, faction = "Mecanic"},
        ["repairkit"] = 500,
        ["scanner"] = 250
    },
    ["Echipament Smurd"] = {
        _config = {faction = "Smurd"}, 
        ["bandaj"] = 100,
        ["medkit"] = 100,
        ["smurd-id-card"] = 0     
    },      
    ["Echipament Politie"] = {
        _config = {faction = "Politie"}, 
        ["police-id-card"] = 0      
    }, 

    ["Black Market"] = {
        _config = {},
        ["bandaj"] = 100
    },

    ["Vodafone"] = {
        _config = {},
        ["aphone"] = 5000
    },

    ["Atasamente Arma"] = {
        _config = {blipid=0, blipcolor=69},
        ["lanterna"] = 1000000,
        ["surpresor"] = 1000000,
        ["grip"] = 1000000,
        ["skin"] = 1000000
    }
}

cfg.markets = {
  --  {"Magazin Set Chimie",vector3(-264.13201904297,2196.4829101563,130.39877319336)},
  --  {"Magazin Apa",vector3(403.60079956055,-1930.0767822266,24.736312866211)},
   -- {"Magazin de Tigari",vector3(4904.6748046875,-4941.7514648438,3.3795213699341)},
    -- {"El Diablos",vector3(-1288.931640625,500.72738647461,97.559783935547)},
    {"Echipament Mecanic",vector3(915.93084716797,-2105.6401367188,30.459426879883)},
    {"Atasamente Arma",vector3(-1120.0310058594,2696.1325683594,18.554269790649)},
    {"Echipament Smurd",vector3(-822.11126708984,-1240.8449707031,7.3374276161194)},
    {"Black Market",vector3(241.1791229248,-1378.9144287109,33.741706848145)}, 
 --   {"Echipament DIICOT",vector3(609.10833740234,-18.866249084473,76.627998352051)},
   {"Vodafone",vector3(-657.10491943359,-857.63049316406,24.503078460693)}, 
   {"Echipament Politie", vector3(484.93630981445,-999.00653076172,30.689643859863)},
   -- {"Camorra", vector3(-1567.3278808594,-94.628509521484,54.528987884521)},
   -- {"Guadalajara Cartel", vector3(-808.15850830078,189.2244720459,72.478019714355)},
--{"La Familia", vector3(-1812.4501953125,447.04626464844,128.51118469238)},
    {"Magazin Carduri", vector3(414.0133972168,-1508.5985107422,29.291604995728)},
}
 
return cfg





    



    
