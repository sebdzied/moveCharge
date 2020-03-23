function [E, crash] = field_E(charges, r)
%
%  field_E: a function that calculating vector of the electric field from a finite radius charge
%
% INPUTS
%  charges     : a structure consisting all of charges related parameters (e.g location,q,radius)
%  r           : the point at which the field is calculated
%
% OUTPUTS
%  E           : vector of electric field [V/m]
%  crash       : arent we too near to the charge?
%
crash=0;
E = zeros(1,3);
e = 1/(36*pi)*1e-9; % permittivity of the vacuum
for i = 1:size(charges,2)
    if(charges(i).value~=0)
        % charges setting at the origin of the coordinate system
        R = r-charges(i).coord;
        d = norm(R); % distance from the center of the charge
        if(d>3*charges(i).radius)
            E = E +(charges(i).value*R)/(4*pi*e*d^3);
        else
            crash=1;
        end
    end
end

end

