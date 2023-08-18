function [dCO2,Dust] = fig2_suma(region,modelo)
%fig2: calculate logarithmic fit of pCO2 reduction as a function of Dust Flux values
%
%   region: What kind of median: 'Global', 'SA', 'Oceania', 'NP', 'CP'
%
%   b1, b2: fitted parameters of the regression dCO2 = b1*ln(b2*Dust)

% INITIALIZING
load('area.mat')
%Dir='/media/naty/Seagate Expansion Drive/Tesis/';
Dir='/home/natalia/Documentos/Tesis/';

    dCO2 = NaN(10,1);
CO2 = load(fullfile(Dir,'Cgenie_output','Regionales',modelo,['worjh2.PO4Fe.' modelo '.SA.level1'],'biogem','biogem_series_atm_pCO2.res'));
CO2_PI = mean(CO2(end-10:end,3))* 1000000; % Change to ppm
dCO2(1) = 0;
Dust = NaN(length(dCO2),1);

% Global Dust Flux Median
        
if strcmp(region,'SA')
    
    % CO2 Reduction
    for i = 2:10
        CO2 = load(fullfile(Dir,'Cgenie_output','Regionales',modelo,['worjh2.PO4Fe.' modelo '.' region '.level' num2str(i)],'biogem','biogem_series_atm_pCO2.res'));
        dCO2(i) = CO2_PI - mean(CO2(end-10:end,3)) * 1000000; % Change to ppm
    end
    
    % Dust Levels
    for idx = 1:length(dCO2)
        Fluxes = load(fullfile(Dir,'Flujos_de_polvo','Globales_Kg',modelo,[modelo '.nc_annualflux_kgperm2pers.36x36_level' num2str(idx) '.dat']));
        Flux = cat(2,Fluxes(29:36,20:36),Fluxes(29:36,1:5));
        Dust(idx) = sum(Flux(:).*area_SA); % Change to kg/m2/s ---> kg/s
    end
    
elseif strcmp(region, 'SP')
    % CO2 Reduction
    for i = 2:10
        CO2 = load(fullfile(Dir,'Cgenie_output','Regionales',modelo,['worjh2.PO4Fe.' modelo '.' region '.level' num2str(i)],'biogem','biogem_series_atm_pCO2.res'));
        dCO2(i) = CO2_PI - mean(CO2(end-10:end,3)) * 1000000; % Change to ppm
    end
    
    % Dust Levels
    for idx = 1:length(dCO2)
        Fluxes = load(fullfile(Dir,'Flujos_de_polvo','Globales_Kg',modelo,[modelo '.nc_annualflux_kgperm2pers.36x36_level' num2str(idx) '.dat']));
        Flux = Fluxes(29:36,6:19);
        Dust(idx) = sum(Flux(:).*area_SP); 
    end
    
elseif strcmp(region, 'NP')
 
    % CO2 Reduction
    for i = 2:10
        CO2 = load(fullfile(Dir,'Cgenie_output','Regionales',modelo,['worjh2.PO4Fe.' modelo '.' region '.level' num2str(i)],'biogem','biogem_series_atm_pCO2.res'));
        dCO2(i) = CO2_PI - mean(CO2(end-10:end,3)) * 1000000; % Change to ppm
    end
    
    % Dust Levels
    for idx = 1:length(dCO2)
        Fluxes = load(fullfile(Dir,'Flujos_de_polvo','Globales_Kg',modelo,[modelo '.nc_annualflux_kgperm2pers.36x36_level' num2str(idx) '.dat']));
        Flux = Fluxes(1:8,3:15);
        Dust(idx) = sum(Flux(:).*area_NP); 
    end
    
elseif strcmp(region, 'CP')
  
    % CO2 Reduction
    for i = 2:10
        CO2 = load(fullfile(Dir,'Cgenie_output','Regionales',modelo,['worjh2.PO4Fe.' modelo '.' region '.level' num2str(i)],'biogem','biogem_series_atm_pCO2.res'));
        dCO2(i) = CO2_PI - mean(CO2(end-10:end,3)) * 1000000; % Change to ppm
    end
    
    % Dust Levels
    for idx = 1:length(dCO2)
        Fluxes = load(fullfile(Dir,'Flujos_de_polvo','Globales_Kg',modelo,[modelo '.nc_annualflux_kgperm2pers.36x36_level' num2str(idx) '.dat']));
        Flux = Fluxes(15:22,3:18);
        Dust(idx) = sum(Flux(:).*area_CP);
    end
    
else
    error('valid entries for region are ''global'', ''SA'',''SP'', ''NP'', or ''CP''.');
end

% % % %%Fit logarithmic regression
% % %  modelfun = @(b,x)(b(1)*log(b(2)*x));
% % %  b = nlinfit(Dust,dCO2+5, modelfun, [1,1]); % Translate dCO2 by +5 to avoid problems around zero
% % %  b1 = b(1);
% % %  b2 = b(2)/exp(5/b(1)); % Translate back to original dCO2 values: 5=b1*ln(b2*x)-b1*ln(a*b2*x) -> 5/b1=-ln(a)
% % % 
% % %  % Plot Result
% % %  x = linspace(min(Dust),max(Dust));
% % %  x=x';
% % %  y = b1*log(b2*x);
% % %  scatter(Dust,dCO2)
% % %  hold on
% % %  plot(x,y,'r')
% % %  hold off
% % %  xlabel('Dust Flux ($\frac{g}{m^{2}a}$)','FontWeight','bold','FontSize',30,...
% % %     'Interpreter','latex');
% % %   ylabel('pCO_2 (ppm) Reduction ','FontSize',24);
% % %  
% % %  % Save results
% % %  T1 = table(Dust,dCO2, 'VariableNames',{[region 'DustMedian'],'dCO2'});% T2 = table(x,y, 'VariableNames',{'Dust', 'dCO2fit'});
% % %  T2 = table(x,y, 'VariableNames',{'Dust', 'dCO2fit'});
% % %  T3 = table(b1,b2,min(Dust),max(Dust), 'VariableNames',{'b1', 'b2', 'minDust', 'maxDust'});
% % %  writetable(T1,fullfile(userdir,'Tesis','Figuras','Regionales','Lambert','Fig2_Regions','sum', ['Fig2_' region '.dat']),'Delimiter','\t');
% % %  writetable(T2,fullfile(userdir,'Tesis','Figuras','Regionales','Lambert','Fig2_Regions','sum', ['Fig2_' region '_fit.dat']),'Delimiter','\t');
% % %  writetable(T3,fullfile(userdir,'Tesis','Figuras','Regionales','Lambert','Fig2_Regions','sum', ['Fig2_' region '_fitparam.dat']),'Delimiter','\t');
createFit(Dust, dCO2)
%createFit1(Dust,dCO2)
%print(gcf,'-dpng','-r100',fullfile(Dir,'Figuras','Regionales',modelo,'Ingles',[region '.png']))
print(gcf,'-dpng','-r100',fullfile(Dir,'Figuras','Regionales',modelo,[region '.png']))
T1 = table(Dust,dCO2, 'VariableNames',{[region 'DustMedian'],'dCO2'});% T2 = table(x,y, 'VariableNames',{'Dust', 'dCO2fit'});
writetable(T1,fullfile(Dir,'Figuras','Regionales',modelo, ['Fig2_' region '.dat']),'Delimiter','\t');
end

