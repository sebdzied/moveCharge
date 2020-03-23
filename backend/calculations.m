function [rSaved, isSimCorrect] = calculations(charges,wires,v,r,q,m,step,method,areaDim)
%
%  calculations:  mainy body of associated with all numerical calculations: e.g of the location, velocity, based on field E,H
%
% INPUTS
%  charges      : a structure consisting all of charges related parameters (e.g location,q,radius)
%  wires        : a structure consisting all of wires related parameters (e.g location,current)
%  v            : initial velocity [m/s]
%  r            : initial location
%  q            : elementary charge value in coulombs
%  m            : elementary charge mass in [kg]
%  step         : its time [s] if active "1" method
%                 its the constant distance between by further points [m] if active "2" method
%  method       : chose simulation method 1/2
%  areamDim     : area (simulation board) dimension [x;y]
%
% OUTPUTS
%  rSaved       : vector of location
%  isSimCorrent : checking the correctness of performed calculations
%
absDim = abs(areaDim(:,2) - areaDim(:,1));
if(r(1)>=areaDim(1,1)-absDim(1)*0.001 && r(1)<=areaDim(1,2)+absDim(1)*0.001) && (r(2)>=areaDim(2,1)-absDim(2)*0.001 && r(2)<=areaDim(2,2)+absDim(2)*0.001)
    maxIt = 20000; % limit of iteration if the charge doesnt come out of the way, e.g. to go round in circles
    rSaved = zeros(maxIt,2);
    u=4*pi*1e-7;  % permeability of the vacuum
    i=1;
    isSimCorrect = 1;
    if(method==2)
        addpath('eulerFun');
    else
        t = step;
        const = 2*m/(q*t);
    end
    
    switch method
        case 1
            %saving the first two initial positions
            temp = r+v*step;
            rSaved(i,1)=r(1);
            rSaved(i,2)=r(2);
            rSaved(i+1,1)=temp(1);
            rSaved(i+1,2)=temp(2);
        case 2
            Eo = energy(v,charges,r,q,m); %initial energy
            rSaved(i,1)=r(1);
            rSaved(i,2)=r(2);
    end
    
    while(rSaved(i,1)>=areaDim(1,1)-absDim(1)*0.01 && rSaved(i,1)<=areaDim(1,2)+absDim(1)*0.01) && (rSaved(i,2)>=areaDim(2,1)-absDim(2)*0.01 && rSaved(i,2)<=areaDim(2,2)+absDim(2)*0.01)
        switch method
            case 1  %central finite difference technique
                [H, crashH]=field_H(wires, r);
                [E, crashE]=field_E(charges,r);
                Bz = H(3)*u;
                
                if(crashE==1 || crashH==1)
                    i=i+1;
                    rSaved(i+1,1)=areaDim(1,2)+absDim(1);
                    rSaved(i+1,2)=areaDim(2,2)+absDim(2);
                    isSimCorrect=0;
                else
                    %equation AX = C
                    A = [const -Bz; Bz const];
                    C = [2*const*rSaved(i+1,1)-const*rSaved(i,1)-Bz*rSaved(i,2)+2*t*E(1);
                        2*const*rSaved(i+1,2)+Bz*rSaved(i,1)-const*rSaved(i,2)+2*t*E(2)];
                    X = A\C;
                    r(1) = X(1);
                    r(2) = X(2);
                    
                    i=i+1;
                    if(i<maxIt)
                        rSaved(i+1,1)=r(1); %save a current position
                        rSaved(i+1,2)=r(2);
                    else
                        rSaved(i+1,1)=areaDim(1,2)+absDim(1);
                        rSaved(i+1,2)=areaDim(2,2)+absDim(2);
                        isSimCorrect=0;
                    end
                end
                
            case 2 % EULER method
                [H, crashH]=field_H(wires, r);
                [E, crashE]=field_E(charges,r);
                B = H*u;
                
                if(crashE==1 || crashH==1)
                    i=i+1;
                    rSaved(i,1)=areaDim(1,2)+absDim(1);
                    rSaved(i+1,2)=areaDim(2,2)+absDim(2);
                    isSimCorrect=0;
                else
                    a=acceleration(B,E,q,v,m); % acceleration based on fields E and H
                    t=time(a,v,step);   %the time after which the charges will pass distance given  in the step
                    r=r+(t*v)+(a*(t^2)/2); %calculation of the position at the next step of time
                    v=v+a*t;
                    v=compens_velocity(charges,r,q,v,Eo,m); %(E=const)
                    
                    i=i+1;
                    if(i<maxIt)
                        rSaved(i,1)=r(1); %save a current position
                        rSaved(i,2)=r(2);
                    else
                        rSaved(i,1)=areaDim(1,2)+absDim(1);
                        rSaved(i,2)=areaDim(2,2)+absDim(2);
                    end
                end
        end
    end
    if(method==2)
        i=i-1;
    end
    rSaved(i+2:end,:) = [];
else
    rSaved = [];
    isSimCorrect = 0;
    disp('ERROR! Check the initial conditions! The charge is not inside the board.');
end

end

