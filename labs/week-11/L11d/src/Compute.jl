## -- STANFORD VERSION OF VALUE ITERATION BELOW HERE -------------------------------------------------------------- ##

"""
    _lookahead(p::MyMDPProblemModel, U::Vector{Float64}, s::Int64, a::Int64)

This function computes the lookahead value for a given state-action pair `(s,a)`. 
It uses a vector `U` to compute the value function.

### Arguments
- `p::MyMDPProblemModel`: the MDP problem model
- `U::Vector{Float64}`: the value function vector
- `s::Int64`: the state
- `a::Int64`: the action

### Returns
- `Float64`: the lookahead value for the state-action pair `(s,a)`. 
"""
function _lookahead(p::MyMDPProblemModel, U::Vector{Float64}, s::Int64, a::Int64)::Float64

    # grab stuff from the problem -
    R = p.R;  # reward -
    T = p.T;    
    γ = p.γ;
    𝒮 = p.𝒮;
    
    # compute the lookahead value and return it
    return R[s,a] + γ*sum(T[s,s′,a]*U[i] for (i,s′) in enumerate(𝒮))
end


"""
    _backup(problem::MyMDPProblemModel, U::Array{Float64,1}, s::Int64) -> Float64

This function computes the backup value for a given state `s` and value function `U`.

### Arguments
- `problem::MyMDPProblemModel`: the MDP problem model
- `U::Array{Float64,1}`: the value function vector
- `s::Int64`: the state

### Returns
- `Float64`: the best backup value for the state `s`
"""
function _backup(problem::MyMDPProblemModel, U::Array{Float64,1}, s::Int64)::Float64
    return maximum(_lookahead(problem, U, s, a) for a ∈ problem.𝒜);
end




"""
    solve(model::MyValueIterationModel, problem::MyMDPProblemModel) -> MyValueIterationSolution

This function solves the MDP problem using value iteration.

### Arguments
- `model::MyValueIterationModel`: the value iteration model
- `problem::MyMDPProblemModel`: the MDP problem model

### Returns
- `MyValueIterationSolution`: the value iteration solution
"""
function solve(model::MyValueIterationModel, problem::MyMDPProblemModel)::MyValueIterationSolution
    
    # initialize -
    k_max = model.k_max;
    U = [0.0 for _ ∈ problem.𝒮]; # initially all the U(s) values are 0

    # main loop -
    for _ ∈ 1:k_max
        U = [_backup(problem, U, s) for s ∈ problem.𝒮];
    end

    return MyValueIterationSolution(problem, U);
end

## -- STANFORD VERSION OF VALUE ITERATION ABOVE HERE -------------------------------------------------------------- ##

## -- OUR VERSION OF VALUE ITERATION BELOW HERE ------------------------------------------------------------------- ##
"""
    function mysolve(model::MyValueIterationModel, problem::MyMDPProblemModel; ϵ::Float64 = 1e-6) -> MyValueIterationSolution

This function solves the MDP problem using value iteration with convergence checking. 

### Arguments
- `model::MyValueIterationModel`: the value iteration model
- `problem::MyMDPProblemModel`: the MDP problem model
- `ϵ::Float64`: convergence threshold (default: 1e-6)

### Returns
- `MyValueIterationSolution`: the value function wrapped in a solution type
"""
function mysolve(model::MyValueIterationModel, problem::MyMDPProblemModel; ϵ::Float64 = 1e-6)::MyValueIterationSolution
    
    # initialize -
    k_max = model.k_max;
    number_of_states = length(problem.𝒮);
    number_of_actions = length(problem.𝒜);
    converged = false;
    counter = 1; # initialize iteration counter
    U = zeros(Float64, number_of_states); # initialize space, initially all the U(s) values are 0
    
    # TODO: implement the value iteration algorithm with convergence checking as shown in the pseudocode in lecture and lab
    throw(ErrorException("Oooops! The `mysolve(...)` function is not yet implemented. Please implement it as per the lab instructions."))

    return MyValueFunctionPolicy(problem, U); # wrap and return
end

"""
    mypolicy(Q_array::Array{Float64,2}) -> Array{Int,1}

This function computes the policy from the Q-value function.

### Arguments
- `Q_array::Array{Float64,2}`: the Q-value function

### Returns
- `Array{Int,1}`: the policy which maps states to actions
"""
function mypolicy(Q_array::Array{Float64,2})::Array{Int64,1}

    # get the dimension -
    (NR, _) = size(Q_array);

    # initialize some storage -
    π_array = Array{Int64,1}(undef, NR)
    for s ∈ 1:NR
        π_array[s] = argmax(Q_array[s,:]);
    end

    # return -
    return π_array;
end



"""
    QM(p::MyMDPProblemModel, U::Array{Float64,1}) -> Array{Float64,2}

This function computes the Q-value function for a given value function `U`.

### Arguments
- `p::MyMDPProblemModel`: the MDP problem model
- `U::Array{Float64,1}`: the value function vector

### Returns
- `Array{Float64,2}`: the Q-value function
"""
function QM(p::MyMDPProblemModel, U::Array{Float64,1})::Array{Float64,2}

    # grab stuff from the problem -
    R = p.R;  # reward -
    T = p.T;    
    γ = p.γ;
    𝒮 = p.𝒮;
    𝒜 = p.𝒜

    # initialize -
    Q_array = Array{Float64,2}(undef, length(𝒮), length(𝒜))

    # compute the Q-value function -
    for i ∈ eachindex(𝒮)
        s = 𝒮[i]; # get the state s
        for j ∈ eachindex(𝒜)
            a = 𝒜[j]; # get the action a

            # compute the Q-value -
            # We get the reward for being in state s and taking action a, 
            # and then we add the discounted sum of the future value function for the next state s′.
            Q_array[s,a] = R[s,a] + γ*sum([T[s,s′,a]*U[s′] for s′ in 𝒮]);
        end
    end

    # return -
    return Q_array
end

## -- OUR VERSION OF VALUE ITERATION ABOVE HERE ------------------------------------------------------------------- ##