clear all
cla
subplot(2,3,1)
load coastlines
plot3(coastlon(1:3:end,1),coastlat(1:3:end,1),110*ones(3289),'*k','MarkerSize',1.2)
hold on

ND=ncread('/media/natalia/DATA/Tesis/netcdf/Originales/Lambert/Lambert.nc','Flux');
latd1=ncread('/media/natalia/DATA/Tesis/netcdf/Originales/Lambert/Lambert.nc','lat');
lond1=ncread('/media/natalia/DATA/Tesis/netcdf/Originales/Lambert/Lambert.nc','lon');
lond1=lond1-180;
ND=median(ND(:,:,:,2),3)';
[Xmd,Ymd,Zmd] = meshgrid(lond1,latd1,[0,110]);
%Zmd=single(Zmd);
Xmd=double(Xmd);
Ymd=double(Ymd);
xslice = [];   
yslice = [];
zslice = 2;
ND(:,:,2)=ND;
ND=double(ND);

contourslice(Xmd,Ymd,Zmd,log10(ND),[],[],110)
%%

load 'lon_lat.mat'
geoshow('landareas.shp', 'FaceColor', 'black');
view(45,35)
lon=lonlat_edges(:,1)-180;
xlabel('Longitude','FontWeight','bold','FontSize',16);

% Create ylabel
ylabel('Latitude','FontWeight','bold','FontSize',16);
zlabel('Solubility','FontWeight','bold','FontSize',16);
set(get(gca,'ylabel'),'rotation',25)
set(get(gca,'xlabel'),'rotation',-25)
set(get(gca,'zlabel'),'rotation',90)

lat2=ncread('/Documentos/DATA/GModelos/woa13_all_n00_01.nc','lat'); 
lon2=ncread('/Documentos/DATA/GModelos/woa13_all_n00_01.nc','lon');
N=N(:,:,1);
[Ym, Xm] = meshgrid(lat2, lon2);
contourf(Xm,Ym,N)
Colorbar=colorbar('southoutside')
set(get(Colorbar,'title'),'string','Nitrate [umol/kg]');

zlim([0 120])
%zticks([0 20 40 60 80 100])
zticklabels({})

%% Regiones

MODEL={'Lambert'}
%TIME={'H', 'LGM'}
REGION={'SA', 'SP', 'CP', 'NP', 'NA'}
SOL={'0.3333', '0.6666','2','3'}
SOLp=[0.3333,0.6666,2,3];
xxSOL=linspace(0.3333,3,100)

for j=1
		%CO2=[]
        REGION_j=char(REGION(j));
 for k=1:4
     SOL_k=char(SOL(k));
  for l=1
      MODEL_l=char(MODEL(l));
CO2_file=load(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4Fe' MODEL_l '_LGM_Sol_calculated_Dust_' REGION_j '_x' SOL_k '/biogem/biogem_series_atm_pCO2.res']);
CO2(k,1)=(median(CO2_file(end-100:end,3)*1e+6));
  
  end
 end
end

yy=spline(SOLp,CO2,xxSOL);


for j=1
		%CO2=[]
        REGION_j=char(REGION(j));
 for k=1:4
     SOL_k=char(SOL(k));
  for l=1
      MODEL_l=char(MODEL(l));
CO2_or=load(['/media/natalia/DATA/Tesis/Cgenie_output/Globales/' MODEL_l '/worjh2.PO4Fe.All.' MODEL_l '.level1/biogem/biogem_series_atm_pCO2.res']);
CO2_file=load(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4Fe' MODEL_l '_LGM_Sol_calculated_Dust_' REGION_j '_x' SOL_k '/biogem/biogem_series_atm_pCO2.res']);
CO2_1(k,j)=(median(CO2_or(end-100:end,3)*1e+6)-median(CO2_file(end-100:end,3)*1e+6));
  end
 end
end
yy1=spline(SOLp,CO2_1,xxSOL);

AREA=[2.2040e+13,4.0931e+13,1.4168e+13,4.4080e+13,6.9268e+13]
for j=1
		%CO2=[]
        REGION_j=char(REGION(j));
 for k=1:4
     SOL_k=char(SOL(k));
  for l=1
      MODEL_l=char(MODEL(l));
CO2_or=load(['/media/natalia/DATA/Tesis/Cgenie_output/Globales/' MODEL_l '/worjh2.PO4Fe.All.' MODEL_l '.level1/biogem/biogem_series_atm_pCO2.res']);
CO2_file=load(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4Fe' MODEL_l '_LGM_Sol_calculated_Dust_' REGION_j '_x' SOL_k '/biogem/biogem_series_atm_pCO2.res']);
CO2_2(k,j)=(median(CO2_or(end-100:end,3)*1e+6)-median(CO2_file(end-100:end,3)*1e+6))*1e+6/AREA(j);
  end
 end
end
yy2=spline(SOLp,CO2_2,xxSOL);


%%

region={'SA','SP','CP','NP','NA'};
value={'0.3333', '0.6666', '2','3'};

for i=1
   region_i=char(region(i));
      %for j=1:4
           % value_j=char(value(j));
N1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N1=[N1(9:end,:);N1(1:8,:)];
M1=N1<10;
N1(M1==0) = NaN;
N2=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N2=[N2(9:end,:);N2(1:8,:)];
M2=N2<10;
N2(M2==0) = NaN;
lat2=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'lat'); 
lon2=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'lon');
lon2=[lon2(9:end);lon2(1:8)];
lon= wrapTo180(lon2);
[Ym, Xm] = meshgrid(lat2, lon);
pasos = 33;
t1=linspace(0,1,pasos);

%%
N3=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x2/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N3=[N3(9:end,:);N3(1:8,:)];
M3=N3<10;
N3(M3==0) = NaN;
pasos = 33;
t2=linspace(0,1,pasos);


%%
N4=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x3/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N4=[N4(9:end,:);N4(1:8,:)];
M4=N4<10;
N4(M4==0) = NaN;

pasos = 34;
t3=linspace(0,1,pasos);

end

%%
region={'SA','SP','CP','NP','NA'};
value={'0.3333', '0.6666', '2','3'};

for i=1
   region_i=char(region(i));
      %for j=1:4
           % value_j=char(value(j));
N1_1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'bio_export_POC')); 
N1_1=[N1_1(9:end,:);N1_1(1:8,:)];
M1_1=N1_1<10;
N1_1(M1_1==0) = NaN;
N2_1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'bio_export_POC')); 
N2_1=[N2_1(9:end,:);N2_1(1:8,:)];
M2_1=N2_1<10;
N2_1(M2_1==0) = NaN;
lat2_1=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'lat'); 
lon2_1=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'lon');
lon2_1=[lon2(9:end);lon2(1:8)];
lon_1= wrapTo180(lon2);
[Ym_1, Xm_1] = meshgrid(lat2_1, lon_1);
pasos = 33;
t1_1=linspace(0,1,pasos);

