clc
% clear all
close all
%%
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

%% load the data
load('data.mat')
for i=1:numel(data)
    M(i)=data(i).M;
    d(i)=data(i).d_hyp;
    h(i)=data(i).evdp;
end
clear i

%% Figure 1: distribuation of data

figure('name','Distribution of the data')
for i=1:length(M)
semilogx(d(i),M(i),'MarkerFaceColor',[0 1 1],'Marker','o','MarkerSize',...
    h(i)/1.2,'LineStyle','none',...
    'Color',[0 0 0]);hold on
end
xlabel('Hypocentral Distance (km)');ylabel('Magnitude');
set(gca,'TickDir','out'); % title('Distribution');
set(gca,'XMinorTick','on','YMinorTick','on');
xlim([10 450]);ylim([2.4 4.5]);
box(gca,'on');
set(gca,'XTick',[10,20,30,40,50,60,70,80,90,100,200,300,400,450],'XTickLabel',{'10','','','','','','','','','100','','300','','450'})


%%
shift=4;
fig=269;
codawin=5;
% fig=[268 269];
for i=fig(1):fig(end)
figure('name','Time Histories')
%%%%%%%%---------------------Z-Component--------------------------%%%%%%%%%%

    subplot(3,1,1);
    if numel(data(i).Time_Z)~=0
        
        L=min(length(data(i).t),length(data(i).Time_Z));
        plot(data(i).t(1:L),data(i).Time_Z(1:L))
        xlim([0 200]);%ylim([-7e5 7e5]);
        y1=get(gca,'ylim');
        if isfield(data(i),'fp')==1 && isempty(data(i).fp)~=1
        line(data(i).fp*[1 1],y1,'color','k','LineWidth',1)
        hold on
        h=text(data(i).fp-shift,y1(1),'P-wave','color','k','fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off
        end
        if isfield(data(i),'o')==1 && isempty(data(i).o)~=1
        line(data(i).o*[1 1],y1,'color','r','LineWidth',1)
        hold on
        h=text(data(i).o-shift,y1(1),'Origin Time','Color','r','fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off
        end
        if isfield(data(i),'o')==1 && isempty(data(i).o)~=1
        line(data(i).fs*[1 1],y1,'color','m','LineWidth',1)
        hold on
        h=text(data(i).fs-shift,y1(1),'S-wave','color','m','fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off
        end
        if isfield(data(i),'lg1')==1 && isempty(data(i).lg1)~=1
        line(data(i).lg1*[1 1],y1,'color','b','LineWidth',1)
        hold on
        h=text(data(i).lg1,round(max(abs(data(i).lg1))),'Lg-1','Color','b','fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off
        end
        if isfield(data(i),'lg2')==1 && isempty(data(i).lg2)~=1
        line(data(i).lg*[1 1],max(abs(data(i).Time_Z))*[-1 1],'color','b')
        hold on
        h=text(data(i).lg2,round(max(abs(data(i).Time_Z))),'Lg-2','Color','b','fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off
        end


    %%% CODA WINDOW LOCATION
        tc1=((data(i).fs-data(i).o)*2+data(i).o)/data(i).delta;
        tc2=(tc1+codawin/data(i).delta);

        line((tc1)*[1 1]*data(i).delta,max(abs(data(i).Time_Z))*[-1 1],'Color',[0 0.498039215686275 0])
        hold on
        h=text((tc1)*data(i).delta,round(max(abs(data(i).Time_Z))),'CODA 1','Color',[0 0.498039215686275 0],'fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off

        line((tc2)*[1 1]*data(i).delta,max(abs(data(i).Time_Z))*[-1 1],'Color',[0 0.498039215686275 0])
        hold on
        h=text((tc2)*data(i).delta,round(max(abs(data(i).Time_Z))),'CODA 2','Color',[0 0.498039215686275 0],'fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off


        title({['Eventname: ' data(i).event '--> Station: ' data(i).station];...
                ['Hypocentral Distance: ' num2str(data(i).d_hyp) '--> Magnitude: ' num2str(data(i).M) ];['DATA NUMBER: ' num2str(i) ]},'fontsize',8)
        set(gca,'Color',[0.8 0.8 0.8],'fontsize',12);
        % xlabel('Time (sec)','fontsize',12)
        set(gca,'TickDir','out'); % title('Distribution');
        set(gca,'XMinorTick','on','YMinorTick','on');
        grid

    end
%%%%%%%%%%---------------------E-Component--------------------------%%%%%%%%%%
    subplot(3,1,2);
    if numel(data(i).Time_E)~=0
        
        L=min(length(data(i).t),length(data(i).Time_E));
        plot(data(i).t(1:L),data(i).Time_E(1:L))
        xlim([0 200]);ylim([-7e5 7e5]);
        y1=get(gca,'ylim');
        if isfield(data(i),'fp')==1 && isempty(data(i).fp)~=1
        line(data(i).fp*[1 1],y1,'color','k','LineWidth',1)
        hold on
        h=text(data(i).fp-shift,y1(1),'P-wave','color','k','fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off
        end
        if isfield(data(i),'o')==1 && isempty(data(i).o)~=1
        line(data(i).o*[1 1],y1,'color','r','LineWidth',1)
        hold on
        h=text(data(i).o-shift,y1(1),'Origin Time','Color','r','fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off
        end
        if isfield(data(i),'o')==1 && isempty(data(i).o)~=1
        line(data(i).fs*[1 1],y1,'color','m','LineWidth',1)
        hold on
        h=text(data(i).fs-shift,y1(1),'S-wave','color','m','fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off
        end
        if isfield(data(i),'lg1')==1 && isempty(data(i).lg1)~=1
        line(data(i).lg1*[1 1],y1,'color','b','LineWidth',1)
        hold on
        h=text(data(i).lg1,round(max(abs(data(i).lg1))),'Lg-1','Color','b','fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off
        end
        if isfield(data(i),'lg2')==1 && isempty(data(i).lg2)~=1
        line(data(i).lg*[1 1],max(abs(data(i).Time_E))*[-1 1],'color','b')
        hold on
        h=text(data(i).lg2,round(max(abs(data(i).Time_E))),'Lg-2','Color','b','fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off
        end


    %%% CODA WINDOW LOCATION
        tc1=((data(i).fs-data(i).o)*2+data(i).o)/data(i).delta;
        tc2=(tc1+codawin/data(i).delta);

        line((tc1)*[1 1]*data(i).delta,max(abs(data(i).Time_E))*[-1 1],'Color',[0 0.498039215686275 0])
        hold on
        h=text((tc1)*data(i).delta,round(max(abs(data(i).Time_E))),'CODA 1','Color',[0 0.498039215686275 0],'fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off

        line((tc2)*[1 1]*data(i).delta,max(abs(data(i).Time_E))*[-1 1],'Color',[0 0.498039215686275 0])
        hold on
        h=text((tc2)*data(i).delta,round(max(abs(data(i).Time_E))),'CODA 2','Color',[0 0.498039215686275 0],'fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off
        grid
        set(gca,'Color',[0.8 0.8 0.8],'fontsize',12);
        set(gca,'TickDir','out'); % title('Distribution');
        set(gca,'XMinorTick','on','YMinorTick','on');
        % xlabel('Time (sec)','fontsize',12)
        title('E-W')
    
    end
    %%%%%%%%---------------------N-Component--------------------------%%%%%%%%%%
    subplot(3,1,3);
    
    if numel(data(i).Time_N)~=0
        
        L=min(length(data(i).t),length(data(i).Time_N));
        plot(data(i).t(1:L),data(i).Time_N(1:L))
        xlim([0 200]);ylim([-7e5 7e5]);
        y1=get(gca,'ylim');
        if isfield(data(i),'fp')==1 && isempty(data(i).fp)~=1
        line(data(i).fp*[1 1],y1,'color','k','LineWidth',1)
        hold on
        h=text(data(i).fp-shift,y1(1),'P-wave','color','k','fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off
        end
        if isfield(data(i),'o')==1 && isempty(data(i).o)~=1
        line(data(i).o*[1 1],y1,'color','r','LineWidth',1)
        hold on
        h=text(data(i).o-shift,y1(1),'Origin Time','Color','r','fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off
        end
        if isfield(data(i),'o')==1 && isempty(data(i).o)~=1
        line(data(i).fs*[1 1],y1,'color','m','LineWidth',1)
        hold on
        h=text(data(i).fs-shift,y1(1),'S-wave','color','m','fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off
        end
        if isfield(data(i),'lg1')==1 && isempty(data(i).lg1)~=1
        line(data(i).lg1*[1 1],y1,'color','b','LineWidth',1)
        hold on
        h=text(data(i).lg1,round(max(abs(data(i).lg1))),'Lg-1','Color','b','fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off
        end
        if isfield(data(i),'lg2')==1 && isempty(data(i).lg2)~=1
        line(data(i).lg*[1 1],max(abs(data(i).Time_N))*[-1 1],'color','b')
        hold on
        h=text(data(i).lg2,round(max(abs(data(i).Time_N))),'Lg-2','Color','b','fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off
        end


    %%% CODA WINDOW LOCATION
        tc1=((data(i).fs-data(i).o)*2+data(i).o)/data(i).delta;
        tc2=(tc1+codawin/data(i).delta);

        line((tc1)*[1 1]*data(i).delta,max(abs(data(i).Time_N))*[-1 1],'Color',[0 0.498039215686275 0])
        hold on
        h=text((tc1)*data(i).delta,round(max(abs(data(i).Time_N))),'CODA 1','Color',[0 0.498039215686275 0],'fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off

        line((tc2)*[1 1]*data(i).delta,max(abs(data(i).Time_N))*[-1 1],'Color',[0 0.498039215686275 0])
        hold on
        h=text((tc2)*data(i).delta,round(max(abs(data(i).Time_N))),'CODA 2','Color',[0 0.498039215686275 0],'fontsize',12,'fontweight','bold');
        set(h,'rotation',90)
        hold off
        grid
        set(gca,'Color',[0.8 0.8 0.8],'fontsize',12);
        set(gca,'TickDir','out'); % title('Distribution');
        set(gca,'XMinorTick','on','YMinorTick','on');
        xlabel('Time (sec)','fontsize',12)
        ylabel('Amplitude (counts)')
        title('N-S')
        %%%%%%%%%%%%%%%%%%%%%%

        
    end

    set( gcf, 'toolbar', 'figure' )
    % set(gcf, 'Position', get(0,'Screensize'));
    clear btn btn1 btn2 c h i r tc1 tc2 L
end


%%