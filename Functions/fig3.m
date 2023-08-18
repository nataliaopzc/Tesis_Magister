function [] = fig3(Region)

Dir='/home/natalia/Documentos/Tesis';

if strcmp(Region,'All')
    
All(:,1)=dlmread(fullfile(Dir,'Figuras','Globales','Albani','Fig2_All.dat'),'',[1 1 10 1]);
All(:,2)=dlmread(fullfile(Dir,'Figuras','Globales','Lambert','Fig2_All.dat'),'',[1 1 10 1]);
All(:,3)=dlmread(fullfile(Dir,'Figuras','Globales','Takemura','Fig2_All.dat'),'',[1 1 10 1]);
All(:,4)=dlmread(fullfile(Dir,'Figuras','Globales','MIROC-ESM','Fig2_All.dat'),'',[1 1 10 1]);
All(:,5)=dlmread(fullfile(Dir,'Figuras','Globales','MRI-CGCM3','Fig2_All.dat'),'',[1 1 10 1]);

for i=1:5;
    Pon(:,i)=(All(:,i)/All(10,i))*100;
end

elseif strcmp(Region,'SA')

HNLC(:,1)=dlmread(fullfile(Dir,'Figuras','Regionales','Albani',['Fig2_' Region '.dat']),'',[1 1 10 1]);
HNLC(:,2)=dlmread(fullfile(Dir,'Figuras','Regionales','Lambert',['Fig2_' Region '.dat']),'',[1 1 10 1]);
HNLC(:,3)=dlmread(fullfile(Dir,'Figuras','Regionales','MRI-CGCM3',['Fig2_' Region '.dat']),'',[1 1 10 1]);

for i=1:3;
    Pon(:,i)=(HNLC(:,i)/HNLC(10,i))*100;
end

elseif strcmp(Region,'SP')
    
HNLC(:,1)=dlmread(fullfile(Dir,'Figuras','Regionales','Albani',['Fig2_' Region '.dat']),'',[1 1 10 1]);
HNLC(:,2)=dlmread(fullfile(Dir,'Figuras','Regionales','Lambert',['Fig2_' Region '.dat']),'',[1 1 10 1]);
HNLC(:,3)=dlmread(fullfile(Dir,'Figuras','Regionales','Takemura',['Fig2_' Region '.dat']),'',[1 1 10 1]);
HNLC(:,4)=dlmread(fullfile(Dir,'Figuras','Regionales','MRI-CGCM3',['Fig2_' Region '.dat']),'',[1 1 10 1]);

for i=1:4;
    Pon(:,i)=(HNLC(:,i)/HNLC(10,i))*100;
end

elseif strcmp(Region,'NP')
    
HNLC(:,1)=dlmread(fullfile(Dir,'Figuras','Regionales','Albani',['Fig2_' Region '.dat']),'',[1 1 10 1]);
HNLC(:,2)=dlmread(fullfile(Dir,'Figuras','Regionales','Lambert',['Fig2_' Region '.dat']),'',[1 1 10 1]);
HNLC(:,3)=dlmread(fullfile(Dir,'Figuras','Regionales','Takemura',['Fig2_' Region '.dat']),'',[1 1 10 1]);
HNLC(:,4)=dlmread(fullfile(Dir,'Figuras','Regionales','MIROC-ESM',['Fig2_' Region '.dat']),'',[1 1 10 1]);
HNLC(:,5)=dlmread(fullfile(Dir,'Figuras','Regionales','MRI-CGCM3',['Fig2_' Region '.dat']),'',[1 1 10 1]);

for i=1:5;
    Pon(:,i)=(HNLC(:,i)/HNLC(10,i))*100;
end

else
    
HNLC(:,1)=dlmread(fullfile(Dir,'Figuras','Regionales','Lambert',['Fig2_' Region '.dat']),'',[1 1 10 1]);
HNLC(:,2)=dlmread(fullfile(Dir,'Figuras','Regionales','Takemura',['Fig2_' Region '.dat']),'',[1 1 10 1]);
HNLC(:,3)=dlmread(fullfile(Dir,'Figuras','Regionales','MIROC-ESM',['Fig2_' Region '.dat']),'',[1 1 10 1]);
HNLC(:,4)=dlmread(fullfile(Dir,'Figuras','Regionales','MRI-CGCM3',['Fig2_' Region '.dat']),'',[1 1 10 1]);

for i=1:4;
    Pon(:,i)=(HNLC(:,i)/HNLC(10,i))*100;
end
end
A=median(Pon');
boxplot(Pon')
hold on
createFit_pond(A)
title(Region ,'FontSize',30);
% Create xlabel
xlabel('Niveles','FontWeight','bold','FontSize',24);
% Create ylabel
ylabel('\% Diferencia\ de ($pCO_{2}$)','FontWeight','bold','FontSize',24,...
    'Interpreter','latex');
hold off

end 