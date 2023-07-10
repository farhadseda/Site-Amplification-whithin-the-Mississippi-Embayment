clc
clear
close all
set(0,'DefaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize', 12)
set(0,'DefaultTextFontname', 'Times New Roman')
set(0,'DefaultTextFontSize', 12)
set(0,'DefaultUicontrolFontname', 'Times New Roman')
set(0,'DefaultUicontrolFontSize', 12)
set(0,'DefaultUicontrolFontname', 'Times New Roman')
set(0,'DefaultUitableFontSize', 12)
set(0,'DefaultUipanelFontname', 'Times New Roman')
set(0,'DefaultUipanelFontSize', 12)
% read the data
load('data.mat')

%% Input parameters

% which station you want to determine the site amplification
station='GLAT';

% using cosine taper to window selected part, just choose the precentage
% it should be between 0 (rectangular = no window) to 1 (hanning)
percentage=0.10;

% number of FFT
NFFT=2^14;

% smoothing moving average, points = 21
points=21;

% freqeuncy range of interest 0.1 20
fmin=0.15;
fmax=20;

% choose one record to draw (for figures)
fig=5;

%% Preparing the database for analysis

% read data of the station of interest
counter=1;
for i=1:numel(data)
    if strcmpi(data(i).station,station)
        result(counter)=data(i); %#ok<SAGROW>
        counter=counter+1;
    end
end
records_num=numel(result);
clear data counter i


%% demean and detrend
correction=menu('Do you want to correct the baseline?','No','Yes, Demean it','Yes, Detrend it','Yes, Demean and Detrend it');

switch correction
    case 1
        % Do nothing
    case 2
        % Demean
        disp('Demean the data');
        disp('----------------------------------------------');
        for i=1:records_num
            result(i).Time_Z = result(i).Time_Z - mean(result(i).Time_Z);
            result(i).Time_N = result(i).Time_N - mean(result(i).Time_N);
            result(i).Time_E = result(i).Time_E - mean(result(i).Time_E);
        end
    case 3
        % Detrend
        for i=1:records_num
            disp('Remove the linear trend');
            disp('----------------------------------------------');
            result(i).Time_Z = detrend(result(i).Time_Z,'linear');
            result(i).Time_N = detrend(result(i).Time_N,'linear');
            result(i).Time_E = detrend(result(i).Time_E,'linear');
        end
    case 4
        % Demean and Detrend
        disp('Remove the mean and linear trend');
        disp('----------------------------------------------');
        for i=1:records_num
            result(i).Time_Z = result(i).Time_Z - mean(result(i).Time_Z);
            result(i).Time_N = result(i).Time_N - mean(result(i).Time_N);
            result(i).Time_E = result(i).Time_E - mean(result(i).Time_E);
            result(i).Time_Z = detrend(result(i).Time_Z,'linear');
            result(i).Time_N = detrend(result(i).Time_N,'linear');
            result(i).Time_E = detrend(result(i).Time_E,'linear');
        end
end

clear correction i

% disp('Press Enter to Continue');
% pause