N3_1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x2/biogem/fields_biogem_2d.nc'],'bio_export_POC')); 
N3_1=[N3_1(9:end,:);N3_1(1:8,:)];
M3_1=N3_1<10;
N3_1(M3_1==0) = NaN;
pasos = 33;
t2_1=linspace(0,1,pasos);

N4_1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x3/biogem/fields_biogem_2d.nc'],'bio_export_POC')); 
N4_1=[N4_1(9:end,:);N4_1(1:8,:)];
M4_1=N4_1<10;
N4_1(M4_1==0) = NaN;

pasos = 34;
t3_1=linspace(0,1,pasos);

end

%%
subplot(2,3,2)
geoshow('landareas.shp', 'FaceColor', 'black');
hold on
subplot(2,3,3)
geoshow('landareas.shp', 'FaceColor', 'black');
hold on

% video = VideoWriter('newfile1.mp4');
%  open(video);

for j=1:100
%SA

subplot(2,3,1)
Y=[lonlat_edges(1,2),lonlat_edges(9,2)];
X=[lon(12),lon(34)];
Z=linspace(0,60);

XX = [X(1) X(end) X(end) X(1) X(1); X(1) X(1) X(1) X(1) X(1);X(1) X(1) X(end) X(end) 0;X(end) X(end) X(end) X(end) X(end); X(end) X(end) X(1) X(1) X(end)];
YY = [Y(1) Y(1) Y(end) Y(end) Y(1); Y(1) Y(1) Y(end) Y(end) Y(1);Y(1) Y(1) Y(1) Y(1) Y(1); Y(1) Y(1) Y(end) Y(end) Y(1);Y(end) Y(end) Y(end) Y(end) Y(end)];
ZZ = [Z(j) Z(j) Z(j) Z(j) Z(j); Z(1) Z(j) Z(j) Z(1) Z(1); Z(1) Z(j) Z(j) Z(1) Z(1);(1) Z(j) Z(j) Z(1) Z(1);Z(1) Z(j) Z(j) Z(1) Z(1)];
B=fill3(XX',YY',ZZ','r','FaceAlpha',.3);
subplot(2,3,4)
Li=plot(xxSOL(1:j),yy(1:j),'r');
   ylim([230 265])
   xlim([0 3.5])
   title('pCO2 v/s Iron solubility scale')
   xlabel('Iron solubility scale')
   ylabel('Atmospheric CO2 [ppm]')
subplot(2,3,5)   
Li_1=plot(xxSOL(1:j),yy1(1:j),'r');
   ylim([25 40])
   xlim([0 3.5])
      title('pCO2 difference v/s Iron solubility scale')
   xlabel('Iron solubility scale')
   ylabel('Atmospheric CO2 [ppm]')
subplot(2,3,6)
Li_2=plot(xxSOL(1:j),yy2(1:j),'r');
   ylim([0 0.3e-5])
   xlim([0 3.5])
      title('pCO2 difference per m2 v/s Iron solubility scale')
   xlabel('Iron solubility scale')
   ylabel('Atmospheric CO2 [ppm/m2]')
subplot(2,3,2)
%%
if 1<= j && j <=33
    N=(t1(j)*N2+(1-t1(j))*N1);
elseif 34<= j && j <=66

    N=(t2(j-33)*N3+(1-t2(j-33))*N2); 
else 
      N=(t3(j-66)*N4+(1-t3(j-66))*N3);
end 
[c1,h1]=contourf(Xm,Ym,N);
Colorbar1=colorbar('southoutside')
set(get(Colorbar1,'title'),'string','Solulablized aeolian iron flux density to surface [umol Fe m-2 yr-1]');
ylabel('Latitude','FontWeight','bold','FontSize',16);
xlabel('Longitude','FontWeight','bold','FontSize',16);
subplot(2,3,3)
if 1<= j && j <=33
    N_1=(t1_1(j)*N2_1+(1-t1_1(j))*N1_1);
elseif 34<= j && j <=66

    N_1=(t2_1(j-33)*N3_1+(1-t2_1(j-33))*N2_1); 
else 
      N_1=(t3_1(j-66)*N4_1+(1-t3_1(j-66))*N3_1);
end 
[c2,h2]=contourf(Xm_1,Ym_1,N_1);
Colorbar2=colorbar('southoutside')
set(get(Colorbar2,'title'),'string','Biological export - POC [mol m-2 yr-1]');
ylabel('Latitude','FontWeight','bold','FontSize',16);
xlabel('Longitude','FontWeight','bold','FontSize',16);
pause(0.01)
delete(B)
delete(h1)
delete(h2)
% delete(Li)
% delete(Li_1)
% delete(Li_2)

%   M(j*5) = getframe();
%   writeVideo(video,M);

end
subplot(2,3,4)
plot(xxSOL(1:j),yy(1:j),'r');
hold on
subplot(2,3,5)
plot(xxSOL(1:j),yy1(1:j),'r');
hold on
subplot(2,3,6)
plot(xxSOL(1:j),yy2(1:j),'r');
hold on
% % subplot(2,3,2)
% % [c,h]=contourf(Xm,Ym,N);
% % subplot(2,3,3)
% % [c2,h2]=contourf(Xm_1,Ym_1,N_1);

hold on
 
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MODEL={'Lambert'}
%TIME={'H', 'LGM'}
REGION={'SA', 'SP', 'CP', 'NP', 'NA'}
SOL={'0.3333', '0.6666','2','3'}
SOLp=[0.3333,0.6666,2,3];
xxSOL=linspace(0.3333,3,100)

for j=2
		%CO2=[]
        REGION_j=char(REGION(j));
 for k=1:4
     SOL_k=char(SOL(k));
  for l=1
      MODEL_l=char(MODEL(l));
CO2_file=load(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4Fe' MODEL_l '_LGM_Sol_calculated_Dust_' REGION_j '_x' SOL_k '/biogem/biogem_series_atm_pCO2.res']);
CO2(k,1)=(median(CO2_file(end-100:end,3)*1e+6));
  
  end
 end
end

yy=spline(SOLp,CO2,xxSOL);


for j=2
		%CO2=[]
        REGION_j=char(REGION(j));
 for k=1:4
     SOL_k=char(SOL(k));
  for l=1
      MODEL_l=char(MODEL(l));
CO2_or=load(['/media/natalia/DATA/Tesis/Cgenie_output/Globales/' MODEL_l '/worjh2.PO4Fe.All.' MODEL_l '.level1/biogem/biogem_series_atm_pCO2.res']);
CO2_file=load(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4Fe' MODEL_l '_LGM_Sol_calculated_Dust_' REGION_j '_x' SOL_k '/biogem/biogem_series_atm_pCO2.res']);
CO2_1(k,1)=(median(CO2_or(end-100:end,3)*1e+6)-median(CO2_file(end-100:end,3)*1e+6));
  end
 end
end
yy1=spline(SOLp,CO2_1,xxSOL);

AREA=[2.2040e+13,4.0931e+13,1.4168e+13,4.4080e+13,6.9268e+13]
for j=2
		%CO2=[]
        REGION_j=char(REGION(j));
 for k=1:4
     SOL_k=char(SOL(k));
  for l=1
      MODEL_l=char(MODEL(l));
CO2_or=load(['/media/natalia/DATA/Tesis/Cgenie_output/Globales/' MODEL_l '/worjh2.PO4Fe.All.' MODEL_l '.level1/biogem/biogem_series_atm_pCO2.res']);
CO2_file=load(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4Fe' MODEL_l '_LGM_Sol_calculated_Dust_' REGION_j '_x' SOL_k '/biogem/biogem_series_atm_pCO2.res']);
CO2_2(k,1)=(median(CO2_or(end-100:end,3)*1e+6)-median(CO2_file(end-100:end,3)*1e+6))*1e+6/AREA(j);
  end
 end
end
yy2=spline(SOLp,CO2_2,xxSOL);


%%

region={'SA','SP','CP','NP','NA'};
value={'0.3333', '0.6666', '2','3'};

for i=2
   region_i=char(region(i));
      %for j=1:4
           % value_j=char(value(j));
N1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N1=[N1(9:end,:);N1(1:8,:)];
M1=N1<10;
N1(M1==0) = NaN;
N2=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N2=[N2(9:end,:);N2(1:8,:)];
M2=N2<10;
N2(M2==0) = NaN;
lat2=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'lat'); 
lon2=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'lon');
lon2=[lon2(9:end);lon2(1:8)];
lon= wrapTo180(lon2);
[Ym, Xm] = meshgrid(lat2, lon);
pasos = 33;
t1=linspace(0,1,pasos);

%%
N3=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x2/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N3=[N3(9:end,:);N3(1:8,:)];
M3=N3<10;
N3(M3==0) = NaN;
pasos = 33;
t2=linspace(0,1,pasos);


%%
N4=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x3/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N4=[N4(9:end,:);N4(1:8,:)];
M4=N4<10;
N4(M4==0) = NaN;

pasos = 34;
t3=linspace(0,1,pasos);

end

%%
region={'SA','SP','CP','NP','NA'};
value={'0.3333', '0.6666', '2','3'};

for i=2
   region_i=char(region(i));
      %for j=1:4
           % value_j=char(value(j));
N1_1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'bio_export_POC')); 
N1_1=[N1_1(9:end,:);N1_1(1:8,:)];
M1_1=N1_1<10;
N1_1(M1_1==0) = NaN;
N2_1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'bio_export_POC')); 
N2_1=[N2_1(9:end,:);N2_1(1:8,:)];
M2_1=N2_1<10;
N2_1(M2_1==0) = NaN;
lat2_1=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'lat'); 
lon2_1=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'lon');
lon2_1=[lon2(9:end);lon2(1:8)];
lon_1= wrapTo180(lon2);
[Ym_1, Xm_1] = meshgrid(lat2_1, lon_1);
pasos = 33;
t1_1=linspace(0,1,pasos);

