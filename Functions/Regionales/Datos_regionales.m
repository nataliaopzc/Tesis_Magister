function [Datos] = Datos_regionales(modelo,region)
load('area.mat')
%Dir='/media/naty/Seagate Expansion Drive/Tesis/';
Dir='/media/natalia/DATA/Tesis/';
    % Dust Levels   
    if strcmp(region,'SA')
    for idx = 1:10;
        Fluxes = load(fullfile(Dir,'Flujos_de_polvo','Globales_Kg',modelo,[modelo '.nc_annualflux_kgperm2pers.36x36_level' num2str(idx) '.dat']));
        Flux = cat(2,Fluxes(29:36,20:36),Fluxes(29:36,1:5));
        Dust_mean(idx,1) = mean(Flux(:)); % Change to kg/m2*s        
        Dust_median(idx,1) = median(Flux(:)); % Change to kg/m2*s        
        Dust_sum(idx,1) = sum(Flux(:).*area_SA); % Change to kg/s                  
    end   
    
    elseif strcmp(region, 'SP')
    for idx = 1:10;
        Fluxes = load(fullfile(Dir,'Flujos_de_polvo','Globales_Kg',modelo,[modelo '.nc_annualflux_kgperm2pers.36x36_level' num2str(idx) '.dat']));
        Flux = Fluxes(29:36,6:19);
        Dust_mean(idx,1) = mean(Flux(:)); % Change to kg/m2*s        
        Dust_median(idx,1) = median(Flux(:)); % Change to kg/m2*s        
        Dust_sum(idx,1) = sum(Flux(:).*area_SP); % Change to kg/s     
    end
    
     elseif strcmp(region, 'NP')
    for idx = 1:10;
        Fluxes = load(fullfile(Dir,'Flujos_de_polvo','Globales_Kg',modelo,[modelo '.nc_annualflux_kgperm2pers.36x36_level' num2str(idx) '.dat']));
        Flux = Fluxes(1:8,3:15);
        Dust_mean(idx,1) = mean(Flux(:)); % Change to kg/m2*s        
        Dust_median(idx,1) = median(Flux(:)); % Change to kg/m2*s        
        Dust_sum(idx,1) = sum(Flux(:).*area_NP); % Change to kg/s     
    end
    
     elseif strcmp(region, 'CP')
    for idx = 1:10;
        Fluxes = load(fullfile(Dir,'Flujos_de_polvo','Globales_Kg',modelo,[modelo '.nc_annualflux_kgperm2pers.36x36_level' num2str(idx) '.dat']));
        Flux = Fluxes(15:22,3:18);
        Dust_mean(idx,1) = mean(Flux(:)); % Change to kg/m2*s        
        Dust_median(idx,1) = median(Flux(:)); % Change to kg/m2*s        
        Dust_sum(idx,1) = sum(Flux(:).*area_CP); % Change to kg/s     
    end
    end
    Niveles = {'Nivel 1';'Nivel 2';'Nivel 3';'Nivel 4';'Nivel 5';'Nivel 6';'Nivel 7';'Nivel 8';'Nivel 9';'Nivel 10'};
    T=table(Niveles,Dust_mean,Dust_median,Dust_sum);
  writetable(T,fullfile(Dir,'Excel','Polvo_Regional',modelo,['Datos_kgm-2s-1_' modelo '2_' region '.dat']),'Delimiter','\t');    
end
