# Code Appendix and Simulation Toolkit
This appendix describes the code used in in the Applications section of ["Myopia in dynamic spatial games"](https://drive.google.com/file/d/1HlA9ZUYV35VE9Zcm1NtbEbxDBxtZf92j/view) by Shane Auerbach and Rebekah Dix.

# Applications
## Constructing Oldenburg
The script ```Construct_Oldenburg.m``` uses ```OLedges.txt``` and ```OLnodes.txt``` to create an undirected graph that represents the transportation network of Oldenburg, Germany using data from Brinkhoﬀ (2002). The file ```OL.mat``` contains the output of ```Construct_Oldenburg.m```.

## Simulations with Myopic Agents on Oldenburg
The script ```Oldenburg_Spatial_Network_Simulation.m```. can be used to simulate MBR agents on Oldenburg's transportation network. Furthermore, this script can be used more generally for simulations with myopic agents on any spatial network. This script uses the helper function ```FunCountTerritories.m```.  The file ```Oldenburg_Allocations.mat``` contains the particular sequence of spatial allocations discussed in the paper. To replicate the sequence of of spatial allocations, use the initial allocation of drivers in ```Oldenburg_Allocations.mat```.

## Oldenburg Figures
The script ```Create_Oldenburg_Figures.m``` creates the figures of Oldenburg's transportation network with allocations of drivers used in this paper. The script plots the initial, final, and approximately optimal allocations of drivers in ```Oldenburg_Allocations.mat``` and ```Oldenburg_Approx_Optimal.mat```.

## Computing Approximately Optimal Spatial Allocations
The file ```Greedy_Adjustment.m```. uses a myopic (greedy) heuristic, as in Kuehn and Hamburger (1963), to compute an approximately optimal allocation of drivers on Oldenburg's transportation network. The file ```Oldenburg_Approx_Optimal.mat```. contains the approximately optimal allocation of 60 drivers on Oldenburg's transportation network. 

# Experiment Code

The computer game was developed in Matlab and uses the [GUI Layout Toolbox](https://www.mathworks.com/matlabcentral/fileexchange/47982-gui-layout-toolbox) (version 2.3.4), which is available through the Matlab File Exchange.

## References
* Brinkhoff, T. (2002). A framework for generating network-based moving objects. GeoInformatica, 6(2):153–180.
* Kuehn, A. A. and Hamburger, M. J. (1963). A heuristic program for locating warehouses. Management science, 9(4):643–666
