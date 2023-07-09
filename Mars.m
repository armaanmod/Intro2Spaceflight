1;
Orbital_Mechanics;
Mass_Budget_Earth;
mu_mars = 4.282 * (10 ^ 13); 
r_peri_arrival_mars = 3789 * 10^3;
a_mars_arrival = -8035822.75; 

r_peri_target_mars = r_peri_arrival_mars;
r_apo_target_mars = 22289*10^3;

V_Hyperbola = calc_OrbitVelocity (mu_mars,r_peri_arrival_mars,a_mars_arrival);

a_target_mars = calc_SemiMajorAxis (r_peri_target_mars,r_apo_target_mars);
V_target_peri_mars = calc_OrbitVelocity (mu_mars,r_peri_target_mars,a_target_mars);

deltaVMars = V_Hyperbola - V_target_peri_mars;

%dry_mass_mars = calc_DryMass(Isp_ini, wet_mass_earth, deltaVMars, g_0_earth);
%test = calc_WetMass(Isp_ini, dry_mass_new, deltaVMars, g_0_earth);

wet_mass_mars = calc_WetMass(Isp_ini, dry_mass, deltaVMars, g_0_earth);
prop_mass_mars = wet_mass_mars - dry_mass;
extra_fuel_mars = prop_mass_mars - prop_mass_earth; % This extra fuel is because the dry mass is too much.

dry_mass_new = dry_mass;
wet_mass_new = wet_mass_mars;
while extra_fuel_mars >= 0.01
    wet_mass_new = calc_WetMass(Isp_ini, dry_mass_new, deltaVMars, g_0_earth);
    prop_mass_mars = wet_mass_new - dry_mass_new;
    extra_fuel_mars = prop_mass_mars - prop_mass_earth;
    dry_mass_new = dry_mass_new - 0.01;
end
reduced_dry_mass = dry_mass - dry_mass_new;

% Find out the wet_Mass such that the propellant Mass is suitable is prop
% system
% dry mass = dry mass -> variable
% propellant is known, deltaV is known, the initial mass is also unknown

