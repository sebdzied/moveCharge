function [E] = energy(v,charges,r,q,m)
%
%  energy:  a function that calculates whole charge energy at the given point 
%
% INPUTS
%  v        : vector of velocity [m/s]
%  charges  : a structure consisting all of charges related parameters (e.g location,q,radius)
%  r        : the point at which the energy is calculated
%  q        : elementary charge value in coulombs
%  m        : elementary charge mass in [kg]
%
% OUTPUTS
%  E        : value of whole (kinetic and potential) energy [V]
% 
v=norm(v);
U=potential(charges,r);
E=U*q+(m/2)*v^2;

end

