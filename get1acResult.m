function [ RError,TError ] = get1acResult( Rimu1,Rimu2,A, Rfirst,x1,x2,Rzyxall,T12,d)
%get1acResult 
% input parameters
%   Rimu1 3¡Á3 -the rotation matrix from IMU1 to world frame 
%   Rimu2 3¡Á3 -the rotation matrix from IMU2 to world frame
%   (A, x1,x2)    - The A is the 2¡Á2  affine matrix of affine correspondence, the x1 and x2 are the normalized image point correspondence  
%   Rfirst           - The initial rotation matrix between camera and IMU
%   Rzyxall         - The ground truth of the rotation matrix between camera and IMU
%   T12              - The translation vector between camera1 and camera2.
%   Let  eye1, eye2 be position coordinates in world frame of camera1 and camera2, then T12 =-( eye2 - eye1)';
%   d                  - The distance from eye1 to the plane
% output parameters
%   RError     - The error of the estimated rotation matrix between
%   camera and IMU
%   TError          - The error of the recovered translation vector
%   between camera1 and  camera2.
[rxGB, ryGB, rzGB, txGB, tyGB, tzGB] = OneAc0(Rimu1(1,1), Rimu1(2,1), Rimu1(3,1), Rimu1(1,2), Rimu1(2,2), Rimu1(3,2), Rimu1(1,3), Rimu1(2,3), Rimu1(3,3), ...
              Rimu2(1,1), Rimu2(2,1), Rimu2(3,1), Rimu2(1,2), Rimu2(2,2), Rimu2(3,2), Rimu2(1,3), Rimu2(2,3), Rimu2(3,3), ...
            A(1,1), A(2,1), A(1,2), A(2,2), ...
             Rfirst(1,1), Rfirst(2,1), Rfirst(3,1), Rfirst(1,2), Rfirst(2,2), Rfirst(3,2),Rfirst(1,3),Rfirst(2,3),Rfirst(3,3),...
              x1(1,1), x1(2,1), x1(3,1), ...
              x2(1,1), x2(2,1), x2(3,1));
          %% Recover the ture solution
        nsx = size(rxGB,2);
        if nsx > 0  % We have several solutions each of which must be tested
            bestindex = 1;     % Initial allocation of best solution
            RError = inf;     % Number of inliers
            
            for k = 1:nsx
                Rsmall = ComposeRfromrxryrz_smallangle(rxGB(k),ryGB(k),rzGB(k));
%                 Rsmall=eye(3)+skew([rxGB(k),ryGB(k),rzGB(k)]);
                RzyxallGB=Rsmall*Rfirst;
                RError0=acos((trace(Rzyxall*RzyxallGB.')-1)/2)*(180/pi);
                if abs(RError0) < abs(RError)   % Record best solution
                    bestindex = k;
                    RError = RError0;
                end
            end
            rxGBC = rxGB(bestindex);
            ryGBC = ryGB(bestindex);
            rzGBC = rzGB(bestindex);
            %change to the orignal T
            TGB=d* (Rimu2*Rzyxall)*[txGB(bestindex); tyGB(bestindex); tzGB(bestindex)];
            txGBC = TGB(1);
            tyGBC = TGB(2);
            tzGBC = TGB(3);
            TError=acos((T12.'*TGB)/(norm(T12)*norm(TGB)))*(180/pi);
            if (~isreal(TError))
                TError=0;
            end
        else
            RError=[];
            TError=[];
        end
end

