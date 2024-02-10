@@uncurried

module type CONFIG = {
  type node
  type edge
}

module type GRAPH = {
  type t
  type node
  type edge
  type nodeAttr<'a> = {..} as 'a
  type edgeAttr<'a> = {..} as 'a

  type graphOptions = {
    allowSelfLoops?: bool,
    multi?: bool,
    @as("type") type_?: [#mixed | #undirected | #directed],
  }

  // Instantiation
  let makeGraph: (~options: graphOptions=?, unit) => t

  // Specialized Constructors
  let makeDirectedGraph: unit => t
  let makeUndirectedGraph: unit => t
  let makeMultiGraph: unit => t
  let makeMultiDirectedGraph: unit => t
  let makeMultiUndirectedGraph: unit => t

  // Static from method
  // todo: need to implement this
  // let from: (data, option) => t

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
  let addNode: (t, node, ~attr: nodeAttr<'a>=?, unit) => unit
  // todo: need to implement this
  //  mergeNode: (t, node) => unit = "mergeNode"
  let updateNode: (t, node, node => node) => (node, bool)
  let addEdge: (t, node, node, ~attr: edgeAttr<'a>=?, unit) => unit
  let addEdgeWithKey: (t, edge, node, node, ~attr: edgeAttr<'a>=?, unit) => unit
  let mergeEdge: (t, node, node, ~attr: edgeAttr<'a>=?, unit) => (edge, bool, bool, bool)
  let mergeEdgeWithKey: (
    t,
    edge,
    node,
    node,
    ~attr: edgeAttr<'a>=?,
    unit,
  ) => (edge, bool, bool, bool)
  let updateEdge: (t, node, node, edgeAttr<'a> => edgeAttr<'a>) => (edge, bool, bool, bool)
  let updateEdgeWithKey: (
    t,
    edge,
    node,
    node,
    edgeAttr<'a> => edgeAttr<'a>,
  ) => (edge, bool, bool, bool)

  let dropEdge: (t, edge) => unit
  let dropNode: (t, node) => unit

  let clear: t => unit
  let clearEdges: t => unit

  // todo:Attributes
  let getEdgeAttribute: (t, edge, string) => 'a

  // Iteration
  // Nodes Iteration
  let nodes: t => array<node>
  let forEachNode: (t, (node, nodeAttr<'a>) => unit) => unit
  let mapNodes: (t, (node, nodeAttr<'a>) => 'b) => array<'b>
  let filterNodes: (t, (node, nodeAttr<'a>) => bool) => array<node>
  let reduceNodes: (t, ('b, node, nodeAttr<'a>) => 'b, 'b) => array<node>
  let findNode: (t, (node, nodeAttr<'a>) => bool) => node
  let someNode: (t, (node, nodeAttr<'a>) => bool) => bool
  let everyNode: (t, (node, nodeAttr<'a>) => bool) => bool

  type nodeIterValue<'a> = {node: node, attributes: nodeAttr<'a>}
  let nodeEntries: t => RescriptCore.Iterator.t<nodeIterValue<'a>>

  // Edges Iteration
  let edges: t => array<edge>
  let forEachEdge: (t, (edge, edgeAttr<'a>) => unit) => unit
  let mapEdges: (t, (edge, edgeAttr<'a>) => 'b) => array<'b>
  let filterEdges: (t, (edge, edgeAttr<'a>) => bool) => array<edge>
  let reduceEdges: (t, ('a, edge, edgeAttr<'a>) => 'a, 'a) => array<edge>
  let findEdge: (t, (edge, edgeAttr<'a>) => bool) => edge
  let someEdge: (t, (edge, edgeAttr<'a>) => bool) => bool
  let everyEdge: (t, (edge, edgeAttr<'a>) => bool) => bool

  type edgeIterValue<'a> = {edge: edge, attributes: edgeAttr<'a>}
  let edgeEntries: t => RescriptCore.Iterator.t<edgeIterValue<'a>>

  // Neighbors Iteration
  let neighbors: t => array<node>
  let forEachNeighbor: (t, (node, nodeAttr<'a>) => unit) => unit
  let mapNeighbors: (t, (node, nodeAttr<'a>) => 'b) => array<'b>
  let filterNeighbors: (t, (node, nodeAttr<'a>) => bool) => array<node>

  let reduceNeighbors: (t, ('b, node, nodeAttr<'a>) => 'b, 'b) => array<node>
  let findNeighbor: (t, (node, nodeAttr<'a>) => bool) => node
  let someNeighbor: (t, (node, nodeAttr<'a>) => bool) => bool
  let everyNeighbor: (t, (node, nodeAttr<'a>) => bool) => bool
  let neighborEntries: t => RescriptCore.Iterator.t<nodeIterValue<'a>>

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

      let bidirectional: (
        t,
        node,
        node,
        ~weight: @unwrap
        [
          | #Attr(string)
          | #Getter((edge, edgeAttr<'a>) => int)
        ],
      ) => array<node>

      // todo: result is a map like :  { '1': [ '1' ], '2': [ '1', '2' ], '3': [ '1', '2', '3' ] } how to handle it?
      let singleSource: (t, node) => 'a
    }

    module Utils: {
      let edgePathFromNodePath: (t, array<node>) => array<edge>
    }
  }

  module SimplePath: {
    type opts
    let allSimplePaths: (t, node, node, ~opts: opts=?, unit) => array<array<node>>
    let allSimpleEdgePaths: (t, node, node, ~opts: opts=?, unit) => array<array<edge>>
    let allSimpleEdgeGroupPaths: (t, node, node, ~opts: opts=?, unit) => array<array<array<node>>>
  }

  module Traversal: {
    let bfs: (t, (node, nodeAttr<'a>, int) => unit) => unit
    let bfsFromNode: (t, node, (node, nodeAttr<'a>, int) => unit) => unit
    let dfs: (t, (node, nodeAttr<'a>, int) => unit) => unit
    let dfsFromNode: (t, node, (node, nodeAttr<'a>, int) => unit) => unit
  }
}

module type MAKE_GRAPH = (C: CONFIG) =>
(
  GRAPH
    with type node = C.node
    and type edge = C.edge
    and type nodeAttr<'a> = {..} as 'a
    and type edgeAttr<'a> = {..} as 'a
)

module MakeGraph: MAKE_GRAPH = (C: CONFIG) => {
  type t
  type node = C.node
  type edge = C.edge
  type nodeAttr<'a> = {..} as 'a
  type edgeAttr<'a> = {..} as 'a

  type graphOptions = {
    allowSelfLoops?: bool,
    multi?: bool,
    @as("type") type_?: [#mixed | #undirected | #directed],
  }

  @new @module("graphology") @scope("default")
  external makeGraph: (~options: graphOptions=?, unit) => t = "Graph"

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
  @send external addNode: (t, node, ~attr: nodeAttr<'a>=?, unit) => unit = "addNode"
  // todo: need to implement this
  //  @send external mergeNode: (t, node) => unit = "mergeNode"
  @send external updateNode: (t, node, node => node) => (node, bool) = "updateNode"

  @send external addEdge: (t, node, node, ~attr: edgeAttr<'a>=?, unit) => unit = "addEdge"
  @send
  external addEdgeWithKey: (t, edge, node, node, ~attr: edgeAttr<'a>=?, unit) => unit =
    "addEdgeWithKey"
  @send
  external mergeEdge: (t, node, node, ~attr: edgeAttr<'a>=?, unit) => (edge, bool, bool, bool) =
    "mergeEdge"
  external mergeEdgeWithKey: (
    t,
    edge,
    node,
    node,
    ~attr: edgeAttr<'a>=?,
    unit,
  ) => (edge, bool, bool, bool) = "mergeEdgeWithKey"
  external updateEdge: (t, node, node, edgeAttr<'a> => edgeAttr<'a>) => (edge, bool, bool, bool) =
    "updateEdge"
  external updateEdgeWithKey: (
    t,
    edge,
    node,
    node,
    edgeAttr<'a> => edgeAttr<'a>,
  ) => (edge, bool, bool, bool) = "updateEdgeWithKey"

  @send external dropNode: (t, node) => unit = "dropNode"
  @send external dropEdge: (t, edge) => unit = "dropEdge"

  @send external clear: t => unit = "clear"
  @send external clearEdges: t => unit = "clearEdges"

  // Attributes
  @send external getEdgeAttribute: (t, edge, string) => 'a = "getEdgeAttribute"

  // Iteration
  // Nodes Iteration
  @send external nodes: t => array<node> = "nodes"
  @send external forEachNode: (t, (node, nodeAttr<'a>) => unit) => unit = "forEachNode"
  @send external mapNodes: (t, (node, nodeAttr<'a>) => 'b) => array<'b> = "mapNodes"
  @send external filterNodes: (t, (node, nodeAttr<'a>) => bool) => array<node> = "filterNodes"
  @send external reduceNodes: (t, ('b, node, nodeAttr<'a>) => 'b, 'b) => array<node> = "reduceNodes"
  @send external findNode: (t, (node, nodeAttr<'a>) => bool) => node = "findNode"
  @send external someNode: (t, (node, nodeAttr<'a>) => bool) => bool = "someNode"
  @send external everyNode: (t, (node, nodeAttr<'a>) => bool) => bool = "everyNode"
  type nodeIterValue<'a> = {node: node, attributes: nodeAttr<'a>}
  @send external nodeEntries: t => Core__Iterator.t<nodeIterValue<'a>> = "nodeEntries"

  // Edges Iteration
  @send external edges: t => array<edge> = "edges"
  @send external forEachEdge: (t, (edge, edgeAttr<'a>) => unit) => unit = "forEachEdge"
  @send external mapEdges: (t, (edge, edgeAttr<'a>) => 'b) => array<'b> = "mapEdges"
  @send external filterEdges: (t, (edge, edgeAttr<'a>) => bool) => array<edge> = "filterEdges"
  @send external reduceEdges: (t, ('b, edge, edgeAttr<'a>) => 'b, 'b) => array<edge> = "reduceEdges"
  @send external findEdge: (t, (edge, edgeAttr<'a>) => bool) => edge = "findEdge"
  @send external someEdge: (t, (edge, edgeAttr<'a>) => bool) => bool = "someEdge"
  @send external everyEdge: (t, (edge, edgeAttr<'a>) => bool) => bool = "everyEdge"
  type edgeIterValue<'a> = {edge: edge, attributes: edgeAttr<'a>}
  @send external edgeEntries: t => Core__Iterator.t<edgeIterValue<'a>> = "edgeEntries"

  // Neighbors Iteration
  @send external neighbors: t => array<node> = "neighbors"
  @send external forEachNeighbor: (t, (node, nodeAttr<'a>) => unit) => unit = "forEachNeighbor"
  @send external mapNeighbors: (t, (node, nodeAttr<'a>) => 'b) => array<'b> = "mapNeighbors"
  @send
  external filterNeighbors: (t, (node, nodeAttr<'a>) => bool) => array<node> = "filterNeighbors"
  @send
  external reduceNeighbors: (t, ('b, node, nodeAttr<'a>) => 'b, 'b) => array<node> =
    "reduceNeighbors"
  @send external findNeighbor: (t, (node, nodeAttr<'a>) => bool) => node = "findNeighbor"
  @send external someNeighbor: (t, (node, nodeAttr<'a>) => bool) => bool = "someNeighbor"
  @send external everyNeighbor: (t, (node, nodeAttr<'a>) => bool) => bool = "everyNeighbor"
  @send external neighborEntries: t => Core__Iterator.t<nodeIterValue<'a>> = "neighborEntries"

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
      external bidirectional: (
        t,
        node,
        node,
        ~weight: @unwrap
        [
          | #Attr(string)
          | #Getter((edge, edgeAttr<'a>) => int)
        ],
      ) => array<node> = "bidirectional"

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
    external allSimplePaths: (t, node, node, ~opts: opts=?, unit) => array<array<node>> =
      "allSimplePaths"

    @module("graphology-simple-path")
    external allSimpleEdgePaths: (t, node, node, ~opts: opts=?, unit) => array<array<edge>> =
      "allSimpleEdgePaths"

    @module("graphology-simple-path")
    external allSimpleEdgeGroupPaths: (
      t,
      node,
      node,
      ~opts: opts=?,
      unit,
    ) => array<array<array<node>>> = "allSimpleEdgeGroupPaths"
  }

  module Traversal = {
    // todo: the option arg is not supported yet
    @module("graphology-traversal")
    external bfs: (t, (node, nodeAttr<'a>, int) => unit) => unit = "bfs"

    @module("graphology-traversal")
    external bfsFromNode: (t, node, (node, nodeAttr<'a>, int) => unit) => unit = "bfsFromNode"

    @module("graphology-traversal")
    external dfs: (t, (node, nodeAttr<'a>, int) => unit) => unit = "dfs"

    @module("graphology-traversal")
    external dfsFromNode: (t, node, (node, nodeAttr<'a>, int) => unit) => unit = "dfsFromNode"
  }
}
