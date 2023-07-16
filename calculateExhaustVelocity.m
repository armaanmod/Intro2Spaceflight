function v_e = calculateExhaustVelocity(k,R,M,T_c,p_e,p_c)

v_e = sqrt(2*(k/(k-1))*(R/M)*T_c*(1-(p_e/p_c)^((k-1)/k)));

end
