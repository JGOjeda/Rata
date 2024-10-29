% ANALISIS DE FRECUENCIA DESPUES DE SCRIPT JIMENA
clc; clear all; 

exp1=[];
exp2=[];
exp3=[];

%% comenzamos analisis 
L= size(exp1);
D= L(1);
L= L(2);

contadorL =1;

while contadorL <= 40
    z= [exp1(:,contadorL),exp2(:,contadorL)] ;
    contadorD = 1;
    while contadorD<= D
    p1= mean(z(contadorD,:));
    %z= [exp1(contadorD,contadorl),exp2(contadorD,contadorl)] ;
    P2{contadorD,contadorL}= p1;
    %P1{contadorD,contadorl}= mean(exp1(contadorD,contadorl),exp2(contadorD,contadorl));
    contadorD = contadorD+1;
    end
    contadorL = contadorL+1;
end 