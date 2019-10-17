semilogy(1:MaxIt,Mean(:,1),':',1:MaxIt, Mean(:,2),'--',1:MaxIt, Mean(:,3),'LineWidth',1.5,'color','k');
xlabel('Iteration');
ylabel('Mean Cost Value for 50 run');
legend('FG1','FG2', 'FG3');
title('F1','Fontweight','bold','FontSize',15,'FontAngle','Italic');