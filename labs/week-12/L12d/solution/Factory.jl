"""
    build(modeltype::Type{MyBinaryVectorArmsEpsilonGreedyAlgorithmModel}, data::NamedTuple) -> MyBinaryVectorArmsEpsilonGreedyAlgorithmModel

Builds a `MyBinaryVectorArmsEpsilonGreedyAlgorithmModel` from data in a `NamedTuple`.

### Arguments
- `modeltype::Type{MyBinaryVectorArmsEpsilonGreedyAlgorithmModel}`: the model type to build
- `data::NamedTuple`: the data to use to build the model

The `data` `NamedTuple` must contain the following keys:
- `K::Int64`: number of arms

### Returns
- `MyBinaryVectorArmsEpsilonGreedyAlgorithmModel`: a populated binary vector arms epsilon greedy algorithm model
"""
function build(modeltype::Type{MyBinaryVectorArmsEpsilonGreedyAlgorithmModel}, data::NamedTuple)

    # initialize -
    K = data.K; # number of arms

    # build empty model -
    model = modeltype();
    model.K = K;

    # return -
    return model;
end

"""
    build(modeltype::Type{MyConsumerChoiceBanditContextModel}, data::NamedTuple) -> MyConsumerChoiceBanditContextModel

Builds a `MyConsumerChoiceBanditContextModel` from data in a `NamedTuple`.

### Arguments
- `modeltype::Type{MyConsumerChoiceBanditContextModel}`: the model type to build
- `data::NamedTuple`: the data to use to build the model
The `data` `NamedTuple` must contain the following keys:
- `data::Dict{String, Any}`: data dictionary for each item, or more generally the context
- `items::Array{String,1}`: items for each asset
- `bounds::Array{Float64,2}`: bounds on the assets that we can purchase
- `B::Float64`: budget that we have to spend on the collection of assets
- `nₒ::Array{Float64,1}`: initial guess for the solution
- `μₒ::Array{Float64,1}`: initial for the utility of each arm
- `γ::Array{Float64,1}`: parameters for the utility function (preferences)

### Returns
- `MyConsumerChoiceBanditContextModel`: a populated consumer choice bandit context model
"""
function build(modeltype::Type{MyConsumerChoiceBanditContextModel}, 
    data::NamedTuple)::MyConsumerChoiceBanditContextModel

    # initialize -
    # data::Dict{String, Any} # data dictionary for each item, or more generally the context
    # items::Array{String,1} # items for each asset
    # bounds::Array{Float64,2} # bounds on the assets that we can purchase
    # B::Float64 # budget that we have to spend on the collection of assets
    # nₒ::Array{Float64,1} # initial guess for the solution
    # μₒ::Array{Float64,1} # initial for the utility of each arm
    # γ::Array{Float64,1} # parameters for the utility function (preferences)

    # get stuff from the NamedTuple -
    contextdata = data.data; # data dictionary for each item, or more generally the context
    items = data.items; # items for each asset
    bounds = data.bounds; # bounds on the assets that we can purchase
    B = data.B; # budget that we have to spend on the collection of assets
    nₒ = data.nₒ; # initial guess for the solution
    μₒ = data.μₒ; # initial for the utility of each arm
    γ = data.γ; # parameters for the utility function (preferences)

    # build empty model -
    model = modeltype();
    model.data = contextdata;
    model.items = items;
    model.bounds = bounds;
    model.B = B;
    model.nₒ = nₒ;
    model.μₒ = μₒ;
    model.γ = γ;

    # return -
    return model;
end