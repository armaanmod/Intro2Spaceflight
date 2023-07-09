1;

%% Acknowledgements
%Git Test
% Units: Throughout, SI units shall be used.

%% Parameters

r_earth = 6378 * 1000; % Radius of Earth
G_earth = 6.67*10^(-11); % Gravitation Constant of Earth
M_earth = 5.974 * 10^24; % Mass of Earth
mu_earth = G_earth * M_earth; % Standard Gravitational Parameter of Earth   
g_0_earth = 9.80665;

a_ini = 6678 * 1000; % Initial Orbit Radius
e_ini = 0; % Eccentricity of Initial Orbit, 0 implies circular orbit.
i_ini = deg2rad(90); % Initial Orbital Inclination
RAAN_ini = deg2rad(140); % Initial Orbital RAAN

alt_target = 750 * 1000; % Target Orbit Radius
e_target = 0; % Target Orbit Eccentricity, 0 implies circular orbit.
i_target = deg2rad(94); % Target Orbit Inclination
RAAN_target = deg2rad(140); % Target Orbit RAAN

Isp_ini = 290; % Initial Specific Impulse
m_0 = 0; % Initial Mass; To be filled

%% Main

a_target = alt_target + r_earth;
r_peri = a_ini;
r_apo = a_target;

a_t = calc_SemiMajorAxis(r_peri, r_apo);

v_ini = calc_OrbitVelocity(mu_earth, a_ini, calc_SemiMajorAxis(a_ini, a_ini));
v_target = calc_OrbitVelocity(mu_earth, a_target, calc_SemiMajorAxis(a_target, a_target));

v_t_peri = calc_OrbitVelocity(mu_earth, r_peri, a_t);
v_t_apo = calc_OrbitVelocity(mu_earth, r_apo, a_t);

deltaV1 = hohmannTransfer(v_ini, v_t_peri);
deltaV2 = hohmannTransfer(v_t_apo, v_target);

deltaV_Hohmann = deltaV1 + deltaV2;
m_prop_Hohmann = calc_PropMass(Isp_ini, m_0, deltaV_Hohmann, g_0_earth);

deltaV_Incl = changeInclination(v_target, v_target, i_target - i_ini);
m_prop_Incl = calc_PropMass(Isp_ini, m_0, deltaV_Incl, g_0_earth);
