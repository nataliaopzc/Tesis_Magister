%function [Datos] = Datos_atipicos(modelo,region)
modelo='Albani'
Dir='/media/natalia/Seagate Expansion Drive/Tesis/';
for idx=2:10
        Fluxes1 = load(fullfile(Dir,'Flujos_de_polvo','Globales_Kg',modelo,[modelo '.nc_annualflux_kgperm2pers.36x36_level1.dat']));
        Fluxes2 = load(fullfile(Dir,'Flujos_de_polvo','Globales_Kg',modelo,[modelo '.nc_annualflux_kgperm2pers.36x36_level' num2str(idx) '.dat']));       
        Flux1 = Fluxes1(15:22,3:18);      
        Flux2 = Fluxes2(15:22,3:18);     
        Rest(:,:,idx-1)=Flux2-Flux1;
                    d_pos=find(Rest>0);
    Media(idx-1,1)=mean(Rest(d_pos)); %Primera columna valores positivos 
    d_neg=find(Rest<0);
    Media(idx-1,2)=mean(Rest(d_neg)); %Columna dos, valores negativos
end
Positiva=Media(:,1);
Negativa=Media(:,2);
 T=table(Positiva,Negativa);
 writetable(T,fullfile(Dir,'Excel','DatosAtipicos_kgm-2s-1_Albani_CP.dat'),'Delimiter','\t');   
        
load 'lon_lat.mat'
load coastlines
%geoshow(coastlat, coastlon, 'Color', 'black')
set(gcf,'position',[200 300 800 500])
geoshow('landareas.shp', 'FaceColor', 'black');
lon=lonlat_edges(:,1)-180;
hold on
for i=1:37
    plot(lon,repmat(lonlat_edges(i,2),[1,37]),'-k')
end
for j=1:37
    plot(repmat(lon(j),[1,37]),lonlat_edges(:,2),'-k')
end

xlabel('Longitud','FontWeight','bold','FontSize',24);

% Create ylabel
ylabel('Latitud','FontWeight','bold','FontSize',24);

%% Regiones

%CP Esta ok
for i=15:23
    plot(lon(1:11),repmat(lonlat_edges(i,2),[1, 11]),'-g')
end
for j=1:11
    plot(repmat(lon(j),[1 9]),lonlat_edges(15:23,2),'-g')
end

for i=15:23
    plot(lon(31:37),repmat(lonlat_edges(i,2),[1, 7]),'-g')
end
for j=31:37
    plot(repmat(lon(j),[1 9]),lonlat_edges(15:23,2),'-g')
end

%% CP
    
    h=text(lonlat(10,1),lonlat(12,2),['Media=' num2str(Media)],'Color','blue');
    set(h,'visible','off')
    h1=text(lonlat(10,1),lonlat(25,2),['Media=' num2str(Media)],'Color','red');
for p=1:9
[m,n]=find(Rest(:,:,p)<0);
[x,y]=find(Rest(:,:,p)>0);    
for i=1:length(m) 
    text(lonlat(n(i)+2,1),lonlat(m(i)+14,2),'x','Color','blue');
end

for i=1:length(x)
    Media=mean(Rest(x(i),y(i)));
    text(lonlat(y(i)+2,1),lonlat(x(i)+14,2),'x','Color','red');
end
%clear h1 h2
drawnow;
pause(0.5);
end