%% taper to selectd different phases, then FFT, and then smoothing
for i=1:records_num
    % whole signal
    start=result(i).fp/result(i).delta-10/result(i).delta;
    ending=start+150/result(i).delta;
    signal_whole_Z=result(i).Time_Z(int32(start):int32(ending)); 
    signal_whole_E=result(i).Time_E(int32(start):int32(ending));
    signal_whole_N=result(i).Time_N(int32(start):int32(ending));
    L=length(signal_whole_Z);
    w = tukeywin(L,percentage); 
    result(i).FFT_whole_Z=fft(signal_whole_Z.*w,NFFT);
    result(i).FFT_whole_E=fft(signal_whole_E.*w,NFFT);
    result(i).FFT_whole_N=fft(signal_whole_N.*w,NFFT);
    result(i).FFT_whole_Z=smooth(abs(result(i).FFT_whole_Z),points);
    result(i).FFT_whole_E=smooth(abs(result(i).FFT_whole_E),points);
    result(i).FFT_whole_N=smooth(abs(result(i).FFT_whole_N),points);
    Fs=1/result(i).delta;
    df=Fs/NFFT;
    f=0:df:Fs-df;
    result(i).freq_whole=f';
    result(i).HoverV_whole=sqrt(result(i).FFT_whole_N.*result(i).FFT_whole_E)./result(i).FFT_whole_Z;
    clear L w start ending Fs df f signal_whole_Z signal_whole_E signal_whole_N
    
    % preevent noise part
    start=result(i).fp/result(i).delta-7/result(i).delta;
    ending=start+5/result(i).delta;
    noise_Z=result(i).Time_Z(int32(start):int32(ending)); 
    noise_E=result(i).Time_E(int32(start):int32(ending));
    noise_N=result(i).Time_N(int32(start):int32(ending));
    L=length(noise_Z);
    w = tukeywin(L,percentage); 
    result(i).FFT_noise_Z=fft(noise_Z.*w,NFFT);
    result(i).FFT_noise_E=fft(noise_E.*w,NFFT);
    result(i).FFT_noise_N=fft(noise_N.*w,NFFT);
    result(i).FFT_noise_Z=smooth(abs(result(i).FFT_noise_Z),points);
    result(i).FFT_noise_E=smooth(abs(result(i).FFT_noise_E),points);
    result(i).FFT_noise_N=smooth(abs(result(i).FFT_noise_N),points);
    Fs=1/result(i).delta;
    df=Fs/NFFT;
    f=0:df:Fs-df;
    result(i).freq_noise=f';
    result(i).HoverV_noise=sqrt(result(i).FFT_noise_N.*result(i).FFT_noise_E)./result(i).FFT_noise_Z;
    clear L w start ending Fs df f noise_Z noise_E noise_N
    
    % p phase part
    start=result(i).fp/result(i).delta;
    SP=result(i).fs/result(i).delta-start;
    if SP*result(i).delta>5
        ending=start+5/result(i).delta;
    else
        ending=start+SP-1/result(i).delta;
    end
    signal_p_Z=result(i).Time_Z(int32(start):int32(ending)); 
    signal_p_E=result(i).Time_E(int32(start):int32(ending));
    signal_p_N=result(i).Time_N(int32(start):int32(ending));
    L=length(signal_p_Z);
    w = tukeywin(L,percentage); 
    result(i).FFT_p_Z=fft(signal_p_Z.*w,NFFT);
    result(i).FFT_p_E=fft(signal_p_E.*w,NFFT);
    result(i).FFT_p_N=fft(signal_p_N.*w,NFFT);
    result(i).FFT_p_Z=smooth(abs(result(i).FFT_p_Z),points);
    result(i).FFT_p_E=smooth(abs(result(i).FFT_p_E),points);
    result(i).FFT_p_N=smooth(abs(result(i).FFT_p_N),points);
    Fs=1/result(i).delta;
    df=Fs/NFFT;
    f=0:df:Fs-df;
    result(i).freq_p=f';
    result(i).HoverV_p=sqrt(result(i).FFT_p_N.*result(i).FFT_p_E)./result(i).FFT_p_Z;
    clear L w start ending Fs df f signal_p_Z signal_p_E signal_p_N SP
    
    % s phase part
    start=result(i).fs/result(i).delta;
    ending=start+5/result(i).delta;
    signal_s_Z=result(i).Time_Z(int32(start):int32(ending)); 
    signal_s_E=result(i).Time_E(int32(start):int32(ending));
    signal_s_N=result(i).Time_N(int32(start):int32(ending));
    L=length(signal_s_Z);
    w = tukeywin(L,percentage); 
    result(i).FFT_s_Z=fft(signal_s_Z.*w,NFFT);
    result(i).FFT_s_E=fft(signal_s_E.*w,NFFT);
    result(i).FFT_s_N=fft(signal_s_N.*w,NFFT);
    result(i).FFT_s_Z=smooth(abs(result(i).FFT_s_Z),points);
    result(i).FFT_s_E=smooth(abs(result(i).FFT_s_E),points);
    result(i).FFT_s_N=smooth(abs(result(i).FFT_s_N),points);
    Fs=1/result(i).delta;
    df=Fs/NFFT;
    f=0:df:Fs-df;
    result(i).freq_s=f';
    result(i).HoverV_s=sqrt(result(i).FFT_s_N.*result(i).FFT_s_E)./result(i).FFT_s_Z;
    clear L w start ending Fs df f signal_s_Z signal_s_E signal_s_N
    
    % early coda phase part
    start=1.5*(result(i).fs/result(i).delta-result(i).o/result(i).delta)+result(i).o/result(i).delta;
    ending=start+5/result(i).delta;
    signal_ecoda_Z=result(i).Time_Z(int32(start):int32(ending)); 
    signal_ecoda_E=result(i).Time_E(int32(start):int32(ending));
    signal_ecoda_N=result(i).Time_N(int32(start):int32(ending));
    L=length(signal_ecoda_Z);
    w = tukeywin(L,percentage); 
    result(i).FFT_ecoda_Z=fft(signal_ecoda_Z.*w,NFFT);
    result(i).FFT_ecoda_E=fft(signal_ecoda_E.*w,NFFT);
    result(i).FFT_ecoda_N=fft(signal_ecoda_N.*w,NFFT);
    result(i).FFT_ecoda_Z=smooth(abs(result(i).FFT_ecoda_Z),points);
    result(i).FFT_ecoda_E=smooth(abs(result(i).FFT_ecoda_E),points);
    result(i).FFT_ecoda_N=smooth(abs(result(i).FFT_ecoda_N),points);
    Fs=1/result(i).delta;
    df=Fs/NFFT;
    f=0:df:Fs-df;
    result(i).freq_ecoda=f';
    result(i).HoverV_ecoda=sqrt(result(i).FFT_ecoda_N.*result(i).FFT_ecoda_E)./result(i).FFT_ecoda_Z;
    clear L w start ending Fs df f signal_ecoda_Z signal_ecoda_E signal_ecoda_N
    
    % late coda phase part
    start=2*(result(i).fs/result(i).delta-result(i).o/result(i).delta)+result(i).o/result(i).delta;
    ending=start+5/result(i).delta;
    signal_coda_Z=result(i).Time_Z(int32(start):int32(ending)); 
    signal_coda_E=result(i).Time_E(int32(start):int32(ending));
    signal_coda_N=result(i).Time_N(int32(start):int32(ending));
    L=length(signal_coda_Z);
    w = tukeywin(L,percentage); 
    result(i).FFT_coda_Z=fft(signal_coda_Z.*w,NFFT);
    result(i).FFT_coda_E=fft(signal_coda_E.*w,NFFT);
    result(i).FFT_coda_N=fft(signal_coda_N.*w,NFFT);
    result(i).FFT_coda_Z=smooth(abs(result(i).FFT_coda_Z),points);
    result(i).FFT_coda_E=smooth(abs(result(i).FFT_coda_E),points);
    result(i).FFT_coda_N=smooth(abs(result(i).FFT_coda_N),points);
    Fs=1/result(i).delta;
    df=Fs/NFFT;
    f=0:df:Fs-df;
    result(i).freq_coda=f';
    result(i).HoverV_coda=sqrt(result(i).FFT_coda_N.*result(i).FFT_coda_E)./result(i).FFT_coda_Z;
    clear L w start ending Fs df f signal_coda_Z signal_coda_E signal_coda_N
    
