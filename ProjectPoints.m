%% Projects spatial points onto a camera
function p2ds = ProjectPoints(points, P)

    N       = size(points, 1);
    p2ds    = zeros(N, 2);
    
    for i = 1 : N
        point           = [points(i,:)'; 1];
        p2d             = P * point;
        p2d             = p2d / p2d(3);
        p2ds(i,:)       = p2d(1:2)';    
    end
end