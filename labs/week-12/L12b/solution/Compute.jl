# PRIVATE METHODS BELOW HERE ================================================================================= #
# placeholder - always return 0
_null(action::Int64)::Int64 = return 0;

# Private implementation of solve for MyExploreFirstAlgorithmModel
function _solve(model::MyExploreFirstAlgorithmModel; T::Int = 0, world::Function = _null)::Array{Float64,2}

    # initialize -
    K = model.K # get the number of arms
    rewards = zeros(Float64, T, K); # rewards for each arm

    # how many expore steps should we take?
    Nₐ = ((T/K)^(2/3))*(log(T))^(1/3) |> x -> round(Int,x); # number of explore steps
    
    # exploration phase -
    counter = 1;
    for a ∈ 1:K
        for _ ∈ 1:Nₐ
            rewards[counter, a] = world(a); # store from action a
            counter += 1;
        end
    end

    μ = zeros(Float64, K); # average reward for each arm
    for a ∈ 1:K
        μ[a] = findall(x -> x != 0.0, rewards[:, a]) |> i-> mean(rewards[i, a]); # compute the average reward
    end

    # exploitation phase -
    a = argmax(μ); # compute the arm with best average reward
    for _ ∈ 1:(T - Nₐ*K)
        rewards[counter, a] = world(a); # store the reward
        counter += 1;
    end
    
    # return -
    return rewards;
end

# Private implementation of Epsilon-Greedy algorithm
function _solve(model::MyEpsilonGreedyAlgorithmModel; T::Int = 0, world::Function = _null)::Array{Float64,2}

    # initialize -
    K = model.K # get the number of arms
    rewards = zeros(Float64, T, K); # rewards for each arm

    for t ∈ 1:T
        ϵₜ = (1.0/(t^(1/3)))*(log(K*t))^(1/3); # compute the epsilon value -

        p = rand(); # role a random number
        aₜ = 1; # default action is to pull the first arm
        if (p ≤ ϵₜ)
            aₜ = rand(1:K);  # ramdomly select an arm
        else
            
            μ = zeros(Float64, K); # average reward for each arm
            for a ∈ 1:K
                μ[a] = findall(x -> x != 0.0, rewards[:, a]) |> i-> mean(rewards[i, a]); # compute the average reward
            end
            aₜ = argmax(μ); # compute the arm with best average reward
        end
        rewards[t, aₜ] = world(aₜ); # store the reward
    end

    # return -
    return rewards;
end

# Private implementation of UCB1 algorithm
function _solve(model::MyUCB1AlgorithmModel; T::Int = 0, world::Function = _null)::Array{Float64,2}

    # initialize -
    K = model.K # get the number of arms
    rewards = zeros(Float64, T, K); # rewards for each arm
    Nₐ = zeros(Int64, K); # number of times we have pulled each arm

    # try each arm once
    counter = 1;
    for a = 1:K
        rewards[counter, a] = world(a); # pull each arm once
        Nₐ[a] += 1; # increment the counter
        counter += 1;
    end
    
    # main loop -
    for t ∈ counter:T

        # conpute the UCB value 
        tmp = zeros(Float64, K);
        μ = zeros(Float64, K); # average reward for each arm
        for a ∈ 1:K
            μ[a] = findall(x -> x != 0.0, rewards[:, a]) |> i-> mean(rewards[i, a]); # compute the average reward
        end
        
        for i ∈ 1:K
            tmp[i] = μ[i] + sqrt((2*log(t))/Nₐ[i]); # compute the UCB value
        end

        aₜ = argmax(tmp); # select the arm with the highest UCB value
        Nₐ[aₜ] += 1; # increment the counter
        rewards[t, aₜ] = world(aₜ); # store the reward
    end

    # return -
    return rewards;
end

# PRIVATE METHODS ABOVE HERE ================================================================================= #

# PUBLIC METHODS BELOW HERE ================================================================================== #
"""
    solve(model::AbstractBanditAlgorithmModel; T::Int = 0, world::Function = _null)

Solve the bandit problem using the given model. 

### Arguments
- `model::AbstractBanditAlgorithmModel`: The model to use to solve the bandit problem.
- `T::Int = 0`: The number of rounds to play. Default is 0.
- `world::Function = _null`: The function that returns the reward for a given action. Default is the private `_null` function.

### Returns
- `Array{Float64,2}`: The rewards for each arm at each round.
"""
function solve(model::AbstractBanditAlgorithmModel; T::Int = 0, world::Function = _null)::Array{Float64,2}
    return _solve(model, T = T, world = world);
end


"""
    regret(rewards::Array{Float64,2})::Array{Float64,1}

Compute the regret for the given rewards.

### Arguments
- `rewards::Array{Float64,2}`: The rewards for each arm at each round.

### Returns
- `Array{Float64,1}`: The regret at each round.
"""
function regret(rewards::Array{Float64,2})::Array{Float64,1}
    
    # initialize -
    T = size(rewards, 1); # how many rounds did we play?
    K = size(rewards, 2); # how many arms do we have?
    regret = zeros(Float64, T); # initialize the regret array

    # first: compute the best arm in hindsight -
    μ = zeros(Float64, K); # average reward for each arm
    for a ∈ 1:K
        μ[a] = findall(x -> x != 0.0, rewards[:, a]) |> i-> mean(rewards[i, a]); # compute the average reward
    end
    μₒ = maximum(μ); # compute the best average reward

    # compute the regret -
    for t ∈ 1:T

        # what action was taken at time t?
        tmp = 0.0;
        for j = 1:t
            aₜ = argmax(rewards[j, :]); # get the action that was taken
            tmp += μ[aₜ]; # compute the hypothetical average reward
        end
        regret[t] = μₒ*t - tmp; # compute the regret at time t
    end

    # return -
    return regret;
end
# PUBLIC METHODS ABOVE HERE ================================================================================== #