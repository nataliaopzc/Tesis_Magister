%% Esta función va aser una resta entre campos de polvo en unidades de kg/m2*s sólo para Albani (porque tiene un netcdf distinto)
Dir='/media/naty/Seagate Expansion Drive/Tesis/';
addpath(fullfile(Dir,'netcdf'))

z_Holoceno=log(ncread('Albanietal2014_C4fn_dep.nc','dep')./(1000*3600*24*365));
z_LGM=log(ncread('Albanietal2014_C4fn-lgm_dep.nc','dep')./(1000*3600*24*365));

lat=ncread('Albanietal2014_C4fn_dep.nc','lat');
lon=ncread('Albanietal2014_C4fn_dep.nc','lon');
Diff=z_LGM-z_Holoceno; % En el LGM se espera más polvo que en el Holoceno. 
Z=Diff(:);
Lat=[];
for i=1:length(lat);
    Lat=[Lat;repmat(lat(i),[length(lon),1])]; % El lon se cambia para Albani
end
Lon=repmat(lon,[length(lat),1]); % El lat se cambia para Albani
OUTPUT=[Lon,Lat,Z];
%% Falta crear un archivo donde se guarde la diferencia :) y es todo, todo amigos :D
dlmwrite(fullfile(Dir,'netcdf',['Albani_diferencia.dat']),OUTPUT(),'precision','%14.6e','delimiter','');
