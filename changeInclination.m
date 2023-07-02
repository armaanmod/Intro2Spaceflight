% Calculation of deltaV for Inclination Changes
function deltaV_burn = changeInclination(v_current, v_new, phi)
    deltaV_burn = sqrt(v_current ^ 2 + v_new ^ 2 - 2 * v_current * v_new * cos(phi));
end