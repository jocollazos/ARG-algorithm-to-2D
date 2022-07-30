%%                                   Tiempo de ejecucion de los algoritmos 2D
% Documento: Extension and Analysis of the ARG algorithm to 2D
% Autor: Jhonatan Collazos, Pablo E. Jojoa. y  Juan P. Hoyos
%%              IEEE Latin America Transactions  2022
%%
clear all;
close all;
%%time 
tic
filterOrderNo=5;% Orden del filtro = filterOrderNo+1, filterOrderNo=6
image1= imread('cameraman.tif');
%image1= imread('moon.tif');
%image1= imread('pout.tif');
I =im2double(image1);% imagen del camaramen escalada a (0,1)

m1=11;
al=1;
ga=180;

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
prefixedimage =covid(h1,h2,N1);% filtro pasabajos para el ruido
W=randn(filterOrderNo+1,filterOrderNo+1);
W=im2double(W);
% llamados de los distintos filtros
[e] = SGLMS2D(prefixedimage,noiseim,filterOrderNo,W,m1,al,ga);%m1=1;al=1; ga=2.04; 
%[e] = SLMS2D(prefixedimage,noiseim,filterOrderNo,0.001,W);
%[e] = SNLMS2D(prefixedimage,noiseim,filterOrderNo,0.05,W);
sel0=sel0+e;
%sel1=sel1+e1;
%sel2=sel2+e2;

e=sel0/k;
%e1=sel1/k;
%e2=sel2/k;

 end
 %figure
% subplot(2, 2, 1),imshow(e1), title('2D-LMS')  
%imshow(e), title('2D-ARgamma')
toc
% subplot(2, 2, 3), imshow(e2), title('2D-NLMS')
% subplot(2, 2, 4), imshow(noiseim), title('imagen + randn(256,256)')

 