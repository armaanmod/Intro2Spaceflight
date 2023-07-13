1;
Orbital_Mechanics;
%booster
mass_booster = 23000 ;
mass_propellant_booster = 284000 ;
Isp_booster = 262 ;
t_burn_booster = 130;
%core stage
mass_structure_core = 10500;
mass_propellant_core = 140000;
Isp_core = 429 ;
%upper stage 
mass_structure_upper = 8200;
mass_propellant_upper = 31000;
mass_adapterandfairing = 800;
mass_launcher_payload = 9500; 
deltav_losses = 1200;
Isp_upper = 465;

needed_velocity = calc_DeltaVIdeal(g_0_earth, r_earth, a_ini - r_earth);


m_0_initial = mass_booster + mass_propellant_booster + mass_structure_core + mass_propellant_core + mass_structure_upper + mass_propellant_upper + mass_adapterandfairing + mass_launcher_payload;
m_0_final = m_0_initial - mass_propellant_booster;
deltav_booster = calc_DeltaV_propellant(Isp_booster, g_0_earth, m_0_initial, m_0_final);

m_1_initial = mass_structure_core + mass_propellant_core + mass_structure_upper + mass_propellant_upper + mass_adapterandfairing + mass_launcher_payload;
m_1_final = m_1_initial - mass_propellant_core;
deltav_core = calc_DeltaV_propellant(Isp_core, g_0_earth, m_1_initial, m_1_final);

m_2_initial = mass_structure_upper + mass_propellant_upper + mass_adapterandfairing + mass_launcher_payload;
m_2_final = m_2_initial - mass_propellant_upper;
deltav_upper = calc_DeltaV_propellant(Isp_upper, g_0_earth, m_2_initial, m_2_final);

combined_delta_v = deltav_booster + deltav_core + deltav_upper;
provided_ariane62_velocity = combined_delta_v - deltav_losses;
if needed_velocity < provided_ariane62_velocity
    disp("Successful"); 
end 