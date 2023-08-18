function []=fig4(modelo)
%% Graficas Series Holoceno-LGM
Dir='/media/naty/Seagate Expansion Drive/Tesis/';

CO2_HOL = load(fullfile(Dir,'Cgenie_output','Globales',modelo,['worjh2.PO4Fe.All.' modelo '.level1'],'biogem','biogem_series_atm_pCO2.res'));
CO2_LGM = load(fullfile(Dir,'Cgenie_output','Globales',modelo,['worjh2.PO4Fe.All.' modelo '.level10'],'biogem','biogem_series_atm_pCO2.res'));

CO2_H = CO2_HOL(:,3) * 1000000; % Change to ppm
CO2_L = CO2_LGM(:,3) * 1000000; % Change to ppm

%% Imágenes 
figure1 = figure;
 set(gcf,'position',[200 200 800 400])
 set(gcf,'PaperPosition',[0 0 800/100 400/100]);
 axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
 hold(axes1,'on');
plot(CO2_HOL(:,1),CO2_H,'LineWidth',2)
% xlabel('\bf A\~nos','FontSize',24,'Interpreter','latex');
 ylabel('Concentración de pCO_2 (ppm) ','FontSize',24);
  xlabel('Años','FontSize',24);  
 xlim(axes1,[-100 10100]);
% title(['Holoceno Modelo ' modelo])
  title(['Holoceno modelo' modelo])
print(gcf,'-dpng','-r100',['/media/naty/Seagate Expansion Drive/Tesis/Figuras/Series/Holocene' modelo '.png']) 

 figure2 = figure;
 set(gcf,'position',[1050 200 800 400])
 set(gcf,'PaperPosition',[0 0 800/100 400/100]);
 axes2 = axes('Parent',figure2,'FontWeight','bold','FontSize',14);
 hold(axes2,'on');
plot(CO2_LGM(:,1),CO2_L,'LineWidth',2)
%  xlabel('\bf A\~nos','FontSize',24,'Interpreter','latex');  
  ylabel('pCO_2 (ppm) ','FontSize',24);
 xlabel('Years','FontSize',24);  
 xlim(axes2,[-100 10100]);
% title(['UMG Modelo ' modelo ])
 title(['LGM Model ' modelo ])
print(gcf,'-dpng','-r100',['/media/naty/Seagate Expansion Drive/Tesis/Figuras/Series/LGM' modelo '.png']) 
end

   

