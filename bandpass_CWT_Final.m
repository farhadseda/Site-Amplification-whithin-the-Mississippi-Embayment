% close all

fig=32;





figure('name','CWT');
subplot(411)
plot(result(fig).t,result(fig).Time_N(:),'Color',[0 0.498039215686275 0]);
set(gca,'TickDir','out'); title('Unfiltered');
set(gca,'XMinorTick','on','YMinorTick','on');
xlim([0 400]);
% ylabel('Amplitude (Counts)');
hold on
start_whole=result(fig).fp-10;
ending_whole=start_whole+150;
start_noise=result(fig).fp-7;
ending_noise=start_noise+5;
start_p=result(fig).fp;
SP=result(fig).fs-start_p;
if SP>5
    ending_p=start_p+5;
else
    ending_p=start_p+SP-1;
end
start_s=result(fig).fs;
ending_s=start_s+5;
start_ecoda=1.5*(result(fig).fs-result(fig).o)+result(fig).o;
ending_ecoda=start_ecoda+5;
start_coda=2*(result(fig).fs-result(fig).o)+result(fig).o;
ending_coda=start_coda+5;
y1=get(gca,'ylim');
plot([start_whole,start_whole],y1,'k','LineWidth',1)
plot([ending_whole,ending_whole],y1,'k','LineWidth',1)
plot([start_noise,start_noise],y1,'color',[0.7 0.7 0.7],'LineWidth',1)
plot([ending_noise,ending_noise],y1,'color',[0.7 0.7 0.7],'LineWidth',1)
plot([start_p,start_p],y1,'color',[0 0.6 1],'LineWidth',1)
plot([ending_p,ending_p],y1,'color',[0 0.6 1],'LineWidth',1)
plot([start_s,start_s],y1,'color',[0 0.8 0],'LineWidth',1)
plot([ending_s,ending_s],y1,'color',[0 0.8 0],'LineWidth',1)
plot([start_ecoda,start_ecoda],y1,'color','m','LineWidth',1)
plot([ending_ecoda,ending_ecoda],y1,'color','m','LineWidth',1)
plot([start_coda,start_coda],y1,'color','r','LineWidth',1)
plot([ending_coda,ending_coda],y1,'color','r','LineWidth',1)
xlim([0 250]);


lowFreq = 0.5;
hiFreq = 1;
fs=100;
% Butterworth transfer function definition
[b,a]=butter(2,[lowFreq hiFreq]/(fs/2),'bandpass');
% filtfilt or filter in order to digitally filter the data
% Using filtfilt (instead of filter) to make the phase of transfer function zero
subplot(412)
filtered_N= filtfilt(b,a,result(fig).Time_N(:));
plot(result(fig).t,filtered_N,'Color',[0 0.498039215686275 0])
% ylabel('Amplitude (Counts)');
set(gca,'TickDir','out'); title('Filtered (0.2 to 1 Hz)');
set(gca,'XMinorTick','on','YMinorTick','on');
xlim([0 400]);
hold on
start_whole=result(fig).fp-10;
ending_whole=start_whole+150;
start_noise=result(fig).fp-7;
ending_noise=start_noise+5;
start_p=result(fig).fp;
SP=result(fig).fs-start_p;
if SP>5
    ending_p=start_p+5;
else
    ending_p=start_p+SP-1;
end
start_s=result(fig).fs;
ending_s=start_s+5;
start_ecoda=1.5*(result(fig).fs-result(fig).o)+result(fig).o;
ending_ecoda=start_ecoda+5;
start_coda=2*(result(fig).fs-result(fig).o)+result(fig).o;
ending_coda=start_coda+5;
y1=get(gca,'ylim');
plot([start_whole,start_whole],y1,'k','LineWidth',1)
plot([ending_whole,ending_whole],y1,'k','LineWidth',1)
plot([start_noise,start_noise],y1,'color',[0.7 0.7 0.7],'LineWidth',1)
plot([ending_noise,ending_noise],y1,'color',[0.7 0.7 0.7],'LineWidth',1)
plot([start_p,start_p],y1,'color',[0 0.6 1],'LineWidth',1)
plot([ending_p,ending_p],y1,'color',[0 0.6 1],'LineWidth',1)
plot([start_s,start_s],y1,'color',[0 0.8 0],'LineWidth',1)
plot([ending_s,ending_s],y1,'color',[0 0.8 0],'LineWidth',1)
plot([start_ecoda,start_ecoda],y1,'color','m','LineWidth',1)
plot([ending_ecoda,ending_ecoda],y1,'color','m','LineWidth',1)
plot([start_coda,start_coda],y1,'color','r','LineWidth',1)
plot([ending_coda,ending_coda],y1,'color','r','LineWidth',1)
xlim([0 250]);


lowFreq = 1;
hiFreq = 2;
fs=100;
% Butterworth transfer function definition
[b,a]=butter(2,[lowFreq hiFreq]/(fs/2),'bandpass');
% filtfilt or filter in order to digitally filter the data
% Using filtfilt (instead of filter) to make the phase of transfer function zero
subplot(413)
filtered_N= filtfilt(b,a,result(fig).Time_N(:));
plot(result(fig).t,filtered_N,'Color',[0 0.498039215686275 0])
% ylabel('Amplitude (Counts)');
set(gca,'TickDir','out'); title('Filtered (1 to 3 Hz)');
set(gca,'XMinorTick','on','YMinorTick','on');
xlim([0 400]);
hold on
start_whole=result(fig).fp-10;
ending_whole=start_whole+150;
start_noise=result(fig).fp-7;
ending_noise=start_noise+5;
start_p=result(fig).fp;
SP=result(fig).fs-start_p;
if SP>5
    ending_p=start_p+5;
