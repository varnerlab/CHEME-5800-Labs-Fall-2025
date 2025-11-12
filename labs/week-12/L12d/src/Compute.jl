# PRIVATE METHODS BELOW HERE ================================================================================= #

function _solve(model::MyBinaryVectorArmsEpsilonGreedyAlgorithmModel, context::MyConsumerChoiceBanditContextModel;
    T::Int = 0, world::Function = _null, startdayindex::Int = 1)

    # initialize -
    K = model.K; # get the number of goods to choose from
    N = 2^K; # this is the maximum number of arms we can have (we have K goods, with each good being {0 | 1})
    μₒ = context.μₒ; # get the average rewards for each possible goods combination
   
    μ = zeros(Float64, N); # average reward for each possible goods combination
    R = zeros(Float64, T, N);
    S = zeros(Float64, T, K); # history of the number of shares 
    P = zeros(Float64, T, K); # history of fill prices for each asset
    G = zeros(Float64, T, K); # history of preferences

    # TODO: Implement the epsilon-greedy algorithm to solve the bandit problem with binary vector arms.
    throw(ErrorException("Ooooops! This method is not implemented yet! We'd better get to it right away!"));
    
    # return -
    return R, μ, S, P, G;
end

# PRIVATE METHODS ABOVE HERE ================================================================================= #

# PUBLIC METHODS BELOW HERE ================================================================================== #`

"""
    solve(model::AbstractBanditAlgorithmModel, context::AbstractBanditProblemContextModel;
        T::Int = 0, world::Function = _null)

Solve the contextual bandit problem using the given model and context.

### Arguments
- `model::MyBinaryVectorArmsEpsilonGreedyAlgorithmModel`: The model to use to solve the bandit problem.
- `context::MyConsumerChoiceBanditContextModel`: The context model to use. Must be a subtype of `AbstractBanditProblemContextModel`.
- `T::Int = 0`: The number of rounds to play. Default is 0.
- `world::Function = _null`: The function that returns the reward for a given action. Default is the private `_null` function.
- `startdayindex::Int = 1`: The starting time index for the context model. Default is 1. This is useful for time series data.
"""
function solve(model::MyBinaryVectorArmsEpsilonGreedyAlgorithmModel, context::MyConsumerChoiceBanditContextModel;
    T::Int = 0, world::Function = _null, startdayindex::Int = 1)
    return _solve(model, context, T = T, world = world, startdayindex = startdayindex);
end