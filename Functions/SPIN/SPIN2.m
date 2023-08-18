Dir='/media/natalia/DATA/Tesis/';

models={'Albani' 'Lambert' 'Takemura' 'MIROC-ESM' 'MRI-CGCM3' 'Ohgaito'};
for i=1:6
    modelo=char(models(i));
TEMP = load(fullfile(Dir,'Cgenie_output','SPIN',['worjh2.PO4Fe_' modelo '.SPIN'],'biogem','biogem_series_ocn_temp.res'));
TEMP_SUP = TEMP(:,3); % Change to ppm
TEMP_FONDO = TEMP(:,4); % Change to ppm

%% Imágenes 
subplot(2,6,i)
set(gca,'FontWeight','bold');
plot(TEMP(:,1),TEMP_SUP,'LineWidth',2')
%  xlabel('\bf A\~nos','FontSize',24,'Interpreter','latex');
%  ylabel('Temperatura (°C) ','FontSize',24);
 xlabel('Years','FontWeight','bold');
 ylabel('Temperature (°C)','FontWeight','bold');
 title([modelo ' surface'])
 xlim(gca,[-100 10100]);
 ylim(gca,[0 20]);

 
 subplot(2,6,i+6)
plot(TEMP(:,1),TEMP_FONDO,'LineWidth',2)
%  xlabel('\bf A\~nos','FontWeight','bold','FontSize',24,'Interpreter','latex');  
%  ylabel('Temperatura (°C) ','FontSize',24);
 xlabel('Years','FontWeight','bold');
 ylabel('Temperature (°C)','FontWeight','bold');
 title([modelo ' bottom'])
 xlim(gca,[-100 10100]);
 ylim(gca,[-1 2]);
end