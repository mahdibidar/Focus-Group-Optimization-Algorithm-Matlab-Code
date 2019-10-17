
effectpop=[];
effectMean=[];
effectWorst=[];
effectBest=[];
effectSD=[];
effectMedian=[];
for i=50:50
    i
    [Mean,Worst,Best,SD,Median] = FGOA(i);
    effectMean = [effectMean Mean'];
    effectWorst = [effectWorst Worst'];
    effectBest = [effectBest Best'];
    effectSD = [effectSD SD'];
    effectMedian = [effectMedian Median'];    
end