%% Jimena es un script para hacer FFT de actividad basal  
%microvolt vs tiempo, de los promedios 

close all; clear all; clc;

Am= input('Escribe la amplificacion realizada:');

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
       %damos direccion y nombre del archivo a abrir, es importante sino no jala 
        if length(filename(:,1)) > 1
            file = strcat(pathname,filename(contador))
            file = file{1};
        else
            file = strcat(pathname,filename)
        end
        %Cargamos datos de .abf
        si = abfload(file);
     
        BOLITA{1,contador}=si(:,2); %datos registro bolita
        INTRA{1,contador}=si(:,3); %datos de registro intracortical
        contador= contador+1;             
   end

   %% procedemos a analizar datos 
INTRA=cell2mat(INTRA);
DIM= size(INTRA);
Datos= DIM(2);
BOLITA = cell2mat(BOLITA);

%PARAMETROS INICIALES
Fs = 10000;
Ts = 1/Fs; %periodo de muestreo 
L  = DIM(1);%longitud 
contador=1;% 
    %% espectro de frecuencias
while contador<= Datos
    %intra
    y = fft(INTRA(:,contador)); %TRASNFORMADA
    %P1{1,contador} = (abs(y(1:L/2)/L));     %MITAD DE VECTOR con fft
    P1{1,contador} = (abs(y(2:90)/L));     %Hasta 90 Hz de frecuencia DE VECTOR con fft
    AreaI{1,contador} = trapz(abs(y(1:L/2)/L)); %OBTENEMOS AREA DE VECTOR 


    %bolita
    y2 = fft(BOLITA(:,contador)); %TRASNFORMADA
    %P2{1,contador} = (abs(y2(2:L/2)/L));     %MITAD DE VECTOR con fft
    P2{1,contador} = (abs(y2(2:90)/L));     %Hasta 90 Hz de frecuencia DE VECTOR con fft
    AreaB{1,contador} = trapz(abs(y2(1:L/2)/L)); %OBTENEMOS AREA DE VECTOR

     contador=contador+1;

end 

P1= cell2mat(P1);
AreaI= cell2mat(AreaI);
AreaI2=AreaI';

P2= cell2mat(P2);
AreaB= cell2mat(AreaB);
AreaB2=AreaB';
'TERMINADO :D'







