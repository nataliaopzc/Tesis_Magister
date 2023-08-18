function [] = regrid_dust(DUM_DUSTID,DUM_NI,DUM_NJ,DUM_MASKID)
% REGRID_DUST
%
%   *********************************************************
%   *** RE-grid dust fields                      ***
%   *********************************************************
%   Original: Andy Ridgewell
%   Modified: F. Lambert, 18 Jan. 2017

%   DUM_DUSTID: Filename
%   DUM_NI: Output grid lon size
%   DUM_NJ: Output grid lat size
%   *********************************************************

% START
disp(['START [regrid_dust] >>>'])
close all;

% INITIALIZE
dum_dustid = DUM_DUSTID;
dum_maskid = DUM_MASKID;
dum_n_i = DUM_NI;
dum_n_j = DUM_NJ;

% CONSTANTS
par_rEarth = 6371000.0;
par_yrtos = 365.25*24.0*3600.0;

% OPEN netCDF
% nc_dust=netcdf.open([dum_dustid '.month.nc'],'nowrite'); %MAHOWALD
nc_dust=netcdf.open(dum_dustid,'nowrite'); %LAMBERT
if ~isempty(dum_maskid)
    ncid_mask=netcdf.open([dum_maskid '.month.nc'],'nowrite'); %MAHOWALD
end



% SET UP IN-GRID
% load grid dimension data
varid  = netcdf.inqVarID(nc_dust,'lat');
[dimname, dimlen] = netcdf.inqDim(nc_dust,varid);
loc_lat = netcdf.getVar(nc_dust,varid);
n_lat = size(loc_lat,1);
loc_axisin_lat = double(loc_lat);
varid  = netcdf.inqVarID(nc_dust,'lon');
[dimname, dimlen] = netcdf.inqDim(nc_dust,varid);
loc_lon = netcdf.getVar(nc_dust,varid);
n_lon = size(loc_lon,1);
loc_axisin_lon = double(loc_lon);
% create lat-lon mesh
[loc_gridin_lat, loc_gridin_lon] = meshgrid(loc_axisin_lat,loc_axisin_lon);
% create lat edges
for nlat = 1:n_lat,
    loc_gridin_lat_mid(nlat) = -90.0 - 0.5*180.0/n_lat + (nlat*180.0/n_lat);
end
for nlat = 1:n_lat+1,
    loc_gridin_lat_Sedge(nlat) = -90.0 + ((nlat - 1)*180.0/n_lat);
end

% area
loc_gridin_area = zeros(n_lon,n_lat);
for nlon = 1:n_lon,
    for nlat = 1:n_lat,
        loc_gridin_area(nlon,nlat) = 2.0*pi*(par_rEarth^2)*(sin((pi/180.0)*loc_gridin_lat_Sedge(nlat+1)) - sin((pi/180.0)*loc_gridin_lat_Sedge(nlat)))*(1.0/n_lon);
    end
end

% SET UP OUT-GRID
% calculate lat,lon axes
[loc_axisout_lon,loc_axisout_lat] = get_grid_genie_lonlat(dum_n_i,dum_n_j,0);
% create lat-lon mesh
[loc_gridout_lat, loc_gridout_lon] = meshgrid(loc_axisout_lat,loc_axisout_lon);
% area
loc_gridout_area = zeros(dum_n_j,dum_n_i);
loc_gridout_area(:,:) = 4.0*pi*(par_rEarth^2)*(1.0/dum_n_i)*(1.0/dum_n_j);

% SET UP MASK
if ~isempty(dum_maskid)
    %%%
end

% LOAD AND PROCESS DATA
% load dust data
% varid  = netcdf.inqVarID(nc_dust,'dustdep'); %MAHOWALD
varid  = netcdf.inqVarID(nc_dust,'DustFluxes'); %LAMBERT
[varname,xtype,dimids,natts] = netcdf.inqVar(nc_dust,varid);
%loc_dustin = double(netcdf.getVar(nc_dust,varid)); % ORIGINAL
loc_dustinTOT = double(netcdf.getVar(nc_dust,varid)); % LAMBERT

