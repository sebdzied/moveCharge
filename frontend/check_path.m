function [pktStop] = check_path(r, gridSize,path,areaDim)
%
%  check_path:  a function that checks and comapres approximates the movement trajectory of the charge within path on the board
%                     
% INPUTS
%  r            : vector of location
%  gridSize     : mesh gird size (axis x and y)
%  path         : discretisation matrix
%  areaDim      : area (game board) dimension [x;y]
%
% OUTPUTS
%  pktStop      : index of location where instance path equals "0", doesnt fit
%
i=1;
pktStop=0;
absDim = abs(areaDim(:,2) - areaDim(:,1));

while(i<=size(r,1)) 
    if(r(i,1)>=areaDim(1,1)-absDim(1)*0.01 && r(i,2)>=areaDim(2,1)-absDim(2)*0.01)
        distX = abs(r(i,1)-areaDim(1,1));
        distY = abs(r(i,2)-areaDim(2,1));
        x=(ceil(distX/gridSize(1)));
        y=(ceil(distY/gridSize(2)));
        
        if(x>0 && y>0 && x<=size(path,1) && y<=size(path,2))
            if(path(x,y)==0)
                pktStop=i;
                i=size(r,1)+1;
            end
        end
    end
    i=i+1;
end

end