end

clear i

%% FFT plots log
figure
subplot(131)
loglog(result(fig).freq_whole,abs(result(fig).FFT_whole_Z),'k')
hold on
loglog(result(fig).freq_noise,abs(result(fig).FFT_noise_Z),'color',[0.7 0.7 0.7])
loglog(result(fig).freq_p,abs(result(fig).FFT_p_Z),'color',[0 0.6 1])
loglog(result(fig).freq_s,abs(result(fig).FFT_s_Z),'color',[0 0.8 0])
loglog(result(fig).freq_ecoda,abs(result(fig).FFT_ecoda_Z),'color','m')
loglog(result(fig).freq_coda,abs(result(fig).FFT_coda_Z),'color','r')
hold off
xlim([fmin fmax])
set(gca,'TickDir','out');  title('Vertical');
set(gca,'XMinorTick','on','YMinorTick','on');

subplot(132)
loglog(result(fig).freq_whole,abs(result(fig).FFT_whole_E),'k')
hold on
loglog(result(fig).freq_noise,abs(result(fig).FFT_noise_E),'color',[0.7 0.7 0.7])
loglog(result(fig).freq_p,abs(result(fig).FFT_p_E),'color',[0 0.6 1])
loglog(result(fig).freq_s,abs(result(fig).FFT_s_E),'color',[0 0.8 0])
loglog(result(fig).freq_ecoda,abs(result(fig).FFT_ecoda_E),'color','m')
loglog(result(fig).freq_coda,abs(result(fig).FFT_coda_E),'color','r')
hold off
xlim([fmin fmax])
set(gca,'TickDir','out'); title('E-W');
set(gca,'XMinorTick','on','YMinorTick','on');