% loop through the intermediate dust levels
for idx = 1:size(loc_dustinTOT,4)
    % create lat-lon mesh
    [loc_gridin_lat, loc_gridin_lon] = meshgrid(loc_axisin_lat,loc_axisin_lon);
    % area
    loc_gridin_area = zeros(n_lon,n_lat);
    for nlon = 1:n_lon,
        for nlat = 1:n_lat,
            loc_gridin_area(nlon,nlat) = 2.0*pi*(par_rEarth^2)*(sin((pi/180.0)*loc_gridin_lat_Sedge(nlat+1)) - sin((pi/180.0)*loc_gridin_lat_Sedge(nlat)))*(1.0/n_lon);
        end
    end
    
    loc_dustin = loc_dustinTOT(:,:,:,idx);
    % create annual average
    % NOTE: weight each monthly slice by 1/12!
    loc_dustin_ann = zeros(n_lon,n_lat);
    for m = 1:12,
        loc_dustin_ann(:,:) = loc_dustin_ann(:,:) + (1.0/12.0)*loc_dustin(:,:,m);
    end
    % plot something -- AREA
    %figure;
    %loc_plot = log10(fliplr(rot90(loc_gridin_area(:,:),3)));
    %pcolor(loc_plot(:,:));
    %filename = [dum_dustid '_area.ps'];
    %print('-dpsc2', filename);
    % plot something -- annual
    %figure;
    %loc_plot = log10(fliplr(rot90(loc_dustin_ann(:,:),3)));
    %pcolor(loc_plot(:,:));
    %caxis([-13.0 -8.0])
    %filename = [dum_dustid '_annualflux_tot.ps'];
    %print('-dpsc2', filename);
    % % plot something -- monthly
    % for m = 1:12,
    %     figure;
    %     loc_data = log10(loc_dustin(:,:,m));
    %     filename = [dum_dustid '_flux_month' num2str(m) '_tot.ps'];
    %     print('-dpsc2', filename);
    % end
    % create wrap-around grid for re-gridding
    if loc_axisout_lon(1) < loc_axisin_lon(1)
        loc_dustin_ann  = [loc_dustin_ann(:,:); loc_dustin_ann(:,:)];
        loc_gridin_lon  = [loc_gridin_lon(:,:) - 360.0; loc_gridin_lon(:,:)];
        loc_gridin_lat  = [loc_gridin_lat(:,:); loc_gridin_lat(:,:)];
        loc_gridin_area = [loc_gridin_area(:,:); loc_gridin_area(:,:)];
    elseif loc_axisout_lon > loc_axisin_lon
        loc_dustin_ann  = [loc_dustin_ann(:,:); loc_dustin_ann(:,:)];
        loc_gridin_lon  = [loc_gridin_lon(:,:); loc_gridin_lon(:,:) + 360.0];
        loc_gridin_lat  = [loc_gridin_lat(:,:); loc_gridin_lat(:,:)];
        loc_gridin_area = [loc_gridin_area(:,:); loc_gridin_area(:,:)];
    end
    
    % RE-GRID DATA
    % NOTE: in log10 space
    loc_dustout_ann = 10.^(griddata(loc_gridin_lon,loc_gridin_lat,log10(loc_dustin_ann),loc_gridout_lon,loc_gridout_lat,'linear'));
    %loc_dustout_ann = griddata(loc_gridin_lon,loc_gridin_lat,loc_dustin_ann,loc_gridout_lon,loc_gridout_lat,'linear');
    % plot something
    %figure;
    %loc_plot = log10(fliplr(rot90(loc_dustout_ann(:,:),3)));
    %loc_plot = [loc_plot(:,:,1), zeros(dum_n_j,1)];
    %loc_plot = [loc_plot; zeros(1,dum_n_i + 1)];
    %pcolor(loc_plot(:,:));
    %caxis([-13.0 -8.0])
    % axis([1 n_lon+1 1 n_lat+1]);
    %filename = [dum_dustid '_annualflux_tot.' num2str(dum_n_i) 'x' num2str(dum_n_j) '.ps'];
    %print('-dpsc2', filename);
    
    % SAVE DATA
    % annual
    % NOTE: raw units = kg m-2 s-1
    % NOTE: assume RMM of 60 for SiO2 in converting g -> mol
    filename = [dum_dustid '_annualflux_kgperm2pers.' num2str(dum_n_i) 'x' num2str(dum_n_j) '_level' num2str(idx) '.dat'];
    %filename = [dum_dustid '_annualflux_kgperm2pers.' num2str(dum_n_i) 'x' num2str(dum_n_j) '.dat'];
    data_save = double(fliplr(rot90(loc_dustout_ann(:,:),3)));
    fprint_2D_d(data_save,filename);
    filename = [dum_dustid '_annualflux_kgperm2pers_log10.' num2str(dum_n_i) 'x' num2str(dum_n_j) '_level' num2str(idx) '.dat'];
    %filename = [dum_dustid '_annualflux_kgperm2pers_log10.' num2str(dum_n_i) 'x' num2str(dum_n_j) '.dat'];
    data_save = log10(double(fliplr(rot90(loc_dustout_ann(:,:),3))));
    fprint_2D_d(data_save,filename);
    filename = [dum_dustid '_annualflux_molperyr.' num2str(dum_n_i) 'x' num2str(dum_n_j) '_level' num2str(idx) '.dat'];
    %filename = [dum_dustid '_annualflux_molperyr.' num2str(dum_n_i) 'x' num2str(dum_n_j) '.dat'];
    data_save = par_yrtos*(1.0/60.0)*1000.0*loc_gridout_area(:,:).*double(fliplr(rot90(loc_dustout_ann(:,:),3)));
    fprint_2D_d(data_save,filename);
    % % monthly
    % for m = 1:12,
    %     loc_data = 10.^(griddata(loc_gridin_lon,loc_gridin_lat,log10(loc_dustin(:,:,m)),loc_gridout_lon,loc_gridout_lat,'cubic'));
    %     filename = [dum_dustid '_flux_month' num2str(m) '_tot.' num2str(dum_n_i) 'x' num2str(dum_n_j) 'dat'];
    %     data_save = double(fliplr(rot90(loc_data(:,:),3)));
    %     fprint_2D_d(data_save,filename);
    % end
    % diagnostics
    if ~isempty(dum_maskid)
        fid = fopen([dum_dustid '_summary_' dum_maskid '.' num2str(dum_n_i) 'x' num2str(dum_n_j) '_level' num2str(idx) '.txt'], 'wt');
    else
        fid = fopen([dum_dustid '_summary_ALL' '.' num2str(dum_n_i) 'x' num2str(dum_n_j) '_level' num2str(idx) '.txt'], 'wt');
    end
    fprintf(fid, 'Dust summary\n');
    fprintf(fid, '\n');
    %
    % NOTE: in grid has been doubled for re-gridding,
    % hence global totals must be divided by 2 ...
    fprintf(fid, 'Global area (in)             : %12.6e (m2) \n', sum(sum(loc_gridin_area(:,:))));
    fprintf(fid, 'Global dust deposition (in)  : %12.6e (kg s-1) \n', 0.5*sum(sum(loc_gridin_area(:,:).*loc_dustin_ann(:,:))));
    fprintf(fid, 'Global dust deposition (in)  : %9.3f  (Tg yr-1) \n', 1000.0*1.0E-12*par_yrtos*0.5*sum(sum(loc_gridin_area(:,:).*loc_dustin_ann(:,:))));
    %
    fprintf(fid, '\n');
    fprintf(fid, 'Global area (out)            : %12.6e (m2) \n', sum(sum(loc_gridout_area(:,:))));
    fprintf(fid, 'Global dust deposition (out) : %12.6e (kg s-1) \n', sum(sum(loc_gridout_area(:,:).*loc_dustout_ann(:,:))));
    fprintf(fid, 'Global dust deposition (out) : %9.3f (Tg yr-1) \n', 1000.0*1.0E-12*par_yrtos*sum(sum(loc_gridout_area(:,:).*loc_dustout_ann(:,:))));
    fclose(fid);

end
% CLOSE netCDF
netcdf.close(nc_dust);

% END
disp(['<<< END [plot_extract_dust]'])

%   *********************************************************
