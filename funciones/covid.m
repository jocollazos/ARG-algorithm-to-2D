%%                           Función Filtro pasabajos del Ruido 
% Documento: Extension and Analysis of the ARG algorithm to 2D
% Autor: Jhonatan Collazos, Pablo E. Jojoa. y  Juan P. Hoyos
%                IEEE Latin America Transactions  2022
%%
function[final]=covid(h1,h2,Ag)

[Y1,X2]=size(Ag);
n1h=length(h1)-1;
n2h=length(h2)-1;
[Y,X]=size(Ag);
Ag(:,X2+1:X2+n1h) = 0;  
Ag(Y1+1:Y1+n2h,:) = 0;
[Y,X]=size(Ag);
Ag=double(Ag);
% for y=1:Y
%         Agh1(y,:)=conv(Ag_d(y,:),h1);
% end
% for x=1:X
%         Agh2(:,x)=conv(Agh1(:,x),h2);
% end
Agf=Ag(1:Y1,1:X2); %ajuste al tamaño original
Agf(Y1+1:Y+n1h,X2+1:X2+n2h)=0;
for x=1:X
        Agh3(:,x)=deconv(Agf(:,x),h2);
end
for y=1:Y
        Agh4(y,:)=deconv(Agh3(y,:),h1);
end
final=Agh4(1:Y1,1:X2);



end