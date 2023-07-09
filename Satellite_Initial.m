1;

%% Aperture diameter
PayloadFrequency = 13.575 * 10^9; % The frequency of SIRAL in Cryosat 2.
c = 2.997925 * 10^8; % Speed of light
lambda = c / PayloadFrequency; % Wavelength
GR = 50; % Ground Resolution
alt_target = 750 * 1000; % Target Orbit Radius

D = calcApertureDiameter(alt_target, lambda, GR);

%% Parameters

% Taken from Excel Sheet
Pw_payload = 150;
Pw_ADCS = 20;
Pw_Com = 70;
Pw_datahand = 60;
Pw_pwr = 100;
Pw_tcs = 100;
Margin = 0.2;

Pw_nm = Pw_payload + Pw_ADCS + Pw_Com + Pw_datahand + Pw_pwr + Pw_tcs; % Power with no margin
Pw_tot = (1 + Margin)*Pw_nm; % Power with margin

G_earth = 6.674*10^(-11); % Gravitation Constant of Earth
M_earth = 5.971 * 10^24; % Mass of Earth
mu_earth = G_earth * M_earth; % Standard Gravitational Parameter of Earth
r_earth = 6378 * 1000; % Radius of Earth
a_target = alt_target + r_earth;

%% Sizing the Battery

% Step 1: Calculate Eclipse Time

vel = calc_OrbitVelocity(mu_earth, a_target, a_target); % Velocity in orbit
T = 2*pi()*a_target/vel; % Time period of the satellite
N = 365*24*60*60/T; % Number of Orbits per year
T_e = 0.4 * T; % Eclipse Time is approximately 40% of the total orbit time.

% Step 2: Calculate Power required during eclipse

Pw_per_e = 0.2; % Percentage of total power consumed during eclipse
Pw_req_e = (Pw_nm - Pw_payload) * (1 + Margin) * Pw_per_e; % Total power needed during eclipse
C_min  = Pw_req_e * T_e; % Minimum Capacity (to hold energy) of the battery [Ws]
C_min = C_min/3600; % Minimum Capacity [Wh]

% Step 3: Calculate Battery capacity

DoD = 73.5; % From the chart for Li-ion
C_battery = C_min * 100 / DoD; % [Wh]

%% Sizing the Solar Array

phi_sun = 1367; % From formulary
efficiency_battery = 0.824; % Might change to 90%
efficiency_array = 0.33;
Pw_req = Pw_tot + (Pw_req_e / efficiency_battery); % The solar array needs to generate power for sub-systems and for charging the battery
A_array = Pw_req/(phi_sun * efficiency_array);

%% TT&C

% We have to evaluate free space loss and transmission power.

f = 137 * 10^6; % Frequency of Communication
s = -100; % Sensitivity of the receiver [dBm]
G_RX = 2; % Receiver Gain [db]
L_RX = 3; % Receiver Loss [dB]

L_FS = 20*(log10(4*pi/c) + log10(alt_target) + log10(f)); % Free Space Loss [dB]
P_RX = -90; % The magnitude should be less than the sensitivity.
EIRP = P_RX + L_FS - G_RX + L_RX;

%% Thermal Subsystem

% Evaluate mean temperature & choose coating

alpha = 0.3; % Anodized Aluminium
epsilon = 0.8; % Anodized Aluminium
heat_dissipated = 0.2;

l_sat = 2.5; % Length of satellite
b_sat = 2.1; % Breadth of satellite
h_sat = 1.8; % Height of Satellite
A_sat_sun = computeArea(l_sat, b_sat); % The biggest area is considered.
A_sat_earth =  A_sat_sun;
A_sat_total = 2 * computeArea (l_sat, b_sat) + 2 * computeArea(b_sat, h_sat) + 2 * computeArea(l_sat, h_sat);
ViewFactor = alt_target/r_earth;
F = 0.8; % This is a function of dep_var.
q_l = 237-21; % Average IR energy flux from Earth is 237 +- 21
sigma = 5.6704 * 10^-8;

q_sun = alpha * phi_sun * A_sat_sun;
q_albedo = alpha * phi_sun * A_sat_earth * F;
q_earth = alpha * q_l * A_sat_earth;
q_internal = Pw_tot * heat_dissipated;

q_abs = q_sun + q_earth + q_albedo;
q_emit = q_abs + q_internal;

Temp_kelvin = nthroot(q_emit/(epsilon * sigma * A_sat_total), 4);
Temp_celsius = Temp_kelvin - 273.15;

% After testing the materials, anodized aluminium was chosen as it results
% the mean temperature being in the provide range of -30 to 50 deg celsius.

function A = computeArea(l,b)
    A = l*b;
end


