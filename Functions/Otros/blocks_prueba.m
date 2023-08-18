figure
clear all
X=linspace(0,2);
Y=linspace(0,4);
Z=linspace(0,3);

hold on
XX = [X(1) X(end) X(end) 0 0; 0 0 0 0 0;0 0 X(end) X(end) 0;X(end) X(end) X(end) X(end) X(end); X(end) X(end) 0 0 X(end)];
YY = [0 0 Y(end) Y(end) 0; 0 0 Y(end) Y(end) 0;0 0 0 0 0; 0 0 Y(end) Y(end) 0;Y(end) Y(end) Y(end) Y(end) Y(end)];
ZZ = [3 3 3 3 3; 0 3 3 0 0; 0 3 3 0 0;0 3 3 0 0;0 3 3 0 0];
for i=1:5
fill3(XX(i,:),YY(i,:),ZZ(i,:),'y','FaceAlpha',.3)
end




