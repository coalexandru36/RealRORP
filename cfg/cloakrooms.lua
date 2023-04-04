local cfg = {}
local default_male = {model = "mp_m_freemode_01"}
local default_female = {model = "mp_f_freemode_01"}
local uniforma_medic = {model = "s_m_m_paramedic_01"}
local pol_agent = {model = "s_m_y_cop_01"}
local sias_pol = {model = "s_m_y_blackops_01"}
local skinlopitista = {model = "s_f_y_sheriff_01"}
local skin_copil = {model = "ig_groom"}

for i=0,19 do
  default_female[i] = {0,0}
  default_male[i] = {0,0}
end

cfg.cloakroom_types = {
  ["Default"] = {
    _config = { not_uniform = true },
    ["Barbat"] = default_male,
    ["Femeie"] = default_female
  },
  ["Medici"] = {
    _config = { not_uniform = true },
    ["Medic"] = uniforma_medic,
    ["Copil"] = skin_copil   
  },
  ["Politie"] = {
    _config = { not_uniform = true },
    ["Agent"] = pol_agent,
    ["AntiDrog"] = sias_pol,
    ["Fata"] = skinlopitista
  }
}

cfg.cloakrooms = {
  {"Medici",-823.88763427734,-1238.5794677734,7.3374190330505},
  {"Politie",487.20596313477,-997.14111328125,30.689653396606}
}

return cfg