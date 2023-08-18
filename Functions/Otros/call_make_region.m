region={'NA','NP','CP','SP','SA'};
modelo={'Lambert','Albani','Takemura','Ohgaito','MIROC-ESM','MRI-CGCM3'};
for i=1:5
    region_i=char(region(i));
    for j=1:6
        modelo_j=char(modelo(j));
[ OUTPUT ] = make_solubility(region_i,modelo_j);

    end
end
