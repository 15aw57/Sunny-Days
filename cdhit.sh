#!/bin/bash
sudo apt-get install cd-hit # install cd-hit; check github page for cdhit for installing on mac/windows
mkdir output/
cd-hit -i input/protein.fa -o cdhit_output/ -c 0.95 # run cdhit
cp cdhit_output/1616967362.fas.1.clstr cluster.txt