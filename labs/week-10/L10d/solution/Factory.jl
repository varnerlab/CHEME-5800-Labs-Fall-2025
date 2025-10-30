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