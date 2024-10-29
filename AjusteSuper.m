clc; clear all; close all; 

V= []; % vector voltaje medido al punto maximo 
V=V'; % se transpone 

T= [0:60]; %minutos 

[y,x]=max(V);
p1=x-5;
p2=x+5;
K= mean(V(p1:p2)); % obtencion del valor maximo
n0= V(1); %condicion inicial
%parametros a estimar r va a ser probabilidad 0 a 1
hr= 0.1; %tamaño de paso 
vr= 0:hr:1; 
m=length(vr); %calcular el tamaño vector
for i=1:m
    r=vr(i);
    Nr=K*n0./(K-n0).*exp(-r.*T)+n0;
    Error(i)=sum((Nr-T).*2);
end
Stt=sum((V-mean(V)).^2);%desviacion estandar
[SSE,pr]=min(Error);
r=vr(pr); %valor de r con minimo error
R2= 1-SSE/Stt; %valor de R cuadrado
% graficamos la solucion
t=linspace(T(1),T(end), 50);
N=K*n0./((T-n0).*exp(-r.*t)+n0); %reemplazamos 
hold on
plot(t,N,'r','LineWidth',2)
