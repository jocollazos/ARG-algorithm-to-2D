%%                           Función PSNR
% Documento: Extension and Analysis of the ARG algorithm to 2D
% Autor: Jhonatan Collazos, Pablo E. Jojoa. y  Juan P. Hoyos
%                IEEE Latin America Transactions  2022
%%
function[k] =psnr1(A,B)
[nm,nn] = size(A);  % tamaño 96 x96  M*N
nxm = nm*nn; 
D=A-B;
c=D.*D;
w=sum(c(:));
o=w/(nxm);
k=-10*log10(o);
end 