function [ Dust, dCO2 ] = fig2_mean(modelo,region)

Dir='/media/natalia/DATA/Tesis/';
    
    dCO2 = NaN(10,1);
CO2 = load(fullfile(Dir,'Cgenie_output','Globales',modelo,['worjh2.PO4Fe.All.' modelo '.level1'],'biogem','biogem_series_atm_pCO2.res'));
CO2_PI = mean(CO2(end-10:end,3))* 1000000; % Change to ppm
dCO2(1) = 0;
Dust = NaN(length(dCO2),1);

  % CO2 Reduction
    for i = 2:10
        CO2 = load(fullfile(Dir,'Cgenie_output','Regionales',modelo,['worjh2.PO4Fe.' modelo '.' region '.level' num2str(i)],'biogem','biogem_series_atm_pCO2.res'));
        dCO2(i) = CO2_PI - mean(CO2(end-10:end,3)) * 1000000; % Change to ppm 
    end
    
    % Dust Levels
    for idx = 1:length(dCO2)
        Fluxes = load(fullfile(Dir,'Flujos_de_polvo','Globales_Kg',modelo,[modelo '.nc_annualflux_kgperm2pers.36x36_level' num2str(idx) '.dat']));
        Dust(idx) = mean(Fluxes(:))*1000*3600*24*365; % Change to g/m2/a
    end
createFit(Dust, dCO2)
print(gcf,'-dpng','-r100',fullfile(Dir,'Figuras','Globales',modelo,'Ingles',[region '.png']))
%print(gcf,'-dpng','-r100',fullfile(Dir,'Figuras','Globales',modelo,[region '.png']))
T1 = table(Dust,dCO2, 'VariableNames',{[region 'DustMedian'],'dCO2'});% T2 = table(x,y, 'VariableNames',{'Dust', 'dCO2fit'});
writetable(T1,fullfile(Dir,'Figuras','Globales',modelo, ['Fig2_' region '.dat']),'Delimiter','\t');    
end
