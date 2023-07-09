function mass = calc_DryMass(Isp, m_0, deltaV, g_0)
     c_e = Isp * g_0;
     mass = m_0/exp(deltaV/c_e);
 end