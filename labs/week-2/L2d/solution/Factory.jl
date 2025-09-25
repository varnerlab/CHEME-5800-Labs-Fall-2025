"""
    build(modeltype::Type{MyFibonacciSequenceModel}, data::NamedTuple) -> MyFibonacciSequenceModel

This function builds a new `MyFibonacciSequenceModel` from a named tuple containing the parameters for the model.

### Arguments
- `modeltype::Type{MyFibonacciSequenceModel}`: The type of the model to build. This is used to create an instance of the model.
- `data::NamedTuple`: A named tuple containing the parameters for the model. The named tuple must contain the fields `n` and `defaultvalue`.

### Returns
- `MyFibonacciSequenceModel`: A new instance of `MyFibonacciSequenceModel` with the parameters set from the named tuple.
"""
function build(modeltype::Type{MyFibonacciSequenceModel}, data::NamedTuple)::Union{MyFibonacciSequenceModel, Nothing}
    
    # Initially the model is nothing -
    sequencemodel = nothing;
    
    # TODO: Uncomment the following code to give a warning if the named tuple is missing required fields
    required_fields = [:n, :defaultvalue] # we must have these fields to build the model
    for field ∈ required_fields
        if haskey(data, field) == false
            @error "Ooops! Missing required field: $field. Cannot build the model, returning nothing."
            return nothing; # Early retrn we cannot build the model, so return nothing
        end
    end

    # we have the required fields, so we can build the model - build an empty model
    sequencemodel = modeltype(); # create an instance of the model type

    # TODO: Check the size parameter n
    # TODO: If we get here, then we know that the named tuple has the required fields
    # TODO: However, the values could be invalid, so we should check them
    # TODO: Uncomment the following code to check the value for for the size parameter n
    default_size_parameter = 10; # this is the default value for n
    if data.n isa Int64 && data.n >= 0
        sequencemodel.n = data.n; # set the number of elements in the sequence
    else
        @warn "Ooops! Invalid value for n: $(data.n). Using default value: $default_size_parameter."
        sequencemodel.n = default_size_parameter; # set the default value
    end

    # TODO: Check the defaultvalue parameter
    # TODO: Uncomment the following code to check the value for the defaultvalue parameter
    my_default_value = 0; # this is the default value for the defaultvalue parameter
    if data.defaultvalue isa Int64
        my_default_value = data.defaultvalue;
    else
        @warn "Ooops! Invalid value for defaultvalue: $(data.defaultvalue). Using default value: $my_default_value."
    end

    # TODO: Populate a default sequence disctionary with the default value
    # TODO: Initialize the sequence dictionary with the default value
    initial_sequence_dictionary = Dict{Int64, Int64}();
    for i in 0:(sequencemodel.n - 1)
        initial_sequence_dictionary[i] = my_default_value; # set the default value for each element
    end
    sequencemodel.sequence = initial_sequence_dictionary; # set the initial sequence

    # return the model -
    return sequencemodel; 
end;