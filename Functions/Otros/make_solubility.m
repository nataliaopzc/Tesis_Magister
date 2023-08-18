function [ Solub ] = make_solubility(region,modelo,value)
% make_region: Produces cGENIE input files with only the specified region
% changing Solub fluxes
%
%   region: 'SA', 'SP', NP, CP, NA
%

% INITIALIZING
% if ispc
%     userdir = getenv('USERPROFILE');
%     else userdir = getenv('HOME');
% end
userdir='/media/natalia/DATA/Documentos/TesisI/cgenie/Solubility';
value=str2double(value);

%Solub = NaN(36,36,2);

% READ DATA


    Solub(:,:,1)=load(fullfile(userdir,['worjh2.det_Fe_sol.' modelo '_H.dat']));
    Solub(:,:,2)=load(fullfile(userdir,['worjh2.det_Fe_sol.' modelo '_LGM.dat']));




% Calculations

%Solub = repmat(Solub(:,:,1),[1,1,2]);

if strcmp(region,'SA')
    Solub(29:36,20:36,1:2) = value*Solub(29:36,20:36,1:2);
    Solub(29:36,1:5,1:2) = value*Solub(29:36,1:5,1:2);
    
elseif strcmp(region,'SP')
    Solub(29:36,6:19,1:2) = value*Solub(29:36,6:19,1:2);
    
elseif strcmp(region,'NP')
    Solub(1:8,3:15,1:2) = value*Solub(1:8,3:15,1:2);
    
elseif strcmp(region,'NA')
    Solub(1:8,20:25,1:2) = value*Solub(1:8,20:25,1:2);
    
elseif strcmp(region,'CP')
    Solub(17:20,10:18,1:2) = value*Solub(17:20,10:18,1:2);
    
else
    error('valid entries for region are ''SA'' or ''SP''.');
end
% Save Results
value=num2str(value);

for i=1:2
dlmwrite(fullfile(userdir,'Region','new',['worjh2.det_Fe_Sol_calculated.' modelo '_' num2str(i) '_' region '_x' value '.dat']),Solub(:,:,i),'precision','%14.6e','delimiter','');
end
end

