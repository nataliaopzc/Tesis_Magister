function [ ] = make_dat(modelo)
% if ispc
%     userdir = getenv('USERPROFILE');
%     else userdir = getenv('HOME');
% end
Dir='/media/natalia/DATA/Tesis/';
addpath(fullfile(Dir,'netcdf'))
if strcmp(modelo,'Lambert')
    DustFlux=ncread([modelo '.nc'],'Flux');
else
DustFlux=ncread([modelo '.nc'],'DustFluxes');
end
lat=ncread([modelo '.nc'],'lat');
lon=ncread([modelo '.nc'],'lon');
Lat=[];
for j=1:length(lat);
    Lat=[Lat;repmat(lat(j),[length(lon),1])]; % El lon se cambia para Albani
end
Lon=repmat(lon,[length(lat),1]); % El lat se cambia para Albani


for i=1:2;
z(:,:,i)=log10(median(DustFlux(:,:,:,i),3));
Z=reshape(z(:,:,i),[length(Lat),1]);
OUTPUT=[Lon,Lat,Z];
dlmwrite(fullfile(Dir,'netcdf',[modelo '_log10_' num2str(i) '.dat']),OUTPUT(),'precision','%14.6e','delimiter',''); % 1 es Holonoce, 2 es LGM
end
end
