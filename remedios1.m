%modelo de remedios 2019 para actividad de canales mas ruido 
clear all
clc
%
%ES= input('Escribe minutos de estimulacion:');
%% estimulacion 
%noise
%ES=ES*60000;
%i=[0:ES];
i=[0:250];%<-- este es el del modelo
t=2.^i;
ai= randperm(length(i));%<-- este es el del modelo
%ai=ai(1);
Xmean= mean(i);
rho= var(i);

Fxt= ai.*(sin(pi*t)); 
plot(Fxt)


%rampa
vt=i;
contador=1;
while contador<=25
vt(:,contador) = (-80);
contador = contador+1;
 end 
while contador<=125
vt(:,contador) = (-100);
contador = contador+1;
end 
while contador<=226
vt(:,contador) = 1.4*vt(:,contador)-275;%-600;
contador = contador+1;
 end 
while contador<=251
vt(:,contador) = -80;
contador = contador+1;
 end 
plot(vt)

 Vstim= vt+ Fxt;
 plot(Vstim)
% 
 %% Hodking huxley model
%  amVstim= exp(0.5*)
%Am= (0.1*(V+25))./(exp((V+25)/10)-1);
V=Vstim;
Va=(V+25);
Vas=(0.1*Va);
Vai=(exp((Va)/10)-1);
Am=Vas./Vai;
plot (V,Am)

Bm=4*exp(V/18);
hold on 
plot(V,Bm)
