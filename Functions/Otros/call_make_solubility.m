region={'NA','NP','CP','SP','SA'};
modelo={'Lambert','Albani','Takemura','Ohgaito','MIROC-ESM','MRI-CGCM3'};
value={'0.3333', '0.6666', '2','3'};
for i=1:5
    region_i=char(region(i));
    for j=1:6
        modelo_j=char(modelo(j));
        for k=1:4
            value_k=char(value(k));
[ OUTPUT ] = make_solubility(region_i,modelo_j,value_k);
        end
    end
end
