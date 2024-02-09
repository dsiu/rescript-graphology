module type CONFIG = {
  type node
  type nodeAttr
  type edge
  type edgeAttr
}

module type GRAPH = {
  type t
  type node
  type edge
  type nodeAttr
  type edgeAttr

  let makeGraph: unit => t

  // Specialized Constructors
  let makeDirectedGraph: unit => t
  let makeUndirectedGraph: unit => t
  let makeMultiGraph: unit => t
  let makeMultiDirectedGraph: unit => t
  let makeMultiUndirectedGraph: unit => t

  // Properties
  let order: t => int
  let size: t => int
  let type_: t => string
  let multi: t => bool
  let allowSelfLoops: t => bool
  let selfLoopCount: t => int
  let implementation: t => string

  // Read
  let hasNode: (t, node) => bool
  let hasEdge: (t, edge) => bool
  let edge: (t, node, node) => edge
  let degree: (t, node) => int
  let degreeWithoutSelfLoops: (t, node) => int
  let source: (t, edge) => node
  let target: (t, edge) => node
  let opposite: (t, node, edge) => node
  let extremities: (t, edge) => array<node>
  let hasExtremity: (t, edge, node) => bool
  let isDirected: (t, edge) => bool
  let isSelfLoop: (t, edge) => bool
  let areNeighbors: (t, node, node) => bool

  // Mutation
  let addNode: (t, node, ~attr: nodeAttr=?) => unit
  // todo: need to implement this
  //  mergeNode: (t, node) => unit = "mergeNode"
  let updateNode: (t, node, node => node) => (node, bool)
  let addEdge: (t, node, node, ~attr: edgeAttr=?) => unit
  let addEdgeWithKey: (t, edge, node, node, ~attr: edgeAttr=?) => unit
  let mergeEdge: (t, node, node, ~attr: edgeAttr=?) => (edge, bool, bool, bool)
  let mergeEdgeWithKey: (t, edge, node, node, ~attr: edgeAttr=?) => (edge, bool, bool, bool)
  let updateEdge: (t, node, node, edgeAttr => edgeAttr) => (edge, bool, bool, bool)
  let updateEdgeWithKey: (t, edge, node, node, edgeAttr => edgeAttr) => (edge, bool, bool, bool)

  let dropEdge: (t, edge) => unit
  let dropNode: (t, node) => unit

  let clear: t => unit
  let clearEdges: t => unit

  // todo:Attributes

