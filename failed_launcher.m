1;
calc_launcher_capability;

while needed_velocity <= provided_ariane62_velocity && TWR >= 1
    
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
    mass_outflow_booster = mass_propellant_booster / t_burn_booster ;
    exhaust_velocity_booster = Isp_booster * g_0_earth ;
    booster_thrust = calc_thrust (mass_outflow_booster, exhaust_velocity_booster);
    %THRUST TO WEIGHT RATIO
    TWR = booster_thrust/(m_0_initial*g_0_earth)
    mass_launcher_payload = mass_launcher_payload + 0.1;

end
incapable_launcher = mass_launcher_payload
disp ("Launcher incapable for the above value");