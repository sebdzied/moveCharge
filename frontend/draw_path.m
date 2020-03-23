function draw_path(gridSize,path,area,areaDim)
%
%  draw_path: the function that draws path on the board for players 
%             on based discretisation matrix  
%
% INPUTS
%  gridSize     :  mesh gird size (axis x and y)
%  path         :  discretisation matrix
%  area         :  axis handle
%  areaDim      :  area (game board) dimension [x;y]
%
% OUTPUTS
%  this function has no output args
%
for j=1:size(path,2)
    for i=1:size(path,1)
        if(path(i,j)==1)
            x=(i-1)*gridSize(1)+areaDim(1,1);
            y=(j-1)*gridSize(2)+areaDim(2,1);
            pathX=[x, x+gridSize(1), x+gridSize(1), x, x];
            pathY=[y, y, y+gridSize(2), y+gridSize(2), y];
            fill(area,pathX,pathY,[0.8 0.8 0.8],'LineStyle','none');
        end
    end
end

end

