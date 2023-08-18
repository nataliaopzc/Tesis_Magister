% Area de la tierra en m cuadrados: 
% % area = areaquad(lat1,lon1,lat2,lon2,ellipsoid,units)
% % earthellipsoid = referenceSphere('earth','km');
% % area = areaquad(-90,-180,90,180,earthellipsoid)
load 'lon_lat.mat'
lon=lonlat_edges(:,1)-180;
earthellipsoid = referenceSphere('earth','m');

%SA lon(12:34) y lonlat_edges(1:9,2)
k=0;
for i=1:8;
    for j=12:33;
        k=k+1;
    area_SA(k,1) = areaquad(lonlat_edges(i,2),lon(j),lonlat_edges(i+1,2),lon(j+1),earthellipsoid);
    end
end

disp(sum(area_SA(:)))

%SP lon(1:12) y lonlat_edges(1:9,2), adem�s lon(34:37) y lonlat_edges(1:9,2)
k=0;
for i=1:8;
    for j=1:11;
        k=k+1;
    area1_SP(k,1) = areaquad(lonlat_edges(i,2),lon(j),lonlat_edges(i+1,2),lon(j+1),earthellipsoid);
    end
end
k=0;
for i=1:8;
    for j=34:36;
        k=k+1;
    area2_SP(k,1) = areaquad(lonlat_edges(i,2),lon(j),lonlat_edges(i+1,2),lon(j+1),earthellipsoid);
    end
end
area_SP=[area1_SP;area2_SP];
disp(sum(area_SP(:)))

%NP lon(1:8) y lonlat_edges(29:37,2), adem�s lon(31:37) lonlat_edges(29:37,2)
k=0;
for i=29:36;
    for j=1:7;
        k=k+1;
    area1_NP(k,1) = areaquad(lonlat_edges(i,2),lon(j),lonlat_edges(i+1,2),lon(j+1),earthellipsoid);
    end
end
k=0;
for i=29:36;
    for j=31:36;
        k=k+1;
    area2_NP(k,1) = areaquad(lonlat_edges(i,2),lon(j),lonlat_edges(i+1,2),lon(j+1),earthellipsoid);
    end
end
area_NP=[area1_NP;area2_NP];
disp(sum(area_NP(:)))

%CP lon(1:11) y lonlat_edges(15:23,2), adem�s lon(31:37) y lonlat_edges(15:23,2)
k=0;
for i=17:20;
    for j=2:10;
        k=k+1;
    area_CP(k,1) = areaquad(lonlat_edges(i,2),lon(j),lonlat_edges(i+1,2),lon(j+1),earthellipsoid);
    end
end

%for i=15:22;
%    for j=1:10;
%        k=k+1;
%    area1_CP(k,1) = areaquad(lonlat_edges(i,2),lon(j),lonlat_edges(i+1,2),lon(j+1),earthellipsoid);
%    end
%end
%k=0;
%for i=15:22;
%    for j=31:36;
%        k=k+1;
%    area2_CP(k,1) = areaquad(lonlat_edges(i,2),lon(j),lonlat_edges(i+1,2),lon(j+1),earthellipsoid);
%    end
%end
%area_CP=[area1_CP;area2_CP];
disp(sum(area_CP(:)))

%NA
k=0;
for i=29:36
    for j=11:17
         k=k+1;
    area_NA(k,1) = areaquad(lonlat_edges(i,2),lon(j),lonlat_edges(i+1,2),lon(j+1),earthellipsoid);
    end
end
disp(sum(area_NA(:)))

%% Para la grilla total
k=0;
for i=1:36;
    for j=1:36;
        k=k+1;
    area_total(j,i) = areaquad(lonlat_edges(i,2),lon(j),lonlat_edges(i+1,2),lon(j+1),earthellipsoid);
    end
end
%save('areat.mat')





