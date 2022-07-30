%%                           Función algoritmo NLMS 2D 
% Documento: Extension and Analysis of the ARG algorithm to 2D
% Autor: Jhonatan Collazos, Pablo E. Jojoa. y  Juan P. Hoyos
%                IEEE Latin America Transactions  2022
%%
function [e] = SNLMS2D(prefixedimage,noiseim,filterOrderNo,mu,WI)
 %% S: step -- ????? filterOrderNo -- ??????R ?initialCoefficients -- ???????W0 
tres = filterOrderNo+1;          % ??????? R
[nm,nn] = size(prefixedimage);  % tamaño 96 x96  M*N
nxm = nm*nn;    % ???? = ??????
 
% Pre-allocations
e = zeros(nm, nn);  % ??? E
outputImage = zeros(nm, nn); % ??? Y
P = zeros(tres,tres,nxm); % ????R*R, ???????????W
k= 1;
 
% Initial state of the weight vector
 
P(:,:,k) = WI;   % ruido gaussino 3x3 ???????
 
% Prefixed input

 
prefixedimage(:,(nn+1):(nn+filterOrderNo)) = 0;  % ???????????????????????prefixedimage,???????M*N?????????F??prefixedimage????(M+F) * (N+F)
prefixedimage((nm+1):(nm+filterOrderNo),:) = 0;
 
 
% Body
for i1 = 1:nm
    for i2 = 1:nn
        X =prefixedimage(i1+(tres-1):-1:i1, i2+(tres-1):-1:i2);
        ex1 = P(:,:,k).*X;
        outputImage(i1,i2) = sum(ex1(:));
        e(i1,i2)=noiseim(i1,i2) - outputImage(i1,i2);
        P(:,:,k+1)=P(:,:,k)+(2*mu*e(i1,i2)*X)/(trace(X*X')+0.05);
        k = k+1;
    end
end
P=P(:,:,nxm+1);