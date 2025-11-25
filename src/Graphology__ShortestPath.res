module type GRAPH_TYPES = Graphology__GraphTypes.T

module type SHORTESTPATH = {
  include GRAPH_TYPES

  module Unweighted: {
    // Unweighted shortest path - returns null if no path found
    let bidirectional: (t, node, node) => Nullable.t<array<node>>

    // Returns a map of shortest paths from source to all reachable nodes
    let singleSource: (t, node) => Dict.t<array<node>>

    // Returns a map of shortest path lengths from source to all reachable nodes
    let singleSourceLength: (t, node) => Dict.t<int>

    // Returns a map of shortest path lengths treating graph as undirected
    let undirectedSingleSourceLength: (t, node) => Dict.t<int>
  }

  module Dijkstra: {
    // Dijkstra's shortest path - returns null if no path found
    let bidirectional: (
      t,
      node,
      node,
      ~weight: [
        | #Attr(string)
        | #Getter((edge, edgeAttr<'a>) => int)
      ]=?,
    ) => Nullable.t<array<node>>

    // Returns a map of shortest weighted paths from source to all reachable nodes
    let singleSource: (
      t,
      node,
      ~weight: [
        | #Attr(string)
        | #Getter((edge, edgeAttr<'a>) => int)
      ]=?,
    ) => Dict.t<array<node>>
  }

  module AStar: {
    // A* shortest path - returns null if no path found
    type heuristic = (node, node) => int
    let bidirectional: (
      t,
      node,
      node,
      ~weight: [
        | #Attr(string)
        | #Getter((edge, edgeAttr<'a>) => int)
      ]=?,
      ~heuristic: heuristic=?,
    ) => Nullable.t<array<node>>
  }

  module Utils: {
    let edgePathFromNodePath: (t, array<node>) => array<edge>
  }
}

// functor type
module type SHORTESTPATH_F = (C: GRAPH_TYPES) =>
(
  SHORTESTPATH
    with type t = C.t
    and type node = C.node
    and type edge = C.edge
    and type graphAttr<'a> = C.graphAttr<'a>
    and type nodeAttr<'a> = C.nodeAttr<'a>
    and type edgeAttr<'a> = C.edgeAttr<'a>
)

module MakeShortestPath: SHORTESTPATH_F = (C: GRAPH_TYPES) => {
  type t = C.t
  type node = C.node
  type edge = C.edge
  type graphAttr<'a> = C.graphAttr<'a>
  type nodeAttr<'a> = C.nodeAttr<'a>
  type edgeAttr<'a> = C.edgeAttr<'a>

  module Unweighted = {
    // Unweighted shortest path - returns null if no path found
    @module("graphology-shortest-path") @scope("unweighted")
    external bidirectional: (t, node, node) => Nullable.t<array<node>> = "bidirectional"

    // Returns a map of shortest paths from source to all reachable nodes
    @module("graphology-shortest-path") @scope("unweighted")
    external singleSource: (t, node) => Dict.t<array<node>> = "singleSource"

    // Returns a map of shortest path lengths from source to all reachable nodes
    @module("graphology-shortest-path") @scope("unweighted")
    external singleSourceLength: (t, node) => Dict.t<int> = "singleSourceLength"

    // Returns a map of shortest path lengths treating graph as undirected
    @module("graphology-shortest-path") @scope("unweighted")
    external undirectedSingleSourceLength: (t, node) => Dict.t<int> = "undirectedSingleSourceLength"
  }

  module Dijkstra = {
    // Dijkstra's shortest path - returns null if no path found
    @module("graphology-shortest-path") @scope("dijkstra")
    external bidirectional: (
      t,
      node,
      node,
      ~weight: @unwrap
      [
        | #Attr(string)
        | #Getter((edge, edgeAttr<'a>) => int)
      ]=?,
    ) => Nullable.t<array<node>> = "bidirectional"

    // Returns a map of shortest weighted paths from source to all reachable nodes
    @module("graphology-shortest-path") @scope("dijkstra")
    external singleSource: (
      t,
      node,
      ~weight: @unwrap
      [
        | #Attr(string)
        | #Getter((edge, edgeAttr<'a>) => int)
      ]=?,
    ) => Dict.t<array<node>> = "singleSource"
  }

  module AStar = {
    // A* shortest path - returns null if no path found
    type heuristic = (node, node) => int

    @module("graphology-shortest-path") @scope("astar")
    external bidirectional: (
      t,
      node,
      node,
      ~weight: @unwrap
      [
        | #Attr(string)
        | #Getter((edge, edgeAttr<'a>) => int)
      ]=?,
      ~heuristic: heuristic=?,
    ) => Nullable.t<array<node>> = "bidirectional"
  }

  module Utils = {
    @module("graphology-shortest-path")
    external edgePathFromNodePath: (t, array<node>) => array<edge> = "edgePathFromNodePath"
  }
}
