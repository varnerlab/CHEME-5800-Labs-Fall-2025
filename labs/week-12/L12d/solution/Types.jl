abstract type AbstractBanditProblemContextModel end
abstract type AbstractBanditAlgorithmModel end

"""
    mutable struct MyConsumerChoiceBanditContextModel <: AbstractBanditProblemContextModel

This struct defines a consumer choice bandit context model for bandit problems with context.

### Fields
- `data::Dict{String, Any}`: A dictionary containing the context data for each item.
- `items::Array{String,1}`: An array of item names (things we are purchasing).
- `bounds::Array{Float64,2}`: A 2D array defining the bounds on the items that we can purchase.
- `B::Float64`: The budget available to spend on the collection of items.
- `nₒ::Array{Float64,1}`: An initial guess for the solution (quantities of each item).
- `μₒ::Array{Float64,1}`: An initial estimate for the utility of each arm (collection of items).
"""
mutable struct MyConsumerChoiceBanditContextModel <: AbstractBanditProblemContextModel

    # data -
    data::Dict{String, Any} # data dictionary for each item, or more generally the context
    items::Array{String,1} # items for each asset
    bounds::Array{Float64,2} # bounds on the assets that we can purchase
    B::Float64 # budget that we have to spend on the collection of assets
    nₒ::Array{Float64,1} # initial guess for the solution
    μₒ::Array{Float64,1} # initial for the utility of each arm
    γ::Array{Float64,1} # parameters for the utility function (preferences)

    # constructor -
    MyConsumerChoiceBanditContextModel() = new();
end

"""
    mutable struct MyBinaryVectorArmsEpsilonGreedyAlgorithmModel <: AbstractBanditAlgorithmModel

A mutable struct that represents a binary vector arms epsilon-greedy bandit algorithm model.

### Fields
- `K::Int64`: number of arms
"""
mutable struct MyBinaryVectorArmsEpsilonGreedyAlgorithmModel <: AbstractBanditAlgorithmModel

    # data -
    K::Int64 # number of arms

    # constructor -
    MyBinaryVectorArmsEpsilonGreedyAlgorithmModel() = new();
end