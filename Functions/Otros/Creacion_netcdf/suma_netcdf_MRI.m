
    if ispc
    userdir = getenv('USERPROFILE');
    else userdir = getenv('HOME');
    end

%if strcmp(Periodo_inicio,'Holoceno')
addpath(fullfile(userdir, 'Dropbox','MRI-CGCM3'))

    T_dry=ncread('drydust_aero_MRI-CGCM3_PiControl_r1i1p1_T42_monthly.nc','drydust');
    T_wet=ncread('wetdust_aero_MRI-CGCM3_PiControl_r1i1p1_T42_monthly.nc','wetdust');
    A(:,:,:,1)=[T_dry + T_wet];
    T_dry=ncread('drydust_aero_MRI-CGCM3_lgm_r1i1p1_T42_monthly.nc','drydust');
    T_wet=ncread('wetdust_aero_MRI-CGCM3_lgm_r1i1p1_T42_monthly.nc','wetdust');
    A(:,:,:,2)=[T_dry + T_wet];


    %% Creando NETCDF
lon1=ncread('drydust_aero_MRI-CGCM3_lgm_r1i1p1_T42_monthly.nc','lon');
lat1=ncread('drydust_aero_MRI-CGCM3_lgm_r1i1p1_T42_monthly.nc','lat');
%Takemura=load('Takemura.nc_annualflux_kgperm2pers.128x64_LGM.dat');

file='/home/naty/Dropbox/MRI-CGCM3/MRI-CGCM3.nc';
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
netcdf.putVar(ncid,dataID,A);

% Re-enter Define Mode
netcdf.reDef(ncid)

% Attributes
netcdf.putAtt(ncid,lonID,'units','degrees_east');
netcdf.putAtt(ncid,latID,'units','degrees_north');
netcdf.putAtt(ncid,timeID,'long_name','Variabilidad anual');
netcdf.putAtt(ncid,periodID,'long_name','Periodo');
netcdf.putAtt(ncid,dataID,'units', 'kg/m2*s');
netcdf.putAtt(ncid,dataID,'long_name', 'Global Interpolated Dust Fluxes MRI-CGCM3 Holoceno-LGM');
%netcdf.putAtt(ncid,dataID,'info', 'First element of 3rd dimension of DustFluxes is HOL, last element is LGM. Rest are intermediate levels');
%netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'Title','Global HOL and LGM Dust Fluxes with 98 intermediate levels');

netcdf.close(ncid)

