%Calculation of Propellant Mass for specific impulse, initial mass and deltaV
function mass = calc_PropMass(Isp, m_0, deltaV, g_0)
    c_e = Isp * g_0;
    mass = m_0 * (1 - exp(deltaV / c_e));
end