%%                           Función SNR
% Documento: Extension and Analysis of the ARG algorithm to 2D
% Autor: Jhonatan Collazos, Pablo E. Jojoa. y  Juan P. Hoyos
%                IEEE Latin America Transactions  2022
%%
function[k] =snr1(A,B)

e=A.*A;
D=A-B;
c=D.*D;
r=sum(e(:));
w=sum(c(:));
o=r/w;
k=10*log10(o);
end 