models={'Albani' 'Lambert' 'Takemura' 'MIROC-ESM' 'MRI-CGCM3'};
region={'SA' 'SP' 'NP' 'CP'};
for i=1:4;
    regiones=char(region(i));
    figure
    set(gcf,'position',[200*i 500 1000 500])
    set(gcf,'PaperPosition',[0 0 1150/100 500/100]);
    for j=1:5;
         modelos=char(models(j));
[dCO2,Dust] = fig2_suma(regiones,modelos);
y=dCO2;
x=Dust;
M=[ones(10,1) 1./x log(x)];
b=M\y;
xx=linspace(min(x),max(x));
yy=b(1)+b(2)./xx+b(3)*log(xx);
XX=(xx-min(xx))./(max(xx)-min(xx));
Dust=(Dust-min(Dust))./(max(Dust)-min(Dust));
hold on
scatter(Dust,dCO2,'filled')
plot(XX,yy,'-')
    end
    grid on
title([region(i)],'FontSize',30)
xlabel('Normalization Dust Flux','FontSize',24);
ylabel('pCO_2 (ppm) Reduction ','FontSize',24);
leyenda=legend('Albani',...
    '','Lambert',...
   '', 'Takemura',...
   '', 'MIROC-ESM',...
   '','MRI-CGCM3','',...
    'Orientation','horizontal');
set(leyenda,'FontSize',7);
print(gcf,'-dpng','-r100',['/media/naty/Seagate Expansion Drive/Tesis/Figuras/Regionales/' char(region(i)) '.png']) 
    hold off
end
%% Zonas correctas
models={'Albani' 'Lambert' 'Takemura' 'MIROC-ESM' 'MRI-CGCM3'};
region={'SA' 'SP' 'NP' 'CP'};
for i=1:4;
    regiones=char(region(i));
    figure
    set(gcf,'position',[200*i 500 1000 500])
    set(gcf,'PaperPosition',[0 0 1150/100 500/100]);
    if strcmp(regiones,'SA')
        for j=[1 2 5];
         modelos=char(models(j));
[dCO2,Dust] = fig2_suma(regiones,modelos);
y=dCO2;
x=Dust;
M=[ones(10,1) 1./x log(x)];
b=M\y;
xx=linspace(min(x),max(x));
yy=b(1)+b(2)./xx+b(3)*log(xx);
XX=(xx-min(xx))./(max(xx)-min(xx));
Dust=(Dust-min(Dust))./(max(Dust)-min(Dust));
hold on
scatter(Dust,dCO2,'filled')
plot(XX,yy,'-')
leyenda=legend('Albani',...
    '','Lambert',...
   '','MRI-CGCM3','',...
    'Orientation','horizontal');
set(leyenda,'FontSize',7);
        end
 
    elseif strcmp(regiones, 'SP')  
        for j=[1 2 3];
   modelos=char(models(j));
[dCO2,Dust] = fig2_suma(regiones,modelos);
y=dCO2;
x=Dust;
M=[ones(10,1) 1./x log(x)];
b=M\y;
xx=linspace(min(x),max(x));
yy=b(1)+b(2)./xx+b(3)*log(xx);
XX=(xx-min(xx))./(max(xx)-min(xx));
Dust=(Dust-min(Dust))./(max(Dust)-min(Dust));
hold on
scatter(Dust,dCO2,'filled')
plot(XX,yy,'-')       
leyenda=legend('Albani',...
    '','Lambert',...
   '','Takemura','',...
    'Orientation','horizontal');
set(leyenda,'FontSize',7);
        end

    elseif strcmp(regiones, 'NP')
        for j=1:5;
   modelos=char(models(j));
[dCO2,Dust] = fig2_suma(regiones,modelos);
y=dCO2;
x=Dust;
M=[ones(10,1) 1./x log(x)];
b=M\y;
xx=linspace(min(x),max(x));
yy=b(1)+b(2)./xx+b(3)*log(xx);
XX=(xx-min(xx))./(max(xx)-min(xx));
Dust=(Dust-min(Dust))./(max(Dust)-min(Dust));
hold on
scatter(Dust,dCO2,'filled')
plot(XX,yy,'-')
leyenda=legend('Albani',...
    '','Lambert',...
   '', 'Takemura',...
   '', 'MIROC-ESM',...
   '','MRI-CGCM3','',...
    'Orientation','horizontal');
set(leyenda,'FontSize',7);
        end
    else 
        for j=2:5;
         modelos=char(models(j));
[dCO2,Dust] = fig2_suma(regiones,modelos);
y=dCO2;
x=Dust;
M=[ones(10,1) 1./x log(x)];
b=M\y;
xx=linspace(min(x),max(x));
yy=b(1)+b(2)./xx+b(3)*log(xx);
XX=(xx-min(xx))./(max(xx)-min(xx));
Dust=(Dust-min(Dust))./(max(Dust)-min(Dust));
hold on
scatter(Dust,dCO2,'filled')
plot(XX,yy,'-')
        leyenda=legend('Lambert',...
   '', 'Takemura',...
   '', 'MIROC-ESM',...
   '','MRI-CGCM3','',...
    'Orientation','horizontal');
set(leyenda,'FontSize',7);
        end
    end
 grid on
title([region(i)],'FontSize',30)
xlabel('Normalization Dust Flux','FontSize',24);
ylabel('pCO_2 (ppm) Reduction ','FontSize',24);
print(gcf,'-dpng','-r100',['/media/naty/Seagate Expansion Drive/Tesis/Figuras/Regionales/' char(region(i)) 'select.png']) 
    hold off
end
        










