tic
MODEL={'Ohgaito'}
%TIME={'H', 'LGM'}
REGION={'SA', 'SP', 'CP', 'NP', 'NA'}
SOL={'0.3333', '0.6666','2','3'}
SOLp=[0.3333,0.6666,2,3];
for j=1:5
		%CO2=[]
        REGION_j=char(REGION(j));
        h = animatedline;
 for k=1:4
     SOL_k=char(SOL(k));
  for l=1
      MODEL_l=char(MODEL(l));
CO2_file=load(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4Fe' MODEL_l '_LGM_Sol_calculated_Dust_' REGION_j '_x' SOL_k '/biogem/biogem_series_atm_pCO2.res']);
CO2(k,j)=(median(CO2_file(end-100:end,3)*1e+6));
  end
 end
end

figure
color=['g','r','c','y','b'];
for j=1:5
    color_j=char(color(j));
h = animatedline('Color',[color_j]);
%a1 = animatedline('Color',[0 .7 .7]);
x=linspace(0.3,3);
y = linspace(min(CO2(:,j)),max(CO2(:,j)));
for k = 1:length(x)
    addpoints(h,x(k),y(k));
    drawnow
   pause(0.05)
   ylim([225 250])
   xlim([0 3.5])
end
hold on
end


for j=1:5
		%CO2=[]
        REGION_j=char(REGION(j));
 for k=1:4
     SOL_k=char(SOL(k));
  for l=1
      MODEL_l=char(MODEL(l));
CO2_or=load(['/media/natalia/DATA/Tesis/Cgenie_output/Globales/' MODEL_l '/worjh2.PO4Fe.All.' MODEL_l '.level1/biogem/biogem_series_atm_pCO2.res']);
CO2_file=load(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4Fe' MODEL_l '_LGM_Sol_calculated_Dust_' REGION_j '_x' SOL_k '/biogem/biogem_series_atm_pCO2.res']);
CO2(k,j)=(median(CO2_or(end-100:end,3)*1e+6)-median(CO2_file(end-100:end,3)*1e+6));
  end
 end
end

figure
color=['g','r','c','y','b']
for j=1:5
    color_j=char(color(j));
h = animatedline('Color',[color_j]);
x=linspace(0.3,3);
y = linspace(min(CO2(:,j)),max(CO2(:,j)));
for k = 1:length(x)
    addpoints(h,x(k),y(k));
    drawnow
   pause(0.05)
   ylim([30 55])
   xlim([0 3.5])
end
hold on
end

AREA=[2.2040e+13,4.0931e+13,1.4168e+13,4.4080e+13,6.9268e+13]
for j=1:5
		%CO2=[]
        REGION_j=char(REGION(j));
 for k=1:4
     SOL_k=char(SOL(k));
  for l=1
      MODEL_l=char(MODEL(l));
CO2_or=load(['/media/natalia/DATA/Tesis/Cgenie_output/Globales/' MODEL_l '/worjh2.PO4Fe.All.' MODEL_l '.level1/biogem/biogem_series_atm_pCO2.res']);
CO2_file=load(['/media/natalia/DATA/Documentos/TesisI/cgenie/cgenie_output/worjh2.PO4Fe' MODEL_l '_LGM_Sol_calculated_Dust_' REGION_j '_x' SOL_k '/biogem/biogem_series_atm_pCO2.res']);
CO2(k,j)=(median(CO2_or(end-100:end,3)*1e+6)-median(CO2_file(end-100:end,3)*1e+6))*1e+6/AREA(j);
  end
 end
end

%figure
color=['g','r','c','y','b']
for j=1:5
    color_j=char(color(j));
h = animatedline('Color',[color_j]);
x=linspace(0.3,3);
y = linspace(min(CO2(:,j)),max(CO2(:,j)));
for k = 1:length(x)
    addpoints(h,x(k),y(k));
    drawnow
   pause(0.05)
   ylim([0 0.3e-5])
   xlim([0 3.5])
end
hold on
end
toc