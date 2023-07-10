close all
for i=1:records_num
    fig=i;
    figure('name','Figure 1')
    subplot(531)
    plot(result(fig).t,result(fig).Time_Z,'Color',[0 0.498039215686275 0])
    hold on
    ylabel('Amplitude (Counts)');xlabel('Time (sec)');
    set(gca,'TickDir','out'); title('Vertical');
    set(gca,'XMinorTick','on','YMinorTick','on');
    xlim([50 250]);ylim([-300000 +300000]);
    start_whole=result(i).fp-10;
    ending_whole=start_whole+150;
    start_noise=result(i).fp-7;
    ending_noise=start_noise+5;
    start_p=result(i).fp;
    SP=result(i).fs-start_p;
    if SP>5
        ending_p=start_p+5;
    else
        ending_p=start_p+SP-1;
    end
    start_s=result(i).fs;
    ending_s=start_s+5;
    start_ecoda=1.5*(result(i).fs-result(i).o)+result(i).o;
    ending_ecoda=start_ecoda+5;
    start_coda=2*(result(i).fs-result(i).o)+result(i).o;
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
    
    subplot(532)
    plot(result(fig).t,result(fig).Time_N,'Color',[0 0.498039215686275 0])
    hold on
    xlabel('Time (sec)');
    set(gca,'TickDir','out'); title('N-S');
    set(gca,'XMinorTick','on','YMinorTick','on');
    xlim([50 250]);ylim([-300000 +300000]);
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
    
    subplot(533)
    plot(result(fig).t,result(fig).Time_E,'Color',[0 0.498039215686275 0])
    hold on
    xlabel('Time (sec)');
    set(gca,'TickDir','out'); title('E-W');
    set(gca,'XMinorTick','on','YMinorTick','on');
    xlim([50 250]);ylim([-300000 +300000]);
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
end
