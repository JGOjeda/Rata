[file path]=uigetfile('*.mat');
load(file) 
cluster_num=max(cluster_class(:,1));
cluster_cell{1,cluster_num}=[];
spikes_cell{1,cluster_num}=[]; 
inst_freq{1,cluster_num}=[];
%stim_onset=8.9354; stim_offset=10.0015;
%stim_onset=stim_onset-0.43;
%% Stores clusters and spikes into cell arrays

for i=1:cluster_num
cluster_cell{1,i}=cluster_class(find(cluster_class(:,1)==i),2)./1000; %Over 1000 for giving it in seconds;
end

time_spike=linspace(0,((par.w_pre+par.w_post)/par.sr)*1000,par.w_pre+par.w_post);
for i=1:cluster_num
spikes_cell{1,i}=(spikes(find(cluster_class(:,1)==i),:)./100).*1000;%%Over Gain (100), in milivolts x1000.
end

%% Plot spikes
colors=[0 0 0;1 0 0; 0 1 0; 0 0 1];
figure
for ii=1:cluster_num
for i=1:length(spikes_cell{1,ii}(:,1))
plot(time_spike,spikes_cell{1,ii}(i,:),'Color',colors(ii,:))
hold on
end
end
legend([plot(1,1,'Color',colors(1,:)),plot(1,1,'Color',colors(2,:)),plot(1,1,'Color',colors(3,:)),plot(1,1,'Color',colors(4,:))],{'Cluster1','Cluster2','Cluster3','Clusters4'})
title('Clusters','FontSize',20)
ylabel('Amplitud (mV)','FontSize',16)
xlabel('Tiempo (ms)','FontSize',16)
xlim([0 0.7])
box off


%% Plot activity rasters
figure
for ii=1:cluster_num
subplot(cluster_num,1,ii)
for i=1:length(cluster_cell{1,ii}(:))
plot(repmat(cluster_cell{1,ii}(i),1,20),linspace(-0.5,0.5,20),'Color',[0 0 0])
hold on
end
title(strcat('Rasters Cluster',num2str(ii)),'FontSize',14)
ylim([-1,1])
xlabel('Time (s)')
ax=gca; ax.YTick=[];
box off
end

%% Calculates the instant firing rate

for ii=1:cluster_num
for i=2:length(cluster_cell{1,ii}(:))
inst_freq{1,ii}(i-1,1)=1./(cluster_cell{1,ii}(i)-cluster_cell{1,ii}(i-1));%%Firing Rate in Hz
end
end

figure
for ii=1:cluster_num
subplot(cluster_num,1,ii)
plot(cluster_cell{1,ii}(2:end),inst_freq{1,ii}(:),'Color',[0 0 0])
hold on
box off
xlabel('Time (s)','FontSize',14)
ylabel('Firing Rate (Hz)','FontSize',14)
title(strcat('Firing Rate Cluster',num2str(ii)),'FontSize',14)
end

%% Stores data into excel files
for ii=1:cluster_num
xlswrite(strcat('Spikes',par.filename,'.xlsx'),time_spike',ii,'B3')
xlswrite(strcat('Spikes',par.filename,'.xlsx'),spikes_cell{1,ii}',ii,'C3')
xlswrite(strcat('Spikes',par.filename,'.xlsx'),{'Time','Spikes'},ii,'B2')
end
abcd='CDEFGHIJKL';
for ii=1:cluster_num
xlswrite(strcat('Rasters',par.filename(1:end-4),'.xlsx'),cluster_cell{1,ii},1,strcat(abcd(ii),'3'))
end
xlswrite(strcat('Rasters',par.filename(1:end-4),'.xlsx'),{'Times (s)','Cluster1','Cluster2','Cluster3'},1,'B2')
for ii=1:cluster_num
xlswrite(strcat('FirRate',par.filename(1:end-4),'.xlsx'),inst_freq{1,ii},1,strcat(abcd(ii),'3'))
end
xlswrite(strcat('FirRate',par.filename(1:end-4),'.xlsx'),{'Rates (Hz)','Cluster1','Cluster2','Cluster3'},1,'B2')
