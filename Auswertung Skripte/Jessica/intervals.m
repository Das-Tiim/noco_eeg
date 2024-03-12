function [latencies] = intervals(fn)
% extracts timestamps for the first (1-4) and second tone (111)
% subtracts them to get the interval for each trial
% separately for each SOA and auditory-only
% mean over all trials per person

[latencies{1,2:6}] = deal('A','SOA 0', 'SOA 50','SOA 200','SOA 600');
[latencies{2:3,1}] = deal('tone 1','tone 2');
latencies{4,1} = 'interval';
latencies{5,1} = 'binned interval'; % runden zwischen 600, 800 in 10er Schritten
latencies{6,1} = 'sum';
latencies{7,1} = 'mean';



%% Auditory-only aka NoPress

load([fn 'NoPress']);

latA1 = [];
latA2 = [];
for z = 1:length(EEG.event)
    if strcmp(EEG.event(z).type(1:4),'S  1')
        latA1 = horzcat(latA1,EEG.event(z).latency);
        ind2 = find(strcmp({EEG.event(z+1:end).type}, 'S111'),1,'first')+z;
        latA2 = horzcat(latA2,EEG.event(ind2).latency);
    end
end

intA = (latA2 - latA1).*2; % latA1, latA2 noch in samples, aber nur alle 2ms gemessen --> *2 to get ms

[latencies{2:4,2}] = deal(latA1, latA2,intA);
latencies{5,2} = round([latencies{4,2}],-1);

bins = 1200:10:1600;
latencies{6,2} = zeros(1,length(bins));
for b = 1:length(bins)
    latencies{6,2}(b) = sum([latencies{5,2}]==bins(b));
end

latencies{7,2} = round(mean([latencies{5,2}]),-1);


%% Motor-auditory (Sound)

clear EEG
load([fn 'Sound']);

for s = 1:4 % for each SOA
    lat1 = [];
    lat2 = [];
    trigger = ['S  ' num2str(s)];
    for z = 1:length(EEG.event)
        if strcmp(EEG.event(z).type, trigger)
            lat1 = horzcat(lat1, EEG.event(z).latency);
            ind2 = find(strcmp({EEG.event(z+1:end).type}, 'S111'),1,'first')+z;
            lat2 = horzcat(lat2, EEG.event(ind2).latency);
        end
    end
    latencies{2,s+2} = lat1;
    latencies{3,s+2} = lat2;
    latencies{4,s+2} = (lat2-lat1).*2;
    latencies{5,s+2} = round([latencies{4,s+2}],-1);
    latencies{7,s+2} = round(mean([latencies{5,s+2}]),-1);

    latencies{6,s+2} = zeros(1,length(bins));
    for b = 1:length(bins)
        latencies{6,s+2}(b) = sum([latencies{5,s+2}]==bins(b));
    end
end


end
