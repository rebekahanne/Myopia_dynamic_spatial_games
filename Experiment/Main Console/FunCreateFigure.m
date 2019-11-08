function [blank] = FunCreateFigure(ListOfPositionsCurrent, CleanTerritories, moveoptionscolor, MoveOptions)

Size = [21,21];
Height = Size(1);
Width = Size(2);

%% Colors

% Computers
black = [0 0 0];

% Tied
grey = [112/255 128/255 144/255];

% Player Territories
green_t = [0 204/255 0];
orange_t = [1 178/255 102/255];
purple_t = [178/255 102/255 1];
blue_t = [102/255 178/255 1];
red_t = [240/255 128/255 128/255];

% Player Locations
green_l = [0 102/255 0];
orange_l = [1 .4 0];
purple_l = [75/255 0 130/255];
blue_l = [0 0 1];
red_l = [176/255 0 0];

f1 = figure;

% Generate the map
img = image(CleanTerritories+1); 
% map = [grey; green_t; orange_t; purple_t; blue_t; red_t; black; black; black; black; black; black; black; black; green_l; orange_l; purple_l; blue_l; red_l; moveoptionscolor];
map = [black; green_t; orange_t; purple_t; blue_t; red_t; grey; grey; grey; grey; grey; grey; grey; grey; green_l; orange_l; purple_l; blue_l; red_l; moveoptionscolor];
colormap(map)
hold on;

set(gca, 'Ticklength', [0 0]);
hold on;

% Figure size?
x0=10;
y0=10;
width=1400;
height=1400;
set(gcf,'units','points','position',[x0,y0,width,height])
pbaspect([1 1 1])

grid off;

% Gridlines
for ii = .5:Height+.5
     plot([ii ii], [.5,Height+.5], 'k', 'LineWidth',1);
     plot([.5,Height+.5], [ii ii], 'k', 'LineWidth',1);
     hold on
end

% Axes
ax = gca;
axisvaluesx = 0:1:Width;
axisvaluesx = {'A', 'B','C','D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U'};  
axisvaluesy = 1:Height;
% ax.XTick = axisvaluesx;
ax.YTick = axisvaluesy;
xdata = 1:Width;
set(gca, 'Xtick', xdata, 'XtickLabel', axisvaluesx);
hold on;
set(gca,'XAxisLocation','top');
hold on;
set(gca, 'FontSize', 20);
hold on;

% CUSTOM MARKERS

% Computer Markers
for nn=6:13
    text(ListOfPositionsCurrent(nn,2),ListOfPositionsCurrent(nn,1),'C','Color','w','FontSize',17, 'HorizontalAlignment', 'center')
end

% Player Markers
for nn = 1:5
    text(ListOfPositionsCurrent(nn,2),ListOfPositionsCurrent(nn,1),num2str(nn),'Color','w','FontSize',17, 'HorizontalAlignment', 'center')
end

movements = {'Left (L)','Up (U)','Stay (S)','Down (D)','Right (R)'};
movementsuse = {'L','U','','D','R'};

% Label move options
for ii = 1:length(MoveOptions)
    text(MoveOptions(ii,2),MoveOptions(ii,1),movementsuse(ii),'Color','w','FontSize',15, 'HorizontalAlignment', 'center') 
end

set(f1,'Visible', 'off'); 

% Save the figure    
export_fig screen.png;

end