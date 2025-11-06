abstract type AbstractProcessModel end
abstract type AbstractWorldModel end

"""
    struct MyValueIterationModel <: AbstractProcessModel

A struct that defines a value iteration model. 
The value iteration model is defined by the maximum number of iterations `k_max`.
"""
struct MyValueIterationModel 
    
    # data -
    k_max::Int64; # max number of iterations
end


"""
    mutable struct MyMDPProblemModel <: AbstractProcessModel

A mutable struct that defines a Markov Decision Process (MDP) model. 
The MDP model is defined by the tuple `(𝒮, 𝒜, T, R, γ)`. 
The state space `𝒮` is an array of integers, the action space `𝒜` is an array of integers, 
the transition matrix `T` is a function or a 3D array, the reward matrix `R` is a function or a 2D array, 
and the discount factor `γ` is a float.

### Fields
- `𝒮::Array{Int64,1}`: state space
- `𝒜::Array{Int64,1}`: action space
- `T::Union{Function, Array{Float64,3}}`: transition matrix of function
- `R::Union{Function, Array{Float64,2}}`: reward matrix or function
- `γ::Float64`: discount factor
"""
mutable struct MyMDPProblemModel <: AbstractProcessModel

    # data -
    𝒮::Array{Int64,1}
    𝒜::Array{Int64,1}
    T::Union{Function, Array{Float64,3}}
    R::Union{Function, Array{Float64,2}}
    γ::Float64
    
    # constructor -
    MyMDPProblemModel() = new()
end

"""
    mutable struct MyRectangularGridWorldModel <: AbstractWorldModel

A mutable struct that defines a rectangular grid world model.

### Fields
- `number_of_rows::Int`: number of rows in the grid
- `number_of_cols::Int`: number of columns in the grid
- `coordinates::Dict{Int,Tuple{Int,Int}}`: dictionary of state to coordinate mapping
- `states::Dict{Tuple{Int,Int},Int}`: dictionary of coordinate to state mapping
- `moves::Dict{Int,Tuple{Int,Int}}`: dictionary of state to move mapping
- `rewards::Dict{Int,Float64}`: dictionary of state to reward mapping
"""
mutable struct MyRectangularGridWorldModel <: AbstractWorldModel

    # data -
    number_of_rows::Int
    number_of_cols::Int
    coordinates::Dict{Int,Tuple{Int,Int}}
    states::Dict{Tuple{Int,Int},Int}
    moves::Dict{Int,Tuple{Int,Int}}
    rewards::Dict{Int,Float64}

    # constructor -
    MyRectangularGridWorldModel() = new();
end

"""
    struct MyValueIterationSolution

A struct that defines a value iteration solution.

### Fields
- `problem::MyMDPProblemModel`: MDP problem model
- `U::Array{Float64,1}`: value function vector. This holds the Utility of each state.
"""
struct MyValueIterationSolution
    problem::MyMDPProblemModel
    U::Array{Float64,1}
end