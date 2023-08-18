Dir='/home/natalia/Documentos/Tesis/';

fig5('Albani')
figure1 = figure;
set(gcf,'position',[200 300 800 500])
set(gcf,'PaperPosition',[0 0 1150/100 500/100]);
% Create axes
axes1 = axes('Parent',figure1,...
    'XTickLabel',{'','SA','','SP','','NP','','CP',''},...
    'FontWeight','bold',...
    'FontSize',12);
%% Uncomment the following line to preserve the X-limits of the axes
xlim(axes1,[0.5 4.5]);
hold(axes1,'on');
plot1 = plot(ans,'MarkerSize',10,'Marker','o','LineStyle','none',...
    'Parent',axes1);
set(plot1,'DisplayName','Lambert',...
    'MarkerFaceColor',[1 0 0]);

fig5('Lambert')
plot(ans,'MarkerSize',10,'Marker','o','LineStyle','none',...
    'MarkerFaceColor',[0 1 0],...
    'Color',[1 0 0],'Parent',axes1);

fig5('Takemura')
plot(ans,'MarkerSize',10,'Marker','o','LineStyle','none',...
    'MarkerFaceColor',[0 0 1],...
    'Color',[1 0 0],'Parent',axes1);

fig5('MIROC-ESM')
plot(ans,'MarkerSize',10,'Marker','o','LineStyle','none',...
    'MarkerFaceColor',[1 0 1],...
    'Color',[1 0 0],'Parent',axes1);

fig5('MRI-CGCM3')
plot(ans,'MarkerSize',10,'Marker','o','LineStyle','none',...
    'MarkerFaceColor',[0 0 0]);

% Create xlabel
xlabel('Regiones HNLC','FontSize',24);
% xlabel('HNLC regions','FontSize',24);


% Create ylabel
ylabel('% de Reducción pCO_2','FontSize',24);
% ylabel('% pCO_2 reduction','FontSize',24);



% Create legend
legend1 = legend(axes1,'Albani','Lambert','Takemura','MIROC-ESM','MRI-CGCM3');
set(legend1,'Orientation','horizontal','FontSize',12)
% set(legend1,...
%     'Position',[0.746525899546605 0.708776598003633 0.144017322004067 0.160460988389896],...
%     'FontSize',20);

grid on
print(gcf,'-dpng','-r100',fullfile(Dir,'Figuras','Ponderaciones','Ponderaciones_LGM.png'))
%print(gcf,'-dpng','-r100',fullfile(Dir,'Figuras','Ponderaciones','Ponderation_LGM.png'))

