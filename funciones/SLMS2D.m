
function [e] = SLMS2D(prefixedimage,noiseim,filterOrderNo,mu,W)
 %if (mu<=10^(-2))
%% S: step -- ????? filterOrderNo -- ??????R ?initialCoefficients -- ???????W0 
[nm,nn] = size(prefixedimage);
outputImage = zeros(nm, nn);
e = zeros(nm, nn); %fspecial('gaussian',[nm nn]);% zeros(nm, nn);
tres = filterOrderNo+1;          % ??????? R
% tamaño 96 x96  M*N
nxm = nm*nn;    % ???? = ??????
k= 1;
prefixedimage(:,(nn+1):(nn+filterOrderNo)) = 0;  % ???????????????????????prefixedimage,???????M*N?????????F??prefixedimage????(M+F) * (N+F)
prefixedimage((nm+1):(nm+filterOrderNo),:) = 0;
P=zeros(tres,tres,nxm);
P(:,:,k)=W;
 O=zeros(3,3);
%for t=1:2

for i1 = 1:nm
    for i2 = 1:nn
        % Y = W * X ????
        X = prefixedimage(i1+(tres-1):-1:i1, i2+(tres-1):-1:i2); %regresor
        ex1 = P(:,:,k).*X ;   % Producto dos puntos entre matrices
        %ex1 = P(:,:,k)'*X;
        %outputImage(i1,i2) = trace(ex1);                                    %nuevo enfoque, preguntarle al profesor Jojoa 
        outputImage(i1,i2) = sum(ex1(:));                                    %como esta planteado en el articulo MOHIY (1988)
        e(i1,i2) = noiseim(i1,i2)-outputImage(i1,i2);
        %X = prefixedimage(i1:1:tres-1+i1, i2:1:tres-1+i2);
        P(:,:,k+1)=P(:,:,k)+2*mu*e(i1,i2)*X;

         k = k+1;
     
        
    end
     
end
P=P(:,:,nxm+1);









































%end

% else mu==10^(-2)
     
     %% S: step -- ????? filterOrderNo -- ??????R ?initialCoefficients -- ???????W0 
% [nm,nn] = size(x);
%  outputImage = zeros(nm, nn);
%  
%  
% 
% tres = filterOrderNo+1;          % ??????? R
% tamaño 96 x96  M*N
% nxm = nm*nn;    % ???? = ??????
%  
% Pre-allocations
% e = zeros(nm, nn);  % ??? E
% ??? Y
% outImage = zeros(nm, nn);
% W = zeros(tres,tres,nxm); % ????R*R, ???????????W
% 
% k= 1;
% Initial state of the weight vector
% W(:,:,1) = WI;   % ruido gaussino 3x3 ???????
%  
% Prefixed input
% x = x;
%  
% x(:,(nn+1):(nn+filterOrderNo)) = 0;  % ???????????????????????prefixedimage,???????M*N?????????F??prefixedimage????(M+F) * (N+F)
% x((nm+1):(nm+filterOrderNo),:) = 0;
%  
% 
% Body
% for i1 = 1:nm
%     for i2 = 1:nn
%         Y = W * X ????
%         X = x(i1+(tres-1):-1:i1, i2+(tres-1):-1:i2);
%         
%          ex1 = W(:,:,k).*X;                                               % como esta planteado en el articulo MOHHY
%         ex1 = W(:,:,k)*X';
%         outputImage(i1,i2) = trace(ex1);                                    %nuevo enfoque, preguntarle al profesor Jojoa 
%    
% 
%         outputImage(i1,i2) = sum(ex1(:));                                    %como esta planteado en el articulo MOHIY (1988)
%         
%         ???
%         e(i1,i2) = d(i1,i2) - outputImage(i1,i2);
%         
%         ??????
%         W(:,:,k+1) = W(:,:,k) + (2*mu*e(i1,i2)*X);
%         
%         k = k+1;
%     end
% end
     
%  end




%%

%%
%T=psnr(outputImage,d)
%K=psnr(outputImageA,d)
%plot(T)


