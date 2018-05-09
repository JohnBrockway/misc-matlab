% function value = projectile_events(t, z)
%
function value = projectile_events(t, z)
    groundHeight = Ground(z(1));
    value = z(2) - groundHeight;
    
