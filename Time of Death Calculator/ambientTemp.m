function Ta = ambientTemp(t)
    while t > 24
        t = t-24;
    end
    if t >= (7.5) && t <= (19)
        Ta = 22;
    elseif t <= (7) || t >= (21)
        Ta = 16;
    elseif t >= (7) && t <= (7.5)
        Ta = (t*12) - 68;
    else
        Ta = (t*-3) + 79;
    end