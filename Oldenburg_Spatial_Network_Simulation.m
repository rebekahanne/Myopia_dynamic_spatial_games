%% Oldenburg_Spatial_Network_Simulation.m
% This file simulates dynamic games of spatial competition with MBR
% agents on Oldenburg's transportation network.

%% Setup
% clear
% clc

% to access export_fig
addpath('./export_fig')

% result exporting settings
export = 0;
name = 'OL';

% Number of iterations for each simulation
numIts = 5000;

%% Setup spatial network

% Import Oldeburg network
importfile('OL.mat');
% Import allocations generated through simualtion
importfile('Oldenburg_Allocations.mat');

% Initial allocation used in paper
initialPositions = ListOfPositions(:,1);

% Set the number of nodes in the spatial network;
numNodes = numnodes(G);

% Specify moving costs of model
movingcost = 0;

% Create distances matrix for the graph (using the edge weights)
% --shortest path distances of all node pairs. 
d = distances(G);

% Add players
P = 60;
N = 60;

% Array to store spatial allocation in each iteration
ListOfPositions = zeros(P,numIts+1);
% Set initial allocation to allocation used in paper
ListOfPositions(:,1) = initialPositions;

% To repeat simulation
numSessions = 1;
SessionLength = numIts;
% Store spatial inefficiency in each iteration
SpatialInefficiencyIt = zeros(numSessions,max(SessionLength));
AverageDistanceIt = zeros(numSessions,max(SessionLength));

% Optimal average distance to nearest player (with 60 players) for Oldenburg
optDist = 480.1796;


% Use to generate a random allocation of players for the initial allocation
% out = randperm(numNodes,N);
% for nn=1:N
%     ListOfPositions(nn,1) = out(nn); 
% end

%% Game Loop
for it=1:numIts
    
    it
    
	% Extract the node where each player is currently positioned
	CurrentPositions = ListOfPositions(:,it);

    % Use deterministic turn order
 	currentPlayer = mod(it,N) + 1;

    % Find the neighbors of the current player's positions
	MoveOptions = neighbors(G,CurrentPositions(currentPlayer,1));
    
    % Add current position to the move options list, as we
    % allow the player to remain in the same position
    MoveOptions = [CurrentPositions(currentPlayer,1); MoveOptions];

	% Array with number of nodes a player would own at each potential state
	Scores = zeros(1,length(MoveOptions));

    % For each move option
	for ii=1:length(MoveOptions)

        % If this move option is feasible (this check only applies in
        % models where collocation is not allowed)
		if MoveOptions(ii,1) > 0
            
			% Create potential list of positions for this movement
			PotPositions = CurrentPositions;
            
            % Move the current player to a new potential state
			PotPositions(currentPlayer) = MoveOptions(ii);

			% Calculate distance from each player to each node in this
			% potential state
			Distances = zeros(numNodes,P);
			for nn=1:P
				for jj=1:numNodes
					Distances(jj,nn) = d(PotPositions(nn,1),jj);
				end
			end

			% Find which players are closest to each node
			Territories = cell(numNodes,1);
			for jj=1:numNodes
			    I=find(Distances(jj,:)==min(Distances(jj,:)));
			    Territories(jj)={I};
            end

            % Calculate the cardinality of this player's Voronoi cell
			Scores(1,ii) = FunCountTerritories(currentPlayer, Territories);
            
            % Include moving costs if in model
            if ii ~= 1
                Scores(1,ii) = Scores(1,ii) - movingcost;
            end
            
		else
			Scores(1,ii) = 0;
		end
    end

    % The MBR move is the highest scoring move option
	MBRmove = (find(Scores(1,:) == max(Scores(1,:))));

    % If there is more than one MBR move, pick the first
	if length(MBRmove) > 1
		MBRmove = MBRmove(1);
    end
    
    % Update the new position of this player, after movement
	CurrentPositions(currentPlayer,1) = MoveOptions(MBRmove);
   
    % Update list of positions
	ListOfPositions(:,it+1) = CurrentPositions;
    
    % Calculate spatial inefficiency for this iteration
    DistancesIt = zeros(numNodes,P);
    minDistanceIt = zeros(numNodes,1);
    AverageDistanceIt(1,it) = 0;
    
    for nn=1:P
        for ii=1:numNodes
            DistancesIt(ii,nn) = d(ListOfPositions(nn,it),ii);
        end
    end
    for ii=1:numNodes
        minDistanceIt(ii) = min(DistancesIt(ii,:));
    end
    
    AverageDistanceIt(1,it) = mean2(minDistanceIt(:,1));  
    SpatialInefficiencyIt(1,it) = (AverageDistanceIt(1,it) - optDist)/optDist;  
end