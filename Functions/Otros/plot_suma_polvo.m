%Kgxs
AH=sum(Albani'.*area_total');
ALGM=sum(Albani1'.*area_total');
LH=sum(LambertH'.*area_total');
LLGM=sum(Lambert1'.*area_total');
TH=sum(TakemuraH'.*area_total');
TLGM=sum(Takemura1'.*area_total');
OH=sum(OhgaitoH'.*area_total');
OLGM=sum(Ohgaito1'.*area_total');
MIH=sum(MIROCESMH'.*area_total');
MILGM=sum(MIROCESM1'.*area_total');
MRH=sum(MRICGCM3H'.*area_total');
MRLGM=sum(MRICGCM1'.*area_total');

f = figure;
f.Position = [100 100 900 500];
hold on
plot(flipud(dum_lat'),AH,'Linewidth',1.5)
plot(flipud(dum_lat'),LH,'Linewidth',1.5)
plot(flipud(dum_lat'),TH,'Linewidth',1.5)
plot(flipud(dum_lat'),OH,'Linewidth',1.5)
plot(flipud(dum_lat'),MIH,'Linewidth',1.5)
plot(flipud(dum_lat'),MRH,'Linewidth',1.5)
legend('Albani','Lambert','Takemura','Ohgaito','MIROC-ESM','MRI-CGCM3','Location','northwest')
set(gca,'FontSize',18)
hold off
xlabel('Latitude','FontSize',24) 
ylabel('Total Dust [kg s-1]','FontSize',24) 

f = figure;
f.Position = [100 100 900 500];
hold on
set(gca,'FontSize',18)
plot(flipud(dum_lat'),ALGM,'Linewidth',1.5)
plot(flipud(dum_lat'),LLGM,'Linewidth',1.5)
plot(flipud(dum_lat'),TLGM,'Linewidth',1.5)
plot(flipud(dum_lat'),OLGM,'Linewidth',1.5)
plot(flipud(dum_lat'),MILGM,'Linewidth',1.5)
plot(flipud(dum_lat'),MRLGM,'Linewidth',1.5)
legend('Albani','Lambert','Takemura','Ohgaito','MIROC-ESM','MRI-CGCM3','Location','northwest')
hold off
xlabel('Latitude','FontSize',24) 
ylabel('Total Dust [kg s-1]','FontSize',24) 
