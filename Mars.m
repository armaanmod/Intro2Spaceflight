1;
Orbital_Mechanics;
MassBudget;
mu_mars = 4.282*(10^13); 
r_peri_arrival_mars = 3789*10^3;
a_mars_arrival = -8035822.75; 

r_peri_target_mars = r_peri_arrival_mars;
r_apo_target_mars = 22289*10^3;


V_Hyperbola = calc_OrbitVelocity (mu_mars,r_peri_arrival_mars,a_mars_arrival);

a_target_mars = calc_SemiMajorAxis (r_peri_target_mars,r_apo_target_mars);
V_target_peri_mars = calc_OrbitVelocity (mu_mars,r_peri_target_mars,a_target_mars);

deltaVMars = V_Hyperbola - V_target_peri_mars;

final_mass_mars = calc_finalMass(Isp_ini, wet_mass, deltaVMars,g_0_earth);
prop_mass_mars = wet_mass - final_mass_mars; % The propellant used comes out to be 960 kg, which means
% that the maneouvre is not possible

% Find out the wet_Mass such that the propellant Mass is xxcx
% final mass = dry mass -> variable
% propellant is known, deltaV is known, the initial mass is also unknown
