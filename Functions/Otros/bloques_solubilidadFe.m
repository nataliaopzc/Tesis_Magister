tic
load coastlines
geoshow(coastlat, coastlon, 'Color', 'black')
geoshow('landareas.shp', 'FaceColor', 'black');

hold on

region={'SA','SP','CP','NP','NA'};
value={'0.3333', '0.6666', '2','3'};

for i=1:5
   region_i=char(region(i));
      %for j=1:4
           % value_j=char(value(j));
N1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N1=[N1(9:end,:);N1(1:8,:)];
M1=N1<10;
N1(M1==0) = NaN;
N2=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol'); 
N2=[N2(9:end,:);N2(1:8,:)];
M2=N2<10;
N2(M2==0) = NaN;
lat2=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'lat'); 
lon2=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'lon');
lon2=[lon2(9:end);lon2(1:8)];
lon= wrapTo180(lon2);
[Ym, Xm] = meshgrid(lat2, lon);
pasos = 10;
t=linspace(0,1,pasos);
for j=1:pasos
    N=(t(j)*N2+(1-t(j))*N1);
[c,h]=contourf(Xm,Ym,N)
set(h,'LineColor','none')
pause(0.001)
delete(h)
end 

%%
N1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N1=[N1(9:end,:);N1(1:8,:)];
M1=N1<10;
N1(M1==0) = NaN;
N2=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x2/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N2=[N2(9:end,:);N2(1:8,:)];
M2=N2<10;
N2(M2==0) = NaN;
pasos = 10;
t=linspace(0,1,pasos);
for j=1:pasos
    N=(t(j)*N2+(1-t(j))*N1);
[c,h]=contourf(Xm,Ym,N)
set(h,'LineColor','none')
pause(0.001)
delete(h)
end 

%%
N1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x2/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N1=[N1(9:end,:);N1(1:8,:)];
M1=N1<10;
N1(M1==0) = NaN;
N2=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x3/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N2=[N2(9:end,:);N2(1:8,:)];
M2=N2<10;
N2(M2==0) = NaN;

pasos = 10;
t=linspace(0,1,pasos);
for j=1:pasos
    N=(t(j)*N2+(1-t(j))*N1);
[c,h]=contourf(Xm,Ym,N)
set(h,'LineColor','none')
pause(0.001)
delete(h)
end 

end

toc
