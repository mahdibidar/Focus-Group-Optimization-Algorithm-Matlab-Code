function participant=Removebadagents(nPop,participant,VarSize,VarMin,VarMax)

CostFunction=@(x)   Ackley(x);        % Cost Function


f=[participant.Cost];
%sort costs function
[sortf,IXf]=sort(f);

%% remove columns
percent = round(0.1*length(IXf));
cols2remove=IXf(end-percent+1:end);
cols2add=IXf(1:percent);

for ii=1:length(cols2remove)
participant(cols2remove(ii)).Idea=participant(cols2add(ii)).Idea;
participant(cols2remove(ii)).Cost = CostFunction(participant(cols2add(ii)).Idea);
end


end