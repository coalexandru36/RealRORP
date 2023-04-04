local cfg = {}

cfg.spawn_enabled = true
cfg.spawn_position = {-542.75213623047,-208.13307189941,37.649833679199}
cfg.spawn_death = {-804.07641601562,-1209.0070800781,7.3374266624451}
cfg.spawn_radius = 1
cfg.default_customization = {model = "mp_m_freemode_01"}
for i=0,19 do
  cfg.default_customization[i] = {0,0}
end
cfg.clear_phone_directory_on_death = false
cfg.lose_aptitudes_on_death = false

return cfg