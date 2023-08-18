  function Dust=Razon(region,modelo)

  load('area.mat')
Dir='/media/naty/Seagate Expansion Drive/Tesis/';
  
        Fluxes_Holoceno= load(fullfile(Dir,'Flujos_de_polvo','Globales_Kg',modelo,[modelo '.nc_annualflux_kgperm2pers.36x36_level1.dat']));
        Fluxes_LGM= load(fullfile(Dir,'Flujos_de_polvo','Globales_Kg',modelo,[modelo '.nc_annualflux_kgperm2pers.36x36_level10.dat']));
        Razon=Fluxes_LGM./Fluxes_Holoceno;
        
   if strcmp(region,'SA')              
        Flux = cat(2,Razon(29:36,20:36),Razon(29:36,1:5));
        Dust = median(Flux(:).*area_SA);
        
   elseif strcmp(region,'SP')            
        Flux = Razon(29:36,6:19);
        Dust = median(Flux(:).*area_SP); 
        
   elseif strcmp(region, 'NP')
        Flux = Razon(1:8,3:15);
        Dust = median(Flux(:).*area_NP); 
        
   elseif strcmp(region, 'CP')
        Flux = Razon(15:22,3:18);
        Dust = median(Flux(:).*area_CP);
   end
  end