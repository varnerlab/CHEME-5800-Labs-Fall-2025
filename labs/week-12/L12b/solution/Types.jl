abstract type AbstractBanditAlgorithmModel end

"""
    mutable struct MyExploreFirstAlgorithmModel <: AbstractBanditAlgorithmModel

A mutable struct that represents an explore-first bandit algorithm model.
"""
mutable struct MyExploreFirstAlgorithmModel <: AbstractBanditAlgorithmModel

    # data -
    K::Int64 # number of arms

    # constructor -
    MyExploreFirstAlgorithmModel() = new();
end

"""
    mutable struct MyUCB1AlgorithmModel <: AbstractBanditAlgorithmModel

A mutable struct that represents a UCB1 bandit algorithm model.
"""
mutable struct MyUCB1AlgorithmModel <: AbstractBanditAlgorithmModel

    # data -
    K::Int64 # number of arms

    # constructor -
    MyUCB1AlgorithmModel() = new();
end

"""
    mutable struct MyEpsilonGreedyAlgorithmModel <: AbstractBanditAlgorithmModel

A mutable struct that represents an epsilon-greedy bandit algorithm model.
"""
mutable struct MyEpsilonGreedyAlgorithmModel <: AbstractBanditAlgorithmModel

    # data -
    K::Int64 # number of arms

    # constructor -
    MyEpsilonGreedyAlgorithmModel() = new();
end