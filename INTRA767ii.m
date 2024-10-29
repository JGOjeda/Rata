%% Amplitud es un script para obtener datos para graficas de Amplitud en
%microvolt vs tiempo, de los promedios 
close all;
clear all;
clc;

% n = input('escribe el numero de señales a procesar de la 1 a la n: ');
% EEG = input('escribe el canal de la corteza: ');
% ECG = input('escribe el canal del corazon: ');
% fm = input('escribe la frecuencia de muestreo: ');
 Am= input('Escribe la amplificacion realizada:');
%  Ctl= input('Escribe minutos control :');
%  M2= input('Escribe minutos de registro 2m:');
%  M5= input('Escribe minutos de registro 5m:');

%% abrimos la ubicacion de lo archivos y en listamos sus nombres 
[filename pathname] = uigetfile('*.abf', 'seleccion archivos abf', 'Multiselect', 'on');
%enlistamos nombre de archivos 
     if length(filename(1,:)) > 1
      filename = filename'; %generamos una columna con los nombres de los datos 
      number = length(filename); %contamos cantidad de archivos seleccionados 
     else
        number = length(filename(:,1)); %si solo se selecciona uno, 1 sera el valor 
     end



     %% preparamos bucle donde todos los datos se abren 
     contador = 1; 
   while contador <= number 
       %damos direccion y nombre del archivo a abrir, es importante sino no
       %jala 
        if length(filename(:,1)) > 1
            file = strcat(pathname,filename(contador))
            file = file{1};
        else
            file = strcat(pathname,filename)
        end
        %Cargamos datos de .abf
        si = abfload(file);
        contador2=1;
        %accesamos a los valores de la 3era columna del registro de la matriz 5000*4*61 para cada archivo
        %hacemos una matriz llamada s2, 
        % #columnas  = al numero de archivos seleccionados 
        % #filas = al numero de Sweeps, en este caso seran 61, 60 + 1 que
        % será el promedio 
        s2{:,contador}= si(:,3); %<<<<<<<-------------CAMBIAMOS 2 POR 3 PARA EL 767

       contador= contador+1;             
   end


    %% procedemos a obtener el valor al pico y el basal 
               contadorX = 1; %este en y 
               contadorY = 1; %este en X
               P= 1536; %tiempo en que debe de aparecer el potencial 

while contadorY < contador
%        z2= size(s2);
%        z2= z(1);
       %POTENCIAL DE SUPERFICIE
       %DeltaBN = s2(z2, contadorY);
       DeltaBN = s2(1, contadorY);%
       DeltaBN2= cell2mat(DeltaBN);
       DeltaBN3= DeltaBN2;%<<<<<<<<<<-------------CAMBIAR POR EXPERIMENTO 
       %DeltaBN4= ((DeltaBN3(900)- min(DeltaBN3))/Am)*1000000; %Obtengo el valor en microvoltios 
       %DeltaBN4= ((DeltaBN3(900)- min(DeltaBN3(1:P)))/Am)*1000000; %Obtengo el valor en microvoltios, considero tiempo de aparicion 
       DeltaBN4= abs(((0- min(DeltaBN3(1:P)))/Am)*1000000); %correcion a cero 
       AmpliBN{contadorX,:}= DeltaBN4; %COPIAR Y PEGAR EN SIGMA U OTRO GRAFICADOR

       %POTENCIAL INTRA767
%        DeltaBN = s2(61, contadorY);
%        DeltaBN2= cell2mat(DeltaBN);
       Delta3767= DeltaBN2;%(:,4);%<<<<<<<<<<-------------CAMBIAR POR EXPERIMENTO 
       Delta4767= abs(((0- min(Delta3767(1:P)))/Am)*1000000); %correcion a cero 
       Ampli767{contadorX,:}= Delta4767;
%        
       contadorY= contadorY+1;
       contadorX=contadorX+1;
end 

%% Procedemos  a hacer el vector para graficar SUPERFICIE

   %POTENCIAL SUPERFICIE
   AmpliBN2= cell2mat(AmpliBN);
   AmpliBN2= AmpliBN2';
   %AmpliBN2= AmpliBN2(randperm(length(AmpliBN2))) %FORZAMOS VALOR CONTROL 
   tiempo = 1:length(AmpliBN2);
   figure
   plot(tiempo, AmpliBN2,'.') %se grafica la actividad con valores reales

   %POTENCIAL INTRA767
   Ampli7672= cell2mat(Ampli767);
   Ampli7672= Ampli7672';
   %AmpliBN2= AmpliBN2(randperm(length(AmpliBN2))) %FORZAMOS VALOR CONTROL 
   tiempo = 1:length(Ampli7672);
   figure
   plot(tiempo, Ampli7672,'.')