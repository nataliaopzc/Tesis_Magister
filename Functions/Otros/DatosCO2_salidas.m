function DatosCO2_salidas(region)
Dir='/media/natalia/DATA/Tesis/';

models={'Lambert' 'Albani' 'Takemura' 'MIROC-ESM' 'MRI-CGCM3'};
if strcmp(region,'All')
% CO2 Reduction
for j=1:5;
     modelo=char(models(j));
    for i = 1:10
        CO2 = load(fullfile(Dir,'Cgenie_output','Globales',modelo,['worjh2.PO4Fe.' region '.' modelo '.level' num2str(i)],'biogem','biogem_series_atm_pCO2.res'));
        dCO2(i,j) = mean(CO2(end-10:end,3)) * 1000000; % Change to ppm
    end
end
    
else
    
for k=1:5;
     modelo=char(models(k));
    for i = 1:10
        CO2 = load(fullfile(Dir,'Cgenie_output','Regionales',modelo,['worjh2.PO4Fe.' modelo '.' region '.level' num2str(i)],'biogem','biogem_series_atm_pCO2.res'));
        dCO2(i,k) = mean(CO2(end-10:end,3)) * 1000000; % Change to ppm
    end
end
end
Lambert=dCO2(:,1);
Albani=dCO2(:,2);
Takemura=dCO2(:,3);
MIROC_ESM=dCO2(:,4);
MRI_CGCM3=dCO2(:,5);

Niveles = {'Nivel 1';'Nivel 2';'Nivel 3';'Nivel 4';'Nivel 5';'Nivel 6';'Nivel 7';'Nivel 8';'Nivel 9';'Nivel 10'};
T=table(Niveles,Lambert,Albani,Takemura,MIROC_ESM,MRI_CGCM3);
writetable(T,fullfile(Dir,'Excel',['Datos_ppm_' region '.dat']),'Delimiter','\t');    
end