subplot(133)
loglog(result(fig).freq_whole,abs(result(fig).FFT_whole_N),'k')
hold on
loglog(result(fig).freq_noise,abs(result(fig).FFT_noise_N),'color',[0.7 0.7 0.7])
loglog(result(fig).freq_p,abs(result(fig).FFT_p_N),'color',[0 0.6 1])
loglog(result(fig).freq_s,abs(result(fig).FFT_s_N),'color',[0 0.8 0])
loglog(result(fig).freq_ecoda,abs(result(fig).FFT_ecoda_N),'color','m')
loglog(result(fig).freq_coda,abs(result(fig).FFT_coda_N),'color','r')
hold off
xlim([fmin fmax])
set(gca,'TickDir','out'); title('N-S');
set(gca,'XMinorTick','on','YMinorTick','on');
legend('Whole','Noise','P-wave','S-wave','Early coda-wave','Late Coda-wave','location','SW')





%% FFT plots normal
figure
subplot(131)
plot(result(fig).freq_whole,abs(result(fig).FFT_whole_Z),'k')
hold on
plot(result(fig).freq_noise,abs(result(fig).FFT_noise_Z),'color',[0.7 0.7 0.7])
plot(result(fig).freq_p,abs(result(fig).FFT_p_Z),'color',[0 0.6 1])
plot(result(fig).freq_s,abs(result(fig).FFT_s_Z),'color',[0 0.8 0])
plot(result(fig).freq_ecoda,abs(result(fig).FFT_ecoda_Z),'color','m')
plot(result(fig).freq_coda,abs(result(fig).FFT_coda_Z),'color','r')
hold off
xlim([fmin fmax])
set(gca,'TickDir','out');  title('Vertical');
set(gca,'XMinorTick','on','YMinorTick','on');

subplot(132)
plot(result(fig).freq_whole,abs(result(fig).FFT_whole_E),'k')
hold on
plot(result(fig).freq_noise,abs(result(fig).FFT_noise_E),'color',[0.7 0.7 0.7])
plot(result(fig).freq_p,abs(result(fig).FFT_p_E),'color',[0 0.6 1])
plot(result(fig).freq_s,abs(result(fig).FFT_s_E),'color',[0 0.8 0])
plot(result(fig).freq_ecoda,abs(result(fig).FFT_ecoda_E),'color','m')
plot(result(fig).freq_coda,abs(result(fig).FFT_coda_E),'color','r')
hold off
xlim([fmin fmax])
set(gca,'TickDir','out'); title('E-W');
set(gca,'XMinorTick','on','YMinorTick','on');

subplot(133)
plot(result(fig).freq_whole,abs(result(fig).FFT_whole_N),'k')
hold on
plot(result(fig).freq_noise,abs(result(fig).FFT_noise_N),'color',[0.7 0.7 0.7])
plot(result(fig).freq_p,abs(result(fig).FFT_p_N),'color',[0 0.6 1])
plot(result(fig).freq_s,abs(result(fig).FFT_s_N),'color',[0 0.8 0])
plot(result(fig).freq_ecoda,abs(result(fig).FFT_ecoda_N),'color','m')
plot(result(fig).freq_coda,abs(result(fig).FFT_coda_N),'color','r')
hold off
xlim([fmin fmax])
set(gca,'TickDir','out'); title('N-S');
set(gca,'XMinorTick','on','YMinorTick','on');
legend('Whole','Noise','P-wave','S-wave','Early coda-wave','Late Coda-wave','location','SW')

%% H/V ratio plot log

figure
loglog(result(fig).freq_whole,result(fig).HoverV_whole,'k')
hold on
loglog(result(fig).freq_noise,result(fig).HoverV_noise,'color',[0.7 0.7 0.7])
loglog(result(fig).freq_p,result(fig).HoverV_p,'color',[0 0.6 1])
loglog(result(fig).freq_s,result(fig).HoverV_s,'color',[0 0.8 0])
loglog(result(fig).freq_ecoda,result(fig).HoverV_ecoda,'color','m')
loglog(result(fig).freq_coda,result(fig).HoverV_coda,'color','r')
hold off
xlim([fmin fmax])
set(gca,'TickDir','out'); title('N-S');
set(gca,'XMinorTick','on','YMinorTick','on');
legend('Whole','Noise','P-wave','S-wave','Early coda-wave','Late Coda-wave','location','SW')


%% H/V ratio plot normal

figure
plot(result(fig).freq_whole,result(fig).HoverV_whole,'k')
hold on
plot(result(fig).freq_noise,result(fig).HoverV_noise,'color',[0.7 0.7 0.7])
plot(result(fig).freq_p,result(fig).HoverV_p,'color',[0 0.6 1])
plot(result(fig).freq_s,result(fig).HoverV_s,'color',[0 0.8 0])
plot(result(fig).freq_ecoda,result(fig).HoverV_ecoda,'color','m')
plot(result(fig).freq_coda,result(fig).HoverV_coda,'color','r')
hold off
xlim([fmin fmax])
set(gca,'TickDir','out'); title('N-S');
set(gca,'XMinorTick','on','YMinorTick','on');
legend('Whole','Noise','P-wave','S-wave','Early coda-wave','Late coda-wave','location','NE')


