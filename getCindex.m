function [ C ] = getCindex( participant, nPop, flag )

% If Convergence is good, the C value determine based on exponential random
% value, if not, for obtaining more explority the C value determine based
% on normal random value

%transmition Cost of best to an array for next operations
    Arr=[];
    for i=1:nPop
    Arr(i)=participant(i).Best.Cost;
    end

    %sort participates based on its best Cost
    [B,I] = sort(Arr);

    %produce randm exponential number
    r = exprnd(0.1,[1 nPop]);

if flag==1

    %assign each randm number to related Coefficient
    C=r(I);
else
    C= rand([1 nPop]);
end

end

