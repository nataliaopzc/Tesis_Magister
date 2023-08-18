function [ OUTPUT ] = make_region(region,modelo)
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
userdir='/media/natalia/DATA/Tesis/Flujos_de_polvo/';

Dust = NaN(36,36,10);

% READ DATA

for i=1:10
    Dust(:,:,i)=load(fullfile(userdir,'Globales_Moles',modelo,[modelo '.nc_annualflux_molperyr.36x36_level' num2str(i) '.dat']));
end

% CALCULATIONS

OUTPUT = repmat(Dust(:,:,1),[1,1,10]);

if strcmp(region,'SA')
    OUTPUT(29:36,20:36,2:10) = Dust(29:36,20:36,2:10);
    OUTPUT(29:36,1:5,2:10) = Dust(29:36,1:5,2:10);
    
elseif strcmp(region,'SP')
    OUTPUT(29:36,6:19,2:10) = Dust(29:36,6:19,2:10);
    
elseif strcmp(region,'NP')
    OUTPUT(1:8,3:15,2:10) = Dust(1:8,3:15,2:10);
    
elseif strcmp(region,'NA')
    OUTPUT(1:8,20:25,2:10) = Dust(1:8,20:25,2:10);
    
%elseif strcmp(region,'CP')
%    OUTPUT(15:22,3:18,2:10) = Dust(15:22,3:18,2:10);
    
elseif strcmp(region,'CP')
    OUTPUT(17:20,10:18,2:10) = Dust(17:20,10:18,2:10);
    
else
    error('valid entries for region are ''SA'' or ''SP''.');
end

% Save Results
for i=1:10
      dlmwrite(fullfile(userdir,'Regionales_moles',modelo,[modelo '_' region '_Level' num2str(i) '.dat']),OUTPUT(:,:,i),'precision','%14.6e','delimiter','');
end
end
