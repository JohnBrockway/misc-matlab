% The times represent hours on a 24 hour clock, with .43333 being an approximation of 26 minutes
[t, y] = ode45(@bacteriaDynamics, [11.5, 22.43333], [1 ; 1 ; 37.5]);
a = y(:, 1);
b = y(:, 2);
c = y(:, 3);
bacteriaA = a(end)
bacteriaB = b(end)
temperature = c(end)
plot(t, c);
title('Temperature of corpse');
xlabel('Time on 24 hour clock');
ylabel('Body temperature in Celsius');
