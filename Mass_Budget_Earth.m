1;

% Mass Budget for Earth

Orbital_Mechanics; % Runs script orbital_Mechanics such that all variables are available
dry_mass = 1.2*(442.8+153.6+150.8+268+132+171.2+192.8+491.6+62.8+206.56); % Dry Mass of Satellite, multiplied by margin

%Burn V3 (Inclination):
initial_Mass_3 = calc_WetMass(Isp_ini, dry_mass, deltaV_Incl, g_0_earth);

% Burn V2 (Hohmann 2):
initial_Mass_2 = calc_WetMass(Isp_ini, initial_Mass_3,deltaV2, g_0_earth);

%Burn V1 (Hohmann 1):
initial_Mass_1 = calc_WetMass(Isp_ini, initial_Mass_2, deltaV1,g_0_earth);


Stages =["Delta V1"; "Delta V2"; "Inclination Change"];
initialMasses = [initial_Mass_1; initial_Mass_2; initial_Mass_3];
finalMasses = [initial_Mass_2;initial_Mass_3;dry_mass];
IspValues = [Isp_ini; Isp_ini; Isp_ini];
VeleocityBurns = [deltaV1;deltaV2; deltaV_Incl];
PropellantUsed = [initialMasses - finalMasses];

massBudgetTable = table(Stages,initialMasses,finalMasses, VeleocityBurns, PropellantUsed);

wet_mass_earth = initial_Mass_1;
prop_mass_earth = sum(PropellantUsed);

Masses =[];
