%scrip para graficar rasters 
y=1;
for i= 1:length(Raster1) 
    R1=cell2mat(Raster1(1,i));
    plot(R1,y,'|')

    hold on
    y=y+1;
end
    xlim([0.032 0.236])
    ylim([0 length(Raster1)+1])
    ylabel('Numero de neuronas')
    xlabel('tiempo(ms)')
   title('Actividad de descarga neuronal')