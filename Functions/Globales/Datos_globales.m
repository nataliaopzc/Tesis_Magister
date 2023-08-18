function [Datos] = Datos_globales(modelo,region)
load('area_t.mat')
Dir='/media/natalia/Seagate Expansion Drive/Tesis/';
    % Dust Levels
    for idx = 1:10;
        Fluxes = load(fullfile(Dir,'Flujos_de_polvo','Globales_Kg',modelo,[modelo '.nc_annualflux_kgperm2pers.36x36_level' num2str(idx) '.dat']));
        Dust_mean(idx,1) = mean(Fluxes(:)); % Change to kg/m2*s        
        Dust_median(idx,1) = median(Fluxes(:)); % Change to kg/m2*s        
        Dust_sum(idx,1) = sum(Fluxes(:).*area_total); % Change to kg/m2*s                  
    end     
    Niveles = {'Nivel 1';'Nivel 2';'Nivel 3';'Nivel 4';'Nivel 5';'Nivel 6';'Nivel 7';'Nivel 8';'Nivel 9';'Nivel 10'};
    T=table(Niveles,Dust_mean,Dust_median,Dust_sum);
  writetable(T,fullfile(Dir,'Excel','Polvo_Global',['Datos_kgm-2s-1_' modelo '_' region '.dat']),'Delimiter','\t');    
end
