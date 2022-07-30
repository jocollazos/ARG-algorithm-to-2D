function [e] = SGLMS2D(x,d,filterOrderNo,WI,m1,al,ga)
%% S: step -- ????? filterOrderNo -- ??????R ?initialCoefficients -- ???????W0 
% condiciones para la ARgamma


%mu=0.01

tres = filterOrderNo+1;          % ??????? R
[nm,nn] = size(x);  % tamaño 96 x96  M*N
nxm = nm*nn;    % ???? = ??????
 
% Pre-allocations
e1 = zeros(nm, nn);  % ??? E
outputImage = zeros(nm, nn);% ??? Y
outImage = zeros(nm, nn);
W = zeros(tres,tres,nxm); % ????R*R, ???????????W
qf=zeros(tres,tres,nxm);
k= 1;
 
% Initial state of the weight vector
 
%W(:,:,k) = WI;%zeros(filterOrderNo+1,filterOrderNo+1);   % ruido gaussino 3x3 ???????
%qf(:,:,k)=WI; 
% Prefixed input
% x = x;
 
x(:,(nn+1):(nn+filterOrderNo)) = 0;  % ???????????????????????prefixedimage,???????M*N?????????F??prefixedimage????(M+F) * (N+F)
x((nm+1):(nm+filterOrderNo),:) = 0;
 
 
% Body
for i1 = 1:nm
    for i2 = 1:nn
        % Y = W * X ????
        X = x(i1+(tres-1):-1:i1, i2+(tres-1):-1:i2);
        ex1 = W(:,:,k).*X ;                                              % como esta planteado en el articulo MOHHY
        outputImage(i1,i2) = sum(ex1(:));                                    %como esta planteado en el articulo MOHIY (1988)
        e1(i1,i2) =outputImage(i1,i2)-d(i1,i2);
        %r=X.*W(:,:,k);
        r=X.*qf(:,:,k);
        q_1 =e1(i1,i2)+ga*sum(r(:));
        z=X.*X ;
        q_2=1+al*ga*m1*sum(z(:));
        g1 = q_1/q_2;
        qf(:,:,k+1) = (ga/(ga+al))*(qf(:,:,k)-al*g1*m1*X); 
        W(:,:,k+1) = W(:,:,k)+al*qf(:,:,k);
        %% actualizaciones
        %qfir(:,:,k) = qf(:,:,k);
        k=k+1;
        e(i1,i2) = -e1(i1,i2);
    end
    
end
