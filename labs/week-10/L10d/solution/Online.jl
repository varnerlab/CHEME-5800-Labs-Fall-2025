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

function play(model::MyTwoPersonZeroSumGameModel)

    # initialize -
    n = model.n; # how many experts do we have?
    T = model.T; # how many rounds do we play?
    ϵ = model.ϵ; # learning rate
    weights = model.weights; # weights of the experts
    M = model.payoffmatrix; # payoff matrix
    results_array = zeros(Int64, T, 2); # aggregator predictions

    # main simulation loop -
    for t ∈ 1:T
       
        # compute the probability vector p -
        Φ = sum(weights[t, :]); # Φ is sum of the weights at time t
        p = weights[t, :]/Φ; # probability vector p
        d = Categorical(p); # define the distribution
        #results_array[t, 1] = argmax(p); # store the aggregator prediction (choose max probability)
        results_array[t, 1] = rand(d); # store the aggregator prediction (choose random according to the distribution)
        
        # define q -
        q = zeros(Float64, n);
        for i ∈ 1:n
            q[i] = sum(M[i, :].*p); # compute the expected payoff for each expert
        end
        qstar =  argmax(q);
        results_array[t, 2] = qstar; # store the adversary action
        
        q̄ = zeros(Float64, n);
        q̄[qstar] = 1.0; # action for the adversary

        # compute for 
        m = -M*q̄;

        # update the weights -
        for i ∈ 1:n
            weights[t+1, i] = weights[t, i]*exp(-ϵ*m[i]);
        end
    end

    # return -
    return (results_array, weights);
end