Dir='/media/naty/Seagate Expansion Drive/Tesis/';

modelos={'Lambert', 'Albani', 'Takemura', 'MIROC-ESM','MRI-CGCM3'};
regiones={'SA', 'SP', 'NP', 'CP'};

Dust=[];
for i=1:5;
    modelo=char(modelos(i));
for j=1:4;
    region=char(regiones(j));
    Dust(j,i)=Razon(region,modelo);
end
end
Lambert=Dust(:,1);
Albani=Dust(:,2);
Takemura=Dust(:,3);
MIROC_ESM=Dust(:,4);
MRI_CGCM3=Dust(:,5);
T=table(Lambert,Albani,Takemura,MIROC_ESM,MRI_CGCM3);
writetable(T,fullfile(Dir,'Excel',['Datos_razones2.dat']),'Delimiter','\t');    


    

    