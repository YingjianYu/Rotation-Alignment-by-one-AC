clear
load('data.mat');
[ RError,TError ] = get1acResult( Rimu1,Rimu2,A, Rfirst,x1,x2,Rzyxall,T12,d);
if  (~isempty(RError))&&(~isempty(TError))
    disp('successfully!');
    disp('The error of the estimated rotation matrix is:');
    disp(RError);
    disp('The error of the recovered translation vector is:');
    disp(TError)
else
    disp('falied in solving!');
end