%% Average and standard deviation of H/V for the site of interest using all records


for j=1:NFFT
    counter=0;dummy=0;
    for i=1:records_num
        if isnumeric(result(i).HoverV_whole)
            counter=counter+1;
            dummy(counter)=result(i).HoverV_whole(j);
        end
    end
    AVG_HoverV_whole(j,1)=mean(dummy);
    STD_HoverV_whole(j,1)=std(dummy);
    clear dummy counter
end


for j=1:NFFT
    counter=0;dummy=0;
    for i=1:records_num
        if isnumeric(result(i).HoverV_noise)
            counter=counter+1;
            dummy(counter)=result(i).HoverV_noise(j);
        end
    end
    AVG_HoverV_noise(j,1)=mean(dummy);
    STD_HoverV_noise(j,1)=std(dummy);
    clear dummy counter
end

for j=1:NFFT
    counter=0;dummy=0;
    for i=1:records_num
        if isnumeric(result(i).HoverV_p)
            counter=counter+1;
            dummy(counter)=result(i).HoverV_p(j);
        end
    end
    AVG_HoverV_p(j,1)=mean(dummy);
    STD_HoverV_p(j,1)=std(dummy);
    clear dummy counter
end

for j=1:NFFT
    counter=0;dummy=0;
    for i=1:records_num
        if isnumeric(result(i).HoverV_s)
            counter=counter+1;
            dummy(counter)=result(i).HoverV_s(j);
        end
    end
    AVG_HoverV_s(j,1)=mean(dummy);
    STD_HoverV_s(j,1)=std(dummy);
    clear dummy counter
end

for j=1:NFFT
    counter=0;dummy=0;
    for i=1:records_num
        if isnumeric(result(i).HoverV_ecoda)
            counter=counter+1;
            dummy(counter)=result(i).HoverV_ecoda(j);
        end
    end
    AVG_HoverV_ecoda(j,1)=mean(dummy);
    STD_HoverV_ecoda(j,1)=std(dummy);
    clear dummy counter
end
clear i j

for j=1:NFFT
    counter=0;dummy=0;
    for i=1:records_num
        if isnumeric(result(i).HoverV_coda)
            counter=counter+1;
            dummy(counter)=result(i).HoverV_coda(j);
        end
    end
    AVG_HoverV_coda(j,1)=mean(dummy);
    STD_HoverV_coda(j,1)=std(dummy);
    clear dummy counter
end
clear i j

%%
figure('name','whole')
plot(result(1).freq_whole,AVG_HoverV_whole,'r')
hold on
plot(result(1).freq_whole,max(0,AVG_HoverV_whole-STD_HoverV_whole),'--g')
plot(result(1).freq_whole,AVG_HoverV_whole+STD_HoverV_whole,'--g')
xlim([fmin fmax])
set(gca,'TickDir','out'); title(station);
set(gca,'XMinorTick','on','YMinorTick','on');


figure('name','noise')
plot(result(1).freq_noise,AVG_HoverV_noise,'r')
hold on
plot(result(1).freq_noise,max(0,AVG_HoverV_noise-STD_HoverV_noise),'--g')
plot(result(1).freq_noise,AVG_HoverV_noise+STD_HoverV_noise,'--g')
xlim([fmin fmax])
set(gca,'TickDir','out'); title(station);
set(gca,'XMinorTick','on','YMinorTick','on');

figure('name','p')
plot(result(1).freq_p,AVG_HoverV_p,'r')
hold on
plot(result(1).freq_p,max(0,AVG_HoverV_p-STD_HoverV_p),'--g')
plot(result(1).freq_p,AVG_HoverV_p+STD_HoverV_p,'--g')
xlim([fmin fmax])
set(gca,'TickDir','out'); title(station);
set(gca,'XMinorTick','on','YMinorTick','on');

figure('name','s')
plot(result(1).freq_s,AVG_HoverV_s,'r')
hold on
plot(result(1).freq_s,max(0,AVG_HoverV_s-STD_HoverV_s),'--g')
plot(result(1).freq_s,AVG_HoverV_s+STD_HoverV_s,'--g')
xlim([fmin fmax])
set(gca,'TickDir','out'); title(station);
set(gca,'XMinorTick','on','YMinorTick','on');