N3_1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x2/biogem/fields_biogem_2d.nc'],'bio_export_POC')); 
N3_1=[N3_1(9:end,:);N3_1(1:8,:)];
M3_1=N3_1<10;
N3_1(M3_1==0) = NaN;
pasos = 33;
t2_1=linspace(0,1,pasos);

N4_1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x3/biogem/fields_biogem_2d.nc'],'bio_export_POC')); 
N4_1=[N4_1(9:end,:);N4_1(1:8,:)];
M4_1=N4_1<10;
N4_1(M4_1==0) = NaN;

pasos = 34;
t3_1=linspace(0,1,pasos);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%

lon=lonlat_edges(:,1)-180;

%SP
for j=1:100
    subplot(2,3,1)
Y=[lonlat_edges(1,2),lonlat_edges(9,2)];
X1=[lon(1), lon(12)];X2=[lon(34) lon(37)];
Z=linspace(0,60);

XX1 = [X1(1) X1(end) X1(end) X1(1) X1(1); X1(1) X1(1) X1(1) X1(1) X1(1);X1(1) X1(1) X1(end) X1(end) X1(1);X1(end) X1(end) X1(end) X1(end) X1(end); X1(end) X1(end) X1(1) X1(1) X1(end)];
XX2 = [X2(1) X2(end) X2(end) X2(1) X2(1); X2(1) X2(1) X2(1) X2(1) X2(1);X2(1) X2(1) X2(end) X2(end) X2(1);X2(end) X2(end) X2(end) X2(end) X2(end); X2(end) X2(end) X2(1) X2(1) X2(end)];
YY = [Y(1) Y(1) Y(end) Y(end) Y(1); Y(1) Y(1) Y(end) Y(end) Y(1);Y(1) Y(1) Y(1) Y(1) Y(1); Y(1) Y(1) Y(end) Y(end) Y(1);Y(end) Y(end) Y(end) Y(end) Y(end)];
ZZ = [Z(j) Z(j) Z(j) Z(j) Z(j); Z(1) Z(j) Z(j) Z(1) Z(1); Z(1) Z(j) Z(j) Z(1) Z(1);(1) Z(j) Z(j) Z(1) Z(1);Z(1) Z(j) Z(j) Z(1) Z(1)];
B2=fill3(XX1',YY',ZZ','b','FaceAlpha',.3);
B22=fill3(XX2',YY',ZZ','b','FaceAlpha',.3);
hold on
subplot(2,3,4)
Li=plot(xxSOL(1:j),yy(1:j),'b');
   ylim([230 265])
   xlim([0 3.5])
   title('pCO2 v/s Iron solubility scale')
   xlabel('Iron solubility scale')
   ylabel('Atmospheric CO2 [ppm]')
subplot(2,3,5)   
Li_1=plot(xxSOL(1:j),yy1(1:j),'b');
   ylim([25 40])
   xlim([0 3.5])
      title('pCO2 difference v/s Iron solubility scale')
   xlabel('Iron solubility scale')
   ylabel('Atmospheric CO2 [ppm]')
subplot(2,3,6)
Li_2=plot(xxSOL(1:j),yy2(1:j),'b');
   ylim([0 0.3e-5])
   xlim([0 3.5])
      title('pCO2 difference per m2 v/s Iron solubility scale')
   xlabel('Iron solubility scale')
   ylabel('Atmospheric CO2 [ppm/m2]')
subplot(2,3,2)
%%
if 1<= j && j <=33
    N=(t1(j)*N2+(1-t1(j))*N1);
elseif 34<= j && j <=66

    N=(t2(j-33)*N3+(1-t2(j-33))*N2); 
else 
      N=(t3(j-66)*N4+(1-t3(j-66))*N3);
 end 
%geoshow('landareas.shp', 'FaceColor', 'black');
%hold on
[c1,h1]=contourf(Xm,Ym,N);
Colorbar=colorbar('southoutside')
set(get(Colorbar,'title'),'string','Solulablized aeolian iron flux density to surface [umol Fe m-2 yr-1]');
ylabel('Latitude','FontWeight','bold','FontSize',16);
xlabel('Longitude','FontWeight','bold','FontSize',16);
subplot(2,3,3)
if 1<= j && j <=33
    N_1=(t1_1(j)*N2_1+(1-t1_1(j))*N1_1);
elseif 34<= j && j <=66

    N_1=(t2_1(j-33)*N3_1+(1-t2_1(j-33))*N2_1); 
else 
      N_1=(t3_1(j-66)*N4_1+(1-t3_1(j-66))*N3_1);
end 
%geoshow('landareas.shp', 'FaceColor', 'black');
%hold on
[c2,h2]=contourf(Xm_1,Ym_1,N_1);
Colorbar=colorbar('southoutside')
set(get(Colorbar,'title'),'string','Biological export - POC [mol m-2 yr-1] ');
ylabel('Latitude','FontWeight','bold','FontSize',16);
xlabel('Longitude','FontWeight','bold','FontSize',16);
pause(0.1)
delete(B2)
delete(B22)
delete(Li)
delete(Li_1)
delete(Li_2)
delete(h1)
delete(h2)
end
subplot(2,3,4)
plot(xxSOL(1:j),yy(1:j),'b');
hold on
subplot(2,3,5)
plot(xxSOL(1:j),yy1(1:j),'b');
hold on
subplot(2,3,6)
plot(xxSOL(1:j),yy2(1:j),'b');
hold on

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
MODEL={'Lambert'}
%TIME={'H', 'LGM'}
REGION={'SA', 'SP', 'CP', 'NP', 'NA'}
SOL={'0.3333', '0.6666','2','3'}
SOLp=[0.3333,0.6666,2,3];
xxSOL=linspace(0.3333,3,100)

for j=3
		%CO2=[]
        REGION_j=char(REGION(j));
 for k=1:4
     SOL_k=char(SOL(k));
  for l=1
      MODEL_l=char(MODEL(l));
CO2_file=load(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4Fe' MODEL_l '_LGM_Sol_calculated_Dust_' REGION_j '_x' SOL_k '/biogem/biogem_series_atm_pCO2.res']);
CO2(k,1)=(median(CO2_file(end-100:end,3)*1e+6));
  
  end
 end
end

yy=spline(SOLp,CO2,xxSOL);


for j=3
		%CO2=[]
        REGION_j=char(REGION(j));
 for k=1:4
     SOL_k=char(SOL(k));
  for l=1
      MODEL_l=char(MODEL(l));
CO2_or=load(['/media/natalia/DATA/Tesis/Cgenie_output/Globales/' MODEL_l '/worjh2.PO4Fe.All.' MODEL_l '.level1/biogem/biogem_series_atm_pCO2.res']);
CO2_file=load(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4Fe' MODEL_l '_LGM_Sol_calculated_Dust_' REGION_j '_x' SOL_k '/biogem/biogem_series_atm_pCO2.res']);
CO2_1(k,1)=(median(CO2_or(end-100:end,3)*1e+6)-median(CO2_file(end-100:end,3)*1e+6));
  end
 end
end
yy1=spline(SOLp,CO2_1,xxSOL);

AREA=[2.2040e+13,4.0931e+13,1.4168e+13,4.4080e+13,6.9268e+13]
for j=3
		%CO2=[]
        REGION_j=char(REGION(j));
 for k=1:4
     SOL_k=char(SOL(k));
  for l=1
      MODEL_l=char(MODEL(l));
CO2_or=load(['/media/natalia/DATA/Tesis/Cgenie_output/Globales/' MODEL_l '/worjh2.PO4Fe.All.' MODEL_l '.level1/biogem/biogem_series_atm_pCO2.res']);
CO2_file=load(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4Fe' MODEL_l '_LGM_Sol_calculated_Dust_' REGION_j '_x' SOL_k '/biogem/biogem_series_atm_pCO2.res']);
CO2_2(k,1)=(median(CO2_or(end-100:end,3)*1e+6)-median(CO2_file(end-100:end,3)*1e+6))*1e+6/AREA(j);
  end
 end
end
yy2=spline(SOLp,CO2_2,xxSOL);


%%

region={'SA','SP','CP','NP','NA'};
value={'0.3333', '0.6666', '2','3'};

for i=3
   region_i=char(region(i));
      %for j=1:4
           % value_j=char(value(j));
N1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N1=[N1(9:end,:);N1(1:8,:)];
M1=N1<10;
N1(M1==0) = NaN;
N2=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N2=[N2(9:end,:);N2(1:8,:)];
M2=N2<10;
N2(M2==0) = NaN;
lat2=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'lat'); 
lon2=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'lon');
lon2=[lon2(9:end);lon2(1:8)];
lon= wrapTo180(lon2);
[Ym, Xm] = meshgrid(lat2, lon);
pasos = 33;
t1=linspace(0,1,pasos);

%%
N3=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x2/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N3=[N3(9:end,:);N3(1:8,:)];
M3=N3<10;
N3(M3==0) = NaN;
pasos = 33;
t2=linspace(0,1,pasos);


%%
N4=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x3/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N4=[N4(9:end,:);N4(1:8,:)];
M4=N4<10;
N4(M4==0) = NaN;

pasos = 34;
t3=linspace(0,1,pasos);

end

%%
region={'SA','SP','CP','NP','NA'};
value={'0.3333', '0.6666', '2','3'};

for i=3
   region_i=char(region(i));
      %for j=1:4
           % value_j=char(value(j));
N1_1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'bio_export_POC')); 
N1_1=[N1_1(9:end,:);N1_1(1:8,:)];
M1_1=N1_1<10;
N1_1(M1_1==0) = NaN;
N2_1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'bio_export_POC')); 
N2_1=[N2_1(9:end,:);N2_1(1:8,:)];
M2_1=N2_1<10;
N2_1(M2_1==0) = NaN;
lat2_1=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'lat'); 
lon2_1=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'lon');
lon2_1=[lon2(9:end);lon2(1:8)];
lon_1= wrapTo180(lon2);
[Ym_1, Xm_1] = meshgrid(lat2_1, lon_1);
pasos = 33;
t1_1=linspace(0,1,pasos);

