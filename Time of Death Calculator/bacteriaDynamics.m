function dzdt = bacteriaDynamics(t, z)
    if z(3) >= 29 && z(3) <= 45
        dAdt = 0.0008 * ((z(3) - 29) ^ 2) * (1 - exp(1)^(0.08*(z(3)-45))) * z(1)*(50-z(1));
    else
        dAdt = 0;
    end
    
    if z(3) >= 17 && z(3) <= 27
        dBdt = 0.001 * ((z(3) - 17) ^ 2) * (1 - exp(1)^(0.05*(z(3)-27))) * z(2)*(50-z(2));
    else
        dBdt = 0;
    end
        
    dTdt = (-0.2 * (z(3) - ambientTemp(t))) + (z(1) + z(2))/100;

    dzdt = [ dAdt ; dBdt ; dTdt ];