figure('name','early coda')
plot(result(1).freq_ecoda,AVG_HoverV_ecoda,'r')
hold on
plot(result(1).freq_ecoda,max(0,AVG_HoverV_ecoda-STD_HoverV_ecoda),'--g')
plot(result(1).freq_ecoda,AVG_HoverV_ecoda+STD_HoverV_ecoda,'--g')
xlim([fmin fmax])
set(gca,'TickDir','out'); title(station);
set(gca,'XMinorTick','on','YMinorTick','on');

figure('name','late coda')
plot(result(1).freq_coda,AVG_HoverV_coda,'r')
hold on
plot(result(1).freq_coda,max(0,AVG_HoverV_coda-STD_HoverV_coda),'--g')
plot(result(1).freq_coda,AVG_HoverV_coda+STD_HoverV_coda,'--g')
xlim([fmin fmax])
set(gca,'TickDir','out'); title(station);
set(gca,'XMinorTick','on','YMinorTick','on');





%%
figure('name',station)
subplot(231)
plot(result(1).freq_whole,AVG_HoverV_whole,'r')
hold on
plot(result(1).freq_whole,max(0,AVG_HoverV_whole-STD_HoverV_whole),'--g')
plot(result(1).freq_whole,AVG_HoverV_whole+STD_HoverV_whole,'--g')
xlim([fmin fmax])
set(gca,'TickDir','out'); title(station);
set(gca,'XMinorTick','on','YMinorTick','on');
title('Whole Record')

subplot(232)
plot(result(1).freq_p,AVG_HoverV_p,'r')
hold on
plot(result(1).freq_p,max(0,AVG_HoverV_p-STD_HoverV_p),'--g')
plot(result(1).freq_p,AVG_HoverV_p+STD_HoverV_p,'--g')
xlim([fmin fmax])
set(gca,'TickDir','out'); title(station);
set(gca,'XMinorTick','on','YMinorTick','on');
title('P-wave')

subplot(233)
plot(result(1).freq_s,AVG_HoverV_s,'r')
hold on
plot(result(1).freq_s,max(0,AVG_HoverV_s-STD_HoverV_s),'--g')
plot(result(1).freq_s,AVG_HoverV_s+STD_HoverV_s,'--g')
xlim([fmin fmax])
set(gca,'TickDir','out'); title(station);
set(gca,'XMinorTick','on','YMinorTick','on');
title('S-wave')

subplot(234)
plot(result(1).freq_ecoda,AVG_HoverV_ecoda,'r')
hold on
plot(result(1).freq_ecoda,max(0,AVG_HoverV_ecoda-STD_HoverV_ecoda),'--g')
plot(result(1).freq_ecoda,AVG_HoverV_ecoda+STD_HoverV_ecoda,'--g')
xlim([fmin fmax])
set(gca,'TickDir','out'); title(station);
set(gca,'XMinorTick','on','YMinorTick','on');
title('Early coda-wave')

subplot(235)
plot(result(1).freq_coda,AVG_HoverV_coda,'r')
hold on
plot(result(1).freq_coda,max(0,AVG_HoverV_coda-STD_HoverV_coda),'--g')
plot(result(1).freq_coda,AVG_HoverV_coda+STD_HoverV_coda,'--g')
xlim([fmin fmax])
set(gca,'TickDir','out'); title(station);
set(gca,'XMinorTick','on','YMinorTick','on');
title('Late coda-wave')

subplot(236)
plot(result(1).freq_noise,AVG_HoverV_noise,'r')
hold on
plot(result(1).freq_noise,max(0,AVG_HoverV_noise-STD_HoverV_noise),'--g')
plot(result(1).freq_noise,AVG_HoverV_noise+STD_HoverV_noise,'--g')
xlim([fmin fmax])
set(gca,'TickDir','out'); title(station);
set(gca,'XMinorTick','on','YMinorTick','on');
title('Noise')













%% Ploting

figure('name','Figure 1')
subplot(531)
plot(result(fig).t,result(fig).Time_Z,'Color',[0 0.498039215686275 0])
ylabel('Amplitude (Counts)');xlabel('Time (sec)');
set(gca,'TickDir','out'); title('Vertical');
set(gca,'XMinorTick','on','YMinorTick','on');
xlim([0 400]);ylim([-60000 +60000]);

