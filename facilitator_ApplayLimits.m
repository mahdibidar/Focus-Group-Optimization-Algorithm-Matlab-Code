function [ PIdea ] = facilitator_ApplayLimits( PIdea, VarMin, VarMax)
        
        % Apply Idea Limits
        PIdea = max(PIdea,VarMin);
        PIdea = min(PIdea,VarMax);

end

