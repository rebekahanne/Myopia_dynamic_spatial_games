# Code Appendix
This appendix describes the code used in in the Applications section of "Myopia in dynamic spatial games" by Shane Auerbach and Rebekah Dix.

## Constructing Oldenburg
The script ```Construct_Oldenburg.m``` uses ```OLedges.txt``` and ```OLnodes.txt``` to create an undirected graph that represents the transportation network of Oldenburg, Germany. The file ```OL.mat``` contains the output of ```Construct_Oldenburg.m```.

## Simulations with Myopic Agents on Oldenburg
The script ```Oldenburg_Spatial_Network_Simulation.m```. can be used to simulate MBR agents on Oldenburg's transportation network. This script uses the helper function ```FunCountTerritories.m```.  The file ```Oldenburg_Allocations.mat``` contains the particular sequence of spatial allocations discussed in the paper. To replicate the sequence of of spatial allocations, use the initial allocation of drivers in ```Oldenburg_Allocations.mat```.

## Oldenburg Figures
The script ```Create_Oldenburg_Figures.m``` creates the figures of Oldenburg's transportation network with allocations of drivers used in this paper. The script plots the initial, final, and approximately optimal allocations of drivers in ```Oldenburg_Allocations.mat``` and ```Oldenburg_Approx_Optimal.mat```.

## Computing Approximately Optimal Spatial Allocations
The file ```Greedy_Adjustment.m```. uses a myopic (greedy) heuristic to compute an approximately optimal allocation of drivers on Oldenburg's transportation network. The file ```Oldenburg_Approx_Optimal.mat```. contains the approximately optimal allocation of $60$ drivers on Oldenburg's transportation network. 
