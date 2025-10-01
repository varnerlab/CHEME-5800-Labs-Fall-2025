function _mysolve(A::AbstractMatrix{T}, b::AbstractVector{T}, xₒ::AbstractVector{T}, algorithm::MyJacobiMethod;
    ϵ::Float64 = 1e-6, maxiterations::Int64 = 1000, ω::Float64 = 1.0) where T <: Number

    # initialize -
    is_ok_to_terminate = false;
    k = 0; # initialize iteration counter to 0
    archive = Dict{Int, Array{Float64,1}}(); # we store every iteration in this dictionary
   
    # setup -
    archive[0] = copy(xₒ); # store the initial guess in the archive
    k += 1;  # update the iteration counter -

    # split the matrix A -
    D = diag(A) |> a-> diagm(a);
    U = triu(A,1);
    L = tril(A,-1);

    # check: if any zeros on the diagonal, throw an error -
    if (any(diag(A) .== 0.0))
        error("Matrix A has zero(s) on the diagonal, cannot proceed with Jacobi Method.")
    end
    DI = inv(D); # compute the inverse of the diagonal matrix D

    # iterate -
    prev_residual = Inf;
    while (is_ok_to_terminate == false)

        # compute the residual -
        x = copy(archive[k-1]);

        # TODO: Implement the computation of the residual, norm of the residual, and direction vector
        # TODO: Comment out the throws line after implementing the computation of r and d
        throw(ErrorException("Ooops!: You need to implement the JacobiMethod"));


        # check the error condition -
        if (current_residual < ϵ)
            is_ok_to_terminate = true;
        elseif (k > maxiterations)
            @warn "Jacobi method did not converge within $maxiterations iterations. Final residual: $current_residual"
            is_ok_to_terminate = true;
        elseif (current_residual > 1e10)  # Check for divergence
            @warn "Jacobi method appears to be diverging. Residual: $current_residual"
            is_ok_to_terminate = true;
        else
            is_ok_to_terminate = false;
        end

        y = x + d; # generate new solution vector at k
        archive[k] = y; # save new solution vector in archive
        k += 1;  # update the iteration counter
        prev_residual = current_residual;
    end

    # return archive -
    return archive;
end

function _mysolve(A::AbstractMatrix{T}, b::AbstractVector{T}, xₒ::AbstractVector{T}, algorithm::MyGaussSeidelMethod;
    ϵ::Float64 = 1e-6, maxiterations::Int64 = 1000, ω::Float64 = 1.0) where T <: Number

    # initialize -
    is_ok_to_terminate = false;
    k = 0; # initialize iteration counter to 0
    archive = Dict{Int, Array{Float64,1}}(); # we store every iteration in this dictionary
   
    # setup
    archive[0] =  copy(xₒ);; # store the initial guess in the archive
    k += 1;  # update the iteration counter -

    # split the matrix A -
    D = diag(A) |> a-> diagm(a);
    U = triu(A,1);
    L = tril(A,-1);

    # check: (D+L) must be invertible, if not, throw an error -
    if (det(D+L) == 0.0)
        error("Matrix D+L is not invertible, cannot proceed with Gauss-Seidel Method.")
    end
    C = inv(D + L); # compute the inverse of the matrix D+L

    # iterate -
    prev_residual = Inf;
    while (is_ok_to_terminate == false)

        x = copy(archive[k-1]); # grab the current solution vector, create a copy so we don't overwrite the data in the archive


        # TODO: Implement the computation of the residual, norm of the residual, and direction vector
        # TODO: Comment out the throws line after implementing the computation of r and d
        throw(ErrorException("Ooops!: You need to implement the GaussSeidelMethod"));

        # check the error condition -
        if (current_residual < ϵ)
            is_ok_to_terminate = true;
        elseif (k > maxiterations)
            @warn "Gauss-Seidel method did not converge within $maxiterations iterations. Final residual: $current_residual"
            is_ok_to_terminate = true;
        elseif (current_residual > 1e10)  # Check for divergence
            @warn "Gauss-Seidel method appears to be diverging. Residual: $current_residual"
            is_ok_to_terminate = true;
        else
            is_ok_to_terminate = false;
        end

        # update the archive -
        y = x + d; # generate new solution vector at k
        archive[k] = y; # grab a copy of the solution vector at k+1 (do I need to make a copy here?)
        k += 1;  # update the iteration counter -
        prev_residual = current_residual;
    end

    # return archive -
    return archive;
