% Calculation of deltaV for Hohmann Transfer
function deltaV_burn = hohmannTransfer(v_current, v_new)
    deltaV_burn = v_new - v_current;
end