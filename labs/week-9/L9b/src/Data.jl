
"""
    fixedcircle(center::Tuple{Float64,Float64}; number_of_points::Int = 100, radius::Float64 = 1.0) -> Array{Float64,2}

Generate random data points around a center point that lie on a circle.

### Arguments
- `center::Tuple{Float64,Float64}`: The center point around which the data points will be generated.
- `number_of_points::Int = 100`: The number of data points to generate.
- `radius::Float64 = 1.0`: The radius of the circle around the center point. Default value is 1.0.

### Returns
- A 2D array of data points. The first two columns are the x and y coordinates of the data points.
"""
function fixedcircle(center::Tuple{Float64,Float64}; 
    number_of_points::Int = 100, radius::Float64 = 1.0)::Array{Float64,2}

    # initialize -
    data = zeros(number_of_points, 2);
    θ = range(0, 2π, length=number_of_points);

    # generate the data -
    for i ∈ 1:number_of_points
        # generate random data points -
        data[i,1] = center[1] + radius * cos(θ[i]); # x
        data[i,2] = center[2] + radius * sin(θ[i]); # y
    end

    # return -
    return data;
end

"""
    generatedatacloud(center::Tuple{Float64,Float64}; number_of_points::Int = 100, radius::Float64 = 1.0, label::Int64 = 1) -> Array{Float64,2}

Generate random data points around a center point that have a label, and radius less than equal to the given radius.

### Arguments
- `center::Tuple{Float64,Float64}`: The center point around which the data points will be generated.
- `number_of_points::Int = 100`: The number of data points to generate.
- `radius::Float64 = 1.0`: The radius of the circle around the center point. Default value is 1.0.
- `label::Int64 = 1`: The label to assign to the data points. Default value is 1.

### Returns
- A 2D array of data points. The first two columns are the x and y coordinates of the data points, and the third column is the label.
"""
function generatedatacloud(center::Tuple{Float64,Float64}; 
    number_of_points::Int = 100, radius::Float64 = 1.0, label::Int64 = 1)::Array{Float64,2}

    # initialize -
    data = zeros(number_of_points, 3);

    # generate the data -
    for i ∈ 1:number_of_points
        
        θ = rand() * 2π; # random angle
        r = rand() * radius; # random radius

        # generate random data points -
        data[i,1] = center[1] + r * cos(θ); # x
        data[i,2] = center[2] + r * sin(θ); # y
        data[i,3] = label; # label
    end

    # return -
    return data;
end