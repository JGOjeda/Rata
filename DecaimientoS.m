%% encotrar el ajuste exponencial correcto 
close all 
clear all; clc

%% datos reales, experimenteles 
A5R={};%<---- DATOS EXPERIMENTALES
A5R=A5R'; A5R= cell2mat(A5R);
T5=length(A5R);
t=[1:T5]; %tiempo
n = input('introduce minutos de estimulacion:');% este se puede aut
plot(A5R)

%% modelo de pendientes
%A=((-4+n)*t.^(-1.*((n+0.33)/n))); %modelo original 
%A=(sin(-3.86+n)*t.^(-1.*sin((n+0.33)/n)));%<----------este es MODELO bueno

%% modelo con parametros de rudio 
%t = [0:0.01:15];%length(S)]; %vector de tiempo 
AM = .600 ;%amplitud 
pha = 0; %fase
f = (0.101:0.1:0.640); %frecuencia 
l = length(t);
f2= datasample(f,l); %frecuencia para aplicar 
T = 1./f; %periodo

A=(AM*sin((-3.86+n))*t.^(-1.*sin((n+0.33)/n)));%<----------este es MODELO + Ampliud de RUDIO
%N= A.*sin(2.*pi.*f.*t+pha);
%N= Am.*sin(2.*pi.*f2.*t+pha);
% Al=sin(f2.*(-3.86+n));
% Base = AM*Al;
% %A=(Base.*(t.^(-1*sin(((n+0.33)/n)))));%<--este es MODELO + Ampliud y Hz de RUDIO

R= corrcoef(A5R,A);
hold on 
plot(A)
%%

A2=(A.*t)+1;
plot(A2)

% %% procedemos a obtener la envolvente con la finalidad de encontrar puntos
%   contadorp=1;
%   contadorpX2=10 ;% input('intervalo de minutos promediados:'); %15 es el intervalo ed promedio
%   contadorpX1=1;
% for i =1: T5
%  if contadorpX2<= T5
%      Envol1 = A2(contadorpX1:contadorpX2);
%      Envol2 = mean(Envol1);
%      Envol{contadorp,:} = Envol2;
%      contadorp=contadorp+1;
%      contadorpX1=contadorpX1+ 10;% contadorpX2;
%      contadorpX2=contadorpX2+ 10;%contadorpX2;
%  else 
%           '.';  
%  end 
% end
%    Envol= cell2mat(Envol);
%    Envol= Envol';
%    Envol3 = repelem(Envol, 10);
%     %% Suavizar 
%  tiempo2= 1:length(Envol3);
%  A4= smooth (tiempo2,Envol3,0.07,'loess');%% ES LA LINEA
%  plot(A4)
 
hold on
A3=(A5R.*t)+1;
plot(A3)

