1;

%% Aperture diameter

PayloadFrequency = 13.575 * 10^9; % The frequency of SIRAL in Cryosat 2.
c = 2.997925 * 10^8; % Speed of light
lambda = c / PayloadFrequency; % Wavelength
alt_target = 750 * 1000; % Target Orbit Radius
D = 18.5 * 10-2; % Diameter [m]

GR = calcGroundResolution(alt_target, lambda, D);

%%

function GR = calcGroundResolution(h, lambda, D)
    GR = 2.44 * h * lambda / D;
end