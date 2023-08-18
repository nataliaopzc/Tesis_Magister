load 'lon_lat.mat'
load coastlines
%geoshow(coastlat, coastlon, 'Color', 'black')
%axesm('pcarree','Origin',[0 -150]) %pcarree
geoshow('landareas.shp', 'FaceColor', '[0.909, 0.909, 0.909]');
lon=lonlat_edges(:,1)-180;
hold on
for i=1:37
    plot(lon,repmat(lonlat_edges(i,2),[1,37]),'color',[0.909, 0.909, 0.909])
end
for j=1:37
    plot(repmat(lon(j),[1,37]),lonlat_edges(:,2),'color',[0.909, 0.909, 0.909])
end
% xlabel('Longitud','FontWeight','bold','FontSize',24);
% 
% % Create ylabel
% ylabel('Latitud','FontWeight','bold','FontSize',24);

xlabel('Longitude','FontWeight','bold','FontSize',24,'Color',[0.909, 0.909, 0.909]);

% Create ylabel
ylabel('Latitude','FontWeight','bold','FontSize',24,'Color',[0.909, 0.909, 0.909]);

% % for i=1:36   
% %     for j=1:36
% %         text(lonlat(i,1),lonlat(j,2),'x')
% %     end
% % end

%% SP
for i=1:8
    for j=6:19
    text(lonlat(j,1),lonlat(i,2),'x','Color',[0.909, 0.909, 0.909])
    end
end
%% SA
for i=1:8
    for j=20:36
    text(lonlat(j,1),lonlat(i,2),'x','Color',[0.909, 0.909, 0.909])
    end
end

for i=1:8
    for j=1:5
    text(lonlat(j,1),lonlat(i,2),'x','Color',[0.909, 0.909, 0.909])
    end
end
%% NP
for i=32:36
    for j=3:15
    text(lonlat(j,1),lonlat(i,2),'x','Color',[0.909, 0.909, 0.909])
    end
end

%% NA
for i=33:36
    for j=20:28
    text(lonlat(j,1),lonlat(i,2),'x','Color',[0.909, 0.909, 0.909])
    end
end

%% CP
%for i=15:22
%    for j=3:18
%    text(lonlat(j,1),lonlat(i,2),'x')
%    end
%end
for i=17:20
    for j=10:18
    text(lonlat(j,1),lonlat(i,2),'x','Color',[0.909, 0.909, 0.909])
    end
end
%% Regiones

%SA
for i=1:9 %del 29 al 36
    plot(lon(12:34),repmat(lonlat_edges(i,2),[1, 23]),'-r')
end
for j=12:34
    plot(repmat(lon(j),[1 9]),lonlat_edges(1:9,2),'-r')
end

%SP
for i=1:9
    plot(lon(1:12),repmat(lonlat_edges(i,2),[1, 12]),'-b')
end
for j=1:12
    plot(repmat(lon(j),[1 9]),lonlat_edges(1:9,2),'-b')
end

for i=1:9
    plot(lon(34:37),repmat(lonlat_edges(i,2),[1, 4]),'-b')
end
for j=34:37
    plot(repmat(lon(j),[1 9]),lonlat_edges(1:9,2),'-b')
end

%NP

for i=32:37
    plot(lon(1:8),repmat(lonlat_edges(i,2),[1, 8]),'-m')
end
for j=1:8
    plot(repmat(lon(j),[1 6]),lonlat_edges(32:37,2),'-m')
end

for i=32:37
    plot(lon(31:37),repmat(lonlat_edges(i,2),[1, 7]),'-m')
end
for j=31:37
    plot(repmat(lon(j),[1 6]),lonlat_edges(32:37,2),'-m')
end

%NA

for i=33:37
    plot(lon(11:21),repmat(lonlat_edges(i,2),[1, 11]),'-y')
end
for j=11:21
    plot(repmat(lon(j),[1 5]),lonlat_edges(33:37,2),'-y')
end

% %CP Esta ok
% for i=15:23
%     plot(lon(1:11),repmat(lonlat_edges(i,2),[1, 11]),'-g')
% end
% for j=1:11
%     plot(repmat(lon(j),[1 9]),lonlat_edges(15:23,2),'-g')
% end
% 
% for i=15:23
%     plot(lon(31:37),repmat(lonlat_edges(i,2),[1, 7]),'-g')
% end
% for j=31:37
%     plot(repmat(lon(j),[1 9]),lonlat_edges(15:23,2),'-g')
% end

%CP Esta ok
for i=17:21
    plot(lon(2:11),repmat(lonlat_edges(i,2),[1, 10]),'-g')
end
for j=2:11
    plot(repmat(lon(j),[1 5]),lonlat_edges(17:21,2),'-g')
end

%%
ax = gca % Get handle to current axes.
ax.XColor = [0.909, 0.909, 0.909]; % Red
ax.YColor = [0.909, 0.909, 0.909]; % Blue
set(gcf, 'Color', 'k')
print(gcf, '-dpdf', 'test33.pdf');

