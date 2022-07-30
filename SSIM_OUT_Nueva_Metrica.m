clear all;
close all;

%% PSNR in VS SSIM
% Grafica: PSNR in VS SSIM
% Documento: Extension and Analysis of the ARG algorithm to 2D
% Autor: Jhonatan Collazos, Pablo E. Jojoa. y  Juan P. Hoyos
%                IEEE Latin America Transactions  2022
%%
addpath('funciones\')
filterOrderNo=5;% Orden del filtro = filterOrderNo+1 entonces filterOrderNo=6
image1= imread('cameraman.tif');
%image1= imread('moon.tif');
%image1= imread('pout.tif');
I =im2double(image1);% imagen del camaramen escalada a (0,1)
%% ajustes del algoritmo ARGamma
m1=0,01;
al=0.11; %0.81
ga=0.11; %0.001
%%
[nm,nn] = size(image1);
imm = nm;
imn = nn; 
j=[];
sel0=zeros(nm,nn,10);
sel1=zeros(nm,nn,10);
sel2=zeros(nm,nn,1041);;;
h1=[1 -0.7 0.5 -0.05  0.0056 -0.0004];   %se mueve por la filas
h2=[1 -0.7 0.5 -0.045 0.0046 -0.0003];   %se mueve por la columnas
for i=1:1000
N1(:,:,i)=randn(size(I));
N1(:,:,i)=im2double(N1(:,:,i)); 
noiseim3(:,:,i)=I+N1(:,:,i);
a=psnr(I,noiseim3(:,:,i));
if (abs(a) <= 0.0001)
     j=i;
else k=i   
 end
w(:)=j;
end
w;
psnr(I,noiseim3(:,:,j));
N1=N1(:,:,j);
for j=1:10

 for k=1:20
  
%N1=randn(size(I));
%N1=im2double(N1);   
noiseim=I+sqrt(1/j^2)*N1;% agrega ruido con varianza variable

% ssim(I,noiseim)
prefixedimage =covid(h1,h2,N1);
W=randn(filterOrderNo+1,filterOrderNo+1);
W=im2double(W);
if j<=2 
[e(:,:,j)] = SGLMS2D(prefixedimage,noiseim,filterOrderNo,W,11,1,180);%m1=1;al=1; ga=2.04;
else 
    [e(:,:,j)] = SGLMS2D(prefixedimage,noiseim,filterOrderNo,W,m1,al,ga);%m1=1;al=1; ga=2.04;
end 
[e1(:,:,j)] = SLMS2D(prefixedimage,noiseim,filterOrderNo,0.001,W);
[e2(:,:,j)] = SNLMS2D(prefixedimage,noiseim,filterOrderNo,0.05,W);
sel0(:,:,j)=sel0(:,:,j)+e(:,:,j);
sel1(:,:,j)=sel1(:,:,j)+e1(:,:,j);
sel2(:,:,j)=sel2(:,:,j)+e2(:,:,j);

e(:,:,j)=sel0(:,:,j)/k;
e1(:,:,j)=sel1(:,:,j)/k;
e2(:,:,j)=sel2(:,:,j)/k;

% MSE_gamma(:,k)=immse(I,e);
% MSE_LMS(:,k)=immse(I,e1);
% MSE_NLMS(:,k)=immse(I,e2);
 end
 psnr(I,noiseim);
 ssim(I,noiseim);
psnr1_in(:,:,j)=psnr(I,noiseim); % psnr de entrada 
psnrgamma_out(:,:,j)=ssim(I,e(:,:,j)); % psnr de salida 
psnr1ms_out(:,:,j)=ssim(I,e1(:,:,j)) ;% psnr de salida 
psnrN1ms_out(:,:,j)=ssim(I,e2(:,:,j));
end

 j=1
 plot([psnr1_in(:,:,j) psnr1_in(:,:,j+1) psnr1_in(:,:,j+2) psnr1_in(:,:,j+3) psnr1_in(:,:,j+4) psnr1_in(:,:,j+5) psnr1_in(:,:,j+6) psnr1_in(:,:,j+7) psnr1_in(:,:,j+8) psnr1_in(:,:,j+9)],psnrN1ms_out(:),'r',[psnr1_in(:,:,j) psnr1_in(:,:,j+1) psnr1_in(:,:,j+2) psnr1_in(:,:,j+3)  psnr1_in(:,:,j+4) psnr1_in(:,:,j+5) psnr1_in(:,:,j+6) psnr1_in(:,:,j+7) psnr1_in(:,:,j+8) psnr1_in(:,:,j+9)],psnr1ms_out(:),'b',[psnr1_in(:,:,j) psnr1_in(:,:,j+1) psnr1_in(:,:,j+2) psnr1_in(:,:,j+3)  psnr1_in(:,:,j+4) psnr1_in(:,:,j+5) psnr1_in(:,:,j+6) psnr1_in(:,:,j+7) psnr1_in(:,:,j+8) psnr1_in(:,:,j+9)],psnrgamma_out(:),'g');
 set(gca,'FontSize',12);       
 set(gca,'Box','on');     
 legend('2D-NLMS','2D-LMS','2D-AR\gamma')
 xlabel('PSNR IN');
 ylabel('SSIM');
 grid on;
 axis([0 20 0 1])
% e2=sel2/k;
% e1=sel1/k;
% e=sel0/k;
% 
%   psnr1_in=psnr(I,noiseim) % psnr de entrada 
%   psnrgamma_out=psnr1(I,e) % psnr de salida 
%   psnr1ms_out=psnr1(I,e1) % psnr de salida 
%   psnrN1ms_out=psnr1(I,e2)