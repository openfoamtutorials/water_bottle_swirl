#!/bin/sh

# Quit script if any step has error:
set -e

# Make the mesh:
gmsh -3 -o main.msh mesh/main.geo
# Convert the mesh to OpenFOAM format:
gmshToFoam main.msh -case case
# Adjust polyMesh/boundary:
changeDictionary -case case
# Set the initial conditions for the water phase.
# Copy original alpha.water file:
cp case/0/alpha.water.original case/0/alpha.water
# Copy original U file:
cp case/0/U.original case/0/U
# case/system/setFieldsDict specifies the initial conditions:
setFields -case case
# Finally, run the simulation:
interFoam -case case

