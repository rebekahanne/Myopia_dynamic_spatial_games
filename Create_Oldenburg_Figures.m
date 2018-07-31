%% Create_Oldenburg_Figures.m
% This script plots spatial allocations of drivers on Oldenburg's
% transportation network.

%% Setup

% Import Oldeburg network
importfile('OL.mat');
% Import allocations generated through simualtion
importfile('Oldenburg_Allocations.mat');

% Use export_fig to save figures
addpath('./export_fig')

% Number of drivers in allocation
numDrivers = size(ListOfPositions, 1);

% Set export = 1 to output pdf, else set to 0
export = 0;


%% Figure of initial allocation of 60 drivers in Oldenburg

% Allocation to be plotted
currentPositions = ListOfPositions(:,1);
figure('NumberTitle', 'off', 'Name', 'Initial allocation of 60 drivers in Oldenburg');

% Plot transportation network
h = plot(G,'XData',G.Nodes{:,1},'YData',G.Nodes{:,2});

% Figure settings
h.MarkerSize = 1.75;
ax = gca;
ax.Visible = 'off';
set(gcf,'color','w');
hold on

% Plot drivers
for nn=1:numDrivers
    scatter(G.Nodes{currentPositions(nn,1),1}, G.Nodes{currentPositions(nn,1),2}, ...
        100, 'd','filled', 'black')
    hold on
end

% Export figure
set(gcf, 'Units', 'Normalized', 'OuterPosition', [.05, 0.01, .95, 0.99]);
if export == 1
    export_fig (strcat('ol_initial','.pdf'));
end

%% Figure of final allocation of 60 drivers in Oldenburg
currentPositions = ListOfPositions(:,5001);
figure('NumberTitle', 'off', 'Name', 'Final allocation of 60 drivers in Oldenburg');

% Plot transportation network
h = plot(G,'XData',G.Nodes{:,1},'YData',G.Nodes{:,2});

% Figure settings
h.MarkerSize = 1.75;
ax = gca;
ax.Visible = 'off';
set(gcf,'color','w');
hold on

% Plot drivers
for nn=1:numDrivers
    scatter(G.Nodes{currentPositions(nn,1),1}, G.Nodes{currentPositions(nn,1),2}, ...
        100, 'd','filled', 'black')
    hold on
end

% Export figure
set(gcf, 'Units', 'Normalized', 'OuterPosition', [.05, 0.01, .95, 0.99]);
if export == 1
    export_fig (strcat('ol_final','.pdf'));
end

%% Figure of approximately optimal allocation of 60 drivers in Oldenburg

% Import approximately optimal allocation
importfile('Oldenburg_Approx_Optimal.mat');
figure('NumberTitle', 'off', 'Name', 'Approximately optimal allocation of 60 drivers in Oldenburg');

% Plot transportation network
h = plot(G,'XData',G.Nodes{:,1},'YData',G.Nodes{:,2});

% Figure settings
h.MarkerSize = 1.75;
ax = gca;
ax.Visible = 'off';
set(gcf,'color','w');
hold on

% Plot drivers
for nn=1:numDrivers
    scatter(G.Nodes{currentPositions(nn,1),1}, G.Nodes{currentPositions(nn,1),2}, ...
        100, 'd','filled', 'black')
    hold on
end

% Export figure
set(gcf, 'Units', 'Normalized', 'OuterPosition', [.05, 0.01, .95, 0.99]);
if export == 1
    export_fig (strcat('ol_optimal','.pdf'));
end
