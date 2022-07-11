#!/bin/bash

rm -rf init setup.json lightdock* swarm_*;

if [ "$#" == "3" ]; then
    SPR="-spr $2";
    DS="-ds";
elif [ "$#" == "2" ]; then
    SPR="-spr $2";
    DS="";
elif [ "$#" == "1" ]; then
    SPR="";
    DS="";
else
    echo "Wrong arguments";
    exit 1;
fi

lightdock3_setup.py 2UUY_rec.pdb 2UUY_lig.pdb --noxt --now --noh -rst ${1}_restraints.list ${SPR} ${DS};

for i in `cut -c 9- ${1}_restraints.list`;do echo "resi $i"; done > resi.list;

residues=$(paste -d' ' -s resi.list);

pymol lightdock_2UUY_rec.pdb init/swarm_centers.pdb -d "select lightdock_2UUY_rec and chain A; color white, sele; show surface, sele; select swarm_centers; color red, sele; show spheres, sele; select all and ${residues}; color blue, sele; z vis;";
