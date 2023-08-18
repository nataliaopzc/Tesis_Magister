function [ Solub ] = make_solubility_Control(modelo,value)

userdir='/home/natalia/Documentos/DATA/TesisI/cgenie/Solubility';
value=str2double(value);

%Solub = NaN(36,36,2);

% READ DATA

    Solub(:,:,1)=load(fullfile(userdir,['worjh2.det_Fe_sol.' modelo '_H.dat']));
    Solub(:,:,2)=load(fullfile(userdir,['worjh2.det_Fe_sol.' modelo '_LGM.dat']));

% Calculations

    Solub(:,:,1:2) = value*Solub(:,:,1:2);
   
value=num2str(value);

dlmwrite(fullfile(userdir,'Global',['worjh2.det_Fe_Sol_calculated.' modelo '_H_x' value '.dat']),Solub(:,:,1),'precision','%14.6e','delimiter','');
dlmwrite(fullfile(userdir,'Global',['worjh2.det_Fe_Sol_calculated.' modelo '_LGM_x' value '.dat']),Solub(:,:,2),'precision','%14.6e','delimiter','');
end