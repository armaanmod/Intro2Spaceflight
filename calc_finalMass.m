function mass = calc_FinalMass(Isp, m_0, deltaV, g_0)
     c_e = Isp * g_0;
     mass = m_0/exp(deltaV/c_e);
 end