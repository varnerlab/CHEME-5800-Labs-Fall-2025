"""
    function build(modeltype::Type{MyBinaryWeightedMajorityAlgorithmModel}, 
        data::NamedTuple)::MyBinaryWeightedMajorityAlgorithmModel

This method builds and returns an instance of the `MyBinaryWeightedMajorityAlgorithmModel` type.

### Arguments
- `modeltype::Type{MyBinaryWeightedMajorityAlgorithmModel}`: The model type to build.
- `data::NamedTuple`: A named tuple containing the model parameters:
    - `ϵ::Float64`: The learning rate.
    - `n::Int`: The number of experts.
    - `T::Int`: The number of rounds.
    - `expert::Function`: The expert function.
    - `adversary::Function`: The adversary function.

### Returns 
- `model::MyBinaryWeightedMajorityAlgorithmModel`: An instance of the `MyBinaryWeightedMajorityAlgorithmModel` type with the specified parameters.
"""
function build(modeltype::Type{MyBinaryWeightedMajorityAlgorithmModel}, 
    data::NamedTuple)

    # Initialize - 
    model = modeltype(); # build an empty model
    ϵ = data.ϵ; # learning rate
    n = data.n; # number of experts
    T = data.T; # number of rounds
    expert = data.expert; # expert function
    adversary = data.adversary; # adversary function

    # set the parameters -
    model.ϵ = ϵ;
    model.n = n;
    model.T = T;
    model.expert = expert;
    model.adversary = adversary;
    model.weights = ones(Float64, T+1, n) # initialize the weights array with ones 

    # return the model -
    return model;
end

"""
    function build(modeltype::Type{MyTwoPersonZeroSumGameModel}, 
        data::NamedTuple)::MyTwoPersonZeroSumGameModel

This method builds and returns an instance of the `MyTwoPersonZeroSumGameModel` type.

### Arguments
- `modeltype::Type{MyTwoPersonZeroSumGameModel}`: The model type to build.
- `data::NamedTuple`: A named tuple containing the model parameters:
    - `ϵ::Float64`: The learning rate.
    - `n::Int`: The number of experts (actions).
    - `T::Int`: The number of rounds.
    - `payoffmatrix::Array{Float64,2}`: The payoff matrix.

### Returns 
- `model::MyTwoPersonZeroSumGameModel`: An instance of the `MyTwoPersonZeroSumGameModel` type with the specified parameters.
"""
function build(modeltype::Type{MyTwoPersonZeroSumGameModel},
    data::NamedTuple)

    # initialize -
    model = modeltype(); # build an empty model
    ϵ = data.ϵ; # learning rate
    n = data.n; # number of experts (actions)
    T = data.T; # number of rounds
    payoffmatrix = data.payoffmatrix; # payoff matrix

    # set the parameters -
    model.ϵ = ϵ;
    model.n = n;
    model.T = T;
    model.payoffmatrix = payoffmatrix;
    model.weights = zeros(Float64, T+1, n) # initialize the weights array with ones

    # generate a random initial weight vector -
    model.weights[1, :] = rand(n);

    # return the model -
    return model;
end