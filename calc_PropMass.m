%Calculation of Propellant Mass for specific impulse, initial mass and deltaV
% function mass = calc_PropMass(Isp, m_0, deltaV, g_0)
%     c_e = Isp * g_0;
%     mass = m_0 * (1 - exp(deltaV / c_e));
% end
% The original function was commented because it didn't use the backwards
% approach. We need a fuction that gives the initial mass and not the final
% mass


%Calculation of initial Mass given the final mass, delta V and g_0
function m_0 = calc_PropMass(Isp, mass, deltaV, g_0)
    c_e = Isp * g_0;
    m_0 = mass*exp(deltaV/c_e);
end