subplot(532)
plot(result(fig).t,result(fig).Time_N,'Color',[0 0.498039215686275 0])
xlabel('Time (sec)');
set(gca,'TickDir','out'); title('N-S');
set(gca,'XMinorTick','on','YMinorTick','on');
xlim([0 400]);ylim([-60000 +60000]);

subplot(533)
plot(result(fig).t,result(fig).Time_E,'Color',[0 0.498039215686275 0])
xlabel('Time (sec)');
set(gca,'TickDir','out'); title('E-W');
set(gca,'XMinorTick','on','YMinorTick','on');
xlim([0 400]);ylim([-60000 +60000]);

subplot(334)
loglog(result(fig).freq_whole,abs(result(fig).FFT_whole_Z),'k')
hold on
loglog(result(fig).freq_noise,abs(result(fig).FFT_noise_Z),'color',[0.7 0.7 0.7])
loglog(result(fig).freq_p,abs(result(fig).FFT_p_Z),'color',[0 0.6 1])
loglog(result(fig).freq_s,abs(result(fig).FFT_s_Z),'color',[0 0.8 0])
loglog(result(fig).freq_ecoda,abs(result(fig).FFT_ecoda_Z),'color','m')
loglog(result(fig).freq_coda,abs(result(fig).FFT_coda_Z),'color','r')
hold off
xlim([fmin fmax])
set(gca,'TickDir','out');  title('Vertical');
set(gca,'XMinorTick','on','YMinorTick','on');
set(gca,'XTick',[0.15,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1,2,3,4,5,6,7,8,9,10,20],'XTickLabel',{'0.15','','','','0.5','','','','','1.0','','','','5.0','','','','','','20.0'});
xlabel('Frequency (Hz)');ylabel('FAS');
ylim([10^2 10^8]);

subplot(335)
loglog(result(fig).freq_whole,abs(result(fig).FFT_whole_E),'k')
hold on
loglog(result(fig).freq_noise,abs(result(fig).FFT_noise_E),'color',[0.7 0.7 0.7])
loglog(result(fig).freq_p,abs(result(fig).FFT_p_E),'color',[0 0.6 1])
loglog(result(fig).freq_s,abs(result(fig).FFT_s_E),'color',[0 0.8 0])
loglog(result(fig).freq_ecoda,abs(result(fig).FFT_ecoda_E),'color','m')
loglog(result(fig).freq_coda,abs(result(fig).FFT_coda_E),'color','r')
hold off
xlim([fmin fmax])
set(gca,'TickDir','out'); title('E-W');
set(gca,'XMinorTick','on','YMinorTick','on');
set(gca,'XTick',[0.15,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1,2,3,4,5,6,7,8,9,10,20],'XTickLabel',{'0.15','','','','0.5','','','','','1.0','','','','5.0','','','','','','20.0'});
xlabel('Frequency (Hz)');
ylim([10^2 10^8]);

subplot(336)
loglog(result(fig).freq_whole,abs(result(fig).FFT_whole_N),'k')
hold on
loglog(result(fig).freq_noise,abs(result(fig).FFT_noise_N),'color',[0.7 0.7 0.7])
loglog(result(fig).freq_p,abs(result(fig).FFT_p_N),'color',[0 0.6 1])
loglog(result(fig).freq_s,abs(result(fig).FFT_s_N),'color',[0 0.8 0])
loglog(result(fig).freq_ecoda,abs(result(fig).FFT_ecoda_N),'color','m')
loglog(result(fig).freq_coda,abs(result(fig).FFT_coda_N),'color','r')
hold off
xlim([fmin fmax])
set(gca,'TickDir','out'); title('N-S');
set(gca,'XMinorTick','on','YMinorTick','on');
set(gca,'XTick',[0.15,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1,2,3,4,5,6,7,8,9,10,20],'XTickLabel',{'0.15','','','','0.5','','','','','1.0','','','','5.0','','','','','','20.0'});
xlabel('Frequency (Hz)');
ylim([10^2 10^8]);

subplot(338)
semilogx(result(fig).freq_whole,result(fig).HoverV_whole,'color','k')
hold on
semilogx(result(fig).freq_whole,result(fig).HoverV_noise,'color',[0.7 0.7 0.7])
semilogx(result(fig).freq_whole,result(fig).HoverV_p,'color',[0 0.6 1])
semilogx(result(fig).freq_whole,result(fig).HoverV_s,'color',[0 0.8 0])
semilogx(result(fig).freq_whole,result(fig).HoverV_ecoda,'color','m')
semilogx(result(fig).freq_whole,result(fig).HoverV_coda,'color','r')

