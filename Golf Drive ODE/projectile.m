% function dzdt = projectile(t, z)
%
function dzdt = projectile(t, z)

    dzdt = [ z(3) ; z(4) ; -0.1 * z(3) ; -9.81 - (0.1 * z(4)) ];

