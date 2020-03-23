function [t] = time(a,v,step)
%
%  time:  a function that calculates time to the step (based on acceleration in alternating motion)
%
% INPUTS
%  a       :  vector of acceleration [m/s^2]
%  v       :  vector of velocity [m/s]
%  step    :  constant distance between by further points
%
% OUTPUTS
%  t       : time [s]
%
if(norm(a)~=0)
    %roots of equation 4th order derivation of an analytical formula
    rootSolve = roots([(a(1)^2+a(2)^2)/4, v(1)*a(1)+v(2)*a(2), v(1)^2+v(2)^2, 0, -step^2]);
    t1=1; t2=1; t3=1; t4=1;
    %selecting true time - nonnegative value
    if(rootSolve(1)>0 && imag(rootSolve(1))==0)
        t1=rootSolve(1);
    end
    if(rootSolve(2)>0 && imag(rootSolve(2))==0)
        t2=rootSolve(2);
    end
    if(rootSolve(3)>0 && imag(rootSolve(3))==0)
        t3=rootSolve(3);
    end
    if(rootSolve(4)>0 && imag(rootSolve(4))==0)
        t4=rootSolve(4);
    end
    t=min([t1, t2, t3, t4]);
else
    t=step/norm(v);
end

end

