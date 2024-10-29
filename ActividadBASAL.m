%ESTE ES UN SCRIPT PARA:
% 1.ABRIR DOCUMENTO 
% 2.RECTIFICAR
% 3.OBTENER FFT
% 4. INTEGRAR TRAPEZOIDALMENTE (AREAS)

%% Amplitud es un script para obtener datos para graficas de Amplitud en
%microvolt vs tiempo, de los promedios 
close all; clear all; clc;
Am= input('Escribe la amplificacion realizada:');
%Bloque= input('Cuantas profundidades se hicieron por bloque:');

%% parametros iniciales 

Fs =10000;                                          %frecuencia de muestreo
T = 1/Fs;                                                 % Sampling period 

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
   %parametros para fft   
       
        si = abfload(file);
        L= size(si);
        L= L(1);       % Longitud de la señal 
        t = (0:L-1)*T; % Time vector
        dim= 2;        %dimension 
        Fs =10000;     %frecuencia de muestreo
        T = 1/Fs;      % Sampling period 

  %Cargamos datos de .abf
        %señal de superficie 
        SUPER = si(:,2);
        Fy = fft(SUPER);            % obtenemos transformada del valor rectificado
        MFy = abs(Fy/L);            %Usamos la parte real del fft  valores de la transformada de FFT
        f = Fs*(0:length(MFy)-1)/L; %valores de frecuencia de la transformada
        %plot(f(1:floor(L/2)),MFy(1:floor(L/2))); % graficamos la fft realizada 
        AreaS= trapz(MFy)/2;        %integracion trapezoidal 
        %vectores de informacion 
        FourierS{:,contador} = MFy(1:floor(L/2)); %COPIAR Y PEGAR EN SIGMA U OTRO GRAFICADOR
       
        %señal intracortical 767
        INTRA = si(:,3);              % SE TIENE QUE CAMBIAR A 4 EN EL EXPERIMENTO DEL 5-11-23
        iFy = fft(INTRA);             % obtenemos transformada del valor rectificado
        MiFy = abs(iFy/L);            %Usamos la parte real del fft  valores de la transformada de FFT
        fi = Fs*(0:length(MiFy)-1)/L;   %valores de frecuencia de la transformada
        %plot(fi(1:floor(L/2)),iMFy(1:floor(L/2))); % graficamos la fft realizada 
        AreaINTRA = trapz(MiFy)/2;    %integracion trapezoidal 
        %vectores de informacion 
        FourierINTRA{:,contador} = MiFy(1:floor(L/2)); %COPIAR Y PEGAR EN SIGMA U OTRO GRAFICADOR

        
        contadorII=1;
        contadorIII=1;
        %limite= number/Bloque;

        %while contadorIII <= limite

       % while  contadorII<=Bloque
        %Areas 
        AreaTFS{contador,:} = AreaS; %COPIAR Y PEGAR integracion de superficie
        AreaTFINTRA{contador,:} = AreaINTRA; % COPIAR Y PEGAR integracion de superficie
        contadorII = contador+1;

        %end
       % contadorIII= contadorIII+1;
       % end
                  
            
       contador= contador+1;             
   end

%AreaTFS = cell


    