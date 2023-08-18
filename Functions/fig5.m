function [Pon] = fig5(Modelo)

Dir='/home/natalia/Documentos/Tesis/';

All=dlmread(fullfile(Dir,'Figuras','Globales',Modelo,'Fig2_All.dat'),'',10,1);

if strcmp(Modelo,'MRI-CGCM3')

 HNLC(:,1)=dlmread(fullfile(Dir,'Figuras','Regionales',Modelo,['Fig2_SA.dat']),'',10,1);   
 HNLC(:,2)=nan;
 HNLC(:,3)=dlmread(fullfile(Dir,'Figuras','Regionales',Modelo,['Fig2_NP.dat']),'',10,1);
 HNLC(:,4)=dlmread(fullfile(Dir,'Figuras','Regionales',Modelo,['Fig2_CP.dat']),'',10,1);
 
elseif strcmp(Modelo,'Lambert')
    
HNLC(:,1)=dlmread(fullfile(Dir,'Figuras','Regionales',Modelo,['Fig2_SA.dat']),'',10,1);
HNLC(:,2)=dlmread(fullfile(Dir,'Figuras','Regionales',Modelo,['Fig2_SP.dat']),'',10,1);
HNLC(:,3)=dlmread(fullfile(Dir,'Figuras','Regionales',Modelo,['Fig2_NP.dat']),'',10,1);
HNLC(:,4)=dlmread(fullfile(Dir,'Figuras','Regionales',Modelo,['Fig2_CP.dat']),'',10,1);

elseif strcmp(Modelo,'Albani')

HNLC(:,1)=dlmread(fullfile(Dir,'Figuras','Regionales',Modelo,['Fig2_SA.dat']),'',10,1);
HNLC(:,2)=dlmread(fullfile(Dir,'Figuras','Regionales',Modelo,['Fig2_SP.dat']),'',10,1);
HNLC(:,3)=dlmread(fullfile(Dir,'Figuras','Regionales',Modelo,['Fig2_NP.dat']),'',10,1);
HNLC(:,4)=nan;

elseif strcmp(Modelo,'Takemura')
    
HNLC(:,1)=nan;   
HNLC(:,2)=dlmread(fullfile(Dir,'Figuras','Regionales',Modelo,['Fig2_SP.dat']),'',10,1);
HNLC(:,3)=dlmread(fullfile(Dir,'Figuras','Regionales',Modelo,['Fig2_NP.dat']),'',10,1);   
HNLC(:,4)=dlmread(fullfile(Dir,'Figuras','Regionales',Modelo,['Fig2_CP.dat']),'',10,1);

else
    
HNLC(:,1)=nan;
HNLC(:,2)=nan;
HNLC(:,3)=dlmread(fullfile(Dir,'Figuras','Regionales',Modelo,['Fig2_NP.dat']),'',10,1);
HNLC(:,4)=dlmread(fullfile(Dir,'Figuras','Regionales',Modelo,['Fig2_CP.dat']),'',10,1);   
end


Pon=(HNLC/All)*100;
end