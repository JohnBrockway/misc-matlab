%
%function [t, y] = MyOde(f, tspan, y0, h, event)
%
% Numerically solves the initial value problem
%
%    dy(t)/dt = f(t,y)
%        y(0) = y0
%
% using the Modified Euler time-stepping method.
%
% Input
%   f       handle to a Matlab dynamics function with calling sequence
%              dydt = f(t, y)
%   tspan   1x2 vector giving the start and end times, [start end]
%   y0      initial state of the system (as a column vector)
%   h       the time step to use (this is not adaptive time stepping)
%   events  handle to a Matlab event function with calling sequence
%              val = events(t, y)
%           The computation stops as soon as a negative value is
%           returned by the event function.
%
% Output
%   t       column-vector holding time stamps
%   y       holds one state vector per row (corresponding
%           to the time stamps)
%
%   Notes:
%       - t and y have the same number of rows.
%
%       - The first element of t should be tspan(1), and the first
%         row of y should be the initial state, y0.
%
%       - If the computation was stopped by the triggering of an event,
%         then the last row of t and y should correspond to the
%         time that linear interpolation indicates for the zero-crossing
%         of the event-function.
%
function [t, y] = MyOde(f, tspan, y0, h, event)

    N = ceil( ( tspan(2) - tspan(1) ) / h ); % max number of time steps
    
    t = tspan(1);
    y = [ y0(1) y0(2) y0(3) y0(4) ];
    for i = 1:N
        dydtE = f(t(end), y(end, :));
        dydtE = [ dydtE(1) dydtE(2) dydtE(3) dydtE(4) ];
        dydtM = f(t(end)+h, y(end, :) + h*dydtE);
        dydtM = [ dydtM(1) dydtM(2) dydtM(3) dydtM(4) ];
        newState = y(end, :) + h*((dydtE+dydtM)/2);
        value = event(t(end) + h, newState);
        if value < 0
            t = [t ; t(end) + h/2];
            dydtM = f(t(end) + h/2, y(end, :) + h*dydtE);
            dydtM = [ dydtM(1) dydtM(2) dydtM(3) dydtM(4) ];
            y = [ y ; y(end, :) + h*((dydtE+dydtM)/2) ];
            break
        end
        t = [t ; t(end) + h];
        y = [y ; newState ];
    end