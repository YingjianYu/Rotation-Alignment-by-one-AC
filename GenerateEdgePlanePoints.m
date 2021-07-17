%% output the 4 edge points in the plane
function points = GenerateEdgePlanePoints(v1, v2, center, regionRange)
% regionRange : the side length of the square
    points = zeros(4, 3);
    maxAxis = regionRange/2;
    edgeMatrix = [-maxAxis maxAxis; 
                   maxAxis maxAxis;
                   maxAxis -maxAxis;
                  -maxAxis -maxAxis];
    for i = 1 : 4
        uv              = edgeMatrix(i,:);
        pos             = center + v1 * uv(1) + v2 * uv(2);
        points(i,:)     = pos';    
    end
end