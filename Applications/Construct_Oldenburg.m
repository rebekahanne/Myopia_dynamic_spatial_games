%% Construct_Oldenburg.m
% This script reads in data files for the city of Oldenburg, Germany and
% creates an undirected graph that represents the transportation network of
% the city. 

%% Setup
clear
clc

name = 'OL';
numNodes = 6105;
numEdges = 7035;

%% File input

% Open edge/node text files
fileID1 = fopen('OLedges.txt','r');
store1 = textscan(fileID1, '%d %d %d %f');

fileID2 = fopen('OLnodes.txt','r');
store2 = textscan(fileID2, '%d %f %f');

% Parse these files to pull node/edge data
nodeData = zeros(numNodes,3);

nodeData(:,1) = store2{1,1};
nodeData(:,1) = nodeData(:,1) + 1;
nodeData(:,2) = store2{1,2};
nodeData(:,3) = store2{1,3};

edgeData = zeros(numEdges,4);
edgeData(:,1) = store1{1,1};
edgeData(:,2) = store1{1,2};
edgeData(:,3) = store1{1,3};
edgeData(:,4) = store1{1,4};

% Create the weighted adjacency matrix
adMat = sparse(numNodes,numNodes);
for ii=1:numEdges
    adMat(edgeData(ii,2)+1,edgeData(ii,3)+1) = edgeData(ii,4);
end

% Create the directed graph
OL = digraph(adMat);
OL.Nodes.Xcoord = nodeData(:,2);
OL.Nodes.Ycoord = nodeData(:,3);

% Make an undirected graph from the directed graph
G = OL;
[s,t] = findedge(G);
A = sparse(s,t,G.Edges.Weight,numNodes,numNodes);
A = (A + A.');
G = graph(A);
G.Nodes.Xcoord = nodeData(:,2);
G.Nodes.Ycoord = nodeData(:,3);

% Output .mat file with graph
save('OL.mat','G');