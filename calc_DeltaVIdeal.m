function deltaV_ideal = calc_DeltaVIdeal(g_0_earth, r_earth, h)
    
    % Ascent into circular orbit
    deltaV_ideal = sqrt ( g_0_earth * r_earth * (2 - (r_earth / (r_earth + h))));

end
