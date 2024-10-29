% Programa para extraer canales y gener .mat
clear all; clc

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
     
      si = abfload(file);%Cargamos datos de .abf
      tiempov = length(si(:,1))/10000; % usamos 10000 por la frecuencia de muestreo 
        tiempov = 1/10000:1/10000:tiempov; %Vector de tiempo con la duracion del archivo
%       fname = filename(contador); %otenemos el nombre
%         fname = fname{1};
          
      contador2=1;
        %si es una matriz 5000*4*61 para cada archivo, hacemos una matriz llamada s2, 
          while contador2 <= 61
            s2{contador2,contador}= si(:,:,contador2);  %tenemos columnas X:#de_archivos,  filas Y:61 sweeps 60 + 1 que es el promedio
            contador2=contador2+1;
          end   
       contador= contador+1;             
   end
   
   %% procedemos a obtener datos del canal de neuronas 
               contadorX = 1; %Sirve para avanzar entre archivos
               contadorY2= 1; % 
     while contadorX <= length(filename)
       contadorY = 1; % Sirve para avanzar entre sweeps
       fname = filename(contadorX); %otenemos el nombre del archivo
        fname = fname{1};
          fname = fname(1:length(fname)-4); 
        
         while contadorY < 60  %INDICA LA CANTIDAD DE SWEEPS A USAR 61 OPTIMO 
             Neuro1 = s2(contadorY, contadorX); %del archivo #n obtenemos los 61(Y) sweeps*7(X) canales
             Neuro2= cell2mat(Neuro1);
             Neuro3= Neuro2(:,6); %otenemos los valores de la neurona 
             Neuro4(:,contadorY2)= Neuro3;
             
             data = Neuro3';
             %save(fname, 'data');
             
             fname,contadorY)
             
             
             
              contadorY=contadorY+1;
              contadorY2=contadorY2+1;
           end 
          contadorX= contadorX+1;
      end 
       
      %Neuro4= cell2mat(Neuro4);
    
      
      
      