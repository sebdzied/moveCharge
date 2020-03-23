function [H, crash] = field_H(wires, r)
%
%  field_H:  a function that calculating vector of the magnetic field from a finite radius wires
%
% INPUTS
%  wires     : a structure consisting all of wires related parameters (e.g location,current)
%  r         : the point at which the field is calculated
%
% OUTPUTS
%  H         : vector of magnetic field [A/m]
%  crash     : arent we too near to the wire?
%
H = zeros(1,3);
crash=0;
for i = 1:size(wires,2)
    if(wires(i).value~=0)
        direct=wires(i).pktMinus-wires(i).pktPlus;
        direct = direct / norm(direct);
        % equation of a straight line Ax+Bx+C=0
        A = direct(2);
        B = -direct(1);
        C = -(A*wires(i).pktPlus(1)+B*wires(i).pktPlus(2));
        dist =A*r(1)+B*r(2)+C/sqrt(A^2+B^2);
        if(abs(dist) > wires(i).radius)
            H(3) = H(3) + wires(i).value/(2*pi*dist);
        else
            crash=1;
        end
    end
end

end

