# setup paths -
const _ROOT = @__DIR__
const _PATH_TO_SRC = joinpath(_ROOT, "src");

# check: do we need to download any packages?
using Pkg
if (isfile(joinpath(_ROOT, "Manifest.toml")) == false) # have manifest file, we are good. Otherwise, we need to instantiate the environment
    Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
end

# load the required packages -
using Distributions
using Plots
using StatsPlots
using Colors
using LinearAlgebra
using Statistics
using DataFrames
using PrettyTables
using Random

# Set the random seed for reproducibility -
# Random.seed!(1234); # set the random seed for reproducibility

# include my source files -
include(joinpath(_PATH_TO_SOLN, "Types.jl"));
include(joinpath(_PATH_TO_SOLN, "Factory.jl"));
include(joinpath(_PATH_TO_SOLN, "Compute.jl"));
