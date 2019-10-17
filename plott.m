for ii=1:nPop

hold on
plot(participant(ii).Idea(1,1),participant(ii).Idea(1,2),'b','Marker','o','MarkerSize',4);
%axis([-2,2,-2,2]);
hold off
hold on
[X,Y] = meshgrid(-2:.1:2,-2:.1:2);
Z = X.*exp(-X.^2-Y.^2);
[C,h] = contour(X,Y,Z);
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2)
colormap spring
end