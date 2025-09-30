
# -- PRIVATE METHODS BELOW HERE ------------------------------------------------------------------------------- #

"""
Private logic to solve the FBA problem for the `MyOptimalOpenExtentProblemCalculationModel` model type
"""
function _flux(problem::MyOptimalOpenExtentProblemCalculationModel)

    # initialize -
    results = Dict{String,Any}()
    c = problem.objective; # objective function coefficients

    # bounds -
    fluxbounds = problem.fluxbounds;
    lb = fluxbounds[:, 1]; # lower bounds
    ub = fluxbounds[:, 2]; # upper bounds
    
    # species bounds -
    speciesbounds = problem.speciesbounds;
    b = speciesbounds[:, 1]; # right-hand side vector
    
    # species constraints -
    A = problem.S; # constraint matrix

    # how many variables do we have?
    d = length(c);

    # Setup the problem -
    model = Model(GLPK.Optimizer)
    @variable(model, lb[i,1] <= x[i=1:d] <= ub[i,1], start=0.0) # we have d variables
    
    # set objective function -   
    @objective(model, Max, transpose(c)*x);
    @constraints(model, 
        begin
            A*x >= -b # my material balance constraints 
        end
    );

    # run the optimization -
    optimize!(model)

    # check: was the optimization successful?
    @assert is_solved_and_feasible(model)

    # populate -
    x_opt = value.(x);
    results["argmax"] = x_opt
    results["objective_value"] = objective_value(model);

    # return -
    return results
end

"""
Private logic to solve the FBA problem for the `MyPrimalFluxBalanceAnalysisCalculationModel` model type
"""
function _flux(problem::MyPrimalFluxBalanceAnalysisCalculationModel)

    # initialize -
    results = Dict{String,Any}()
    c = problem.objective; # objective function coefficients

    # bounds -
    fluxbounds = problem.fluxbounds;
    lb = fluxbounds[:, 1]; # lower bounds
    ub = fluxbounds[:, 2]; # upper bounds
        
    # species constraints -
    A = problem.S; # constraint matrix

    # how many variables do we have?
    d = length(c);

    # Setup the problem -
    model = Model(GLPK.Optimizer)
    @variable(model, lb[i,1] <= x[i=1:d] <= ub[i,1], start=0.0) # we have d variables
    
    # set objective function -   
    @objective(model, Max, transpose(c)*x);
    @constraints(model, 
        begin
            A*x == 0 # my material balance constraints 
        end
    );

    # run the optimization -
    optimize!(model)

    # check: was the optimization successful?
    @assert is_solved_and_feasible(model)

    # populate -
    x_opt = value.(x);
    results["argmax"] = x_opt
    results["objective_value"] = objective_value(model);

    # return -
    return results
end
# -- PRIVATE METHODS ABOVE HERE ------------------------------------------------------------------------------- #

# -- PUBLIC METHODS BELOW HERE -------------------------------------------------------------------------------- #
"""
    softmax(x::Array{Float64,1})::Array{Float64,1}

Compute the softmax of a vector. 
This function takes a vector of real numbers and returns a vector of the same size with the softmax of the input vector, 
i.e., the exponential of the input vector divided by the sum of the exponential of the input vector.


### Arguments
- `x::Array{Float64,1}`: a vector of real numbers.

### Returns
- `::Array{Float64,1}`: a vector of the same size as the input vector with the softmax of the input vector.
"""
function softmax(x::Array{Float64,1})::Array{Float64,1}
    
    # compute the exponential of the vector
    y = exp.(x);
    
    # compute the sum of the exponential
    s = sum(y);
    
    # compute the softmax
    return y / s;
end

"""
    binary(S::Array{Float64,2})::Array{Int64,2}

Convert a matrix of floats to a matrix of binary values. 
Each non-zero element in the input matrix is converted to 1, and each zero element is converted to 0.

### Arguments
- `S::Array{Float64,2}`: a matrix of floats.

### Returns
- `::Array{Int64,2}`: a matrix of binary values.
"""
function binary(S::Array{Float64,2})::Array{Int64,2}
    
    # initialize -
    number_of_rows = size(S, 1);
    number_of_columns = size(S, 2);
    B = zeros(Int64, number_of_rows, number_of_columns);

    # main -
    for i ∈ 1:number_of_rows
        for j ∈ 1:number_of_columns
            if (S[i, j] != 0.0) # if the value is not zero, then B[i,j] = 1
                B[i, j] = 1;
            end
        end
    end

    # return -
    return B;
end

"""
    solve(model::AbstractFluxCalculationModel)

Solve the flux calculation model.

### Arguments
- `model::AbstractFluxCalculationModel`: the flux calculation model to solve. The correct method
  will be called based on the type of the model.

### Returns
- `Dict{String,Any}`: a dictionary with the results of the optimization.
"""
function solve(model::AbstractFluxCalculationModel)
    return _flux(model);
end


"""
    enumerate_binary_variable_cases(number_of_variables::Int) -> Array{Int,2}

Enumerate all possible cases of `n` binary variables

### Arguments
- `number_of_variables::Int`: the number of binary variables to enumerate.

### Returns
- `Array{Int,2}`: a 2D array with all possible cases of `n` binary variables.
"""
function enumerate_binary_variable_cases(number_of_variables::Int)

	# how many binary variables are we going to have?
	number_of_rows = 2^number_of_variables	
	
	# initialize -
	tmp_array = Array{Int,2}(undef, number_of_rows, number_of_variables)

	# main -
	for i ∈ 1:number_of_rows

		# generate a row -
		tmp_row = parse.(Int,Base.bin(UInt8(i-1), number_of_variables ,false) |> collect)

		# add the row to the tmp_array =
		for j ∈ 1:number_of_variables
			tmp_array[i,j] = tmp_row[j]
		end
	end

	return tmp_array
end

# -- PUBLIC METHODS ABOVE HERE -------------------------------------------------------------------------------- #