N3_1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x2/biogem/fields_biogem_2d.nc'],'bio_export_POC')); 
N3_1=[N3_1(9:end,:);N3_1(1:8,:)];
M3_1=N3_1<10;
N3_1(M3_1==0) = NaN;
pasos = 33;
t2_1=linspace(0,1,pasos);

N4_1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x3/biogem/fields_biogem_2d.nc'],'bio_export_POC')); 
N4_1=[N4_1(9:end,:);N4_1(1:8,:)];
M4_1=N4_1<10;
N4_1(M4_1==0) = NaN;

pasos = 34;
t3_1=linspace(0,1,pasos);

end


%%
lon=lonlat_edges(:,1)-180;
%CP Esta ok
for j=1:100
    subplot(2,3,1)
Y=[lonlat_edges(17,2),lonlat_edges(21,2)];
X=[lon(2),lon(11)];
Z=linspace(0,60);

XX = [X(1) X(end) X(end) X(1) X(1); X(1) X(1) X(1) X(1) X(1);X(1) X(1) X(end) X(end) 0;X(end) X(end) X(end) X(end) X(end); X(end) X(end) X(1) X(1) X(end)];
YY = [Y(1) Y(1) Y(end) Y(end) Y(1); Y(1) Y(1) Y(end) Y(end) Y(1);Y(1) Y(1) Y(1) Y(1) Y(1); Y(1) Y(1) Y(end) Y(end) Y(1);Y(end) Y(end) Y(end) Y(end) Y(end)];
ZZ = [Z(j) Z(j) Z(j) Z(j) Z(j); Z(1) Z(j) Z(j) Z(1) Z(1); Z(1) Z(j) Z(j) Z(1) Z(1);(1) Z(j) Z(j) Z(1) Z(1);Z(1) Z(j) Z(j) Z(1) Z(1)];
B5=fill3(XX',YY',ZZ','g','FaceAlpha',.3);
hold on
subplot(2,3,4)
Li=plot(xxSOL(1:j),yy(1:j),'g');
   ylim([230 265])
   xlim([0 3.5])
   title('pCO2 v/s Iron solubility scale')
   xlabel('Iron solubility scale')
   ylabel('Atmospheric CO2 [ppm]')
subplot(2,3,5)   
Li_1=plot(xxSOL(1:j),yy1(1:j),'g');
   ylim([25 40])
   xlim([0 3.5])
      title('pCO2 difference v/s Iron solubility scale')
   xlabel('Iron solubility scale')
   ylabel('Atmospheric CO2 [ppm]')
subplot(2,3,6)
Li_2=plot(xxSOL(1:j),yy2(1:j),'g');
   ylim([0 0.3e-5])
   xlim([0 3.5])
      title('pCO2 difference per m2 v/s Iron solubility scale')
   xlabel('Iron solubility scale')
   ylabel('Atmospheric CO2 [ppm/m2]')
subplot(2,3,2)
%%
if 1<= j && j <=33
    N=(t1(j)*N2+(1-t1(j))*N1);
elseif 34<= j && j <=66

    N=(t2(j-33)*N3+(1-t2(j-33))*N2); 
else 
      N=(t3(j-66)*N4+(1-t3(j-66))*N3);
 end 
%geoshow('landareas.shp', 'FaceColor', 'black');
%hold on
[c1,h1]=contourf(Xm,Ym,N);
Colorbar=colorbar('southoutside')
set(get(Colorbar,'title'),'string','Solulablized aeolian iron flux density to surface [umol Fe m-2 yr-1]');
ylabel('Latitude','FontWeight','bold','FontSize',16);
xlabel('Longitude','FontWeight','bold','FontSize',16);
subplot(2,3,3)
if 1<= j && j <=33
    N_1=(t1_1(j)*N2_1+(1-t1_1(j))*N1_1);
elseif 34<= j && j <=66

    N_1=(t2_1(j-33)*N3_1+(1-t2_1(j-33))*N2_1); 
else 
      N_1=(t3_1(j-66)*N4_1+(1-t3_1(j-66))*N3_1);
end 
%geoshow('landareas.shp', 'FaceColor', 'black');
%hold on
[c2,h2]=contourf(Xm_1,Ym_1,N_1);
Colorbar=colorbar('southoutside')
set(get(Colorbar,'title'),'string','Biological export - POC [mol m-2 yr-1]');
ylabel('Latitude','FontWeight','bold','FontSize',16);
xlabel('Longitude','FontWeight','bold','FontSize',16);
pause(0.1)
delete(B5)
delete(Li)
delete(Li_1)
delete(Li_2)
delete(h1)
delete(h2)
end
subplot(2,3,4)
plot(xxSOL(1:j),yy(1:j),'g');
hold on
subplot(2,3,5)
plot(xxSOL(1:j),yy1(1:j),'g');
hold on
subplot(2,3,6)
plot(xxSOL(1:j),yy2(1:j),'g');
hold on



%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
MODEL={'Lambert'}
%TIME={'H', 'LGM'}
REGION={'SA', 'SP', 'CP', 'NP', 'NA'}
SOL={'0.3333', '0.6666','2','3'}
SOLp=[0.3333,0.6666,2,3];
xxSOL=linspace(0.3333,3,100)

for j=4
		%CO2=[]
        REGION_j=char(REGION(j));
 for k=1:4
     SOL_k=char(SOL(k));
  for l=1
      MODEL_l=char(MODEL(l));
CO2_file=load(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4Fe' MODEL_l '_LGM_Sol_calculated_Dust_' REGION_j '_x' SOL_k '/biogem/biogem_series_atm_pCO2.res']);
CO2(k,1)=(median(CO2_file(end-100:end,3)*1e+6));
  
  end
 end
end

yy=spline(SOLp,CO2,xxSOL);


for j=4
		%CO2=[]
        REGION_j=char(REGION(j));
 for k=1:4
     SOL_k=char(SOL(k));
  for l=1
      MODEL_l=char(MODEL(l));
CO2_or=load(['/media/natalia/DATA/Tesis/Cgenie_output/Globales/' MODEL_l '/worjh2.PO4Fe.All.' MODEL_l '.level1/biogem/biogem_series_atm_pCO2.res']);
CO2_file=load(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4Fe' MODEL_l '_LGM_Sol_calculated_Dust_' REGION_j '_x' SOL_k '/biogem/biogem_series_atm_pCO2.res']);
CO2_1(k,1)=(median(CO2_or(end-100:end,3)*1e+6)-median(CO2_file(end-100:end,3)*1e+6));
  end
 end
end
yy1=spline(SOLp,CO2_1,xxSOL);

AREA=[2.2040e+13,4.0931e+13,1.4168e+13,4.4080e+13,6.9268e+13]
for j=4
		%CO2=[]
        REGION_j=char(REGION(j));
 for k=1:4
     SOL_k=char(SOL(k));
  for l=1
      MODEL_l=char(MODEL(l));
CO2_or=load(['/media/natalia/DATA/Tesis/Cgenie_output/Globales/' MODEL_l '/worjh2.PO4Fe.All.' MODEL_l '.level1/biogem/biogem_series_atm_pCO2.res']);
CO2_file=load(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4Fe' MODEL_l '_LGM_Sol_calculated_Dust_' REGION_j '_x' SOL_k '/biogem/biogem_series_atm_pCO2.res']);
CO2_2(k,1)=(median(CO2_or(end-100:end,3)*1e+6)-median(CO2_file(end-100:end,3)*1e+6))*1e+6/AREA(j);
  end
 end
end
yy2=spline(SOLp,CO2_2,xxSOL);


%%

region={'SA','SP','CP','NP','NA'};
value={'0.3333', '0.6666', '2','3'};

for i=4
   region_i=char(region(i));
      %for j=1:4
           % value_j=char(value(j));
N1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N1=[N1(9:end,:);N1(1:8,:)];
M1=N1<10;
N1(M1==0) = NaN;
N2=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N2=[N2(9:end,:);N2(1:8,:)];
M2=N2<10;
N2(M2==0) = NaN;
lat2=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'lat'); 
lon2=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'lon');
lon2=[lon2(9:end);lon2(1:8)];
lon= wrapTo180(lon2);
[Ym, Xm] = meshgrid(lat2, lon);
pasos = 33;
t1=linspace(0,1,pasos);

%%
N3=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x2/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N3=[N3(9:end,:);N3(1:8,:)];
M3=N3<10;
N3(M3==0) = NaN;
pasos = 33;
t2=linspace(0,1,pasos);


%%
N4=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x3/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N4=[N4(9:end,:);N4(1:8,:)];
M4=N4<10;
N4(M4==0) = NaN;

pasos = 34;
t3=linspace(0,1,pasos);

end

%%
region={'SA','SP','CP','NP','NA'};
value={'0.3333', '0.6666', '2','3'};

for i=4
   region_i=char(region(i));
      %for j=1:4
           % value_j=char(value(j));
N1_1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'bio_export_POC')); 
N1_1=[N1_1(9:end,:);N1_1(1:8,:)];
M1_1=N1_1<10;
N1_1(M1_1==0) = NaN;
N2_1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'bio_export_POC')); 
N2_1=[N2_1(9:end,:);N2_1(1:8,:)];
M2_1=N2_1<10;
N2_1(M2_1==0) = NaN;
lat2_1=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'lat'); 
lon2_1=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'lon');
lon2_1=[lon2(9:end);lon2(1:8)];
lon_1= wrapTo180(lon2);
[Ym_1, Xm_1] = meshgrid(lat2_1, lon_1);
pasos = 33;
t1_1=linspace(0,1,pasos);

