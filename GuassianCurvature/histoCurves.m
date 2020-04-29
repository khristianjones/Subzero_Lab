function fig = histoCurves(MV)
    fig = figure();
    for i = 1:size(MV,2)
       h = histfit(MV(i).gaussianCurvature);
hf=histfit(MV(i).gaussianCurvature);
h = get(gca,'Children');
set(h(2),'FaceColor',[.8 .8 1])
get(hf(1)) %properties of the histogram
get(hf(2)) %properties of the normal curve
%you can retrieve and plot the curve
x=get(hf(2),'XData'); 
y=get(hf(2),'YData');
plot(x,y)
lgd = legend(MV(i).label);
hold on
    end





end