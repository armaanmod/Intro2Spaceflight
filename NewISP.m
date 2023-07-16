% These are the calculations for the task of checking the newly developed
% rocket engine

% Calculate exhaust velcoity
k = 1.3564;
R = 8.31434*10^3; % J/mol*K
M = 17.996; % kg/kmol -> Clarify whether this is the correct unit. Wikipedia says yes
p_e = 500; % pascal
p_c = 12*10^5; %pascal
T_c = 2529;% kelvin
r_e = 80 *10^-3; % meters

v_e = calculateExhaustVelocity(k,R,M,T_c,p_e,p_c);
ROF = 0.85;
mdot_fuel =  34*10^(-3); % kg/s
mdot_ox = mdot_fuel * ROF;
mdot_tot = mdot_ox + mdot_fuel;

A_e = pi*(r_e)^2;
p_a = 10^(-8); % ambient pressure in Pascal, from NASA source for ambient pressure at low earth orbit


thrust = mdot_tot * v_e + (p_e-p_a)*A_e;

c_e = thrust/mdot_tot;
ISP_New = mdot_tot*c_e;

% We get a lower ISP which means the engine is less efficient, from this we
% could conclude that it wouldn't be smart to use this engine

% Required propellant:


Orbital_Mechanics; % Runs script orbital_Mechanics such that all variables are available
dry_mass = 1.2*(442.8+153.6+150.8+268+132+171.2+192.8+491.6+62.8+206.56); % Dry Mass of Satellite, multiplied by margin

%Burn V3 (Inclination):
initial_Mass_3 = calc_WetMass(ISP_New, dry_mass, deltaV_Incl, g_0_earth);

% Burn V2 (Hohmann 2):
initial_Mass_2 = calc_WetMass(ISP_New, initial_Mass_3,deltaV2, g_0_earth);

%Burn V1 (Hohmann 1):
initial_Mass_1 = calc_WetMass(ISP_New, initial_Mass_2, deltaV1,g_0_earth);

Stages =["Delta V1"; "Delta V2"; "Inclination Change"];
initialMasses = [initial_Mass_1; initial_Mass_2; initial_Mass_3];
finalMasses = [initial_Mass_2;initial_Mass_3;dry_mass];
IspValues = [Isp_ini; Isp_ini; Isp_ini];
VeleocityBurns = [deltaV1;deltaV2; deltaV_Incl];
PropellantUsed = [initialMasses - finalMasses];

massBudgetTable = table(Stages,initialMasses,finalMasses, VeleocityBurns, PropellantUsed)

% We can conclude that more propellabt is needed, with the newly developed
% engine