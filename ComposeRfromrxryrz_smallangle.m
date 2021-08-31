function R = ComposeRfromrxryrz_smallangle(rx, ry, rz)
% Given rx ry rz as degree
R = eye(3)+skew([rx ry rz]);
Q=logm(R);
Qsym=1/2*(Q-Q.');
R=expm(Qsym);

end
        
