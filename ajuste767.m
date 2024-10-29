
Z={};
 Z1={};
% Z2={};
% Z3={};

% Z1=cell2mat(Z1);
% Z2=cell2mat(Z2);
% Z3=cell2mat(Z3);


% para ajuste random 
Z=cell2mat(Z);
Z1= cell2mat(Z1);
%a=Z(randperm(length(Z)));
% %a= Z.*1.2+0.15;
% %mean(a)
% plot(a, '.')
% %a=a';
%a=abs(fft(Z));

% %% analisis para obtener promedio de intra
% % [y1,X1]= size(Z1);
% % [y2,X2]= size(Z2);
% % [y3,X3]= size(Z3);
% % 
% % contadorY =1;
% % contadorX =1;
% % 
% % X=max([X1,X2,X3]);
% % y= max([y1,y2,y3]);
% % if x1<X
% %     
% % 
% % 
% % while contadorY <= y
% %     while contadorX <=X
% %         R=[Z1(contadorY,contadorX),Z2(contadorY,contadorX),Z3(contadorY,contadorX)];
% %         P{contadorY,contadorX}= mean(R);
% %         P{contadorY,contadorX}= mean(Z1(contadorY,contadorX),Z2(contadorY,contadorX),Z3(contadorY,contadorX));
% %         contadorX= contadorX+1;
% %     end
% %     contadorY=contadorY+1;
% % end 



a=Z1./Z;

% obtener correlacion entre ajuste y datos reales 
% [r,t]=xcorr(Z,Z1);
 r2= corrcoef(Z,Z1);

% estadistica
[h,p] = ttest(Z, Z1);
[p1,h1] = ranksum(Z, Z1);

