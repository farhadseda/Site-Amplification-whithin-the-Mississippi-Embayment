
fig=[8];

for i=1:records_num
    figure('name',num2str(i));
    fig=i;
    % fig=16;
    subplot(211);plot(result(fig).t,result(fig).Time_Z)
    subplot(212);cwt(result(fig).Time_Z,100)
end


%%

fig=[2];

figure('name','Figure 1')
subplot(341)
plot(result(fig).t,result(fig).Time_Z,'Color',[0 0.498039215686275 0])


subplot(342)
plot(result(fig).t,result(fig).Time_N,'Color',[0 0.498039215686275 0])


subplot(343)
plot(result(fig).t,result(fig).Time_E,'Color',[0 0.498039215686275 0])


subplot(245)
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

subplot(246)
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

subplot(247)
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

subplot(144)
