abstract type AbstractSequenceModel end # This is an abstract type for sequence models
abstract type AbstractIterationModel end # This is an abstract type for iteration models

"""
    MyFibonacciSequenceModel <: AbstractSequenceModel

A mutable struct to represent a Fibonacci sequence. 

### Fields
- `n::Int64`: The number of elements in the sequence.
- `sequence::Dict{Int64, Int64}`: The sequence itself, stored as a dictionary with indices as keys and Fibonacci numbers as values.

"""
mutable struct MyFibonacciSequenceModel <: AbstractSequenceModel

    # data -
    n::Int64 # number of elements in the sequence
    sequence::Dict{Int64, Int64} # the sequence itself

    # constructor -
    MyFibonacciSequenceModel() = new();
end

"""
    MyForLoopIterationModel <: AbstractIterationModel

An immutable struct to represent a for loop iteration model. This type has no fields and serves as a marker for a for loop iteration implementation.
"""
struct MyForLoopIterationModel <: AbstractIterationModel
    MyForLoopIterationModel() = new();
end

"""
    MyWhileLoopIterationModel <: AbstractIterationModel

An immutable struct to represent a while loop iteration model. This type has no fields and serves as a marker for a while loop iteration implementation.
"""
struct MyWhileLoopIterationModel <: AbstractIterationModel
    MyWhileLoopIterationModel() = new();
end