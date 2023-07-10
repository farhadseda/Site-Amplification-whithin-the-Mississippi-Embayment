% Dir
clear
%% Data Folder ' Event Year Folder ' Event Name Folder ' FIELS!!!
display('SELECT THE FOLDER THAT CONTAINS EVENT YEARS...');
DIR0=uigetdir;
DIR=dir(DIR0); % Make Sure there are ONLY folders in
addpath(genpath(DIR0));
%% Reading Folders 
J=1;
for j=3:numel(DIR)
    if exist(DIR(j).name)==7 %#ok<EXIST>
        NEWpath=strcat(DIR0,'\',DIR(j).name);
        DIRLIST{J,1}=NEWpath;
        DIR1{J,1}=dir(NEWpath);
        K=1;
        for k=3:numel(DIR1{J})
            NEWpath_EVENT=strcat(DIR0,'\',DIR(j).name,'\',DIR1{J,1}(k).name);
            EVENTNAMES{J,1}{K,1}=dir(fullfile(NEWpath_EVENT));
            EVENTNAMES{J,1}{K,2}=NEWpath_EVENT;
            EVENTNAMES{J,1}{K,3}=DIR(j).name;
            K=K+1;
        end
        J=J+1;
    end
end

%% Constructing the data Structure
% Station'event'M'Depth'D_epi'D-hyp'dt'Time_Z'Time_N'Time_E'file
% Path
count=1;
for j=1:numel(EVENTNAMES) %events
    for k=1:numel(EVENTNAMES{j,1})/3 %seismograms
        eventset(count)=struct('eventname',[],'network',[],'station',[],'direction',[],'filepath',[],'folder',[]); %#ok<*SAGROW>
        %for l=1:numel(EVENTNAMES{j,1}{k,1}) 
            name=EVENTNAMES{j,1}(k,3);
            eventset(count).eventname=name{:};
            eventset(count).network=EVENTNAMES{j,1}{k,1}.name(1:2);
            eventset(count).station=EVENTNAMES{j,1}{k,1}.name(4:7);
            eventset(count).direction=EVENTNAMES{j,1}{k,1}.name(12:14);
            eventset(count).filepath=EVENTNAMES{j,1}{k,2};
            eventset(count).folder=DIRLIST{j};
            count=count+1;
        %end

    end
end

%% construction the dataset USING loadsac
cd(DIR0)
count=1;
data=struct('event',[],'evla',[],'evlo',[],'evdp',[],'M',[],'network',[],'station',[],'stla',[],'stlo',[],'delta',[],'az',[],'d_epi',[],'d_hyp',[],'o',[],'fp',[],'fs',[],'t',[],'Time_Z',[],'Time_E',[],'Time_N',[]);
for i=1:numel(eventset)
    %addpath(eventset{i,1}.folder)
    
    [sachdr,SEIS] = load_sac(eventset(i).filepath);
    if i==1
        st1=sachdr.kstnm(1:4);
    end
    if  i>1 && strcmp(sachdr.kstnm(1:4),st1)==0
        st1=sachdr.kstnm(1:4);
        count=count+1;
    end
    
    %%%%%%%%%%%%%%%% DATA %%%%%%%%%%%%%%%%%%%%%%%%
    if upper(eventset(i).direction(3))=='Z'
        data(count).Time_Z=SEIS;
    elseif upper(eventset(i).direction(3))=='E'
        data(count).Time_E=SEIS;
    elseif upper(eventset(i).direction(3))=='N'
        data(count).Time_N=SEIS;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% skip sachdr for other components
    
    
%     if i>1 && strcmp(sachdr.kstnm(1:4),st1)==1
%         continue
%     elseif i==1
%         % Nothing
%     else
%     end
    %%
    
    %%%%%%%%%%%%%%%%%%% EVENT %%%%%%%%%%%%%%%%%%%%
    data(count).event=eventset(i).eventname;   % EVENT NAME
    data(count).evla=sachdr.evla;              % EVENT LATITUDE 
    data(count).evlo=sachdr.evlo;              % EVENT LONGITUDE
    data(count).evdp=sachdr.evdp;              % EVENT DEPTH
    data(count).M=eventset(i).eventname(strfind(eventset(i).eventname,'_')+1:end); % Magnitude
    
    %%%%%%%%%%%%%%%%%%%% STATION %%%%%%%%%%%%%%%%%
    data(count).station=sachdr.kstnm(1:4);         % STATION NAME
    data(count).stla=sachdr.stla;                  % STATION LATITUDE
    data(count).stlo=sachdr.stlo;                  % STATION LONGITUDE
    data(count).delta=sachdr.delta;                % STATION LATITUDE
    data(count).network=sachdr.knetwk;             % NETWORK NAME
    data(count).az=sachdr.az;                      % NETWORK NAME
    
    %%%%%%%%%%%%%%%%%%%%% DISTS%%%%%%%%%%%%%%%%%%%
    data(count).d_epi=sachdr.dist;          % SOURCE TO SITE DISTANCE (EPICENTRAL)
    data(count).d_hyp=sqrt(data(count).d_epi^2 +data(count).evdp^2);          % SOURCE TO SITE DISTANCE (EPICENTRAL)
    
    %%%%%%%%%%%%%%%%%%%%%TIMES%%%%%%%%%%%%%%%%%%%%
    data(count).o=sachdr.o;                  % ORIGIN TIME FROM THE BEGINNING OF DATA
    data(count).fp=sachdr.t1;                % FIRST P ARRIVAL
    data(count).fs=sachdr.t2;                % FIRST S ARRIVAL
    data(count).t=(0:data(count).delta:(length(SEIS)-1)*data(count).delta)';
end

%SNRCHECK;
%% Clean up

clear count DIR DIRLIST  i j k J K name NEWpath NEWpath_EVENT sachdr SEIS st1


























