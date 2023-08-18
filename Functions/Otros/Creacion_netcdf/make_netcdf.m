%Write IntermDust to NetCDF file
%% Esta función es la segunda parte de suma_netcdf para crear el netcdf de takemura, 
% pero puede ser eventualmente modificado y servir para hacer cualquier archivo netcdf
file='/media/naty/Seagate Expansion Drive/Tesis/netcdf/Takemura.nc';
lon1=ncread('/media/naty/Seagate Expansion Drive/Tesis/netcdf/Originales/Takemura_holoceno/dgrvdu1.nc','lon');
lat1=ncread('/media/naty/Seagate Expansion Drive/Tesis/netcdf/Originales/Takemura_holoceno/dgrvdu1.nc','lat');
Takemura=load('/media/naty/Seagate Expansion Drive/Tesis/netcdf/Takemura.nc_annualflux_kgperm2pers.128x64_Holoceno.dat');


%file='/home/naty/Dropbox/Takemura_LGM/Takemura.nc';
lon='lon';
lat='lat';

% Create File
ncid = netcdf.create(file,'CLOBBER');

% Define Dimensions
lon_dimID=netcdf.defDim(ncid,'lon',128);
lat_dimID=netcdf.defDim(ncid,'lat',64);
%period_dimID=netcdf.defDim(ncid,'period',100);

% Define Variables
lonID=netcdf.defVar(ncid,'lon','float',lon_dimID);
latID=netcdf.defVar(ncid,'lat','float',lat_dimID);
%periodID=netcdf.defVar(ncid,'Period','float',period_dimID);
dataID=netcdf.defVar(ncid,'DustFluxes','float',[lon_dimID lat_dimID]);

% Leave Define Mode and enter Data Entry Mode
netcdf.endDef(ncid)

% Write Variables
netcdf.putVar(ncid,lonID,lon1);
netcdf.putVar(ncid,latID,lat1);
%netcdf.putVar(ncid,periodID,1:100);
netcdf.putVar(ncid,dataID,Takemura);

% Re-enter Define Mode
netcdf.reDef(ncid)

% Attributes
netcdf.putAtt(ncid,lonID,'units','degrees_east');
netcdf.putAtt(ncid,latID,'units','degrees_north');
%netcdf.putAtt(ncid,periodID,'long_name','Intermediate Dust Levels');
netcdf.putAtt(ncid,dataID,'units', 'kg/m2*s');
netcdf.putAtt(ncid,dataID,'long_name', 'Global Interpolated Dust Fluxes Takemura');
%netcdf.putAtt(ncid,dataID,'info', 'First element of 3rd dimension of DustFluxes is HOL, last element is LGM. Rest are intermediate levels');
%netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'Title','Global HOL and LGM Dust Fluxes with 98 intermediate levels');


netcdf.close(ncid)

clear all
