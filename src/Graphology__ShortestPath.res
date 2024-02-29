module type GRAPH_TYPES = Graphology__GraphTypes.T

module type SHORTESTPATH = {
  include GRAPH_TYPES

  module Unweighted: {
    // Unweighted
    // todo: result might be null if no path found and raises Error exception. how to handle it
    let bidirectional: (t, node, node) => array<node>

    // todo: result is a map like :  { '1': [ '1' ], '2': [ '1', '2' ], '3': [ '1', '2', '3' ] } how to handle it?
    let singleSource: (t, node) => RescriptCore.Dict.t<array<node>>

    // todo: result is a map
    let singleSourceLength: (t, node) => RescriptCore.Dict.t<int>

    // todo: result is a map
    let undirectedSingleSourceLength: (t, node) => RescriptCore.Dict.t<int>
  }

  module Dijkstra: {
    // todo: result might be null if no path found and raises Error exception. how to handle it

    let bidirectional: (
      t,
      node,
      node,
      ~weight: @unwrap
      [
        | #Attr(string)
        | #Getter((edge, edgeAttr<'a>) => int)
      ]=?,
      unit,
    ) => array<node>

    // todo: result is a map like :  { '1': [ '1' ], '2': [ '1', '2' ], '3': [ '1', '2', '3' ] } how to handle it?
    let singleSource: (
      t,
      node,
      ~weight: @unwrap
      [
        | #Attr(string)
        | #Getter((edge, edgeAttr<'a>) => int)
      ]=?,
      unit,
    ) => RescriptCore.Dict.t<array<node>>
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
    // Unweighted
    // todo: result might be null if no path found and raises Error exception. how to handle it
    @module("graphology-shortest-path") @scope("unweighted")
    external bidirectional: (t, node, node) => array<node> = "bidirectional"

    // todo: result is a map like :  { '1': [ '1' ], '2': [ '1', '2' ], '3': [ '1', '2', '3' ] } how to handle it?
    @module("graphology-shortest-path") @scope("unweighted")
    external singleSource: (t, node) => RescriptCore.Dict.t<array<node>> = "singleSource"

    // todo: result is a map
    @module("graphology-shortest-path") @scope("unweighted")
    external singleSourceLength: (t, node) => RescriptCore.Dict.t<int> = "singleSourceLength"

    // todo: result is a map
    @module("graphology-shortest-path") @scope("unweighted")
    external undirectedSingleSourceLength: (t, node) => RescriptCore.Dict.t<int> =
      "undirectedSingleSourceLength"
  }

  module Dijkstra = {
    // todo: result might be null if no path found and raises Error exception. how to handle it
    // todo: optiona getEdgeWeight arg is not supported yet

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
      unit,
    ) => array<node> = "bidirectional"

    // todo: result is a map like :  { '1': [ '1' ], '2': [ '1', '2' ], '3': [ '1', '2', '3' ] } how to handle it?
    // todo: optiona getEdgeWeight arg is not supported yet
    @module("graphology-shortest-path") @scope("dijkstra")
    external singleSource: (
      t,
      node,
      ~weight: @unwrap
      [
        | #Attr(string)
        | #Getter((edge, edgeAttr<'a>) => int)
      ]=?,
      unit,
    ) => RescriptCore.Dict.t<array<node>> = "singleSource"
  }

  module Utils = {
    @module("graphology-shortest-path")
    external edgePathFromNodePath: (t, array<node>) => array<edge> = "edgePathFromNodePath"
  }
}
