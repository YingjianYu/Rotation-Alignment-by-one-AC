function R = ComposeRfromrxryrz_smallangle(rx, ry, rz)
% Given rx ry rz as degree
R = eye(3)+skew([rx ry rz]);

% detaR = det(R);
% a = nthroot(detaR, 3);
% 
% R = R / a;
%% yyj ���������ע��20201106
Q=logm(R);
Qsym=1/2*(Q-Q.');
R=expm(Qsym);

end
        
