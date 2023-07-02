% Calculation of orbital velocity
function orbit_velocity = calc_OrbitVelocity (mu,r,a) 
    orbit_velocity = sqrt(mu*((2/r)-(1/a)));
end