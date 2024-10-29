%% script para medir la variacion pre y post estimulacion 
clear all; clc
AmpliNC={};%<--- introducimos vector ya normalizado del excel libro1 en graficas 
AmpliNS1={};%estimulacion 1
AmpliNB={};%basal 
AmpliNS2={};%estimulacion 2
%Control y estimulacion 
nC= length(AmpliNC);%tiempo del efecto de la estimulacion, usamos una pausa
    AmpliNC= cell2mat(AmpliNC);
nS1 = length(AmpliNS1);
    AmpliNS1= cell2mat(AmpliNS1);
nB = length(AmpliNB);
    AmpliNB= cell2mat(AmpliNB);
nS2 = length(AmpliNS2);
    AmpliNS2= cell2mat(AmpliNS2);

%% Procedemos a obtener el factor de fano (F)
%                 Variacion de ventana
% Formula de F = -----------------------
%                 promedio de ventana
%Variacion de ventana
%obtenemos promedio de ventana de 10 min 
  contadorp=1;
  contadorpX2=10 ;% input('intervalo de minutos promediados:'); %15 es el intervalo ed promedio
  contadorpX1=1;
 for i =1: nC
        if contadorpX2<= nC
                Envol1 = AmpliNC(contadorpX1:contadorpX2);
                Envol2 = mean(Envol1);
                EnvolC{contadorp,:} = Envol2;
                contadorp=contadorp+1;
                contadorpX1=contadorpX1+ 10;% contadorpX2;
                contadorpX2=contadorpX2+ 10;%contadorpX2;
        else 
          '.';  
        end
 end 
  contadorp=1;
  contadorpX2=10 ;% input('intervalo de minutos promediados:'); %15 es el intervalo ed promedio
  contadorpX1=1;
 for i =1: nS1
        if contadorpX2<= nS1
                Envol1 = AmpliNS1(contadorpX1:contadorpX2);
                Envol2 = mean(Envol1);
                EnvolS1{contadorp,:} = Envol2;
                contadorp=contadorp+1;
                contadorpX1=contadorpX1+ 10;% contadorpX2;
                contadorpX2=contadorpX2+ 10;%contadorpX2;
        else 
          '.';  
        end
 end 
  contadorp=1;
  contadorpX2=10 ;% input('intervalo de minutos promediados:'); %15 es el intervalo ed promedio
  contadorpX1=1;
 for i =1: nB
        if contadorpX2<= nB
                Envol1 = AmpliNB(contadorpX1:contadorpX2);
                Envol2 = mean(Envol1);
                EnvolB{contadorp,:} = Envol2;
                contadorp=contadorp+1;
                contadorpX1=contadorpX1+ 10;% contadorpX2;
                contadorpX2=contadorpX2+ 10;%contadorpX2;
        else 
          '.';  
        end
 end 
  contadorp=1;
  contadorpX2=10 ;% input('intervalo de minutos promediados:'); %15 es el intervalo ed promedio
  contadorpX1=1;
 for i =1: nS2
        if contadorpX2<= nS2
                Envol1 = AmpliNS2(contadorpX1:contadorpX2);
                Envol2 = mean(Envol1);
                EnvolS2{contadorp,:} = Envol2;
                contadorp=contadorp+1;
                contadorpX1=contadorpX1+ 10;% contadorpX2;
                contadorpX2=contadorpX2+ 10;%contadorpX2;
        else 
          '.';  
        end
   end 
   EnvolC= cell2mat(EnvolC);
   EnvolS1= cell2mat(EnvolS1);
   EnvolB= cell2mat(EnvolB);
   EnvolS2= cell2mat(EnvolS2);
%    Envol= Envol';
%    Envol3 = repelem(Envol, 10);
% Vc = var(AmpliNC);
% VSS1= var(AmpliNS1);
% VSB = var(AmpliNB);
% VSS2= var(AmpliNS2);

%promedio de ventana 
PC = mean(AmpliNC);
PS1= mean(AmpliNS1);
PB = mean(AmpliNB);
PS2= mean(AmpliNS2);

%obtencion del factor de fano
FC = ((EnvolC.^2)-(PC.^2))./PC;
FC = abs(mean(FC));
FS1= ((EnvolS1.^2)-(PS1.^2))./PS1;
FS1 = abs(mean(FS1));
FB = ((EnvolB.^2)-(PB.^2))./PB;
FB = abs(mean(FB));
FS2= ((EnvolS2.^2)-(PS2.^2))./PS2;
FS2= abs(mean(FS2));
%Factore de Fano por ventana 
F={FC,FS1,FB,FS2};

'Terminado :D'




