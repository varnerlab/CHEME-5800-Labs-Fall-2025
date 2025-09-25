# -- PRIVATE METHODS BELOW HERE ------------------------------------------------------------------------------------------------------- #
function _fibonacci(sequencemodel::MyFibonacciSequenceModel, iterationmodel::MyForLoopIterationModel)

    @info "Debug message: We are using the for loop iteration model"

    # initialize -
    n = sequencemodel.n;
    sequence = Dict{Int64, Int64}();

    # we know the first two elements -
    sequence[0] = 0;
    sequence[1] = 1;

    # main loop, compute F₂, ....
    for i ∈ 2:n # what is this short-hand for?
        sequence[i] = sequence[i-1] + sequence[i-2]
    end

    # update the model -
    sequencemodel.sequence = sequence;
end

function _fibonacci(sequencemodel::MyFibonacciSequenceModel, iterationmodel::MyWhileLoopIterationModel)

    @info "Debug message: We are using the while loop iteration model"

    # check: is n legit?
    n = sequencemodel.n;
    sequence = Dict{Int64, Int64}();
    
    # main loop 
    should_loop_continue = true
    i = 0;
    while (should_loop_continue == true)
       
        # conditional logic: hardcode 0, 1 else gets all other cases
        if (i == 0)
            sequence[i] = 0; 
        elseif (i == 1)
            sequence[i] = 1;
        else
            sequence[i] = sequence[i - 1] + sequence[i - 2]
        end

        # update i -
        i += 1; # this is short-hand for i = i + 1

        # check: should we go around again?
        if (i>n)
            should_loop_continue = false;
        end
    end
    
    # update the model -
    sequencemodel.sequence = sequence;
end
# -- PRIVATE METHODS ABOVE HERE ------------------------------------------------------------------------------------------------------- #

# -- PUBLIC METHODS BELOW HERE -------------------------------------------------------------------------------------------------------- #
"""
    function fibonacci!(sequencemodel::MyFibonacciSequenceModel; 
        iterationmodel::T = MyForLoopIterationModel()) where T <: AbstractIterationModel

This function computes the Fibonacci sequence, given sequence and iteration models. 
The sequence model is updated in place (the sequence model is mutable). 
The iteration model is used to determine the type of loop to use.

# Arguments
- `sequencemodel::MyFibonacciSequenceModel`: The sequence model to update. The sequence model must have a field `n::Int64` that is the number of elements to compute.
- `iterationmodel::T`: The iteration model to use. It must be a subtype of `AbstractIterationModel`. The default is `MyForLoopIterationModel`.

There is no return value. The `sequencemodel` is updated in place.
"""
function fibonacci!(sequencemodel::MyFibonacciSequenceModel; 
    iterationmodel::T = MyForLoopIterationModel()) where T <: AbstractIterationModel
    
    # Status: If we get here, then we know n >= 0
    _fibonacci(sequencemodel, iterationmodel); # multiple dispatch to the appropriate implementation
end;
## 00 PUBLIC METHODS ABOVE HERE -------------------------------------------------------------------------------------------------------- #