  // Iteration
  // Nodes Iteration
  let nodes: t => array<node>
  let forEachNode: (t, (node, nodeAttr) => unit) => unit
  let mapNodes: (t, (node, nodeAttr) => 'a) => array<'a>
  let filterNodes: (t, (node, nodeAttr) => bool) => array<node>
  let reduceNodes: (t, ('a, node, nodeAttr) => 'a, 'a) => array<node>
  let findNode: (t, (node, nodeAttr) => bool) => node
  let someNode: (t, (node, nodeAttr) => bool) => bool
  let everyNode: (t, (node, nodeAttr) => bool) => bool

  type nodeIterValue = {node: node, attributes: nodeAttr}
  let nodeEntries: t => RescriptCore.Iterator.t<nodeIterValue>

  // Edges Iteration
  let edges: t => array<edge>
  let forEachEdge: (t, (edge, edgeAttr) => unit) => unit
  let mapEdges: (t, (edge, edgeAttr) => 'a) => array<'a>
  let filterEdges: (t, (edge, edgeAttr) => bool) => array<edge>
  let reduceEdges: (t, ('a, edge, edgeAttr) => 'a, 'a) => array<edge>
  let findEdge: (t, (edge, edgeAttr) => bool) => edge
  let someEdge: (t, (edge, edgeAttr) => bool) => bool
  let everyEdge: (t, (edge, edgeAttr) => bool) => bool

  type edgeIterValue = {edge: edge, attributes: edgeAttr}
  let edgeEntries: t => RescriptCore.Iterator.t<edgeIterValue>

  // Neighbors Iteration
  let neighbors: t => array<node>
  let forEachNeighbor: (t, (node, nodeAttr) => unit) => unit
  let mapNeighbors: (t, (node, nodeAttr) => 'a) => array<'a>
  let filterNeighbors: (t, (node, nodeAttr) => bool) => array<node>

  let reduceNeighbors: (t, ('a, node, nodeAttr) => 'a, 'a) => array<node>
  let findNeighbor: (t, (node, nodeAttr) => bool) => node
  let someNeighbor: (t, (node, nodeAttr) => bool) => bool
  let everyNeighbor: (t, (node, nodeAttr) => bool) => bool
  let neighborEntries: t => RescriptCore.Iterator.t<nodeIterValue>

  // Known methods
  let inspect: t => string

  // Standard Libraries
  module ShortestPath: {
    module Unweighted: {
      // Unweighted
      // todo: result might be null if no path found and raises Error exception. how to handle it
      let bidirectional: (t, node, node) => array<node>

      // todo: result is a map like :  { '1': [ '1' ], '2': [ '1', '2' ], '3': [ '1', '2', '3' ] } how to handle it?
      let singleSource: (t, node) => 'a

      // todo: result is a map
      let singleSourceLength: (t, node) => 'a

      // todo: result is a map
      let undirectedSingleSourceLength: (t, node) => 'a
    }

    module Dijkstra: {
      // todo: result might be null if no path found and raises Error exception. how to handle it
      // todo: optiona getEdgeWeight arg is not supported yet
      let bidirectional: (t, node, node) => array<node>

      // todo: result is a map like :  { '1': [ '1' ], '2': [ '1', '2' ], '3': [ '1', '2', '3' ] } how to handle it?
      // todo: optiona getEdgeWeight arg is not supported yet
      let singleSource: (t, node) => 'a
    }

    module Utils: {
      let edgePathFromNodePath: (t, array<node>) => array<edge>
    }
  }

  module SimplePath: {
    type opts
    let allSimplePaths: (t, node, node, ~opts: opts=?) => array<array<node>>
    let allSimpleEdgePaths: (t, node, node, ~opts: opts=?) => array<array<edge>>
    let allSimpleEdgeGroupPaths: (t, node, node, ~opts: opts=?) => array<array<array<node>>>
  }

  module Traversal: {
    let bfs: (t, (node, nodeAttr, int) => unit) => unit
    let bfsFromNode: (t, node, (node, nodeAttr, int) => unit) => unit
    let dfs: (t, (node, nodeAttr, int) => unit) => unit
    let dfsFromNode: (t, node, (node, nodeAttr, int) => unit) => unit
  }
}

module type MAKE_GRAPH = (C: CONFIG) =>
(
  GRAPH
    with type node = C.node
    and type nodeAttr = C.nodeAttr
    and type edge = C.edge
    and type edgeAttr = C.edgeAttr
)

module MakeGraph: MAKE_GRAPH = (C: CONFIG) => {
  type t
  type node = C.node
  type edge = C.edge
  type nodeAttr = C.nodeAttr
  type edgeAttr = C.edgeAttr

  @new @module("graphology") @scope("default") external makeGraph: unit => t = "Graph"

  // Specialized Constructors
  @new @module("graphology") @scope("default")
  external makeDirectedGraph: unit => t = "DirectedGraph"
  @new @module("graphology") @scope("default")
  external makeUndirectedGraph: unit => t = "UndirectedGraph"
  @new @module("graphology") @scope("default") external makeMultiGraph: unit => t = "MultiGraph"
  @new @module("graphology")
  external makeMultiDirectedGraph: unit => t = "MultiDirectedGraph"
  @new @module("graphology")
  external makeMultiUndirectedGraph: unit => t = "MultiUndirectedGraph"

  @get external order: t => int = "order"
  @get external size: t => int = "size"
  @get external type_: t => string = "type"
  @get external multi: t => bool = "multi"
  @get external allowSelfLoops: t => bool = "allowSelfLoops"
  @get external selfLoopCount: t => int = "selfLoopCount"
  @get external implementation: t => string = "implementation"

  @send external hasNode: (t, node) => bool = "hasNode"
  @send external hasEdge: (t, edge) => bool = "hasEdge"
  @send external edge: (t, node, node) => edge = "edge"
  @send external degree: (t, node) => int = "degree"
  @send external degreeWithoutSelfLoops: (t, node) => int = "degreeWithoutSelfLoops"
  @send external source: (t, edge) => node = "source"
  @send external target: (t, edge) => node = "target"
  @send external opposite: (t, node, edge) => node = "opposite"
  @send external extremities: (t, edge) => array<node> = "extremities"
  @send external hasExtremity: (t, edge, node) => bool = "hasExtremity"
  @send external isDirected: (t, edge) => bool = "isDirected"
  @send external isSelfLoop: (t, edge) => bool = "isSelfLoop"
  @send external areNeighbors: (t, node, node) => bool = "areNeighbors"

  // Mutation
  @send external addNode: (t, node, ~attr: nodeAttr=?) => unit = "addNode"
  // todo: need to implement this
  //  @send external mergeNode: (t, node) => unit = "mergeNode"
  @send external updateNode: (t, node, node => node) => (node, bool) = "updateNode"

  @send external addEdge: (t, node, node, ~attr: edgeAttr=?) => unit = "addEdge"
  @send
  external addEdgeWithKey: (t, edge, node, node, ~attr: edgeAttr=?) => unit = "addEdgeWithKey"
  @send
  external mergeEdge: (t, node, node, ~attr: edgeAttr=?) => (edge, bool, bool, bool) = "mergeEdge"
  external mergeEdgeWithKey: (t, edge, node, node, ~attr: edgeAttr=?) => (edge, bool, bool, bool) =
    "mergeEdgeWithKey"
  external updateEdge: (t, node, node, edgeAttr => edgeAttr) => (edge, bool, bool, bool) =
    "updateEdge"
  external updateEdgeWithKey: (
    t,
    edge,
    node,
    node,
    edgeAttr => edgeAttr,
  ) => (edge, bool, bool, bool) = "updateEdgeWithKey"

  @send external dropNode: (t, node) => unit = "dropNode"
  @send external dropEdge: (t, edge) => unit = "dropEdge"

  @send external clear: t => unit = "clear"
  @send external clearEdges: t => unit = "clearEdges"

  // Iteration
  // Nodes Iteration
  @send external nodes: t => array<node> = "nodes"
  @send external forEachNode: (t, (node, nodeAttr) => unit) => unit = "forEachNode"
  @send external mapNodes: (t, (node, nodeAttr) => 'a) => array<'a> = "mapNodes"
  @send external filterNodes: (t, (node, nodeAttr) => bool) => array<node> = "filterNodes"
  @send external reduceNodes: (t, ('a, node, nodeAttr) => 'a, 'a) => array<node> = "reduceNodes"
  @send external findNode: (t, (node, nodeAttr) => bool) => node = "findNode"
  @send external someNode: (t, (node, nodeAttr) => bool) => bool = "someNode"
  @send external everyNode: (t, (node, nodeAttr) => bool) => bool = "everyNode"
  type nodeIterValue = {node: node, attributes: nodeAttr}
  @send external nodeEntries: t => Core__Iterator.t<nodeIterValue> = "nodeEntries"

  // Edges Iteration
  @send external edges: t => array<edge> = "edges"
  @send external forEachEdge: (t, (edge, edgeAttr) => unit) => unit = "forEachEdge"
  @send external mapEdges: (t, (edge, edgeAttr) => 'a) => array<'a> = "mapEdges"
  @send external filterEdges: (t, (edge, edgeAttr) => bool) => array<edge> = "filterEdges"
  @send external reduceEdges: (t, ('a, edge, edgeAttr) => 'a, 'a) => array<edge> = "reduceEdges"
  @send external findEdge: (t, (edge, edgeAttr) => bool) => edge = "findEdge"
  @send external someEdge: (t, (edge, edgeAttr) => bool) => bool = "someEdge"
  @send external everyEdge: (t, (edge, edgeAttr) => bool) => bool = "everyEdge"
  type edgeIterValue = {edge: edge, attributes: edgeAttr}
  @send external edgeEntries: t => Core__Iterator.t<edgeIterValue> = "edgeEntries"

  // Neighbors Iteration
  @send external neighbors: t => array<node> = "neighbors"
  @send external forEachNeighbor: (t, (node, nodeAttr) => unit) => unit = "forEachNeighbor"
  @send external mapNeighbors: (t, (node, nodeAttr) => 'a) => array<'a> = "mapNeighbors"
  @send external filterNeighbors: (t, (node, nodeAttr) => bool) => array<node> = "filterNeighbors"
  @send
  external reduceNeighbors: (t, ('a, node, nodeAttr) => 'a, 'a) => array<node> = "reduceNeighbors"
  @send external findNeighbor: (t, (node, nodeAttr) => bool) => node = "findNeighbor"
  @send external someNeighbor: (t, (node, nodeAttr) => bool) => bool = "someNeighbor"
  @send external everyNeighbor: (t, (node, nodeAttr) => bool) => bool = "everyNeighbor"
  @send external neighborEntries: t => Core__Iterator.t<nodeIterValue> = "neighborEntries"

  // Known methods
  @send external inspect: t => string = "inspect"

  //
  // Graphology Stand Libraries
  //
  module ShortestPath = {
    module Unweighted = {
      // Unweighted
      // todo: result might be null if no path found and raises Error exception. how to handle it
      @module("graphology-shortest-path") @scope("unweighted")
      external bidirectional: (t, node, node) => array<node> = "bidirectional"

      // todo: result is a map like :  { '1': [ '1' ], '2': [ '1', '2' ], '3': [ '1', '2', '3' ] } how to handle it?
      @module("graphology-shortest-path") @scope("unweighted")
      external singleSource: (t, node) => 'a = "singleSource"

      // todo: result is a map
      @module("graphology-shortest-path") @scope("unweighted")
      external singleSourceLength: (t, node) => 'a = "singleSourceLength"

      // todo: result is a map
      @module("graphology-shortest-path") @scope("unweighted")
      external undirectedSingleSourceLength: (t, node) => 'a = "undirectedSingleSourceLength"
    }

    module Dijkstra = {
      // todo: result might be null if no path found and raises Error exception. how to handle it
      // todo: optiona getEdgeWeight arg is not supported yet
      @module("graphology-shortest-path") @scope("dijkstra")
      external bidirectional: (t, node, node) => array<node> = "bidirectional"

      // todo: result is a map like :  { '1': [ '1' ], '2': [ '1', '2' ], '3': [ '1', '2', '3' ] } how to handle it?
      // todo: optiona getEdgeWeight arg is not supported yet
      @module("graphology-shortest-path") @scope("dijkstra")
      external singleSource: (t, node) => 'a = "singleSource"
    }

    module Utils = {
      @module("graphology-shortest-path") @scope("utils")
      external edgePathFromNodePath: (t, array<node>) => array<edge> = "edgePathFromNodePath"
    }
  }

  module SimplePath = {
    type opts = {maxDepth?: int}

    @module("graphology-simple-path")
    external allSimplePaths: (t, node, node, ~opts: opts=?) => array<array<node>> = "allSimplePaths"

    @module("graphology-simple-path")
    external allSimpleEdgePaths: (t, node, node, ~opts: opts=?) => array<array<edge>> =
      "allSimpleEdgePaths"

    @module("graphology-simple-path")
    external allSimpleEdgeGroupPaths: (t, node, node, ~opts: opts=?) => array<array<array<node>>> =
      "allSimpleEdgeGroupPaths"
  }

  module Traversal = {
    // todo: the option arg is not supported yet
    @module("graphology-traversal")
    external bfs: (t, (node, nodeAttr, int) => unit) => unit = "bfs"

    @module("graphology-traversal")
    external bfsFromNode: (t, node, (node, nodeAttr, int) => unit) => unit = "bfsFromNode"

    @module("graphology-traversal")
    external dfs: (t, (node, nodeAttr, int) => unit) => unit = "dfs"

    @module("graphology-traversal")
    external dfsFromNode: (t, node, (node, nodeAttr, int) => unit) => unit = "dfsFromNode"
  }
}
