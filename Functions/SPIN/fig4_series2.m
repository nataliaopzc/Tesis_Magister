Dir='/media/natalia/DATA/Tesis/';

models={'Albani' 'Lambert' 'Takemura' 'MIROC-ESM' 'MRI-CGCM3'};
for i=1:5
    modelo=char(models(i));
    CO2_HOL = load(fullfile(Dir,'Cgenie_output','Globales',modelo,['worjh2.PO4Fe.All.' modelo '.level1'],'biogem','biogem_series_atm_pCO2.res'));
CO2_LGM = load(fullfile(Dir,'Cgenie_output','Globales',modelo,['worjh2.PO4Fe.All.' modelo '.level10'],'biogem','biogem_series_atm_pCO2.res'));

CO2_H = CO2_HOL(:,3) * 1000000; % Change to ppm
CO2_L = CO2_LGM(:,3) * 1000000; % Change to ppm
%% Imágenes 
subplot(1,5,i)
set(gca,'FontWeight','bold');
plot(CO2_HOL(:,1),CO2_H,'LineWidth',2)
 ylabel('Concentración de pCO_2 (ppm) ','FontWeight','bold');
  xlabel('Años','FontWeight','bold');  
  title([modelo]) 
 xlim(gca,[-100 10100]);
  ylim(gca,[278 278.11]);

end



