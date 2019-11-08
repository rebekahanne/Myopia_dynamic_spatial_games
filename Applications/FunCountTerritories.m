%% FunCountTerritories.m
% This script counts the number of nodes in players' Voronoi cells.

function [NumTerritories] = FunCountTerritories(PlayerNumber,Territories)

  % Make a binary matrix of the territories where ones represent territories
  % in which the player is a (part-) owner.
  BinResult = cellfun(@(x)ismember(PlayerNumber,x),Territories);

  % Turn this into a list of territories.
  ListOfTerritories = Territories(find(BinResult==1));

  % Counts the territories, adding 1/(number of owners) to the score for each
  % territory in which the player is an owner.
  NumTerritories = 0;
  for m=1:size(ListOfTerritories,1)
      NumTerritories = NumTerritories + 1/cellfun(@length,(ListOfTerritories(m)));
  end

end
