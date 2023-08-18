function Diferencia(modelo)
%% Esta función va aser una resta entre campos de polvo en unidades de kg/m2*s
%% Este script funciona para todos los netcdf (Lambert,Takemura,MIROC-ESM,MRI-CGCM3), excepto para Albani
%Dir='/media/natalia/Seagate Expansion Drive/Tesis/';
Dir='/media/natalia/DATA/Tesis/';
addpath(fullfile(Dir,'netcdf'))
if strcmp(modelo,'Lambert')
    DustFlux=ncread([modelo '.nc'],'Flux');
else
DustFlux=ncread([modelo '.nc'],'DustFluxes');
end
lat=ncread([modelo '.nc'],'lat');
lon=ncread([modelo '.nc'],'lon');
for i=1:2;
z(:,:,i)=mean(DustFlux(:,:,:,i),3);
end
Holoceno=z(:,:,1);
LGM=z(:,:,2);
Diff=LGM-Holoceno; % En el LGM se espera más polvo que en el Holoceno (pero ambos valores son negativos).
Z=Diff(:);
Lat=[];
for i=1:length(lat);
    Lat=[Lat;repmat(lat(i),[length(lon),1])]; % El lon se cambia para Albani
end
Lon=repmat(lon,[length(lat),1]); % El lat se cambia para Albani
OUTPUT=[Lon,Lat,Z];
%% Falta crear un archivo donde se guarde la diferencia :) y es todo, todo amigos :D
dlmwrite(fullfile(Dir,'netcdf',[modelo '_diferencia.dat']),OUTPUT(),'precision','%14.6e','delimiter','');
end