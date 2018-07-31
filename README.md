# Code Appendix
This appendix describes the code used in in the Applications section of "Myopia in dynamic spatial games" by Shane Auerbach and Rebekah Dix.

## Constructing Oldenburg
The script ```Construct\_Oldenburg.m``` uses \texttt{OLedges.txt} and \texttt{OLnodes.txt} to create an undirected graph that represents the transportation network of Oldenburg, Germany. The file \texttt{OL.mat} contains the output of \texttt{Construct\_Oldenburg.m}.

## Simulations with Myopic Agents on Oldenburg
The script \texttt{Oldenburg\_Spatial\_Network\_Simulation.m} can be used to simulate MBR agents on Oldenburg's transportation network. This script uses the helper function \linebreak \texttt{FunCountTerritories.m}.  The file \texttt{Oldenburg\_Allocations.mat} contains the particular sequence of spatial allocations discussed in the paper. To replicate the sequence of of spatial allocations, use the initial allocation of drivers in \texttt{Oldenburg\_Allocations.mat}.

## Oldenburg Figures
The script \texttt{Create\_Oldenburg\_Figures.m} creates the figures of Oldenburg's transportation network with allocations of drivers used in this paper. The script plots the initial, final, and approximately optimal allocations of drivers in \texttt{Oldenburg\_Allocations.mat} and \texttt{Oldenburg\_Approx\_Optimal.mat}.

## Computing Approximately Optimal Spatial Allocations
The file \texttt{Greedy\_Adjustment.m} uses a myopic (greedy) heuristic to compute an approximately optimal allocation of drivers on Oldenburg's transportation network. The file \texttt{Oldenburg\_Approx\_Optimal.mat} contains the approximately optimal allocation of $60$ drivers on Oldenburg's transportation network. 
