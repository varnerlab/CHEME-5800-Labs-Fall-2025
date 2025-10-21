function ∇f(f, x, y, θ, h)
    
    diff = zeros(size(θ))
    for i ∈ eachindex(θ)
        θᵢ = copy(θ) # bad ...
        θᵢ[i] += h
        diff[i] = (f(x, y, θᵢ) - f(x, y, θ)) / h
    end
    
    return diff
end