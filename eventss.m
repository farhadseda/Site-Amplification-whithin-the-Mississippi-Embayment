for i=1:numel(data)
AA(i,1)=data(i).evla;
AA(i,2)=data(i).evlo;
AA(i,3)=data(i).M;
AA(i,4)=data(i).evdp;
BB{i,1}=data(i).event;
end


C=unique(AA,'rows');
CC=unique(BB,'rows');