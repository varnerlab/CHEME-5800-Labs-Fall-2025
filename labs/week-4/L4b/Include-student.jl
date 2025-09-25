# setup paths -
const _ROOT = @__DIR__;
const _PATH_TO_DATA = joinpath(_ROOT, "data");
const _PATH_TO_SRC = joinpath(_ROOT, "src");

# if we are missing any packages, install them -
using Pkg;
if (isfile(joinpath(_ROOT, "Manifest.toml")) == false) # have manifest file, we are good. Otherwise, we need to instantiate the environment
    Pkg.add(path="https://github.com/varnerlab/VLDataScienceMachineLearningPackage.jl.git")
    Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
end

# load external packages -
using VLDataScienceMachineLearningPackage
using JSON
using JLD2
using FileIO
using KernelFunctions
using PrettyTables
using DataFrames
using Test
using Random
using Statistics
using LinearAlgebra
using BenchmarkTools
using Plots
using Colors
using DataStructures
using CSTParser
using GraphViz
using Distributions
using Images
using ImageInTerminal
using ImageShow
using Statistics

# For 
# using Graphs
# using GraphIO
# using Karnak
# using NetworkLayout

# include my source files -
include(joinpath(_PATH_TO_SRC, "Types.jl"));
include(joinpath(_PATH_TO_SRC, "Graphs.jl"));