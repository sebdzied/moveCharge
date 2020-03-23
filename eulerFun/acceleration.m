function [a] = acceleration(B,E,q,v,m)
%
%  acceleration:  a function that calculates the acceleration based on EM field and the Lorentz force
%
% INPUTS
%  B     : vector of magnetic induction [H]
%  E     : vector of electric field [V/m]
%  q     : elementary charge value in coulombs 
%  v     : vector of velocity [m/s]
%  m     : elementary charge mass in [kg]
%
% OUTPUTS
%  a     : vector of acceleration [m/s^2]
%
F=q*(E+cross(v,B));
a=F/m;

end


