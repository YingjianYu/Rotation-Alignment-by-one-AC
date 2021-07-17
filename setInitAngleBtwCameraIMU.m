function [ initR ,approximateInitR ] = setInitAngleBtwCameraIMU( Ax,Ay,Az,Axa,Aya,Aza )
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
% Ground truth
% Ax = 0;
% Ay = 0;
% Az = 0;
% Approximate installed angle
% Axa = 1;
% Aya = 1;
% Aza = 1;
% Approximate installed angle
        rxf = Axa*(pi/180);
        Rxf = [1 0  0 ;
            0 cos(rxf) -sin(rxf);
            0  sin(rxf) cos(rxf)];
        
        ryf = Aya*(pi/180);
        Ryf = [cos(ryf) 0 sin(ryf);
            0 1  0 ;
            -sin(ryf) 0  cos(ryf)];
        
        rzf = Aza*(pi/180);
        Rzf = [cos(rzf) -sin(rzf) 0;
            sin(rzf) cos(rzf) 0;
            0  0 1];
        
        approximateInitR=Rzf*Ryf*Rxf;
        % Ground truth angle
        rx = Ax*(pi/180);
        Rx = [1 0  0 ;
            0 cos(rx) -sin(rx);
            0  sin(rx) cos(rx)];
         ry= Ay*(pi/180);
        Ry = [cos(ry) 0 sin(ry);
            0 1  0 ;
            -sin(ry) 0  cos(ry)];
        %the rotation bewteen aligned cameras
        rz = Az*(pi/180);
        Rz = [cos(rz) -sin(rz) 0;
            sin(rz) cos(rz) 0;
            0  0 1];
        initR=Rz*Ry*Rx;

end

