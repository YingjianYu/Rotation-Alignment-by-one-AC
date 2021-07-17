%-----------------------------------------------------------------%
% Copyright 2014-2016, Daniel Barath  barath.daniel@sztaki.mta.hu %
%-----------------------------------------------------------------%

%% Generates N random spatial point on a plane
function points = GeneratePlanePoints(v1, v2, center, N, regionRange)
% regionRange : the side length of the square
    points = zeros(N, 3);
    
    for i = 1 : N
        uv              = regionRange* (rand(2,1)-0.5);
        pos             = center + v1 * uv(1) + v2 * uv(2);
        points(i,:)     = pos';    
    end
end