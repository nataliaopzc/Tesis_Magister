userdir='/home/natalia/Documentos/DATA/TesisI/';

TIME={'LGM','H'};
REGION={'NA', 'NP','CP', 'SP', 'SA'};
MODEL={'Albani','Lambert','Takemura','Ohgaito','MIROC-ESM','MRI-CGCM3'};
SOL={'0.3333', '0.6666','2','3'};


OUTPUTFF=[];
for i=1:length(TIME)
    TIME_i=char(TIME(i));
    for j=1:length(REGION)
        REGION_j=char(REGION(j));
        for l=1:length(MODEL)
            MODEL_l=char(MODEL(l));
            for k=1:length(SOL)
                  SOL_k=char(SOL(k));
OUTPUT=rot90(ncread(fullfile(userdir,'cgenie', 'cgenie_output','Regional/',[MODEL_l,'/worjh2.PO4Fe' MODEL_l '_' TIME_i '_Sol_calculated_Dust_' REGION_j '_x' SOL_k '/biogem/fields_biogem_2d.nc']),'misc_sur_fFe_mol'));
  [x,y]=find(OUTPUT>= 1e+36);
  for s=1:length(x);
      OUTPUT(x(s),y(s))=nan;
  end

if strcmp(REGION_j,'SA')
    SA1 = median(nanmedian(OUTPUT(29:36,20:36))); 
    SA2= median(nanmedian(OUTPUT(29:36,1:5)));
    SA=[SA1,SA2];OUTPUTF=median(SA);
elseif strcmp(REGION_j,'SP')
    
    OUTPUTF =median(nanmedian(OUTPUT(29:36,6:19)));
elseif strcmp(REGION_j,'NP')
    
    OUTPUTF = median(nanmedian(OUTPUT(1:8,3:15)));
elseif strcmp(REGION_j,'NA')
    
    OUTPUTF = median(nanmedian(OUTPUT(1:8,20:25)));
elseif strcmp(REGION_j,'CP')
    
    OUTPUTF = median(nanmedian(OUTPUT(17:20,10:18)));
else
    error('valid entries for region are ''SA'' or ''SP''.');
end
OUTPUTFF=[OUTPUTFF,OUTPUTF];
            end
        end
    end
end
OUT1=OUTPUTFF(1:120);
OUT2=OUTPUTFF(121:240);
OUTp(:,:,1)=OUT1;
OUTp(:,:,2)=OUT2;
OUTPUT1=[OUTPUTFF(1:24);OUTPUTFF(25:48);OUTPUTFF(49:72);OUTPUTFF(73:96);OUTPUTFF(97:120);OUTPUTFF(121:144);OUTPUTFF(145:168);OUTPUTFF(169:192);OUTPUTFF(193:216);OUTPUTFF(217:240)];
OUTPUT11=OUTPUT1(1:5,:);
OUTPUT21=OUTPUT1(6:10,:);
OUT(:,:,1)=OUTPUT11;
OUT(:,:,2)=OUTPUT21;

save('DissolvedIron.mat','OUT')
