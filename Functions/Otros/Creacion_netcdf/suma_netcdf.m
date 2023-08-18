function Takemura=suma_netcdf(Periodo_inicio,Periodo_Termino)

%% Esta función fué creada sólo para takemura, puesto que venía en originalmente
% en distintos archivos netcdf. Primero fue necesario crear un archivo
% netcdf, que contuviera todas las variaciones de polvo y fuera una suma de los
% disntos componentes de polvo que tenpia originalmente takemura. 
Dir='/media/naty/Seagate Expansion Drive/Tesis/';

%     if ispc
%     userdir = getenv('USERPROFILE');
%     else userdir = getenv('HOME');
%     end

for l=1:2;
    Takemura(:,:,:,l)= zeros(128,64,12);
    if (l==1)
        addpath(fullfile(Dir,'netcdf','Originales','Takemura',['Takemura_' Periodo_inicio]))
    else 
        addpath(fullfile(Dir,'netcdf','Originales','Takemura',['Takemura_' Periodo_Termino]))

    end
for i=1:6
    T_dry=ncread(['ddrydu' num2str(i) '.nc'],['ddrydu' num2str(i)]);
    T_grv=ncread(['dgrvdu' num2str(i) '.nc'],['dgrvdu' num2str(i)]);
    T_wet=ncread(['dwetdu' num2str(i) '.nc'],['dwetdu' num2str(i)]);
    Takemura1=[T_dry + T_grv + T_wet];
    Takemura(:,:,:,l)=(Takemura1 + Takemura(:,:,:,l));
end
end 

%% Creando NETCDF
lon1=ncread('dgrvdu1.nc','lon');
lat1=ncread('dgrvdu1.nc','lat');
%Takemura=load('Takemura.nc_annualflux_kgperm2pers.128x64_LGM.dat');

% file='/home/naty/Dropbox/DustRegions_Takemura/Takemura.nc';
file='/media/naty/Seagate Expansion Drive/Tesis/netcdf/Takemura.nc';

lon='lon';
lat='lat';

% Create File
ncid = netcdf.create(file,'CLOBBER');

% Define Dimensions
lon_dimID=netcdf.defDim(ncid,'lon',128);
lat_dimID=netcdf.defDim(ncid,'lat',64);
time_dimID=netcdf.defDim(ncid,'time',12);
period_dimID=netcdf.defDim(ncid,'period',2);

% Define Variables
lonID=netcdf.defVar(ncid,'lon','float',lon_dimID);
latID=netcdf.defVar(ncid,'lat','float',lat_dimID);
timeID=netcdf.defVar(ncid,'time','float',time_dimID);
periodID=netcdf.defVar(ncid,'period','float',period_dimID);
dataID=netcdf.defVar(ncid,'DustFluxes','float',[lon_dimID lat_dimID time_dimID period_dimID]);

% Leave Define Mode and enter Data Entry Mode
netcdf.endDef(ncid)

% Write Variables
netcdf.putVar(ncid,lonID,lon1);
netcdf.putVar(ncid,latID,lat1);
netcdf.putVar(ncid,timeID,1:12)
netcdf.putVar(ncid,periodID,1:2);
netcdf.putVar(ncid,dataID,Takemura);

% Re-enter Define Mode
netcdf.reDef(ncid)

% Attributes
netcdf.putAtt(ncid,lonID,'units','degrees_east');
netcdf.putAtt(ncid,latID,'units','degrees_north');
netcdf.putAtt(ncid,timeID,'long_name','Variabilidad anual');
netcdf.putAtt(ncid,periodID,'long_name','Periodo');
netcdf.putAtt(ncid,dataID,'units', 'kg/m2*s');
netcdf.putAtt(ncid,dataID,'long_name', 'Global Interpolated Dust Fluxes Takemura Holoceno-LGM');
%netcdf.putAtt(ncid,dataID,'info', 'First element of 3rd dimension of DustFluxes is HOL, last element is LGM. Rest are intermediate levels');
%netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'Title','Global HOL and LGM Dust Fluxes with 98 intermediate levels');

netcdf.close(ncid)

end
