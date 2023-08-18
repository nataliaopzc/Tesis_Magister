function []=SPIN(modelo)

Dir='/media/natalia/DATA/Tesis/';

TEMP = load(fullfile(Dir,'Cgenie_output','SPIN',['worjh2.PO4Fe_' modelo '.SPIN'],'biogem','biogem_series_ocn_temp.res'));
TEMP_SUP = TEMP(:,3); % Change to ppm
TEMP_FONDO = TEMP(:,4); % Change to ppm

%% Imágenes 
figure1 = figure;
 axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',14);
 hold(axes1,'on');
plot(TEMP(:,1),TEMP_SUP,'LineWidth',2)
%  xlabel('\bf A\~nos','FontSize',24,'Interpreter','latex');
%  ylabel('Temperatura (°C) ','FontSize',24);
 xlabel('Years','FontSize',24);
 ylabel('Temperature (°C) ','FontSize',24);

 xlim(axes1,[-100 10100]);
 
  figure2 = figure;
 axes2 = axes('Parent',figure2,'FontWeight','bold','FontSize',14);
 hold(axes2,'on');
plot(TEMP(:,1),TEMP_FONDO,'LineWidth',2)
%  xlabel('\bf A\~nos','FontWeight','bold','FontSize',24,'Interpreter','latex');  
%  ylabel('Temperatura (°C) ','FontSize',24);
 xlabel('Years','FontSize',24);
 ylabel('Temperature (°C) ','FontSize',24);
   xlim(axes2,[-100 10100]);
end