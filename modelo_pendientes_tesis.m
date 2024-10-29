%% Scrip para probar modelo
%donde 
close all; clc; clear all 
S= input('Escribe minutos de estimulacion:');
t= [0:155];%tiempo del experimento 
%in= (3*S*t).^(-1/(3*S));
%At=-in*(-3.86+S)+1;
%E= -sin((1+3*S)/3*S)+1;
%in= sin(-3.86+S)/(sin((1+3*S)/3*S)+1);
%At=1-in*t.^E;

%% parametros del rudio 
S2 = [0:0.01:S];%length(S)]; %vector de tiempo 
AM = 0.600 ;%amplitud 
pha = 0; %fase
f = (101:640); %frecuencia 
l = length(t);
f2= datasample(f,l); %frecuencia para aplicar 
%T = 1./f; %periodo

%N= Am.*sin(2.*pi.*f2.*t+pha);
A=(sin((-3.86+S))*t.^(-1.*sin((S+0.33)/S)));%<----------este es MODELO bueno
A2=(A.*t)+1;
plot(A2)
%A=(AM*sin(101*(-3.86+S))*t.^(-1.*sin((S+0.33)/S)));%<----------este es MODELO bueno
    contador= 1;
while contador <= l
    A=(sin((-3.86+S))*t(contador)^(-1*sin((S+0.33)/S)));
    A2{contador,:}= A;
    contador=contador +1;
end

A3=cell2mat(A2);
hold on 
plot(A3)


% A4=(A3*t)+1;
% plot(A4)
