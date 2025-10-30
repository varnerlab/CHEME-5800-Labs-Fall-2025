"""
    function play(model::MyBinaryWeightedMajorityAlgorithmModel, 
        data::Array{Float64,2})::Tuple{Array{Int64,2}, Array{Float64,2}}

This method plays the online learning game using the `MyBinaryWeightedMajorityAlgorithmModel` instance and the provided data. 
It returns the results of the game and the updated weights of the experts.

### Arguments
- `model::MyBinaryWeightedMajorityAlgorithmModel`: An instance of the `MyBinaryWeightedMajorityAlgorithmModel` type.
- `data::Array{Float64,2}`: A 2D array containing the data for the game.

### Returns 
- `results_array::Array{Int64,2}`: A 2D array containing the results of the game. Each row corresponds to a round, and the columns contain:
- `weights::Array{Float64,2}`: A 2D array containing the updated weights of the experts after each round.
"""
function play(model::MyBinaryWeightedMajorityAlgorithmModel, 
    data::Array{Float64,2})

    # initialize -
    n = model.n; # how many experts do we have?
    T = model.T; # how many rounds do we play?
    ϵ = model.ϵ; # learning rate
    weights = model.weights; # weights of the experts
    expert = model.expert; # expert function
    adversary = model.adversary; # adversary function
    results_array = zeros(Int64, T, 3+n); # aggregator predictions

    # main simulation loop -
    for t ∈ 1:T
        
        # query the experts -
        expert_predictions = zeros(Int64, n);
        for i ∈ 1:n
            expert_predictions[i] = expert(i, t, data); # call the expert function, returns a prediction for expert i at time t-1
        end

        # store the expert predictions -
        for i ∈ 1:n
            results_array[t, i] = expert_predictions[i];
        end

        # compute the weighted prediction -
        weight_down_vote = findall(x-> x == -1, expert_predictions) |> i-> sum(weights[t, i]);
        weight_up_vote = findall(x-> x == 1, expert_predictions) |> i-> sum(weights[t, i]);
        aggregator_prediction = (weight_up_vote > weight_down_vote) ? 1 : -1;
        results_array[t,n+1] = aggregator_prediction; # store the aggregator prediction

        # query the adversary -
        actual = adversary(t, data); # call the adversary function, returns the actual outcome at time t
        results_array[t, n+2] = actual; # store the adversary outcome

        # compute the aggregator loss -
        results_array[t, end] = (aggregator_prediction == actual) ? 0 : 1;

        # compute the loss for each expert -
        loss = zeros(Float64, n);
        for i ∈ 1:n
            loss[i] = (expert_predictions[i] == actual) ? 0.0 : 1.0; # change the sign of the loss, to update the weights
        end

        # update the weights -
        for i ∈ 1:n
            weights[t+1, i] = weights[t, i]*(1 - ϵ*loss[i]);
        end
    end

    # return -
    return (results_array, weights);
end

"""
    function play(model::MyTwoPersonZeroSumGameModel)::Tuple{Array{Int64,2}, Array{Float64,2}}

This method plays the two-person zero-sum game using the `MyTwoPersonZeroSumGameModel` instance. 
It returns the results of the game and the updated weights of the experts.

### Arguments
- `model::MyTwoPersonZeroSumGameModel`: An instance of the `MyTwoPersonZeroSumGameModel` type.

### Returns 
- `results_array::Array{Int64,2}`: A 2D array containing the results of the game. Each row corresponds to a round, and the columns contain:
    - The first column is the action of the row player (aggregator).
    - The second column is the action of the column player (adversary).
- `weights::Array{Float64,2}`: A 2D array containing the updated weights of the experts after each round.
"""
function play(model::MyTwoPersonZeroSumGameModel)

    # initialize -
    n = model.n; # how many experts do we have?
    T = model.T; # how many rounds do we play?
    ϵ = model.ϵ; # learning rate
    weights = model.weights; # weights of the experts
    M = model.payoffmatrix; # payoff matrix
    L = -M; # loss matrix
    results_array = zeros(Int64, T, 2); # aggregator predictions

    # main simulation loop -
    # TODO: implement the play method for the two-person zero-sum game model
    # TODO: remove(delete or comment out) the error exception below once implemented
    throw(ErrorException("Ooops! The play method is not implemented yet. Better fix that."))

    # return -
    return (results_array, weights);
end