else
    ending_p=start_p+SP-1;
end
start_s=result(fig).fs;
ending_s=start_s+5;
start_ecoda=1.5*(result(fig).fs-result(fig).o)+result(fig).o;
ending_ecoda=start_ecoda+5;
start_coda=2*(result(fig).fs-result(fig).o)+result(fig).o;
ending_coda=start_coda+5;
y1=get(gca,'ylim');
plot([start_whole,start_whole],y1,'k','LineWidth',1)
plot([ending_whole,ending_whole],y1,'k','LineWidth',1)
plot([start_noise,start_noise],y1,'color',[0.7 0.7 0.7],'LineWidth',1)
plot([ending_noise,ending_noise],y1,'color',[0.7 0.7 0.7],'LineWidth',1)
plot([start_p,start_p],y1,'color',[0 0.6 1],'LineWidth',1)
plot([ending_p,ending_p],y1,'color',[0 0.6 1],'LineWidth',1)
plot([start_s,start_s],y1,'color',[0 0.8 0],'LineWidth',1)
plot([ending_s,ending_s],y1,'color',[0 0.8 0],'LineWidth',1)
plot([start_ecoda,start_ecoda],y1,'color','m','LineWidth',1)
plot([ending_ecoda,ending_ecoda],y1,'color','m','LineWidth',1)
plot([start_coda,start_coda],y1,'color','r','LineWidth',1)
plot([ending_coda,ending_coda],y1,'color','r','LineWidth',1)
xlim([0 250]);


lowFreq = 3;
hiFreq = 10;
fs=100;
% Butterworth transfer function definition
[b,a]=butter(2,[lowFreq hiFreq]/(fs/2),'bandpass');
% filtfilt or filter in order to digitally filter the data
% Using filtfilt (instead of filter) to make the phase of transfer function zero
subplot(414)
start_whole=result(fig).fp-10;
ending_whole=start_whole+150;
start_noise=result(fig).fp-7;
ending_noise=start_noise+5;
start_p=result(fig).fp;
SP=result(fig).fs-start_p;
if SP>5
    ending_p=start_p+5;
else
    ending_p=start_p+SP-1;
end
start_s=result(fig).fs;
ending_s=start_s+5;
start_ecoda=1.5*(result(fig).fs-result(fig).o)+result(fig).o;
ending_ecoda=start_ecoda+5;
start_coda=2*(result(fig).fs-result(fig).o)+result(fig).o;
ending_coda=start_coda+5;
filtered_N= filtfilt(b,a,result(fig).Time_N(:));
plot(result(fig).t,filtered_N)
y1=get(gca,'ylim');
plot([start_whole,start_whole],y1,'k','LineWidth',1)
hold on
plot([start_noise,start_noise],y1,'color',[0.7 0.7 0.7],'LineWidth',1)
plot([start_p,start_p],y1,'color',[0 0.6 1],'LineWidth',1)
plot([start_s,start_s],y1,'color',[0 0.8 0],'LineWidth',1)
plot([start_ecoda,start_ecoda],y1,'color','m','LineWidth',1)
plot([start_coda,start_coda],y1,'color','r','LineWidth',1)

plot([ending_whole,ending_whole],y1,'k','LineWidth',1)
plot([ending_noise,ending_noise],y1,'color',[0.7 0.7 0.7],'LineWidth',1)
plot([ending_p,ending_p],y1,'color',[0 0.6 1],'LineWidth',1)
plot([ending_s,ending_s],y1,'color',[0 0.8 0],'LineWidth',1)
plot([ending_ecoda,ending_ecoda],y1,'color','m','LineWidth',1)
plot([ending_coda,ending_coda],y1,'color','r','LineWidth',1)
filtered_N= filtfilt(b,a,result(fig).Time_N(:));
plot(result(fig).t,filtered_N,'Color',[0 0.498039215686275 0])
ylabel('Amplitude (Counts)');
set(gca,'TickDir','out'); title('Filtered (3 to 7 Hz)');
set(gca,'XMinorTick','on','YMinorTick','on');
legend('Whole','Noise','P-wave','S-wave','Early coda-wave','Late Coda-wave','location','SW','Location','NE')
xlim([0 250]);xlabel('Time (sec)');


set(findall(gcf,'-property','FontSize'),'FontSize',12)
set(findall(gcf,'-property','Fontname'),'Fontname', 'Times New Roman')





%%

figure('name','CWT');




lowFreq = 0.2;
hiFreq = 20;
fs=100;
% Butterworth transfer function definition
[b,a]=butter(2,[lowFreq hiFreq]/(fs/2),'bandpass');
% filtfilt or filter in order to digitally filter the data
% Using filtfilt (instead of filter) to make the phase of transfer function zero
filtered_N= filtfilt(b,a,result(fig).Time_N(:));
subplot(211);plot(result(fig).t,filtered_N)
xlim([0 250]);xlabel('Time (sec)');ylabel('Amplitude (Counts)');
set(gca,'TickDir','out'); title('Unfiltered');
set(gca,'XMinorTick','on','YMinorTick','on');
subplot(212);cwt(filtered_N,fs)
set(gca,'XMinorTick','on','YMinorTick','on');
title('Continuous Wavelet Transform (CWT)')
xlim([0 4.167]);ylim([-2 5]);xlabel('Time (sec)')
set(gca,'TickDir','out');
set(findall(gcf,'-property','FontSize'),'FontSize',12)
set(findall(gcf,'-property','Fontname'),'Fontname', 'Times New Roman')









