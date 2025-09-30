


# --- PUBLIC METHODS BELOW HERE -------------------------------------------------------------------------------- #
function build(base::String, model::MyBiggModelsEndpointModel; apiversion::String = "v2")::String
    
    # TODO: implement this function, and remove the throw statement
    # throw(ArgumentError("build(base::String, model::MyWeatherGridPointEndpointModel) not implemented yet!"));

    # build the URL string -
    url_string = "$(base)/api/$(apiversion)/models";

    # return the URL string -
    return url_string;
end

function build(base::String, model::MyBiggModelsDownloadModelEndpointModel; apiversion::String = "v2")::String

    # get data -
    bigg_id = model.bigg_id;

    # build the URL string -
    url_string = "$(base)/api/$(apiversion)/models/$(bigg_id)/download";

    # return the URL string -
    return url_string;
end

function build(modeltype::Type{MyOptimalOpenExtentProblemCalculationModel}, 
    data::NamedTuple)::MyOptimalOpenExtentProblemCalculationModel

   # get data -
    S = data.S;
    fluxbounds = data.fluxbounds;
    speciesbounds = data.speciesbounds;
    objective = data.objective;
    species = data.species;
    reactions = data.reactions;

    # build an empty model -
    model = modeltype();

    # add data to the model -
    model.S = S;
    model.fluxbounds = fluxbounds;
    model.speciesbounds = speciesbounds;
    model.objective = objective;
    model.species = species;
    model.reactions = reactions;
    
    # return the model -
    return model;
end

function build(modeltype::Type{MyPrimalFluxBalanceAnalysisCalculationModel}, 
    data::NamedTuple)::MyPrimalFluxBalanceAnalysisCalculationModel

    # get data -
    S = data.S;
    fluxbounds = data.fluxbounds;
    objective = data.objective;
    species = data.species;
    reactions = data.reactions;
 
    # build an empty model -
    model = modeltype();
 
    # add data to the model -
    model.S = S;
    model.fluxbounds = fluxbounds;
    model.objective = objective;
    model.species = species;
    model.reactions = reactions;
     
     # return the model -
     return model;
 end
# --- PUBLIC METHODS ABOVE HERE -------------------------------------------------------------------------------- #