
local cfg = {}

cfg.gpsLocations = {
  ["Registrul Auto"] = {
      pos = vector3(-29.908824920654,-1104.9194335938,26.42234992981)
  },
  ['Showroom'] = {
      pos = vector3(-796.78186035156,-220.32164001465,37.079616546631)
  },
  ['Giftbox'] = {
      pos = vector3(-925.85992431641,-2037.2231445313,9.4023246765137)
  },
  ['Vama'] = {
      pos = vector3(1701.6116943359,1470.5987548828,86.113616943359)
  },
  ['Garaje VIP'] = {
      pos = vector3(32.682056427002,-1099.0487060547,29.453586578369)
  },
  ['Primarie'] = {
      pos = vector3(-109.66014099121,-965.02233886719,29.359930038452)
  },
  ['Spital'] = {
      pos = vector3(290.53375244141,-591.57818603516,43.160572052002)
  },
  ['Sectia de Politie'] = {
      pos = vector3(440.81698608398,-981.89978027344,30.689504623413)
  }
}

-- mission display css
cfg.display_css = [[
  
@font-face {
  font-family: 'fontcustom';
  src: url(fonts/fontcustom.woff);
} 
.div_mission{
  position: absolute;
  background-color: rgba(0,0,0,0.8);
  top: 155px;
  right: 10px;
  border-top-left-radius: 7px;
  border-bottom-right-radius: 7px;
  text-align:center;
  padding: 5px;
  width : 170px;
  font-size: 15px;
  font-weight: bold;
  font-family: 'Roboto Slab', serif;
  color: #FFFFFF;
  text-shadow: rgb(0, 0, 0) 1px 0px 0px, rgb(0, 0, 0) 0.533333px 0.833333px 0px, rgb(0, 0, 0) -0.416667px 0.916667px 0px, rgb(0, 0, 0) -0.983333px 0.133333px 0px, rgb(0, 0, 0) -0.65px -0.75px 0px, rgb(0, 0, 0) 0.283333px -0.966667px 0px, rgb(0, 0, 0) 0.966667px -0.283333px 0px;
}

.div_mission .name{
  color: rgb(255, 255, 255);
  font-weight: bold;
}

.div_mission .step{
  color: rgb(255,255,255);
  font-weight: bold;
}
]]

return cfg

