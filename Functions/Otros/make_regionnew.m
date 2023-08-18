function [ OUTPUT ] = make_regionnew(region,modelo)
% make_region: Produces cGENIE input files with only the specified region
% changing dust fluxes
%
%   region: 'SA', 'SP', NP, CP, NA
%

% INITIALIZING
% if ispc
%     userdir = getenv('USERPROFILE');
%     else userdir = getenv('HOME');
% end
userdir='/media/natalia/DATA/Tesis/Flujos_de_polvo/';

Dust = NaN(36,36,10);
OUTPUT = zeros(36,36,2);

% READ DATA

for i=1,10
    Dust(:,:,i)=load(fullfile(userdir,'Globales_Moles',modelo,[modelo '.nc_annualflux_molperyr.36x36_level' num2str(i) '.dat']));
    
if strcmp(region,'SA')
    OUTPUT(29:36,20:36,i) = Dust(29:36,20:36,i);
    OUTPUT(29:36,1:5,i) = Dust(29:36,1:5,i);
    
elseif strcmp(region,'SP')
    OUTPUT(29:36,6:19,i) = Dust(29:36,6:19,i);
    
elseif strcmp(region,'NP')
    OUTPUT(1:8,3:15,i) = Dust(1:8,3:15,i);
    
elseif strcmp(region,'NA')
    OUTPUT(1:8,20:25,i) = Dust(1:8,20:25,i);
    
elseif strcmp(region,'CP')
    OUTPUT(17:20,10:18,i) = Dust(17:20,10:18,i);
    
else
    error('valid entries for region are ''SA'' or ''SP''.');
end
% Save Results

dlmwrite(fullfile(userdir,'Regionales_moles',modelo,[modelo '_' region '_Levelnew' num2str(i) '.dat']),OUTPUT(:,:,i),'precision','%14.6e','delimiter','');
end
end

