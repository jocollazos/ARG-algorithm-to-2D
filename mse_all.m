clear all;
close all;
%%
% Grafica: MSE
% Documento: Extension and Analysis of the ARG algorithm to 2D
% Autor: Jhonatan Collazos, Pablo E. Jojoa. y  Juan P. Hoyos
%                IEEE Latin America Transactions  2022
%%
addpath('funciones\')
tic
filterOrderNo=5;
image1= imread('cameraman.tif');
image2= imread('moon.tif');
image3= imread('pout.tif');
I1 =im2double(image1);% imagen del camaramen escalada a (0,1)
I2 =im2double(image2);% imagen del camaramen escalada a (0,1)
I3 =im2double(image3);% imagen del camaramen escalada a (0,1)
%%                                     Ajustes del algoritmo ARGamma
% m1=11;
% al=0.75;
% ga=100;
m1=11;
al=1;
ga=180;
% m1=0.001;
% al=0.11;
% ga=100;
[nm,nn] = size(image1);
[nm2,nn2] = size(image2);
[nm3,nn3] = size(image3);

sel0=zeros(nm,nn);
sel1=zeros(nm2,nn2);
sel2=zeros(nm3,nn3);;;

h1=[1 -0.7 0.5 -0.05  0.0056 -0.0004];   %se mueve por la filas
h2=[1 -0.7 0.5 -0.045 0.0046 -0.0003];   %se mueve por la columnas

 for k=1:300 % Numero  de semillas aleatorias distintas
N1=randn(size(I1));
N2=randn(size(I2));
N3=randn(size(I3));

%N1=im2double(N1);   
noiseim1=I1+N1;
noiseim2=I2+N2;
noiseim3=I3+N3;
% filtro pasabajos para el ruido
prefixedimage1 =covid(h1,h2,N1); 
prefixedimage2 =covid(h1,h2,N2);
prefixedimage3 =covid(h1,h2,N3);
W=randn(filterOrderNo+1,filterOrderNo+1);
W=im2double(W);
% llamados de los distintos filtros
[e] = SGLMS2D(prefixedimage1,noiseim1,filterOrderNo,W,m1,al,ga);%m1=1;al=1; ga=2.04; 
[e1] = SGLMS2D(prefixedimage2,noiseim2,filterOrderNo,W,m1,al,ga);%m1=1;al=1; ga=2.04; 
[e2] = SGLMS2D(prefixedimage3,noiseim3,filterOrderNo,W,m1,al,ga);%m1=1;al=1; ga=2.04; 
sel0=sel0+e;
sel1=sel1+e1;
sel2=sel2+e2;

e=sel0/k;
e1=sel1/k;
e2=sel2/k;

MSE_gamma(:,k)=immse(I1,e);
MSE_LMS(:,k)=immse(I2,e1);
MSE_NLMS(:,k)=immse(I3,e2);
end
semilogy(1:k,MSE_gamma,'r',1:k,MSE_LMS,'b',1:k,MSE_NLMS,'g');
set(gca,'FontSize',12);       
set(gca,'Box','on');     
legend('Cameraman','Moon','Pout')
xlabel('Iteraciones'),ylabel('Mean square error (MSE)')
grid on;
axis([0 300 0 20])

e2=sel2/k;
e1=sel1/k;
e=sel0/k;

 toc
% figure
% 
%     subplot(2, 2, 1),imshow(e1), title('cameraman')  
%     subplot(2, 2, 2), imshow(e), title('moon')
%     subplot(2, 2, 3), imshow(e2), title('pout')
%     subplot(2, 2, 4), imshow(noiseim), title('imagen + randn(256,256)')
% figure 
% 
% %  varN1=std2(N1)^2 % varianza del ruido 
% %  medN1=mean2(N1) % Media del Ruido 
%  % psnr1_in=psnr(I,noiseim) % psnr de entrada 
%  
%   psnrgamma_out=psnr1(I1,e) % psnr de salida 
%   psnr1ms_out=psnr1(I2,e1) % psnr de salida 
%   psnrN1ms_out=psnr1(I3,e2)
%   
%   snrgamma_out=snr1(I1,e) % psnr de salida 
%   snr1ms_out=snr1(I2,e1) % psnr de salida 
%   snrN1ms_out=snr1(I3,e2)
% 
%    err_gamma=immse(I1,e) % psnr de salida 
%   err_lms=immse(I2,e1) % psnr de salida 
%   err_Nlms=immse(I3,e2)
%  
%   
% RMSE_Gamma=sqrt(err_gamma)
% RMSE_LMS=sqrt(err_lms)
% RMSE_NLMS=sqrt(err_Nlms)
