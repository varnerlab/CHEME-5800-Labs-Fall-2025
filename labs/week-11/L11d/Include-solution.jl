# setup paths -
const _ROOT = @__DIR__
const _PATH_TO_SRC = joinpath(_ROOT, "src");
const _PATH_TO_SOLUTION = joinpath(_ROOT, "solution");

# check: do we need to download any packages?
using Pkg
if (isfile(joinpath(_ROOT, "Manifest.toml")) == false) # have manifest file, we are good. Otherwise, we need to instantiate the environment
    Pkg.add(path="https://github.com/varnerlab/VLDataScienceMachineLearningPackage.jl.git")
    Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
end

# load the required packages -
using Distributions
using Plots
using Colors
using LinearAlgebra
using Statistics
using DataFrames
using PrettyTables

# load my codes -
include(joinpath(_PATH_TO_SOLUTION, "Types.jl"));
include(joinpath(_PATH_TO_SOLUTION, "Factory.jl"));
include(joinpath(_PATH_TO_SOLUTION, "Compute.jl"));