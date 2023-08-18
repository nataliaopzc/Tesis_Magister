function []=intermediate_level(modelo)
% Calculate intermediate dust levels

% if ispc
%      userdir = getenv('USERPROFILE');
%      else userdir = getenv('HOME');
%  end

HOL=log(load('/media/natalia/DATA/Tesis/Flujos_de_polvo/Globales_Kg/Ohgaito/Ohgaito.nc_annualflux_kgperm2pers.36x36_level1.dat'));
LGM=log(load('/home/naty/Dropbox/Polvo_Region_MIROC-ESM/Archivos_MIROC-ESM/MIROC-ESM.nc_annualflux_kgperm2pers.36x36_level10.dat'));

nstep=9;
Step=(LGM-HOL)./nstep;
IntermDust10(:,:,1)=exp(HOL);
IntermDust10(:,:,nstep+1)=exp(LGM);
for i=2:nstep
    IntermDust10(:,:,i)=exp(HOL+(i-1).*Step);
    dlmwrite(fullfile(userdir,'Dropbox','Polvo_Region2_MIROC-ESM',['MIROC-ESM.nc_annualflux_kgperm2pers.36x36_level' num2str(i) '.dat']),IntermDust10(:,:,i),'precision','%14.6e','delimiter','');

end


