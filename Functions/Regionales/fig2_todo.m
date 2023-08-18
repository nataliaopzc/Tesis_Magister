function [dCO2] = fig2_todo(region,modelo)
%fig2: calculate logarithmic fit of pCO2 reduction as a function of Dust Flux values
%
%   region: What kind of median: 'Global', 'SA', 'Oceania', 'NP', 'CP'
%
%   b1, b2: fitted parameters of the regression dCO2 = b1*ln(b2*Dust)

% INITIALIZING
load('area.mat')
Dir='/media/naty/Seagate Expansion Drive/Tesis/';

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
      
elseif strcmp(region, 'SP')

    % CO2 Reduction
    for i = 2:10
        CO2 = load(fullfile(Dir,'Cgenie_output','Regionales',modelo,['worjh2.PO4Fe.' modelo '.' region '.level' num2str(i)],'biogem','biogem_series_atm_pCO2.res'));
        dCO2(i) = CO2_PI - mean(CO2(end-10:end,3)) * 1000000; % Change to ppm
    end
     
elseif strcmp(region, 'NP')
 
    % CO2 Reduction
    for i = 2:10
        CO2 = load(fullfile(Dir,'Cgenie_output','Regionales',modelo,['worjh2.PO4Fe.' modelo '.' region '.level' num2str(i)],'biogem','biogem_series_atm_pCO2.res'));
        dCO2(i) = CO2_PI - mean(CO2(end-10:end,3)) * 1000000; % Change to ppm
    end
    
elseif strcmp(region, 'CP')
  
    % CO2 Reduction
    for i = 2:10
        CO2 = load(fullfile(Dir,'Cgenie_output','Regionales',modelo,['worjh2.PO4Fe.' modelo '.' region '.level' num2str(i)],'biogem','biogem_series_atm_pCO2.res'));
        dCO2(i) = CO2_PI - mean(CO2(end-10:end,3)) * 1000000; % Change to ppm
    end

    
else
    error('valid entries for region are ''global'', ''SA'',''SP'', ''NP'', or ''CP''.');
end
end