legend('Whole','Noise','P-wave','S-wave','Early coda-wave','Late Coda-wave','location','SW','Location','NE')
xlabel('Frequency (Hz)');ylabel('H/V Ratio');
set(gca,'XTick',[0.15,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1,2,3,4,5,6,7,8,9,10,20],'XTickLabel',{'0.15','','','','0.5','','','','','1.0','','','','5.0','','','','','','20.0'});
xlim([fmin fmax]);ylim([0 10])
set(gca,'TickDir','out'); 
set(gca,'XMinorTick','on','YMinorTick','on');


%% Ploting

figure('name','whole')
semilogx(result(1).freq_whole,AVG_HoverV_whole,'k','LineWidth',1.5)
hold on
plot(result(1).freq_whole,max(0,AVG_HoverV_whole-STD_HoverV_whole),'--r','LineWidth',1)
for i=1:records_num
    semilogx(result(i).freq_whole,result(i).HoverV_whole,'color',[0.78 0.78 0.78])
    hold on
end
semilogx(result(1).freq_whole,AVG_HoverV_whole,'k','LineWidth',1.5)
hold on
plot(result(1).freq_whole,max(0,AVG_HoverV_whole-STD_HoverV_whole),'--r','LineWidth',1)
plot(result(1).freq_whole,AVG_HoverV_whole+STD_HoverV_whole,'--r','LineWidth',1)
legend('\mu','\mu \pm \sigma','Each Record')
xlabel('Frequency (Hz)');ylabel('H/V Ratio');
xlim([fmin fmax]);ylim([0 10])
set(gca,'TickDir','out'); title(station);
set(gca,'XMinorTick','on','YMinorTick','on');
set(gca,'XTick',[0.15,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1,2,3,4,5,6,7,8,9,10,20],'XTickLabel',{'0.15','0.2','','','0.5','','','','','1.0','','','','5.0','','','','','10.0','20.0'});




figure('name','whole')
semilogx(result(1).freq_whole,AVG_HoverV_whole,'k','LineWidth',1.5)
hold on
plot(result(1).freq_whole,max(0,AVG_HoverV_whole-STD_HoverV_whole),'--r','LineWidth',1)
semilogx(result(1).freq_whole,AVG_HoverV_whole,'k','LineWidth',1.5)
hold on
plot(result(1).freq_whole,max(0,AVG_HoverV_whole-STD_HoverV_whole),'--r','LineWidth',1)
plot(result(1).freq_whole,AVG_HoverV_whole+STD_HoverV_whole,'--r','LineWidth',1)
% legend('\mu','\mu \pm \sigma')
xlabel('Frequency (Hz)');ylabel('H/V Ratio');
xlim([fmin fmax]);ylim([0 10])
set(gca,'TickDir','out'); title(station);
set(gca,'XMinorTick','on','YMinorTick','on');
set(gca,'XTick',[0.15,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1,2,3,4,5,6,7,8,9,10,20],'XTickLabel',{'0.15','0.2','','','0.5','','','','','1.0','','','','5.0','','','','','10.0','20.0'});


%%


figure('name','All in one')
semilogx(result(1).freq_whole,AVG_HoverV_whole,'k','LineWidth',2)
hold on
semilogx(result(1).freq_whole,AVG_HoverV_s,'--b','LineWidth',.5)
semilogx(result(1).freq_whole,AVG_HoverV_p,':r','LineWidth',.5)
semilogx(result(1).freq_whole,AVG_HoverV_ecoda,'-.g','LineWidth',.5)
semilogx(result(1).freq_whole,AVG_HoverV_coda,'m','LineWidth',1.5)
semilogx(result(1).freq_whole,AVG_HoverV_noise,'Color',[0.929411768913269 0.694117665290833 0.125490203499794],'LineWidth',0.5)

legend('Whole','S','P','Early','Late','Noise')
xlabel('Frequency (Hz)');ylabel('H/V Ratio');
xlim([fmin fmax]);ylim([0 10])
set(gca,'TickDir','out'); title(station);
set(gca,'XMinorTick','on','YMinorTick','on');
set(gca,'XTick',[0.15,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1,2,3,4,5,6,7,8,9,10,20],'XTickLabel',{'0.15','0.2','','','0.5','','','','','1.0','','','','5.0','','','','','10.0','20.0'});


% legend('Noise','Late Coda','Earlu Coda','P-wave','S-wave','Whole Record')


set(findall(gcf,'-property','FontSize'),'FontSize',12)
set(findall(gcf,'-property','Fontname'),'Fontname', 'Times New Roman')


