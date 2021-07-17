%-----------------------------------------------------------------%
% Copyright 2014-2016, Daniel Barath  barath.daniel@sztaki.mta.hu %
%-----------------------------------------------------------------%
% x,y: coordinates on the second image (second: after multiplying the homography)
% R_calib ： the groundtrue between the camera and IMU
function [LMat,R_,Rimu,t]= GetLookAtMatrix(eye, lookAtPoint, up, intristic, R_calib)
	
	if intristic == -1
		intristic = [600, 0, 300; 
					 0, 600, 300; 
					 0, 0, 1 ];
	end;	
	vz	= -(eye - lookAtPoint) / norm(eye - lookAtPoint);% 改为正片
	vx	= cross(up,vz);
	vx	= vx / norm(vx);
	vy	= cross(vz,vx);
	
	R 		= [vx; vy; vz];%% 世界坐标系到像机坐标系
    Rimu = R'/R_calib; % Rimu*R_calib 表示从相机到世界
	t		= -R * eye';
	
	LMat	= ([vx, t(1);
				vy, t(2);
				vz, t(3)]);
	
	LMat	= intristic * LMat;	%                                                                                                                                                                                                                        
	R_ =R';%表示从相机到世界
 end

