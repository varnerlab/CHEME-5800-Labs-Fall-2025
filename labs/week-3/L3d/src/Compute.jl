# Private helper function to swap two elements in an array
function _swap!(array::Array{T,1}, i::Int, j::Int) where T <: Number
    tmp = array[i]
    array[i] = array[j]
    array[j] = tmp
end

# -- PUBLIC API BELOW HERE ---------------------------------------------------------------------------------------- #

"""
    bubblesort(array::Array{T,1}) -> Array{T,1} where T <: Number

Sorts an array using the bubble sort algorithm.

### Arguments
- `array::Array{T,1}`: The array to be sorted, where `T` is a subtype of `Number`.

### Returns
- `Array{T,1}`: A new array containing the sorted elements where the elements are of type `T`.
"""
function bubblesort(array::Array{T,1})::Array{T,1} where T <: Number

    # initialize -
    arr = copy(array) # make a copy of the array
    N = length(arr) # how many elements in the array?
    n = N;
    swapped = true;

    # TODO: implement the bubble sort algorithm here
    # TODO: comment out the line below when you implement the algorithm
    
    # Bubble sort implementation using while loop
    # swapped = true
    # while swapped
    #     swapped = false
    #     for j in 1:N-1
    #         if arr[j] > arr[j+1]
    #             _swap!(arr, j, j+1)
    #             swapped = true
    #         end
    #     end
    #     N -= 1  # Reduce the range since the largest element is now in place
    # end

    while swapped == true
        swapped = false
        for j ∈ 1:n-1
            if arr[j] > arr[j+1]
                _swap!(arr, j, j+1)
                swapped = true
            end
        end
        n -= 1 # after each pass, the largest element is in its correct position, reduce the range of comparison
    end

    # return sorted array -
    return arr
end;

"""
    function quicksort(arr::Array{T,1}) -> Array{T,1} where T <: Number

The `quicksort` function sorts an array of numbers using the quicksort algorithm.

### Arguments
- `arr::Array{T,1}`: An array of numbers to be sorted where `T` is a subtype of `Number`.

### Returns
- `Array{T,1}`: A sorted array of numbers where `T` is a subtype of `Number`.

See: https://en.wikipedia.org/wiki/Quicksort
"""
function quicksort(arr::Array{T,1})::Array{T,1} where T <: Number
    
    # initialize -
    smaller_array = Array{T,1}()
    larger_array = Array{T,1}()

    # Base case: if we only have one element, return the array
    if length(arr) <= 1
        return arr
    else
        
        # Recursive case: we have more than one element in the array 
        # 1. grab the *last* element - we call this the pivot element
        # 2. partition arr into elements that are smaller and larger than the pivot element

        # grab the *last* element of the array - this is the pivot element
        pivot = arr[end]

        # populate the smaller array -
        for x ∈ arr[1:end-1]
            
            # if this value of x is *smaller or equal to* the pivot element, it goes in the smaller array
            # otherwise, x goes in the larger array
            if (x <= pivot)
                push!(smaller_array, x);
            else
                push!(larger_array, x);
            end
        end

        # show the user what is going on ...
        # println("small: $(smaller_array) pivot: $(pivot) large: $(larger_array)")

        # return: this line creates (and returns) an array with the smaller part, the pivot and the larger part
        return [quicksort(smaller_array); pivot; quicksort(larger_array)]
    end
end

# -- PUBLIC API ABOVE HERE ---------------------------------------------------------------------------------------- #   