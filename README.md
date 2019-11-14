# Windroses

Welcome to the Heterogeneity Project collaborators

This repository contain a script to plot windroses using met data collected at http://www.atmos.anl.gov/ANLMET/numeric/2019/

The script uses 2019 data of wind direction at 10 m height near building 484.

Below, I'll explain how to install Julia (open-source) and run the script.
You can download Julia at:
https://juliacomputing.com/products/juliapro
which contains Julia + an IDE (Juno in Atom).

You will need to install a few packages to run the script, by running the following commands in Julia:

using Pkg
Pkg.add("DataFrames")
Pkg.add("CSV")
Pkg.add("PyPlot")

You will need to create an Input folder with the met data, and an Output folder

You will need to set your working directory to the path of your folder, using the command written below in Julia

cd("your path")

Note that Julia requires two \\ in path, for example "C:\\Users\\arenchon"
