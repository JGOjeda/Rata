%% hacemos vector para almacenar datos del script amplitud, delta5
%paramos el script en AmpliBN
clc, clear all 
AmpliN={};%<--- introducimos vactor ya normalizado del excel libro1 en graficas 
number= length(AmpliN)%tiempo del efecto de la estimulacion, usamos una pausa
AmpliBN2= cell2mat(AmpliN);

pc = input('introduce promedio control:');% este se puede automatizar usando el promedio general

plot(AmpliBN2,'.')

 %% procedemos a obtener la envolvente con la finalidad de encontrar puntos
   %de inflexion 
  %AmpliBN3= cell2mat(AmpliBN)
  contadorp=1;
  contadorpX2=10 ;% input('intervalo de minutos promediados:'); %15 es el intervalo ed promedio
  contadorpX1=1;

   for i =1: number
%         contadorp=1;
%         contadorpX2=5;
%         contadorpX1=1;
        if contadorpX2<= number
                Envol1 = AmpliBN2(contadorpX1:contadorpX2);
                Envol2 = mean(Envol1);
                Envol{contadorp,:} = Envol2;
                contadorp=contadorp+1;
                contadorpX1=contadorpX1+ 10;% contadorpX2;
                contadorpX2=contadorpX2+ 10;%contadorpX2;
        else 
          '.';  
        end
   end 

   Envol= cell2mat(Envol);
   Envol= Envol';
   Envol3 = repelem(Envol, 10);
 
   %% Suavizar 
 tiempo2= 1:length(Envol3);
 AmpliBN3= smooth (tiempo2,Envol3,0.07,'loess');%% ES LA LINEA
 hold on 
 plot(AmpliBN3)
 
 %% obtener pendiente al punto maximo
number= length(AmpliBN3);
 AmpliBN3=AmpliBN3';  
[AmpliM,tiempoM]= max(AmpliBN3(1:number)); %USAR EN 5 MIN y 4MIN
%[AmpliM,tiempoM]= min(AmpliBN3(1:number));%USAR EN 2 MIN
%AmpliM= AmpliBN3; tiempoM=[1:number]; %USAR EN CONTROL 

%% modelo1 solo Para el punto maximo 1 PENDIENTE
P=(AmpliM-pc)/tiempoM; 
t=[1:number];%TIEMPO DE EN MINUTOS DEL EFECTO DE LA ESTIMULACION  
te=[1:tiempoM];%TIEMPO DE EN MINUTOS DEL EFECTO al punto maximo, NO LO USAMOS   
A=(P*(t))+1;

%% modelo2 vector de modelos de pendientes hasta el punto maximo VARIAS
%***PENDIENTES
Pv=(AmpliBN3-pc)./t; %pendientes <--- **COPIAR PARA MOSTRAR DECAIMIENTO EN PENDIENTES, SE PUEDE AJUSTAR A EXP
PvE=Pv(1:tiempoM); % Pendientes al maximo o minimo 
%PvE=Pv; % solo para el control
%dVdt=(AmpliBN3-pc+t)./t;% para prueba uniendo todo 
dVdt=(AmpliBN3.*t-pc.*t+t)./t;% para prueba uniendo todo 
PvI=PvE; %USAR CUANDO EL MAXIMO ES MENOR QUE 30 EN DECIMATE
PvS= std(PvI);
PvP= mean(PvI);
A3=(PvP*t)+1;%<-- copiar, vector promedio 
contadorT=1;
contadorX=1;

while contadorT< tiempoM
A2= (Pv(contadorX)*t)+1; %todos las rectas hasta el punto maximo
PyR{:,contadorX}= A2;

contadorT =contadorT+1;
contadorX = contadorX+1;
% hold on
% plot(t,A2)
end

PyR=PyR';
PyR2=cell2mat(PyR);
PyR3=PyR2';
Puntos=[1:10:tiempoM];
PyR4=PyR3(:,Puntos);%<---- COPIAR, PENDIENTES CON RESPECTIVAS RECTAS POR INTERVALO DE 10 MIN, GRAFICAR Y PROMEDIAR 

hold on 
plot (t,A)

%%
 'TERMINADO :D'