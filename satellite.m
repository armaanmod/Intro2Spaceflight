1;

%% Aperture diameter
lambda = 0.5*10^6; % Wavelength
GR = 50; % Ground Resolution
h = 750*10^3; % Distance between the satellite and the ground
D = CalcApertureDiameter(h, lambda, GR);
