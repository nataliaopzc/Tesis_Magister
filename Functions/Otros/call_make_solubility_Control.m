modelo={'Lambert','Albani','Takemura','Ohgaito','MIROC-ESM','MRI-CGCM3'};
value={'0.3333', '0.6666','1', '2','3'};
    for i=1:6
        modelo_i=char(modelo(i));
        for j=1:5
            value_j=char(value(j));
[ Solub ] = make_solubility_Control(modelo_i,value_j);
        end
    end