end

function _mysolve(A::AbstractMatrix{T}, b::AbstractVector{T}, xₒ::AbstractVector{T}, algorithm::MySuccessiveOverRelaxationMethod;
    ϵ::Float64 = 1e-6, maxiterations::Int64 = 1000, ω::Float64 = 1.0) where T <: Number

    # initialize -
    is_ok_to_terminate = false;
    k = 0; # initialize iteration counter to 0
    archive = Dict{Int, Array{Float64,1}}(); # we store every iteration in this dictionary
   
    # setup -
    archive[0] = copy(xₒ); # store the initial guess in the archive
    k += 1;  # update the iteration counter -

    # split the matrix A -
    D = diag(A) |> a-> diagm(a);
    U = triu(A,1);
    L = tril(A,-1);

    # check -
    if (det(D + ω*L) == 0.0)
        error("Matrix D + ω*L is not invertible, cannot proceed with Successive Over-Relaxation Method.")
    end
    C = inv(D + ω*L);

        # Grok: Impl me -
    prev_residual = Inf;
    while (is_ok_to_terminate == false)

        x = copy(archive[k-1]); # grab the current solution vector, create a copy so we don't overwrite the data in the archive
        r = b - A*x; # compute the residual
        current_residual = norm(r);
        d = ω * C * r; # compute the direction vector

        # check the error condition -
        if (current_residual < ϵ)
            is_ok_to_terminate = true;
        elseif (k > maxiterations)
            @warn "SOR method did not converge within $maxiterations iterations. Final residual: $current_residual"
            is_ok_to_terminate = true;
        elseif (current_residual > 1e10)  # Check for divergence
            @warn "SOR method appears to be diverging. Residual: $current_residual"
            is_ok_to_terminate = true;
        else
            is_ok_to_terminate = false;
        end

        # update the archive -
        y = x + d;
        archive[k] = y; # grab a copy of the solution vector at k+1 (do I need to make a copy here?)
        k += 1;  # update the iteration counter -
        prev_residual = current_residual;
    end
    
    # Successive Over-Relaxation method
    return archive;
end


# -- PUBLIC METHODS BELOW HERE ---------------------------------------------------------------------------------------------------------------------------------------- #


"""
    mysolve(A::AbstractMatrix{T}, b::AbstractVector{T}, xₒ::AbstractVector{T}; 
    algorithm::AbstractLinearSolverAlgorithm = MyJacobiMethod(), ϵ::Float64 = 0.01, maxiterations::Int64 = 100) where T <: Number

The `solve` function solves the linear system of equations `Ax = b` using the specified algorithm. 
The function returns the solution vector `x` for each iteration of an iterative method. 

### Arguments
- `A::AbstractMatrix{T}`: The system matrix `A` in the linear system of equations `Ax = b`.
- `b::AbstractVector{T}`: The right-hand side vector `b` in the linear system of equations `Ax = b`.
- `xₒ::AbstractVector{T}`: The initial guess for the solution vector `x`.
- `algorithm::MyAbstractLinearSolverAlgorithm`: The algorithm to use to solve the linear system of equations. The default algorithm is `JacobiMethod()`.
- `ϵ::Float64`: The error tolerance for the iterative method. The default value is `1e-6`.
- `maxiterations::Int64`: The maximum number of iterations for the iterative method. The default value is `1000`.
- `ω::Float64`: The relaxation factor for the Successive Over-Relaxation method. The default value is `1.0`. This parameter is only used if the `SuccessiveOverRelaxationMethod` algorithm is selected.

### Returns
- `d::Dict{Int,Array{T,1}}`: The solution vector `x` for each iteration of an iterative method. The keys of the dictionary are the iteration numbers, and the values are the solution vectors at each iteration.
"""
function mysolve(A::AbstractMatrix{T}, b::AbstractVector{T}, xₒ::AbstractVector{T};
    algorithm::MyAbstractLinearSolverAlgorithm = MyJacobiMethod(), 
    ϵ::Float64 = 1e-6, maxiterations::Int64 = 1000, ω::Float64 = 1.0) where T <: Number
    
    
    # return -
    return _mysolve(A, b, xₒ, algorithm, ϵ = ϵ, maxiterations = maxiterations, ω = ω);
end

# -- PUBLIC METHODS ABOVE HERE ---------------------------------------------------------------------------------------------------------------------------------------- #