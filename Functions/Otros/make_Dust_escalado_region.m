function [ OUTPUTF ] = make_Dust_escalado_region(modelo)

userdir='/home/natalia/Documentos/Tesis/Flujos_de_polvo/';

for i=1:10
Dust(:,:,i)=load(fullfile(userdir,'Globales_Kg', modelo,[modelo '.nc_annualflux_kgperm2pers.36x36_level' num2str(i) '.dat']));
end

load('/home/natalia/Documentos/Tesis/Functions/Otros/area_from_IntegrateFLuxes.mat', 'area_total');
Carga=Dust.*area_total;

% CALCULATIONS

    SA1 = sum(sum(Carga(29:36,20:36,1:10)));
    SA2= sum(sum(Carga(29:36,1:5,1:10)));
    SA=SA1+SA2;
    
    SP =sum(sum(Carga(29:36,6:19,1:10)));
    
    NP = sum(sum(Carga(1:8,3:15,1:10)));
    
    NA = sum(sum(Carga(1:8,20:25,1:10)));
    
    CP = sum(sum(Carga(17:20,10:18,1:10)));
    
j=0;
for i=[1,10]
    j=j+1;
      OUTPUTF(:,:,j)=[NA(1,1,i);NP(1,1,i);CP(1,1,i);SP(1,1,i);SA(1,1,i)];
end

end
