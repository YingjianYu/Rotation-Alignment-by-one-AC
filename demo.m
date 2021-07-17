%% Parameters
clear 
noiseInterval = 0.2;
nTry= 1000; % number of try
N = 1000; % pt to generate H           
ptNum=1000;% Number of generated points in a plane
radius = 60; % 60 units length as the distance from camera to oringinal point
regionRange =60; % 1 unit length 
K = [600, 0, 300; % camera intristic parameters
					 0, 600, 300; 
					 0, 0, 1 ];
noiseLevel = noiseInterval;
for InitAngle = 0:1:10%% begin with 0
    Index = round(InitAngle + 1);
    numTrialsAcutal = 0;
    for  try_i =1: nTry+500 % Ԥ��������ʧ�ܵĴ���
        %% change the initAngle
        [ Rzyxall ,Rfirst ] = setInitAngleBtwCameraIMU( 0,0,0,InitAngle*2*(rand(1)-0.5),InitAngle*2*(rand(1)-0.5),InitAngle*2*(rand(1)-0.5) );
        %% Generate plane
        vz =[0 0 1]';
        vx_xy = rand(2,1);
        vx_z = vz(1:2)'*vx_xy/(-vz(3));
        vx=[vx_xy;vx_z]./norm([vx_xy;vx_z]);% the vx and vy of the randon plane
        vy = cross(vz,vx);
        %% Generate random cameras
        phi = 2*pi*rand(2,1); % 0-360 degree
        theta =0.5*pi* rand(2,1);%0-90 degree ; camera should be above the ground
        x=radius.*sin(theta).*cos(phi);
        y=radius.*sin(theta).*sin(phi);
        z= radius.*cos(theta);
        eye1	= [x(1), y(1),z(1)];
        eye2	= [x(2), y(2),z(2)];       
        T12 =-( eye2 - eye1)';
        tx = T12(1);
        ty = T12(2);
        tz = T12(3);
        if (vz'*eye1'<=0)||(vz'*eye2'<=0)
            continue
        end
        up1		=rand(1,3);% [0,1,0];
        up2		=rand(1,3);% [0,1,0];
        [P1,R1,Rimu1,T1]		= GetLookAtMatrix(eye1, [0,0,0], up1, K,Rzyxall);        
        [P2,R2,Rimu2,T2]		= GetLookAtMatrix(eye2, [0,0,0], up2, K,Rzyxall);
        P1		= P1(1:3,:);
        P2		= P2(1:3,:);
        %% Generate and project points
        center = [0;0;0];
        points = GenerateEdgePlanePoints(vx, vy, center, regionRange);%% output the 4 edge points in the plane
        testPoints  = GeneratePlanePoints(vx, vy, center, N,regionRange);% generate test points in the plane
        pts2d1  = ProjectPoints(points, P1)+noiseLevel * randn(4,2);   
        normalizedImPt1=(K\[pts2d1 ones(4,1)]')';
        pts2d2  = ProjectPoints(points, P2);
        normalizedImPt2=(K\[pts2d2 ones(4,1)]')';
        H_gtError = normalizedDLT( normalizedImPt1, normalizedImPt2);
        d=(eye1*vz);
       %% calculate rotation alignment using one rand  point in the plane
        selPt = randperm(N,1);
        selPtNum = length(selPt);
        pts2d1Noisy =ProjectPoints(testPoints(selPt,:), P1)+noiseLevel * randn(selPtNum,2);
        pts2d2Noisy = ProjectPoints(testPoints(selPt,:), P2);%pts2d2;%+noiseLevel * randn(N,2) ;
        % normalized image pt with noise
         normalizedNoiseImPt1=(K\[pts2d1Noisy ones(selPtNum,1)]')';
         normalizedNoiseImPt2=(K\[pts2d2Noisy ones(selPtNum,1)]')';
        x1=normalizedNoiseImPt1';
        x2=normalizedNoiseImPt2';
        A= GetAffineFromHomography(H_gtError, x1(1), x1(2), x2(1), x2(2));
        %% 1ac    
        [ min_error,TError ] = get1acResult( Rimu1,Rimu2,A, Rfirst,x1,x2,Rzyxall,T12,d);
        if  (~isempty(min_error))&&(~isempty(TError))
            numTrialsAcutal=numTrialsAcutal+1;
            RErrorArray(numTrialsAcutal,Index)=min_error;
            TErrorArray(numTrialsAcutal,Index)=TError;
        else
            continue
        end
        if (numTrialsAcutal)>=nTry
            break;
        end
    end
    disp('a 1000 points loop:');toc
end
% draw
sortedRErrorArray=sort(RErrorArray);
figure(1);
plot(InitAngle,mean(sortedRErrorArray(1:200,:)),'r-o','LineWidth',2);
grid on;
hold on;
set(gca,'FontSize',15,'Fontname', 'Times New Roman');
ylabel('Angular error (deg. )','FontName','Times New Roman','LineWidth',2,'FontSize',15);
xlabel('Rotation magnitude (deg. )','FontName','Times New Roman','LineWidth',2,'FontSize',15);
hlegend1 = legend('1ac','Location','Best','Orientation','horizontal ');
set(hlegend1,'FontName','Times New Roman','FontSize',15,'FontWeight','normal')







