function [start_point,end_point] = find_boundaries(image1,image2,data,plot_flags,type)

if type
    name = 'row';
else
    name = 'column';
end

signal_center = length(data)/2;
threshold = mean(abs(diff(angle(data))));

%find start point
for k = signal_center:-1:2
    if(abs(angle(data(k-1)) - angle(data(k))) > threshold)
        start_point = k;
        break;
    end
end

%find end point
for k = signal_center:length(data)-1
    if(abs(angle(data(k+1)) - angle(data(k))) > threshold)
        end_point = k;
        break;
    end
end

if plot_flags
    figure;
    subplot(211)
    plot(angle(data))
    ylimits = get(gca,'ylim');
    line([start_point start_point],[ylimits(1) ylimits(2)],'Color','r','LineStyle','--')
    line([end_point end_point],[ylimits(1) ylimits(2)],'Color','r','LineStyle','--')
    title(['Extracted phase signal of ' name ' vector of ' image1 ' vs ' image2])
    subplot(212)
    plot(angle(data(start_point:end_point)))
    ylimits = get(gca,'ylim');
    line([1 1],[ylimits(1) ylimits(2)],'Color','r','LineStyle','--')
    line([end_point-start_point+1 end_point-start_point+1],[ylimits(1) ylimits(2)],'Color','r','LineStyle','--')
end
end