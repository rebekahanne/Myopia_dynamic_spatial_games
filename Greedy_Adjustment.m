%% Greedy_Adjustment.m
% This script uses a greedy heuristic, as in Kuehn and Hamburger (1963), 
% to compute an approximately optimal allocation of drivers on Oldenburg?s 
% transportation network. 

%% Setup
% clear
% clc

importfile('OL.mat');
numNodes = 6105;

%% Initialization
% Create distances matrix for the graph.
% This matrix gives us the shortest path distances of all node pairs. 
d = distances(G);

% Number of facilities
numFac = 60;

% This array will keep track of where we place each new facility in each
% iteration
currentPositions = zeros(numFac,1);

%% Goal function evaluation

% For each facility
for it=1:numFac
    tic
    
    % Average distance to nearest facility for each potential placement of
    % the next facility
    AverageDistanceAll = zeros(numNodes,1);
    
    % Evaluate the goal function with the next facility placed at each node
    parfor nn=1:numNodes
        
        % Try placing the facility at node nn
        currentPositionsTemp = currentPositions(1:it,1);
        currentPositionsTemp(it,1) = nn;
        
        % Distance from each facility to each node in this allocation
        DistancesIt = zeros(numNodes,it);           
        for ii=1:it
            for jj=1:numNodes
                DistancesIt(jj,ii) = d(currentPositionsTemp(ii,1),jj);
            end
        end
        
        % Distance from each node to its nearest facility in this
        % allocation
        minDistanceIt = zeros(numNodes,1);
        for jj=1:numNodes
            minDistanceIt(jj) = min(DistancesIt(jj,:));
        end
        AverageDistanceAll(nn,1) = mean(minDistanceIt);
    end
    
    % Find the node at which to place the facility to minimize average
    % distance
    [~,index] = min(AverageDistanceAll);
    currentPositions(it,1) = index;
    
    % Save the currentPositions array after we've added each facility
    %filename = sprintf('./greedy_adjustment_positions/currentPositions%d',it);
    %save(filename,'currentPositions');
    toc
end

% Calculate average distance in optimal allocation

DistancesIt = zeros(numNodes,P);
minDistanceIt = zeros(numNodes,1);

for nn=1:P
    for ii=1:numNodes
        DistancesIt(ii,nn) = d(currentPositions(nn),ii);
    end
end

for ii=1:numNodes
    minDistanceIt(ii) = min(DistancesIt(ii,:));
end

AverageDistanceIt = mean2(minDistanceIt(:,1));