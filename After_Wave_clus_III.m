%script para obtener frecuencia instantanea, raster y separacion de datos 
clear all; clc

con1=1;
con2=1;
con3=1;
con4=1;
con0=1;

% Donde estan los archivos
folder_datos = uigetdir()
'ANALIZANDO ...'

% Extraer archivos
todos_archivos = dir([folder_datos '\*.mat']); %es una structura con toda la informacion: name, folder, date, bytes, isdir, datenum
todos_archivos = {todos_archivos.name}'; %tomamos datos del nombre por eso el . 

%ciclo para leer datos y neuronas
for n_segundo = 1:length(todos_archivos)
    %leer datos de times 
    %datos_segundo = load (fullfile(folder_datos,todos_archivos{n_segundo}));
    load (fullfile(folder_datos,todos_archivos{n_segundo}));
    
    %generacion de vectores para almacenar datos 
    cluster_num=(max(cluster_class(:,1)))+1; %obtenemos numero maximo de clusters
    cluster_cell{1,cluster_num}=[];      %Hacemos una celda con la cantidad maxima de clusters
    spikes_cell{1,cluster_num}=[];       %Hacemos una celda con la cantidad maxima de clusters para guardar la forma de la spike 
    inst_freq{1,cluster_num}=[];         %celda para guardar la frecuencia instantanea 
    
%% Stores clusters and spikes into cell arrays/rasters
   %blucle para todos los rasters, se puede copiar y pegar en sigma plot para TODOS LOS RASTERS 
for i=0:cluster_num
    if i<cluster_num
        %obtenemos el tiempo de aparicion de cada spike por segundo 
cluster_cell{1,i+1}=cluster_class(find(cluster_class(:,1)==i),2)./1000; %Over 1000 for giving it in seconds;
    else 
        '.';
    end 
end

time_spike=linspace(0,((par.w_pre+par.w_post)/par.sr)*1000,par.w_pre+par.w_post);
%% sirve para reconstruir el potencial de accion de las neuronas, se puede omitir
for i=0:cluster_num
    if i<cluster_num
spikes_cell{1,i+1}=(spikes(find(cluster_class(:,1)==i),:)./100).*1000;%%Over Gain (100), in milivolts x1000.
    else 
        '.';
    end
end

%% Calculates the instant firing rate
for ii=1:cluster_num
for i=2:length(cluster_cell{1,ii}(:))
inst_freq{1,ii}(i-1,1)=1./(cluster_cell{1,ii}(i)-cluster_cell{1,ii}(i-1));%%Firing Rate in Hz
end
end

%% procedemos a clasificar en subtipos 

for i=1:cluster_num %avanazar por cluster
   cluster_cell2=cell2mat(cluster_cell(:,i));
   inst_freq2=cell2mat(inst_freq(:,i));
   %tomamos rasters en ventana de tiempo de misma duracion pre, durante, post potencial 
   u1=find(cluster_cell2>0.032 & cluster_cell2<=0.105); %ubicacion 32 a 100 ms
   u2=find(cluster_cell2>0.105 & cluster_cell2<=0.168); %ubicacion 101 a 168 ms termino del spss
   u3=find(cluster_cell2>0.168 & cluster_cell2<=0.236);%304); %ubicacion 168 a 236 ms termino del spss
   
   u8=find(cluster_cell2>0.1 & cluster_cell2<=0.134); %ubicacion 101 a 168 ms termino del spss
   
   c1= cluster_cell2(u1);
   c2= cluster_cell2(u2);
   c3= cluster_cell2(u3);
   %c4= (c1,c2,c3);
   c4={c1;c2;c3};
   c4=cell2mat(c4);
   
   %haremos discriminacion por longitud de segmentos 
   pre= length(c1);
   D= length(c2);
   post= length(c3);
   poten= length(c4);
   
   f1=inst_freq2(u1);  
   f2=inst_freq2(u2);
   f3=inst_freq2(u3);
   %f4=[f1,f2,f3];
   f4={f1;f2;f3};
   f4=cell2mat(f4);
   
   Hz1= mean(f1);
   Hz2= mean(f2);
   Hz3= mean(f3);
  
%    if Hz1<Hz2
%        tipo=1;
%    elseif Hz2<Hz1
%        tipo=2;
%    else
%        tipo=0;
%    end 
%    
   if pre<(D*0.5)
       if (D*0.5)>post
           tipo=1; %corresponde a incremento relacionado al potencial n
           Raster1{1,con1}=c4;
           Raster1{2,con1}=fullfile(folder_datos,todos_archivos{n_segundo});
           Freq1{:,con1}=f4;
           con1=con1+1;
       else
           tipo=3; %/¯
           %ty3(i)= [c4,f4];
           %ty3(i)= {c4,f4};
           Raster3{:,con3}=c4;
           Freq3{:,con3}=f4;
           con3=con3+1;
       end
   elseif D< (pre*0.5)
       if  D<(post*0.5)
           tipo =2; %corresponde a inhibicion relacionado al potencial u
           Raster2{:,con2}=c4;
           Freq2{:,con2}=f4;
           con2=con2+1;
       else 
           tipo=4; %\_
           Raster4{:,con4}=c4;
           Freq4{:,con4}=f4;
           con4=con4+1;
       end
   else
       tipo=0; %---
       Raster0{:,con0}=c4;
       Freq0{:,con0}=f4;
       con0=con0+1;
   end    

   
     %t1(:,i)= [c4,tipo];
   a=mat2str(i);
   raster{i,:}= {'Segundo',todos_archivos{n_segundo},fullfile('#neurona',a),'Raster: Pre, D, Post',u1,u2,u3, 'Hz: pre, D, post',f1,f2,f3,'mean Hz', Hz1,Hz2,Hz3,'tipo',tipo} ;
   raster2{n_segundo,:}=raster;
   
   
       
   
   
   b=2;%dummy variable 
end

     
    
end 
%raster2=cell2mat(raster2);
% %obtencion de rasters 
% Raster1=cell2mat(Raster1);
% Raster2=cell2mat(Raster2);
% Raster3=cell2mat(Raster3);
% Raster4=cell2mat(Raster4);
% Raster0=cell2mat(Raster0);


'TERMINADO :D'