function [v] = compens_velocity(charges,r,q,v,Eo,m)
%
%  compens_velocity:  a function that velocity compensations so that the conservation of energy law is met
%
% INPUTS
%  charges  : a structure consisting all of charges related parameters (e.g location,q,radius)
%  r        : the point at which the energy is calculated
%  q        : elementary charge value in coulombs
%  v        : vector of velocity [m/s]
%  Eo       : energy that is corrected [V]
%  m        : elementary charge mass in [kg]
%
% OUTPUTS
%  v        : corrected vector of velocity [m/s] 
%
U=potential(charges,r);
Ep=U*q;
mod_v=norm(v);
k=(1/mod_v)*sqrt(2*(Eo-Ep)/m); % factor of proportionality
v=k*v;

end

