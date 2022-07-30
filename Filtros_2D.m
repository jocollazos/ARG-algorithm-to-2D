

%% Grafica: Imagenes recuperadas con los distintos filtros 
% Documento: Extension and Analysis of the ARG algorithm to 2D
% Autor: Jhonatan Collazos, Pablo E. Jojoa. y  Juan P. Hoyos
%%              IEEE Latin America Transactions  2022
%%
clear all;
close all;
addpath('funciones\')
tic
filterOrderNo=5;% Orden del filtro = filterOrderNo+1, filterOrderNo=6
image1= imread('cameraman.tif');
%image1= imread('moon.tif');
%image1= imread('pout.tif');
I =im2double(image1);% imagen del camaramen escalada a (0,1)
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
%%
[nm,nn] = size(image1);
imm = nm;
imn = nn; 

sel0=zeros(nm,nn);
sel1=zeros(nm,nn);
sel2=zeros(nm,nn);;;
h1=[1 -0.7 0.5 -0.05  0.0056 -0.0004];   %se mueve por la filas
h2=[1 -0.7 0.5 -0.045 0.0046 -0.0003];   %se mueve por la columnas


 for k=1:20 % Numero  de semillas aleatorias distintas 
N1=randn(size(I));
N1=im2double(N1);   
noiseim=I+N1;
prefixedimage =covid(h1,h2,N1); % filtro pasabajos para el ruido 
W=randn(filterOrderNo+1,filterOrderNo+1);
W=im2double(W);
% llamados de los distintos filtros 
[e] = SGLMS2D(prefixedimage,noiseim,filterOrderNo,W,m1,al,ga);%m1=1;al=1; ga=2.04; 
[e1] = SLMS2D(prefixedimage,noiseim,filterOrderNo,0.001,W);
[e2] = SNLMS2D(prefixedimage,noiseim,filterOrderNo,0.05,W);
sel0=sel0+e;
sel1=sel1+e1;
sel2=sel2+e2;

e=sel0/k;
e1=sel1/k;
e2=sel2/k;

MSE_gamma(:,k)=immse(I,e);
MSE_LMS(:,k)=immse(I,e1);
MSE_NLMS(:,k)=immse(I,e2);
 end
psnr1_in=psnr(I,noiseim) % psnr de entrada 
psnrgamma_out=psnr1(I,e) % psnr de salida 
psnr1ms_out=psnr1(I,e1) % psnr de salida 
psnrN1ms_out=psnr1(I,e2)

%plot(1:k,MSE_gamma,'r',1:k,MSE_LMS,'b',1:k,MSE_NLMS,'g');
e2=sel2/k;
e1=sel1/k;
e=sel0/k;

 


%  varN1=std2(N1)^2 % varianza del ruido 
%  medN1=mean2(N1) % Media del Ruido 
  psnr1_in=psnr(I,noiseim) % psnr de entrada 
  psnrgamma_out=psnr1(I,e) % psnr de salida 
  psnr1ms_out=psnr1(I,e1) % psnr de salida 
  psnrN1ms_out=psnr1(I,e2)
%end
figure

    subplot(2, 2, 1),imshow(e1), title('2D-LMS')  
    subplot(2, 2, 2), imshow(e), title('2D-ARgamma')
    subplot(2, 2, 3), imshow(e2), title('2D-NLMS')
    subplot(2, 2, 4), imshow(noiseim), title('imagen con Ruido')

  snrgamma_out=snr1(I,e) % psnr de salida 
  snr1ms_out=snr1(I,e1) % psnr de salida 
  snrN1ms_out=snr1(I,e2)

   err_gamma=immse(I,e) % psnr de salida 
  err_lms=immse(I,e1) % psnr de salida 
  err_Nlms=immse(I,e2)
 
  
RMSE_Gamma=sqrt(err_gamma)
RMSE_LMS=sqrt(err_lms)
RMSE_NLMS=sqrt(err_Nlms)

%  j=2
% N1=randn(size(I));
% N1=im2double(N1);   
% noiseim=I+(10^(1-j))*N1;
%  psnr_in=psnr(I,noiseim)