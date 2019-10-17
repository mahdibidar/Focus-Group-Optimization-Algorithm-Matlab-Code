%% FGOA: Focus Gruop Optimization Algorithm
% Implemented By Edris Fattahi and Mahdi Bidar

% function [Mean,Worst,Best,SD,Median] = FGOA(nPop)
%% erase all



%% Problem Definition

CostFunction=@(x)   beale(x);        % Cost Function

nVar=2;             % Number of Decision Variables

VarSize=[1 nVar];   % Size of Decision Variables Matrix

VarMin=-2;         % Lower Bound of Variables
VarMax=+2;         % Upper Bound of Variables


%% FGOA Parameters

MaxIt=200;      % Maximum Number of Iterations

 nPop=5;        % Population Size (Number of participant)

%% Constriction Coefficients

w=0.9;          % Inertia Weight
wdamp=1;
% Naffect Limits
affectMax=0.1*(VarMax-VarMin);
affectMin=-affectMax;

bestcostrun=[];
for nr=1:50 %number of runs
   
%% Initialization
empty_participant.Idea=[];
empty_participant.Cost=[];
empty_participant.Naffect=[];
empty_participant.Best.Idea=[];
empty_participant.Best.Cost=[];
empty_participant.C=[];


participant=repmat(empty_participant,nPop,1);

GlobalBest.Cost=inf;

for i=1:nPop
    
    % Initialize Idea
    participant(i).Idea=unifrnd(VarMin,VarMax,VarSize);
    
    % Initialize Naffect
    participant(i).Naffect=zeros(VarSize);
    
    % Evaluation
    participant(i).Cost=CostFunction(participant(i).Idea);
    
    % Update Personal Best Idea
    participant(i).Best.Idea=participant(i).Idea;
    participant(i).Best.Cost=participant(i).Cost;
    
    % Update Global Best Idea
    if participant(i).Best.Cost<GlobalBest.Cost
        
        GlobalBest=participant(i).Best;
        
    end
    
end

note_taker.BestCost=zeros(MaxIt,1);

flag=1; % flag=1 means Good Convergence, flag=0 means bad Cenvergence
C_flag =0; % C_flag=1 means apply crossover on participant

%% FGOA Main Loop

for it=1:MaxIt
    
    if it>5
            if(note_taker.BestCost(it)==note_taker.BestCost(it-2))
                flag=0;
            else
                flag=1;
            end
    end
    
    %Remove bad participants
%          participant = Removebadagents(nPop,participant,VarSize,VarMin,VarMax);
     
    
    for i=1:nPop
      
        C=getCindex( participant, nPop, flag );
        temp=0;
        
        % Update Naffection
        for j=1:nPop
            temp=temp+C(j)*rand(VarSize).*(participant(j).Best.Idea-participant(i).Idea);
        end
        participant(i).Naffect = w*participant(i).Naffect + temp;
            
        
        % Apply Naffect Limits
        participant(i).Naffect = max(participant(i).Naffect,affectMin);
        participant(i).Naffect = min(participant(i).Naffect,affectMax);
        
        % Update Idea
        participant(i).Idea = participant(i).Idea + participant(i).Naffect; 
        
        %Crossover
        if C_flag ==1
           Cr = rand(1,nVar) < 0.8 ;
           % Random selection 
           nPop4Cr = round(nPop * rand + 0.5);  
           % Crossover scheme
          participant(i,:).Idea=participant(nPop4Cr,:).Idea .*(1-Cr)+ participant(i,:).Idea.*Cr;
        end
        
        % Applay Limits by facilitator
        participant(i).Idea = facilitator_ApplayLimits(participant(i).Idea, VarMin, VarMax);
        
        % Evaluation
        participant(i).Cost = CostFunction(participant(i).Idea);
        
        % Update Personal Best Idea
        if participant(i).Cost<participant(i).Best.Cost
            
            participant(i).Best.Idea=participant(i).Idea;
            participant(i).Best.Cost=participant(i).Cost;
            
            % Update Global Best Idea
            if participant(i).Best.Cost<GlobalBest.Cost
                
                GlobalBest=participant(i).Best;
                
            end
            
        end
        
    end
    
    % take note by note taker: backup for best Costs
    note_taker.BestCost(it)= GlobalBest.Cost;

    
    %disp(['Iteration ' num2str(it) ,' Best Cost = ' num2str(note_taker.BestCost(it))]);


end

w=w*wdamp;
bestcostrun =[bestcostrun note_taker.BestCost];
end %end run
Mean=mean(bestcostrun');
Worst= max(bestcostrun');
Best = min(bestcostrun');
SD = std(bestcostrun');
Median = median(bestcostrun');
%end

%% Results
 Mean = mean(bestcostrun');
 Worst = max(bestcostrun');
 best = min(bestcostrun');
 SD = std(bestcostrun');
 Median = median(bestcostrun');
 figure;
 plot(bestcostrun,'LineWidth',2);
 semilogy(1:MaxIt,Worst,':',1:MaxIt, Mean,'--',1:MaxIt, best,'LineWidth',1.5,'color','k');
 xlabel('Iteration');
 ylabel('Best Cost');
 legend('Worst run values','Average run values', 'Best run values');
 title('F2','Fontweight','bold','FontSize',15,'FontAngle','Italic');

