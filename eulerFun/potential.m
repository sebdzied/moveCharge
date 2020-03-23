function [V] = potential(charges, r)
%
%  potential:  a function that calculates the value of the electric field potential at a given point
%
% INPUTS
%  charge    : a structure consisting all of charges related parameters (e.g location,q,radius)
%  r         : the point at which the potential is calculated
%
% OUTPUTS
%  V         : value of potential at a given point [V]
%
V = 0;
k = 9*1e9; %constant

for i = 1:2
    % charges setting at the origin of the coordinate system
    R = r-charges(i).coord;
    d = norm(R); % distance from the center of the charg
    if(d> charges(i).radius) %outside charge
        V = V + k * charges(i).value/d;
    else %inside charge
        V = V + k * charges(i).value/charges(i).radius;
    end
end

end

