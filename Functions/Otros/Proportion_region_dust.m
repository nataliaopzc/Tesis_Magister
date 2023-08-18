function [ OUTPUT ] = Proportion_region_dust(region,modelo)
% make_region: Produces cGENIE input files with only the specified region
% changing dust fluxes
%
%   region: 'SA', 'SP', NP, CP
%

% INITIALIZING
% if ispc
%     userdir = getenv('USERPROFILE');
%     else userdir = getenv('HOME');
% end
userdir='/home/natalia/Documentos/Tesis/Flujos_de_polvo/';

% READ DATA

    Dust(:,:,1)=load(fullfile(userdir,'Globales_Moles',modelo,[modelo '.nc_annualflux_molperyr.36x36_level1.dat']));
    Dust(:,:,2)=load(fullfile(userdir,'Globales_Moles',modelo,[modelo '.nc_annualflux_molperyr.36x36_level10.dat']));

% CALCULATIONS

if strcmp(region,'SA')
    OUTPUT = median(median([Dust(29:36,20:36,2),Dust(29:36,1:5,2)]./[Dust(29:36,20:36,1),Dust(29:36,1:5,1)]));
    
elseif strcmp(region,'SP')
    OUTPUT=median(median([Dust(29:36,6:19,2)./Dust(29:36,6:19,1)]));
    
elseif strcmp(region,'NP')
    OUTPUT=median(median([Dust(1:8,3:15,2)./Dust(1:8,3:15,1)]));
    
elseif strcmp(region,'NA')
    OUTPUT=median(median([Dust(1:8,20:25,2)./Dust(1:8,20:25,1)]));
    
elseif strcmp(region,'CP')
    OUTPUT=median(median([Dust(17:20,10:18,2)./Dust(17:20,10:18,1)]));
    
else
    error('valid entries for region are ''SA'' or ''SP''.');

end
