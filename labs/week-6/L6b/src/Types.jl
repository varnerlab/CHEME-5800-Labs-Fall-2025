abstract type AbstractBiggEndpointModel end
abstract type AbstractFluxCalculationModel end

struct MyBiggModelsEndpointModel <: AbstractBiggEndpointModel

    # methods -
    MyBiggModelsEndpointModel() = new();
end

mutable struct MyBiggModelsDownloadModelEndpointModel <: AbstractBiggEndpointModel

    # data -
    bigg_id::String

    # methods -
    MyBiggModelsDownloadModelEndpointModel() = new();
end

mutable struct MyOptimalOpenExtentProblemCalculationModel <: AbstractFluxCalculationModel

    # data -
    S::Array{Float64,2}; # stoichiometric matrix
    fluxbounds::Array{Float64,2}; # flux bounds
    speciesbounds::Array{Float64,2}; # species bounds
    objective::Array{Float64,1}; # objective function coefficients
    species::Array{String,1}; # species names/ids
    reactions::Array{String,1}; # reaction names/ids

    # methods -
    MyOptimalOpenExtentProblemCalculationModel() = new();
end

mutable struct MyPrimalFluxBalanceAnalysisCalculationModel <: AbstractFluxCalculationModel

    # data -
    S::Array{Float64,2}; # stoichiometric matrix
    fluxbounds::Array{Float64,2}; # flux bounds
    objective::Array{Float64,1}; # objective function coefficients
    species::Array{String,1}; # species names/ids
    reactions::Array{String,1}; # reaction names/ids

    # methods -
    MyPrimalFluxBalanceAnalysisCalculationModel() = new();
end

