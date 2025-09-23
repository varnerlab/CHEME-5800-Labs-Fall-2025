function _LAB_BFS(graph::MySimpleDirectedGraphModel, node::MyGraphNodeModel, visited::Set{Int64}, order::Array{Int64,1}; 
    verbose::Bool = false)

    # initialize -
    q = Queue{Int64}();

    # enqueue the first node -
    enqueue!(q, node.id);
    
    # TODO: Implement the BFS algorithm here
    throw(ErrorException("BFS algorithm not yet implemented!"));
end

function _LAB_DFS(graph::MySimpleDirectedGraphModel, node::MyGraphNodeModel, 
    visited::Set{Int64}, order::Array{Int64,1}; verbose::Bool = false)

    # print - if verbose is true
    if (verbose == true)
        println("Visiting node: ", node.id);
    end

    # TODO: Implement the DFS algorithm here
    throw(ErrorException("DFS algorithm not yet implemented!"));
end

"""
    function mychildren(graph::T, node::MyGraphNodeModel) -> Set{Int64} where T <: AbstractGraphModel

Returns the set of child node IDs for a given node in the graph.

### Arguments
- `graph::T`: The graph to search where `T <: AbstractGraphModel`.
- `node::MyGraphNodeModel`: The node to find children for.

### Returns
- `Set{Int64}`: The set of child node IDs.
"""
function mychildren(graph::MySimpleDirectedGraphModel, node::MyGraphNodeModel)::Set{Int64}
    return graph.children[node.id];
end


"""
    function walk(graph::T, startnode::MyGraphNodeModel, algorithm::AbstractGraphTraversalAlgorithm; 
    verbose::Bool = false) where T <: AbstractGraphModel

The `walk` function traverses the graph starting from a given node using the specified algorithm (either Depth-First Search or Breadth-First Search). 
It maintains a set of visited nodes to avoid cycles and ensure that each node is processed only once.

### Arguments
- `graph::T`: The graph to traverse.
- `startnode::MyGraphNodeModel`: The node to start the traversal from.
- `algorithm::AbstractGraphTraversalAlgorithm`: The algorithm to use for the traversal. This can be either an instance of `DepthFirstSearchAlgorithm` or `BreadthFirstSearchAlgorithm`. Default is `BreadthFirstSearchAlgorithm`.
- `verbose::Bool`: Whether to print verbose output (default is false).

### Returns
- `Array{Int64,1}`: The collection of visited node IDs in the order they were visited.
"""
function mywalk(graph::MySimpleDirectedGraphModel, startnode::MyGraphNodeModel; 
    algorithm::AbstractGraphTraversalAlgorithm = BreadthFirstSearchAlgorithm(), 
    verbose::Bool = false)::Array{Int64,1} 

    # initialize -
    visited = Set{Int64}();
    order = Array{Int64,1}();

    if algorithm isa DepthFirstSearchAlgorithm
        _LAB_DFS(graph, startnode, visited, order; verbose=verbose);
    elseif algorithm isa BreadthFirstSearchAlgorithm
        _LAB_BFS(graph, startnode, visited, order; verbose=verbose);
    else
        throw(ErrorException("Unsupported graph traversal algorithm"));
    end

    return order;
end