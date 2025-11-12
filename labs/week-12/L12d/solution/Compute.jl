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

    # so before we start, go through every possible arm, and compute the average reward -
    # this means that we try each possible arm at least once, and compute the average reward
    for i ∈ 1:N
        aₜ = digits(i, base=2, pad=K); # generate a binary representation of the number, with K digits  
        if (i == N)
            aₜ = digits(i - 1, base=2, pad=K); # generate a binary representation of the number, with K digits  
        end
        r,n,p,γ = world(startdayindex, aₜ, context); # get the reward from the world (use the first day of the OOS data)
        μ[i] = μₒ[i]*(1-1/T) + (1/T)*r; # update the average reward for the chosen arm (learning rate = α)
        
        R[1, i] = r; # store the reward in the rewards array
        S[1, :] = n; # store the number of shares purchased in the first round
        P[1, :] = p; # store the probabilities in the first round
        G[1, :] = γ; # store the preferences in the first round
    end

    # main -
    for t ∈ 2:T
        ϵₜ = (1.0/(t^(1/3)))*(log(K*t))^(1/3); # compute the epsilon value -

        # if we were to purchase stuff, how much would we purchase?
        p = rand(); # role a random number
        aₜ = nothing; # initialize action vector
        î = nothing; # index of the combination of goods
        if (p ≤ ϵₜ)
            î = rand(1:N); # randomly select an integer from 1 to N (this will be used to generate a binary representation of the action vector)
        else
            î = argmax(μ); # compute the arm with best average reward
        end
        aₜ = digits(î, base=2, pad=K); # generate a binary representation of the number, with K digits  
        if (î == N)
            aₜ = digits(î - 1, base=2, pad=K); # generate a binary representation of the number, with K digits  
        end

        # call out to the world, record the result.
        rₜ, nₜ, pₜ, γₜ = world(startdayindex, aₜ, context); # get the reward from the world (use the first day of the OOS data)

        # for each arm, compute the reward -
        μ[î]+=(1/t)*(rₜ - μ[î]); # update the average reward for the chosen arm (learning rate = α)

        # store other data -
        R[t, î] = rₜ; # store the reward in the rewards array

        # @show t, î, R[t, î], μ[î]; # debug output

        S[t, :] = nₜ; # store the number of shares purchased in the first round
        P[t, :] = pₜ; # store the probabilities in the first round
        G[t, :] = γₜ; # store the preferences in the first round
    end

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