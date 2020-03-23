function [path] = calc_path(r, gridSize,sizePath,areaDim)
%  
%  calc_path:  a function that approximates the movement path of the charge on the board
%              a location assigns to grid mesh
%              inscribe "1" where the charges is found and around it into the discretisation matrix
%
% INPUTS
%  r            : vector of location
%  gridSize     : mesh gird size (axis x and y)
%  sizePath     : number of mesh gird along the axis x and y
%  areaDim      : area (game board) dimension [x;y]
%
% OUTPUTS
%  path         : discretisation matrix
%
path=zeros(sizePath(1),sizePath(2));
absDim = abs(areaDim(:,2) - areaDim(:,1));

for i = 1:size(r,1)
    if(r(i,1)>=areaDim(1,1)-absDim(1)*0.01 && r(i,2)>=areaDim(2,1)-absDim(2)*0.01)
        distX = abs(r(i,1)-areaDim(1,1));
        distY = abs(r(i,2)-areaDim(2,1));
        x=(ceil(distX/gridSize(1)));
        y=(ceil(distY/gridSize(2)));
        if(x>0 && y>0)
            path(x,y)=1;
            if(x~=1 && y~=1)
                path(x-1:x+1,y-1:y+1)=1;
            end
        end
    end
end

end

