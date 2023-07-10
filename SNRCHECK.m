%% SNR CHECK

SNR_limit=3;

for i=1:numel(data)
    
    dt=data(i).delta;
    fp=int32(data(i).fp/dt);
    fs=int32(data(i).fs/dt);
    
    if numel(data(i).Time_Z)~=0
        signalz=data(i).Time_Z(fs:fs+5/dt);
        noisez=data(i).Time_Z(fp-7/dt:fp-2/dt);
        data(i).SNR_Z=rms(signalz)/rms(noisez); %#ok<*SAGROW>
    else
        data(i).SNR_Z=-1;
    end
    
    if numel(data(i).Time_E)~=0
        signale=data(i).Time_E(fs:fs+5/dt);
        noisee=data(i).Time_E(fp-7/dt:fp-2/dt);
        data(i).SNR_E=rms(signale)/rms(noisee);
    else
        data(i).SNR_E=-1;
    end
    
    if numel(data(i).Time_N)~=0
        signaln=data(i).Time_N(fs:fs+5/dt);
        noisen=data(i).Time_N(fp-7/dt:fp-2/dt);
        data(i).SNR_N=rms(signaln)/rms(noisen);
    else
        data(i).SNR_N=-1;
    end
    
end

count=1;
for i=1:numel(data)
    if data(i).SNR_Z>SNR_limit && data(i).SNR_E>SNR_limit && data(i).SNR_N>SNR_limit
        datafinal(count)=data(i);
        count=count+1;
    end
end