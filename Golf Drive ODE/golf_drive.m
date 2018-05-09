% golf_drive.m
xPos = 0;
yPos = 0;
theta = 52;     % Angle of initial velocity (degrees)
initialTheta = theta;
S = 40;         % Initial speed (m/s)
tspan = [0 20]; % Set start and end times for computation (seconds)
h = 0.1;        % time step 100ms

for i = 1:5
% Set up initial state
    yStart = [xPos;yPos;                   % initial position (0,0)
              S*cos(theta/180*pi);   % x velocity
              S*sin(theta/180*pi)];  % y velocity


    %% Call the MyOde numerical solver function
 
    [t,y] = MyOde(@projectile, tspan, yStart, h, @projectile_events);

    %% Plot

    x = linspace(-10, 250, 300);
    hills = Ground(x);
    plot(x, hills, 'k-', y(:,1), y(:,2), 'ro-');
    axis([-10 250 -10 50]);
    axis equal;
    hold on;

    S = 0.75 * S;
    xPos = y(end, 1);
    yPos = y(end, 2);
 
    u = [ 1 GroundSlope(y(end, 1)) ];
    U = [ u(2) -u(1) ];
    v = [ y(end, 3) y(end, 4) ];
    V = (dot(v, u) * u) - (dot(v, U) * U);
    theta = atan(V(2)/V(1)) * 180 / pi;
    if theta < 0
        theta = 180+theta;
    end
end
title(['\theta = ' num2str(initialTheta) '^\circ: Golf ball landed at ' num2str(y(end,1)) 'm'], 'FontSize', 14);
xlabel('Distance (m)');
ylabel('Height (m)');