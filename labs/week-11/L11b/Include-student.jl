# setup paths -
const _ROOT = @__DIR__
const _PATH_TO_SRC = joinpath(_ROOT, "src");

# check: do we need to download any packages?
using Pkg
if (isfile(joinpath(_ROOT, "Manifest.toml")) == false) # have manifest file, we are good. Otherwise, we need to instantiate the environment
    Pkg.add(path="https://github.com/varnerlab/VLDataScienceMachineLearningPackage.jl.git")
    Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
end

# load the required packages -
# using VLDataScienceMachineLearningPackage # Sneaky! did you catch this bug? (we need this package, so we need to load with a using statement)
using Distributions
using Plots
using Colors
using LinearAlgebra
using Statistics
using DataFrames
using PrettyTables