N3_1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x2/biogem/fields_biogem_2d.nc'],'bio_export_POC')); 
N3_1=[N3_1(9:end,:);N3_1(1:8,:)];
M3_1=N3_1<10;
N3_1(M3_1==0) = NaN;
pasos = 33;
t2_1=linspace(0,1,pasos);

N4_1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x3/biogem/fields_biogem_2d.nc'],'bio_export_POC')); 
N4_1=[N4_1(9:end,:);N4_1(1:8,:)];
M4_1=N4_1<10;
N4_1(M4_1==0) = NaN;

pasos = 34;
t3_1=linspace(0,1,pasos);

end

%%
lon=lonlat_edges(:,1)-180;

%NP
for j=1:100
    subplot(2,3,1)
Y=[lonlat_edges(29,2),lonlat_edges(37,2)];
X1=[lon(1), lon(8)];X2=[lon(31) lon(37)];
Z=linspace(0,60);

XX1 = [X1(1) X1(end) X1(end) X1(1) X1(1); X1(1) X1(1) X1(1) X1(1) X1(1);X1(1) X1(1) X1(end) X1(end) X1(1);X1(end) X1(end) X1(end) X1(end) X1(end); X1(end) X1(end) X1(1) X1(1) X1(end)];
XX2 = [X2(1) X2(end) X2(end) X2(1) X2(1); X2(1) X2(1) X2(1) X2(1) X2(1);X2(1) X2(1) X2(end) X2(end) X2(1);X2(end) X2(end) X2(end) X2(end) X2(end); X2(end) X2(end) X2(1) X2(1) X2(end)];
YY = [Y(1) Y(1) Y(end) Y(end) Y(1); Y(1) Y(1) Y(end) Y(end) Y(1);Y(1) Y(1) Y(1) Y(1) Y(1); Y(1) Y(1) Y(end) Y(end) Y(1);Y(end) Y(end) Y(end) Y(end) Y(end)];
ZZ = [Z(j) Z(j) Z(j) Z(j) Z(j); Z(1) Z(j) Z(j) Z(1) Z(1); Z(1) Z(j) Z(j) Z(1) Z(1);(1) Z(j) Z(j) Z(1) Z(1);Z(1) Z(j) Z(j) Z(1) Z(1)];
B3=fill3(XX1',YY',ZZ','m','FaceAlpha',.3);
B33=fill3(XX2',YY',ZZ','m','FaceAlpha',.3);
hold on
subplot(2,3,4)
Li=plot(xxSOL(1:j),yy(1:j),'m');
   ylim([230 265])
   xlim([0 3.5])
   title('pCO2 v/s Iron solubility scale')
   xlabel('Iron solubility scale')
   ylabel('Atmospheric CO2 [ppm]')
subplot(2,3,5)   
Li_1=plot(xxSOL(1:j),yy1(1:j),'m');
   ylim([25 40])
   xlim([0 3.5])
      title('pCO2 difference v/s Iron solubility scale')
   xlabel('Iron solubility scale')
   ylabel('Atmospheric CO2 [ppm]')
subplot(2,3,6)
Li_2=plot(xxSOL(1:j),yy2(1:j),'m');
   ylim([0 0.3e-5])
   xlim([0 3.5])
      title('pCO2 difference per m2 v/s Iron solubility scale')
   xlabel('Iron solubility scale')
   ylabel('Atmospheric CO2 [ppm/m2]')
subplot(2,3,2)
%%
if 1<= j && j <=33
    N=(t1(j)*N2+(1-t1(j))*N1);
elseif 34<= j && j <=66

    N=(t2(j-33)*N3+(1-t2(j-33))*N2); 
else 
      N=(t3(j-66)*N4+(1-t3(j-66))*N3);
 end 
%geoshow('landareas.shp', 'FaceColor', 'black');
%hold on
[c1,h1]=contourf(Xm,Ym,N);
Colorbar=colorbar('southoutside')
set(get(Colorbar,'title'),'string','Solulablized aeolian iron flux density to surface [umol Fe m-2 yr-1]');
ylabel('Latitude','FontWeight','bold','FontSize',16);
xlabel('Longitude','FontWeight','bold','FontSize',16);
subplot(2,3,3)
if 1<= j && j <=33
    N_1=(t1_1(j)*N2_1+(1-t1_1(j))*N1_1);
elseif 34<= j && j <=66

    N_1=(t2_1(j-33)*N3_1+(1-t2_1(j-33))*N2_1); 
else 
      N_1=(t3_1(j-66)*N4_1+(1-t3_1(j-66))*N3_1);
end 
%geoshow('landareas.shp', 'FaceColor', 'black');
%hold on
[c2,h2]=contourf(Xm_1,Ym_1,N_1);
Colorbar=colorbar('southoutside')
set(get(Colorbar,'title'),'string','Biological export - POC [mol m-2 yr-1]');
ylabel('Latitude','FontWeight','bold','FontSize',16);
xlabel('Longitude','FontWeight','bold','FontSize',16);
pause(0.1)
delete(B3)
delete(B33)
delete(Li)
delete(Li_1)
delete(Li_2)
delete(h1)
delete(h2)
end
subplot(2,3,4)
plot(xxSOL(1:j),yy(1:j),'m');
hold on
subplot(2,3,5)
plot(xxSOL(1:j),yy1(1:j),'m');
hold on
subplot(2,3,6)
plot(xxSOL(1:j),yy2(1:j),'m');
hold on


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
MODEL={'Lambert'}
%TIME={'H', 'LGM'}
REGION={'SA', 'SP', 'CP', 'NP', 'NA'}
SOL={'0.3333', '0.6666','2','3'}
SOLp=[0.3333,0.6666,2,3];
xxSOL=linspace(0.3333,3,100)

for j=5
		%CO2=[]
        REGION_j=char(REGION(j));
 for k=1:4
     SOL_k=char(SOL(k));
  for l=1
      MODEL_l=char(MODEL(l));
CO2_file=load(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4Fe' MODEL_l '_LGM_Sol_calculated_Dust_' REGION_j '_x' SOL_k '/biogem/biogem_series_atm_pCO2.res']);
CO2(k,1)=(median(CO2_file(end-100:end,3)*1e+6));
  
  end
 end
end

yy=spline(SOLp,CO2,xxSOL);


for j=5
		%CO2=[]
        REGION_j=char(REGION(j));
 for k=1:4
     SOL_k=char(SOL(k));
  for l=1
      MODEL_l=char(MODEL(l));
CO2_or=load(['/media/natalia/DATA/Tesis/Cgenie_output/Globales/' MODEL_l '/worjh2.PO4Fe.All.' MODEL_l '.level1/biogem/biogem_series_atm_pCO2.res']);
CO2_file=load(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4Fe' MODEL_l '_LGM_Sol_calculated_Dust_' REGION_j '_x' SOL_k '/biogem/biogem_series_atm_pCO2.res']);
CO2_1(k,1)=(median(CO2_or(end-100:end,3)*1e+6)-median(CO2_file(end-100:end,3)*1e+6));
  end
 end
end
yy1=spline(SOLp,CO2_1,xxSOL);

AREA=[2.2040e+13,4.0931e+13,1.4168e+13,4.4080e+13,6.9268e+13]
for j=5
		%CO2=[]
        REGION_j=char(REGION(j));
 for k=1:4
     SOL_k=char(SOL(k));
  for l=1
      MODEL_l=char(MODEL(l));
CO2_or=load(['/media/natalia/DATA/Tesis/Cgenie_output/Globales/' MODEL_l '/worjh2.PO4Fe.All.' MODEL_l '.level1/biogem/biogem_series_atm_pCO2.res']);
CO2_file=load(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4Fe' MODEL_l '_LGM_Sol_calculated_Dust_' REGION_j '_x' SOL_k '/biogem/biogem_series_atm_pCO2.res']);
CO2_2(k,1)=(median(CO2_or(end-100:end,3)*1e+6)-median(CO2_file(end-100:end,3)*1e+6))*1e+6/AREA(j);
  end
 end
end
yy2=spline(SOLp,CO2_2,xxSOL);


%%

region={'SA','SP','CP','NP','NA'};
value={'0.3333', '0.6666', '2','3'};

for i=5
   region_i=char(region(i));
      %for j=1:4
           % value_j=char(value(j));
N1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N1=[N1(9:end,:);N1(1:8,:)];
M1=N1<10;
N1(M1==0) = NaN;
N2=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N2=[N2(9:end,:);N2(1:8,:)];
M2=N2<10;
N2(M2==0) = NaN;
lat2=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'lat'); 
lon2=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'lon');
lon2=[lon2(9:end);lon2(1:8)];
lon= wrapTo180(lon2);
[Ym, Xm] = meshgrid(lat2, lon);
pasos = 33;
t1=linspace(0,1,pasos);

%%
N3=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x2/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N3=[N3(9:end,:);N3(1:8,:)];
M3=N3<10;
N3(M3==0) = NaN;
pasos = 33;
t2=linspace(0,1,pasos);


%%
N4=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x3/biogem/fields_biogem_2d.nc'],'misc_sur_fFe_mol')); 
N4=[N4(9:end,:);N4(1:8,:)];
M4=N4<10;
N4(M4==0) = NaN;

pasos = 34;
t3=linspace(0,1,pasos);

end

%%
region={'SA','SP','CP','NP','NA'};
value={'0.3333', '0.6666', '2','3'};

for i=5
   region_i=char(region(i));
      %for j=1:4
           % value_j=char(value(j));
N1_1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'bio_export_POC')); 
N1_1=[N1_1(9:end,:);N1_1(1:8,:)];
M1_1=N1_1<10;
N1_1(M1_1==0) = NaN;
N2_1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'bio_export_POC')); 
N2_1=[N2_1(9:end,:);N2_1(1:8,:)];
M2_1=N2_1<10;
N2_1(M2_1==0) = NaN;
lat2_1=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.3333/biogem/fields_biogem_2d.nc'],'lat'); 
lon2_1=ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x0.6666/biogem/fields_biogem_2d.nc'],'lon');
lon2_1=[lon2(9:end);lon2(1:8)];
lon_1= wrapTo180(lon2);
[Ym_1, Xm_1] = meshgrid(lat2_1, lon_1);
pasos = 33;
t1_1=linspace(0,1,pasos);

