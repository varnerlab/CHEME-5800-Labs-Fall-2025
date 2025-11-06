"""
    build(modeltype::Type{MyEpsilonGreedyAlgorithmModel}, data::NamedTuple) -> MyEpsilonGreedyAlgorithmModel

Builds a `MyEpsilonGreedyAlgorithmModel` from data in a `NamedTuple`.

### Arguments
- `modeltype::Type{MyEpsilonGreedyAlgorithmModel}`: the model type to build
- `data::NamedTuple`: the data to use to build the model

The `data` `NamedTuple` must contain the following keys:
- `K::Int64`: number of arms
"""
function build(modeltype::Type{MyEpsilonGreedyAlgorithmModel}, data::NamedTuple)

    # initialize -
    K = data.K; # number of arms

    # build empty model -
    model = modeltype();
    model.K = K;

    # return -
    return model;
end

"""
    build(modeltype::Type{MyExploreFirstAlgorithmModel}, data::NamedTuple) -> MyExploreFirstAlgorithmModel

Builds a `MyExploreFirstAlgorithmModel` from data in a `NamedTuple`.

### Arguments
- `modeltype::Type{MyExploreFirstAlgorithmModel}`: the model type to build
- `data::NamedTuple`: the data to use to build the model

The `data` `NamedTuple` must contain the following keys:
- `K::Int64`: number of arms
"""
function build(modeltype::Type{MyExploreFirstAlgorithmModel}, data::NamedTuple)

    # initialize -
    K = data.K; # number of arms

    # build empty model -
    model = modeltype();
    model.K = K;

    # return -
    return model;
end


"""
    build(modeltype::Type{MyUCB1AlgorithmModel}, data::NamedTuple) -> MyUCB1AlgorithmModel

Builds a `MyUCB1AlgorithmModel` from data in a `NamedTuple`.

### Arguments
- `modeltype::Type{MyUCB1AlgorithmModel}`: the model type to
- `data::NamedTuple`: the data to use to build the model

The `data` `NamedTuple` must contain the following keys:
- `K::Int64`: number of arms
"""
function build(modeltype::Type{MyUCB1AlgorithmModel}, data::NamedTuple)

    # initialize -
    K = data.K; # number of arms

    # build empty model -
    model = modeltype();
    model.K = K;

    # return -
    return model;
end
