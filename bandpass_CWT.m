
fig=16;





figure('name','CWT');
subplot(431)
plot(result(fig).t,result(fig).Time_Z(:));
ylabel('Amplitude (Counts)');
set(gca,'TickDir','out'); title('Vertical');
set(gca,'XMinorTick','on','YMinorTick','on');
xlim([0 400]);
subplot(432)
plot(result(fig).t,result(fig).Time_N(:));
set(gca,'TickDir','out'); title('N-S');
set(gca,'XMinorTick','on','YMinorTick','on');
xlim([0 400]);
subplot(433)
plot(result(fig).t,result(fig).Time_E(:));
set(gca,'TickDir','out'); title('E-W');
set(gca,'XMinorTick','on','YMinorTick','on');
xlim([0 400]);


lowFreq = 0.2;
hiFreq = 1;
fs=100;
% Butterworth transfer function definition
[b,a]=butter(2,[lowFreq hiFreq]/(fs/2),'bandpass');
% filtfilt or filter in order to digitally filter the data
% Using filtfilt (instead of filter) to make the phase of transfer function zero
subplot(434)
filtered_Z= filtfilt(b,a,result(fig).Time_Z(:));
plot(result(fig).t,filtered_Z)
ylabel('Amplitude (Counts)');
set(gca,'TickDir','out'); title('Vertical');
set(gca,'XMinorTick','on','YMinorTick','on');
xlim([0 400]);
subplot(435)
filtered_N= filtfilt(b,a,result(fig).Time_N(:));
plot(result(fig).t,filtered_N)
set(gca,'TickDir','out'); title('N-S');
set(gca,'XMinorTick','on','YMinorTick','on');
xlim([0 400]);
subplot(436)
filtered_E= filtfilt(b,a,result(fig).Time_E(:));
plot(result(fig).t,filtered_E)
set(gca,'TickDir','out'); title('E-W');
set(gca,'XMinorTick','on','YMinorTick','on');
xlim([0 400]);



lowFreq = 1;
hiFreq = 3;
fs=100;
% Butterworth transfer function definition
[b,a]=butter(2,[lowFreq hiFreq]/(fs/2),'bandpass');
% filtfilt or filter in order to digitally filter the data
% Using filtfilt (instead of filter) to make the phase of transfer function zero
subplot(437)
filtered_Z= filtfilt(b,a,result(fig).Time_Z(:));
plot(result(fig).t,filtered_Z)
ylabel('Amplitude (Counts)');
set(gca,'TickDir','out'); title('Vertical');
set(gca,'XMinorTick','on','YMinorTick','on');
xlim([0 400]);
subplot(438)
filtered_N= filtfilt(b,a,result(fig).Time_N(:));
plot(result(fig).t,filtered_N)
set(gca,'TickDir','out'); title('N-S');
set(gca,'XMinorTick','on','YMinorTick','on');
xlim([0 400]);
subplot(439)
filtered_E= filtfilt(b,a,result(fig).Time_E(:));
plot(result(fig).t,filtered_E)
set(gca,'TickDir','out'); title('E-W');
set(gca,'XMinorTick','on','YMinorTick','on');
xlim([0 400]);



lowFreq = 3;
hiFreq = 7;
fs=100;
% Butterworth transfer function definition
[b,a]=butter(2,[lowFreq hiFreq]/(fs/2),'bandpass');
% filtfilt or filter in order to digitally filter the data
% Using filtfilt (instead of filter) to make the phase of transfer function zero
subplot(4,3,10)
filtered_Z= filtfilt(b,a,result(fig).Time_Z(:));
plot(result(fig).t,filtered_Z)
ylabel('Amplitude (Counts)');
set(gca,'TickDir','out'); title('Vertical');
set(gca,'XMinorTick','on','YMinorTick','on');
xlim([0 400]);xlabel('Time (sec)');
subplot(4,3,11)
filtered_N= filtfilt(b,a,result(fig).Time_N(:));
plot(result(fig).t,filtered_N)
set(gca,'TickDir','out'); title('N-S');
set(gca,'XMinorTick','on','YMinorTick','on');
xlim([0 400]);xlabel('Time (sec)');
subplot(4,3,12)
filtered_E= filtfilt(b,a,result(fig).Time_E(:));
plot(result(fig).t,filtered_E)
set(gca,'TickDir','out'); title('E-W');
set(gca,'XMinorTick','on','YMinorTick','on');
xlim([0 400]);xlabel('Time (sec)');

%%

figure('name','CWT');




lowFreq = 0.2;
hiFreq = 20;
fs=100;
% Butterworth transfer function definition
[b,a]=butter(2,[lowFreq hiFreq]/(fs/2),'bandpass');
% filtfilt or filter in order to digitally filter the data
% Using filtfilt (instead of filter) to make the phase of transfer function zero
filtered_Z= filtfilt(b,a,result(fig).Time_Z(:));
filtered_N= filtfilt(b,a,result(fig).Time_N(:));
filtered_E= filtfilt(b,a,result(fig).Time_E(:));
subplot(231);plot(result(fig).t,filtered_Z)
subplot(234);cwt(filtered_Z,fs)
subplot(232);plot(result(fig).t,filtered_N)
subplot(235);cwt(filtered_N,fs)
subplot(233);plot(result(fig).t,filtered_E)
subplot(236);cwt(filtered_E,fs)









