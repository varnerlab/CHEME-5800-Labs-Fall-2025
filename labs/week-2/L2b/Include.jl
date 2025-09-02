# setup paths -
const _ROOT = pwd();
const _PATH_TO_SRC = joinpath(_ROOT, "src");

# check:
const _DID_INCLUDE_GET_CALLED = true; # only true if this file was called

# check do we have a Manifest.toml file?
using Pkg;
if (isfile(joinpath(_ROOT, "Manifest.toml")) == false) # have manifest file, we are good. Otherwise, we need to instantiate the environment
    Pkg.add(path="https://github.com/varnerlab/VLDataScienceMachineLearningPackage.jl.git")
    Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
end

# load external packages
using VLDataScienceMachineLearningPackage
using CSV
using DataFrames
using FileIO
using StatsPlots
using Plots
using Colors
using Statistics
using LinearAlgebra
using Distances
using JLD2
using PrettyTables
using Clustering
using Distributions
using Unicode
using Test