N3_1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x2/biogem/fields_biogem_2d.nc'],'bio_export_POC')); 
N3_1=[N3_1(9:end,:);N3_1(1:8,:)];
M3_1=N3_1<10;
N3_1(M3_1==0) = NaN;
pasos = 33;
t2_1=linspace(0,1,pasos);

N4_1=log(ncread(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4FeAlbani_LGM_Sol_calculated_Dust_' region_i '_x3/biogem/fields_biogem_2d.nc'],'bio_export_POC')); 
N4_1=[N4_1(9:end,:);N4_1(1:8,:)];
M4_1=N4_1<10;
N4_1(M4_1==0) = NaN;

pasos = 34;
t3_1=linspace(0,1,pasos);

end

%%
lon=lonlat_edges(:,1)-180;

%%
%NA
for j=1:100
    subplot(2,3,1)
Y=[lonlat_edges(29,2),lonlat_edges(37,2)];
X=[lon(11),lon(18)];
Z=linspace(0,60);

XX = [X(1) X(end) X(end) X(1) X(1); X(1) X(1) X(1) X(1) X(1);X(1) X(1) X(end) X(end) 0;X(end) X(end) X(end) X(end) X(end); X(end) X(end) X(1) X(1) X(end)];
YY = [Y(1) Y(1) Y(end) Y(end) Y(1); Y(1) Y(1) Y(end) Y(end) Y(1);Y(1) Y(1) Y(1) Y(1) Y(1); Y(1) Y(1) Y(end) Y(end) Y(1);Y(end) Y(end) Y(end) Y(end) Y(end)];
ZZ = [Z(j) Z(j) Z(j) Z(j) Z(j); Z(1) Z(j) Z(j) Z(1) Z(1); Z(1) Z(j) Z(j) Z(1) Z(1);(1) Z(j) Z(j) Z(1) Z(1);Z(1) Z(j) Z(j) Z(1) Z(1)];
B4=fill3(XX',YY',ZZ','y','FaceAlpha',.3);
hold on
subplot(2,3,4)
Li=plot(xxSOL(1:j),yy(1:j),'y');
   ylim([230 265])
   xlim([0 3.5])
   title('pCO2 v/s Iron solubility scale')
   xlabel('Iron solubility scale')
   ylabel('Atmospheric CO2 [ppm]')
subplot(2,3,5)   
Li_1=plot(xxSOL(1:j),yy1(1:j),'y');
   ylim([25 40])
   xlim([0 3.5])
      title('pCO2 difference v/s Iron solubility scale')
   xlabel('Iron solubility scale')
   ylabel('Atmospheric CO2 [ppm]')
subplot(2,3,6)
Li_2=plot(xxSOL(1:j),yy2(1:j),'y');
   ylim([0 0.3e-5])
   xlim([0 3.5])
      title('pCO2 difference per m2 v/s Iron solubility scale')
   xlabel('Iron solubility scale')
   ylabel('Atmospheric CO2 [ppm/m2]')
subplot(2,3,2)
%%
if 1<= j && j <=33
    N=(t1(j)*N2+(1-t1(j))*N1);
elseif 34<= j && j <=66

    N=(t2(j-33)*N3+(1-t2(j-33))*N2); 
else 
      N=(t3(j-66)*N4+(1-t3(j-66))*N3);
 end 
%geoshow('landareas.shp', 'FaceColor', 'black');
%hold on
[c1,h1]=contourf(Xm,Ym,N);
Colorbar=colorbar('southoutside')
set(get(Colorbar,'title'),'string','Solulablized aeolian iron flux density to surface [umol Fe m-2 yr-1]');
ylabel('Latitude','FontWeight','bold','FontSize',16);
xlabel('Longitude','FontWeight','bold','FontSize',16);
subplot(2,3,3)
if 1<= j && j <=33
    N_1=(t1_1(j)*N2_1+(1-t1_1(j))*N1_1);
elseif 34<= j && j <=66

    N_1=(t2_1(j-33)*N3_1+(1-t2_1(j-33))*N2_1); 
else 
      N_1=(t3_1(j-66)*N4_1+(1-t3_1(j-66))*N3_1);
end 
%geoshow('landareas.shp', 'FaceColor', 'black');
%hold on
[c2,h2]=contourf(Xm_1,Ym_1,N_1);
Colorbar=colorbar('southoutside')
set(get(Colorbar,'title'),'string','Biological export - POC [mol m-2 yr-1]');
ylabel('Latitude','FontWeight','bold','FontSize',16);
xlabel('Longitude','FontWeight','bold','FontSize',16);
pause(0.1)
delete(B4)
delete(Li)
delete(Li_1)
delete(Li_2)
delete(h1)
delete(h2)
end
subplot(2,3,4)
plot(xxSOL(1:j),yy(1:j),'y');
subplot(2,3,5)
plot(xxSOL(1:j),yy1(1:j),'y');
subplot(2,3,6)
plot(xxSOL(1:j),yy2(1:j),'y');

subplot(2,3,2)
geoshow('landareas.shp', 'FaceColor', 'black');
hold on
[c,h]=contourf(Xm,Ym,N);
set(get(Colorbar,'title'),'string','Solulablized aeolian iron flux density to surface [umol Fe m-2 yr-1]');
ylabel('Latitude','FontWeight','bold','FontSize',16);
xlabel('Longitude','FontWeight','bold','FontSize',16);

subplot(2,3,3)
geoshow('landareas.shp', 'FaceColor', 'black');
hold on
[c2,h2]=contourf(Xm_1,Ym_1,N_1);
Colorbar=colorbar('southoutside')
set(get(Colorbar,'title'),'string','Solulablized aeolian iron flux density to surface [mol m-2 yr-1]');
ylabel('Latitude','FontWeight','bold','FontSize',16);
xlabel('Longitude','FontWeight','bold','FontSize',16);






