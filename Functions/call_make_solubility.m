region=["NA","NP","CP","SP","SA"]
modelo=["Lambert","Albani","Takemura","Ohgaito","MIROC-ESM","MRI-CGCM3"]

for i=1:6;
    for j=1:5;
[ OUTPUT ] = make_solubility(region,modelo,value)
    end
end
