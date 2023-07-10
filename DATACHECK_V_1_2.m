for i=1:numel(data)

%%%%%%%%---------------------Z-Component--------------------------%%%%%%%%%%

    subplot(3,1,1);
    if numel(data(i).Time_Z)~=0
        
        L=min(length(data(i).t),length(data(i).Time_Z));
        plot(data(i).t(1:L),data(i).Time_Z(1:L))
        ylim([-1.25*max(abs(data(i).Time_Z)) 1.25*max(abs(data(i).Time_Z))])
        xlim([0 300])

        if isfield(data(i),'fp')==1 && isempty(data(i).fp)~=1
        line(data(i).fp*[1 1],max(abs(data(i).Time_Z))*[-1 1],'color','k')
        hold on
        h=text(data(i).fp,round(max(abs(data(i).Time_Z))),'P-wave','color','k','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off
        end
        if isfield(data(i),'o')==1 && isempty(data(i).o)~=1
        line(data(i).o*[1 1],max(abs(data(i).Time_Z))*[-1 1],'color','r')
        hold on
        h=text(data(i).o,round(max(abs(data(i).Time_Z))),'Origin Time','Color','r','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off
        end
        if isfield(data(i),'o')==1 && isempty(data(i).o)~=1
        line(data(i).fs*[1 1],max(abs(data(i).Time_Z))*[-1 1],'color','y')
        hold on
        h=text(data(i).fs,round(max(abs(data(i).Time_Z))),'S-wave','color','y','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off
        end
        if isfield(data(i),'lg1')==1 && isempty(data(i).lg1)~=1
        line(data(i).lg1*[1 1],max(abs(data(i).Time_z))*[-1 1],'color','b')
        hold on
        h=text(data(i).lg1,round(max(abs(data(i).lg1))),'Lg-1','Color','b','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off
        end
        if isfield(data(i),'lg2')==1 && isempty(data(i).lg2)~=1
        line(data(i).lg*[1 1],max(abs(data(i).Time_Z))*[-1 1],'color','b')
        hold on
        h=text(data(i).lg2,round(max(abs(data(i).Time_Z))),'Lg-2','Color','b','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off
        end


    %%% CODA WINDOW LOCATION
        tc1=((data(i).fs-data(i).o)*2+data(i).o)/data(i).delta;
        tc2=(tc1+10/data(i).delta);

        line((tc1)*[1 1]*data(i).delta,max(abs(data(i).Time_Z))*[-1 1],'color','g')
        hold on
        h=text((tc1)*data(i).delta,round(max(abs(data(i).Time_Z))),'CODA 1','Color','g','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off

        line((tc2)*[1 1]*data(i).delta,max(abs(data(i).Time_Z))*[-1 1],'color','g')
        hold on
        h=text((tc2)*data(i).delta,round(max(abs(data(i).Time_Z))),'CODA 2','Color','g','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off


        title({['Eventname: ' data(i).event '--> Station: ' data(i).station];...
                ['Hypocentral Distance: ' num2str(data(i).d_hyp) '--> Magnitude: ' num2str(data(i).M) ];['DATA NUMBER: ' num2str(i) ]},'fontsize',8)
        set(gca,'Color',[0.8 0.8 0.8],'fontsize',8);
        xlabel('Time (sec)','fontsize',8)
        grid

    end
%%%%%%%%%%---------------------E-Component--------------------------%%%%%%%%%%
    subplot(3,1,2);
    if numel(data(i).Time_E)~=0
        
        L=min(length(data(i).t),length(data(i).Time_E));
        plot(data(i).t(1:L),data(i).Time_E(1:L))
        ylim([-1.25*max(abs(data(i).Time_E)) 1.25*max(abs(data(i).Time_E))])
        xlim([0 300])

        if isfield(data(i),'fp')==1 && isempty(data(i).fp)~=1
        line(data(i).fp*[1 1],max(abs(data(i).Time_E))*[-1 1],'color','k')
        hold on
        h=text(data(i).fp,round(max(abs(data(i).Time_E))),'P-wave','color','k','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off
        end
        if isfield(data(i),'o')==1 && isempty(data(i).o)~=1
        line(data(i).o*[1 1],max(abs(data(i).Time_E))*[-1 1],'color','r')
        hold on
        h=text(data(i).o,round(max(abs(data(i).Time_E))),'Origin Time','Color','r','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off
        end
        if isfield(data(i),'o')==1 && isempty(data(i).o)~=1
        line(data(i).fs*[1 1],max(abs(data(i).Time_E))*[-1 1],'color','y')
        hold on
        h=text(data(i).fs,round(max(abs(data(i).Time_E))),'S-wave','color','y','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off
        end
        if isfield(data(i),'lg1')==1 && isempty(data(i).lg1)~=1
        line(data(i).lg1*[1 1],max(abs(data(i).Time_E))*[-1 1],'color','b')
        hold on
        h=text(data(i).lg1,round(max(abs(data(i).lg1))),'Lg-1','Color','b','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off
        end
        if isfield(data(i),'lg2')==1 && isempty(data(i).lg2)~=1
        line(data(i).lg*[1 1],max(abs(data(i).Time_E))*[-1 1],'color','b')
        hold on
        h=text(data(i).lg2,round(max(abs(data(i).Time_E))),'Lg-2','Color','b','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off
        end


    %%% CODA WINDOW LOCATION
        tc1=((data(i).fs-data(i).o)*2+data(i).o)/data(i).delta;
        tc2=(tc1+10/data(i).delta);

        line((tc1)*[1 1]*data(i).delta,max(abs(data(i).Time_E))*[-1 1],'color','g')
        hold on
        h=text((tc1)*data(i).delta,round(max(abs(data(i).Time_E))),'CODA 1','Color','g','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off

        line((tc2)*[1 1]*data(i).delta,max(abs(data(i).Time_E))*[-1 1],'color','g')
        hold on
        h=text((tc2)*data(i).delta,round(max(abs(data(i).Time_E))),'CODA 2','Color','g','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off
        grid
        set(gca,'Color',[0.8 0.8 0.8],'fontsize',8);
        xlabel('Time (sec)','fontsize',8)
    
    end
    %%%%%%%%---------------------N-Component--------------------------%%%%%%%%%%
    subplot(3,1,3);
    
    if numel(data(i).Time_N)~=0
        
        L=min(length(data(i).t),length(data(i).Time_N));
        plot(data(i).t(1:L),data(i).Time_N(1:L))
        ylim([-1.25*max(abs(data(i).Time_N)) 1.25*max(abs(data(i).Time_N))])
        xlim([0 300])

        if isfield(data(i),'fp')==1 && isempty(data(i).fp)~=1
        line(data(i).fp*[1 1],max(abs(data(i).Time_N))*[-1 1],'color','k')
        hold on
        h=text(data(i).fp,round(max(abs(data(i).Time_N))),'P-wave','color','k','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off
        end
        if isfield(data(i),'o')==1 && isempty(data(i).o)~=1
        line(data(i).o*[1 1],max(abs(data(i).Time_N))*[-1 1],'color','r')
        hold on
        h=text(data(i).o,round(max(abs(data(i).Time_N))),'Origin Time','Color','r','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off
        end
        if isfield(data(i),'o')==1 && isempty(data(i).o)~=1
        line(data(i).fs*[1 1],max(abs(data(i).Time_N))*[-1 1],'color','y')
        hold on
        h=text(data(i).fs,round(max(abs(data(i).Time_N))),'S-wave','color','y','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off
        end
        if isfield(data(i),'lg1')==1 && isempty(data(i).lg1)~=1
        line(data(i).lg1*[1 1],max(abs(data(i).Time_N))*[-1 1],'color','b')
        hold on
        h=text(data(i).lg1,round(max(abs(data(i).lg1))),'Lg-1','Color','b','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off
        end
        if isfield(data(i),'lg2')==1 && isempty(data(i).lg2)~=1
        line(data(i).lg*[1 1],max(abs(data(i).Time_N))*[-1 1],'color','b')
        hold on
        h=text(data(i).lg2,round(max(abs(data(i).Time_N))),'Lg-2','Color','b','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off
        end


    %%% CODA WINDOW LOCATION
        tc1=((data(i).fs-data(i).o)*2+data(i).o)/data(i).delta;
        tc2=(tc1+10/data(i).delta);

        line((tc1)*[1 1]*data(i).delta,max(abs(data(i).Time_N))*[-1 1],'color','g')
        hold on
        h=text((tc1)*data(i).delta,round(max(abs(data(i).Time_N))),'CODA 1','Color','g','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off

        line((tc2)*[1 1]*data(i).delta,max(abs(data(i).Time_N))*[-1 1],'color','g')
        hold on
        h=text((tc2)*data(i).delta,round(max(abs(data(i).Time_N))),'CODA 2','Color','g','fontsize',8,'fontweight','bold');
        set(h,'rotation',60)
        hold off
        grid
        set(gca,'Color',[0.8 0.8 0.8],'fontsize',8);
        xlabel('Time (sec)','fontsize',8)
        %%%%%%%%%%%%%%%%%%%%%%

        
    end
    pauseoff=['pause(' char(39) 'off' char(39) ')'];
    r='REMOVE'; %#ok<*NASGU>
    c='CHECK';
    btn = uicontrol('Style', 'pushbutton', 'String', 'REMOVE',...
    'Position', [60 600 100 40],'Callback','data(i).tag=r;','fontsize',10);
    btn1 = uicontrol('Style', 'pushbutton', 'String', 'RECHECK',...
    'Position', [60 550 100 40],'Callback','data(i).tag=c;','fontsize',10);
    btn2 = uicontrol('Style', 'pushbutton', 'String', 'CLEAR TAG',...
    'Position', [60 500 100 40],'Callback','data(i).tag=c;','fontsize',10);

    set( gcf, 'toolbar', 'figure' )
    set(gcf, 'Position', get(0,'Screensize'));
    pause(5)
    clear btn btn1 btn2 c h i r tc1 tc2
    close
end
    
%% clean up

% answer=input('DO YOU WANT TO SAVE PROGRESS? (y/n) >>','s');
% if answer=='y'
%     save('bystationFINAL.mat','bystation')
% end
