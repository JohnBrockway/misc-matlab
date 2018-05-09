function b = randfp(t, L, U)
% function b = randfp(t, L, U)
%
% Generate a random normalized binary floating-point number with
% t digits, and an exponent in the range [L,U] (as a string). For example,
%
%   b = randfp(5, -4, 4)
%
% might yield
%
%   b = '-0.10111b-2'
%
% or
%
%   b = '+0.11100b4'
%
% Note that the output is a string, and that the first character is
% always either a '+' or '-'. The number after the 'b' is
% the exponent for the base 2, although the exponent itself is
% represented in base-10. For example,
%
%   b = '+0.11100b4'
%
% represents the number 0.11100 x 2^4.
%

% To allow for zero element but not with a possibility of it with every
% exponent: generate the total number of elements in this floating point
% representation, and with probability 1 out of the entire set, return the 
% zero element.

if floor(rand * (2^(t-1) * (U-L+1) * 2 + 1)) == 0
    b = '+0.';
    for i = 1:t
        b = [ b '0' ];
    end
    b = [ b 'b0' ];
else
    b = '';
    sign = randi(2);
    if sign == 1
        b = '+';
    else
        b = '-';
    end
    
    b = [ b '0.1' ];
    
    for i = 1:(t-1)
        digit = randi(2) - 1;
        b = [ b num2str(digit) ];
    end
    
    b = [ b 'b' ];
    
    exponent = randi(U-L+1) + L - 1;
    b = [ b num2str(exponent) ];
end