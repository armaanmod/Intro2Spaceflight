function deltaV = calc_DeltaV_propellant(Isp,g_0_earth, m_ini, m_f)
   
    % Calculate delta-v using Tsiolkovsky rocket equation
    deltaV = Isp*g_0_earth * log(m_ini / m_f);

end
