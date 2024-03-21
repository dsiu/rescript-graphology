@@uncurried
module type GRAPH_TYPES = Graphology__GraphTypes.T

module type CONFIG = {
  type node
  type edge
}

module type GRAPH = {
  include GRAPH_TYPES

  type graphOptions = {
    allowSelfLoops?: bool,
    multi?: bool,
    @as("type") type_?: [#mixed | #undirected | #directed],
  }

  type serializedGraphAttr<'a> = {..} as 'a
  type serializedNodeAttr<'a> = {..} as 'a
  type serializedEdgeAttr<'a> = {..} as 'a

  type serialized<'g, 'n, 'e> = {
    attributes: serializedGraphAttr<'g>,
    nodes: array<serializedNodeAttr<'n>>,
    edges: array<serializedNodeAttr<'e>>,
  }

  //
  // Instantiation
  //
  let makeGraph: (~options: graphOptions=?) => t

  // Specialized Constructors
  let makeDirectedGraph: unit => t
  let makeUndirectedGraph: unit => t
  let makeMultiGraph: unit => t
  let makeMultiDirectedGraph: unit => t
  let makeMultiUndirectedGraph: unit => t

  // Static from method
  let from: ('a, ~options: graphOptions=?) => t

  // From Specialized Constructors
  let fromDirectedGraph: 'a => t
  let fromUndirectedGraph: unit => t
  let fromMultiGraph: unit => t
  let fromMultiDirectedGraph: unit => t
  let fromMultiUndirectedGraph: unit => t

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
  let addNode: (t, node, ~attr: nodeAttr<'a>=?) => unit
  let mergeNode: (t, node, ~attr: nodeAttr<'a>=?) => (node, bool)
  let updateNode: (t, node, node => node) => (node, bool)
  let addEdge: (t, node, node, ~attr: edgeAttr<'a>=?) => unit
  let addEdgeWithKey: (t, edge, node, node, ~attr: edgeAttr<'a>=?) => unit
  let mergeEdge: (t, node, node, ~attr: edgeAttr<'a>=?) => (edge, bool, bool, bool)
  let mergeEdgeWithKey: (t, edge, node, node, ~attr: edgeAttr<'a>=?) => (edge, bool, bool, bool)
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

  //
  // Attributes
  //
  // Graph Attributes
  let getAttribute: (t, string) => 'a
  let getAttributes: t => graphAttr<'a>
  let hasAttribute: (t, string) => bool
  let setAttribute: (t, string, 'a) => unit
  let updateAttribute: (t, string, 'a => 'a) => unit
  let removeAttribute: (t, string) => unit
  let replaceAttributes: (t, graphAttr<'a>) => unit
  let mergeAttributes: (t, graphAttr<'a>) => unit
  let updateAttributes: (t, graphAttr<'a> => graphAttr<'a>) => unit

  // Node Attribute
  let getNodeAttribute: (t, node, string) => 'a
  let getNodeAttributes: (t, node) => nodeAttr<'a>
  let hasNodeAttribute: (t, node, string) => bool
  let setNodeAttribute: (t, node, string, 'a) => unit
  let updateNodeAttribute: (t, node, string, 'a => 'a) => unit
  let removeNodeAttribute: (t, node, string) => unit
  let replaceNodeAttributes: (t, node, nodeAttr<'a>) => unit
  let mergeNodeAttributes: (t, node, nodeAttr<'a>) => unit
  let updateNodeAttributes: (t, node, nodeAttr<'a> => graphAttr<'a>) => unit
  let updateEachNodeAttributes: (t, (node, nodeAttr<'a>) => nodeAttr<'a>) => unit

  // Edge Attribute
  let getEdgeAttribute: (t, edge, string) => 'a
  let getEdgeAttributes: (t, edge) => edgeAttr<'a>
  let hasEdgeAttribute: (t, edge, string) => bool
  let setEdgeAttribute: (t, edge, string, 'a) => unit
  let updateEdgeAttribute: (t, edge, string, 'a => 'a) => unit
  let removeEdgeAttribute: (t, edge, string) => unit
  let replaceEdgeAttributes: (t, edge, edgeAttr<'a>) => unit
  let mergeEdgeAttributes: (t, edge, edgeAttr<'a>) => unit
  let updateEdgeAttributes: (t, edge, edgeAttr<'a> => graphAttr<'a>) => unit
  let updateEachEdgeAttributes: (t, (edge, edgeAttr<'a>) => edgeAttr<'a>) => unit

  //
  // Iteration
  //
  // Nodes Iteration
  module NodesIter: {
    open Graphology__Graph_NodesIter
    include NODES_ITER
      with type t := t
      and type node := node
      and type edge := edge
      and type graphAttr<'a> := graphAttr<'a>
      and type nodeAttr<'a> := nodeAttr<'a>
      and type edgeAttr<'a> := edgeAttr<'a>
  }

  //
  // Edges Iteration
  module EdgesIter: {
    open Graphology__Graph_EdgesIter
    include EDGES_ITER
      with type t := t
      and type node := node
      and type edge := edge
      and type graphAttr<'a> := graphAttr<'a>
      and type nodeAttr<'a> := nodeAttr<'a>
      and type edgeAttr<'a> := edgeAttr<'a>
  }

  //
  // Neighbors Iteration
  module NeighborsIter: {
    open Graphology__Graph_NeighborsIter
    include NEIGHBORS_ITER
      with type t := t
      and type node := node
      and type edge := edge
      and type graphAttr<'a> := graphAttr<'a>
      and type nodeAttr<'a> := nodeAttr<'a>
      and type edgeAttr<'a> := edgeAttr<'a>
  }

  // Serialization
  let import: (t, serialized<'g, 'n, 'e>, ~merge: bool=?) => unit
  let export: t => serialized<'g, 'n, 'e>

  // Known methods
  let inspect: t => string

  //
  // Standard Libraries
  //
  module Generators: {
    open Graphology__Generators
    include GENERATORS
      with type t := t
      and type node := node
      and type edge := edge
      and type graphAttr<'a> := graphAttr<'a>
      and type nodeAttr<'a> := nodeAttr<'a>
      and type edgeAttr<'a> := edgeAttr<'a>
  }

  module Layout: {
    open Graphology__Layout
    include LAYOUT
      with type t := t
      and type node := node
      and type edge := edge
      and type graphAttr<'a> := graphAttr<'a>
      and type nodeAttr<'a> := nodeAttr<'a>
      and type edgeAttr<'a> := edgeAttr<'a>
  }

  module ShortestPath: {
    open Graphology__ShortestPath
    include SHORTESTPATH
      with type t := t
      and type node := node
      and type edge := edge
      and type graphAttr<'a> := graphAttr<'a>
      and type nodeAttr<'a> := nodeAttr<'a>
      and type edgeAttr<'a> := edgeAttr<'a>
  }

  module SimplePath: {
    open Graphology__SimplePath
    include SIMPLEPATH
      with type t := t
      and type node := node
      and type edge := edge
      and type graphAttr<'a> := graphAttr<'a>
      and type nodeAttr<'a> := nodeAttr<'a>
      and type edgeAttr<'a> := edgeAttr<'a>
  }

  module SVG: {
    open Graphology__SVG
    include SVG
      with type t := t
      and type node := node
      and type edge := edge
      and type graphAttr<'a> := graphAttr<'a>
      and type nodeAttr<'a> := nodeAttr<'a>
      and type edgeAttr<'a> := edgeAttr<'a>
  }

  module GEXF: {
    open Graphology__GEXF
    include GEXF
      with type t := t
      and type node := node
      and type edge := edge
      and type graphAttr<'a> := graphAttr<'a>
      and type nodeAttr<'a> := nodeAttr<'a>
      and type edgeAttr<'a> := edgeAttr<'a>
  }

  module Traversal: {
    open Graphology__Traversal
    include TRAVERSAL
      with type t := t
      and type node := node
      and type edge := edge
      and type graphAttr<'a> := graphAttr<'a>
      and type nodeAttr<'a> := nodeAttr<'a>
      and type edgeAttr<'a> := edgeAttr<'a>
  }

  module Utils: {
    open Graphology__Utils
    include UTILS
      with type t := t
      and type node := node
      and type edge := edge
      and type graphAttr<'a> := graphAttr<'a>
      and type nodeAttr<'a> := nodeAttr<'a>
      and type edgeAttr<'a> := edgeAttr<'a>
  }
}

module type MAKE_GRAPH = (C: CONFIG) => (GRAPH with type node = C.node and type edge = C.edge)

module MakeGraph: MAKE_GRAPH = (C: CONFIG) => {
  type t
  type node = C.node
  type edge = C.edge
  type graphAttr<'a> = {..} as 'a
  type nodeAttr<'a> = {..} as 'a
  type edgeAttr<'a> = {..} as 'a

  type graphOptions = {
    allowSelfLoops?: bool,
    multi?: bool,
    @as("type") type_?: [#mixed | #undirected | #directed],
  }

  type serializedGraphAttr<'a> = {..} as 'a
  type serializedNodeAttr<'a> = {..} as 'a
  type serializedEdgeAttr<'a> = {..} as 'a

  type serialized<'g, 'n, 'e> = {
    attributes: serializedGraphAttr<'g>,
    nodes: array<serializedNodeAttr<'n>>,
    edges: array<serializedNodeAttr<'e>>,
  }

  @new @module("graphology") @scope("default")
  external makeGraph: (~options: graphOptions=?) => t = "Graph"

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

  // Static from method
  @module("graphology") @scope("Graph")
  external from: ('a, ~options: graphOptions=?) => t = "from"
  // From Specialized Constructors
  @module("graphology") @scope("DirectedGraph")
  external fromDirectedGraph: 'a => t = "from"

  @module("graphology") @scope("UndirectedGraph")
  external fromUndirectedGraph: 'a => t = "from"

  @module("graphology") @scope("MultiGraph")
  external fromMultiGraph: 'a => t = "from"

  @module("graphology") @scope("MultiDirectedGraph")
  external fromMultiDirectedGraph: 'a => t = "from"

  @module("graphology") @scope("MultiUndirectedGraph")
  external fromMultiUndirectedGraph: 'a => t = "from"

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
  @send external addNode: (t, node, ~attr: nodeAttr<'a>=?) => unit = "addNode"
  @send external mergeNode: (t, node, ~attr: nodeAttr<'a>=?) => (node, bool) = "mergeNode"
  @send external updateNode: (t, node, node => node) => (node, bool) = "updateNode"

  @send external addEdge: (t, node, node, ~attr: edgeAttr<'a>=?) => unit = "addEdge"

  @send
  external addEdgeWithKey: (t, edge, node, node, ~attr: edgeAttr<'a>=?) => unit = "addEdgeWithKey"

  @send
  external mergeEdge: (t, node, node, ~attr: edgeAttr<'a>=?) => (edge, bool, bool, bool) =
    "mergeEdge"

  @send
  external mergeEdgeWithKey: (
    t,
    edge,
    node,
    node,
    ~attr: edgeAttr<'a>=?,
  ) => (edge, bool, bool, bool) = "mergeEdgeWithKey"

  @send
  external updateEdge: (t, node, node, edgeAttr<'a> => edgeAttr<'a>) => (edge, bool, bool, bool) =
    "updateEdge"

  @send
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
  // Graph attributes
  @send external getAttribute: (t, string) => 'a = "getAttribute"
  @send external getAttributes: t => graphAttr<'a> = "getAttributes"
  @send external hasAttribute: (t, string) => bool = "hasAttribute"
  @send external setAttribute: (t, string, 'a) => unit = "setAttribute"
  @send external updateAttribute: (t, string, 'a => 'a) => unit = "updateAttribute"
  @send external removeAttribute: (t, string) => unit = "removeAttribute"
  @send external replaceAttributes: (t, graphAttr<'a>) => unit = "replaceAttributes"
  @send external mergeAttributes: (t, graphAttr<'a>) => unit = "mergeAttributes"
  @send external updateAttributes: (t, graphAttr<'a> => graphAttr<'a>) => unit = "updateAttributes"

  // Node Attributes
  @send external getNodeAttribute: (t, node, string) => 'a = "getNodeAttribute"
  @send external getNodeAttributes: (t, node) => nodeAttr<'a> = "getNodeAttributes"
  @send external hasNodeAttribute: (t, node, string) => bool = "hasNodeAttribute"
  @send external setNodeAttribute: (t, node, string, 'a) => unit = "setNodeAttribute"
  @send external updateNodeAttribute: (t, node, string, 'a => 'a) => unit = "updateNodeAttribute"
  @send external removeNodeAttribute: (t, node, string) => unit = "removeNodeAttribute"
  @send external replaceNodeAttributes: (t, node, nodeAttr<'a>) => unit = "replaceNodeAttributes"
  @send external mergeNodeAttributes: (t, node, nodeAttr<'a>) => unit = "mergeNodeAttributes"
  @send
  external updateNodeAttributes: (t, node, nodeAttr<'a> => nodeAttr<'a>) => unit =
    "updateNodeAttributes"
  @send
  external updateEachNodeAttributes: (t, (node, nodeAttr<'a>) => nodeAttr<'a>) => unit =
    "updateEachNodeAttributes"

  // Edge Attributes
  @send external getEdgeAttribute: (t, edge, string) => 'a = "getEdgeAttribute"
  @send external getEdgeAttributes: (t, edge) => edgeAttr<'a> = "getEdgeAttributes"
  @send external hasEdgeAttribute: (t, edge, string) => bool = "hasEdgeAttribute"
  @send external setEdgeAttribute: (t, edge, string, 'a) => unit = "setEdgeAttribute"
  @send external updateEdgeAttribute: (t, edge, string, 'a => 'a) => unit = "updateEdgeAttribute"
  @send external removeEdgeAttribute: (t, edge, string) => unit = "removeEdgeAttribute"
  @send external replaceEdgeAttributes: (t, edge, edgeAttr<'a>) => unit = "replaceEdgeAttributes"
  @send external mergeEdgeAttributes: (t, edge, edgeAttr<'a>) => unit = "mergeEdgeAttributes"
  @send
  external updateEdgeAttributes: (t, edge, edgeAttr<'a> => edgeAttr<'a>) => unit =
    "updateEdgeAttributes"
  @send
  external updateEachEdgeAttributes: (t, (edge, edgeAttr<'a>) => edgeAttr<'a>) => unit =
    "updateEachEdgeAttributes"

  //
  // Iteration
  //
  // Nodes Iteration
  module NodesIter = Graphology__Graph_NodesIter.MakeNodesIter({
    type t = t
    type node = node
    type edge = edge
    type graphAttr<'a> = graphAttr<'a>
    type nodeAttr<'a> = nodeAttr<'a>
    type edgeAttr<'a> = edgeAttr<'a>
  })

  // Edges Iteration
  module EdgesIter = Graphology__Graph_EdgesIter.MakeEdgesIter({
    type t = t
    type node = node
    type edge = edge
    type graphAttr<'a> = graphAttr<'a>
    type nodeAttr<'a> = nodeAttr<'a>
    type edgeAttr<'a> = edgeAttr<'a>
  })

  // Neighbors Iteration
  module NeighborsIter = Graphology__Graph_NeighborsIter.MakeNeighborsIter({
    type t = t
    type node = node
    type edge = edge
    type graphAttr<'a> = graphAttr<'a>
    type nodeAttr<'a> = nodeAttr<'a>
    type edgeAttr<'a> = edgeAttr<'a>
  })

  // Serialization
  @send external import: (t, serialized<'g, 'n, 'e>, ~merge: bool=?) => unit = "import"
  @send external export: t => serialized<'g, 'n, 'e> = "export"

  // Known methods
  @send external inspect: t => string = "inspect"

  //
  // Graphology Stand Libraries
  //
  module Generators = Graphology__Generators.MakeGenerators({
    type t = t
    type node = node
    type edge = edge
    type graphAttr<'a> = graphAttr<'a>
    type nodeAttr<'a> = nodeAttr<'a>
    type edgeAttr<'a> = edgeAttr<'a>
  })

  module Layout = Graphology__Layout.MakeLayout({
    type t = t
    type node = node
    type edge = edge
    type graphAttr<'a> = graphAttr<'a>
    type nodeAttr<'a> = nodeAttr<'a>
    type edgeAttr<'a> = edgeAttr<'a>
  })

  module ShortestPath = Graphology__ShortestPath.MakeShortestPath({
    type t = t
    type node = node
    type edge = edge
    type graphAttr<'a> = graphAttr<'a>
    type nodeAttr<'a> = nodeAttr<'a>
    type edgeAttr<'a> = edgeAttr<'a>
  })

  module SimplePath = Graphology__SimplePath.MakeSimplePath({
    type t = t
    type node = node
    type edge = edge
    type graphAttr<'a> = graphAttr<'a>
    type nodeAttr<'a> = nodeAttr<'a>
    type edgeAttr<'a> = edgeAttr<'a>
  })

  module SVG = Graphology__SVG.MakeSVG({
    type t = t
    type node = node
    type edge = edge
    type graphAttr<'a> = graphAttr<'a>
    type nodeAttr<'a> = nodeAttr<'a>
    type edgeAttr<'a> = edgeAttr<'a>
  })

  module GEXF = Graphology__GEXF.MakeGEXF({
    type t = t
    type node = node
    type edge = edge
    type graphAttr<'a> = graphAttr<'a>
    type nodeAttr<'a> = nodeAttr<'a>
    type edgeAttr<'a> = edgeAttr<'a>
  })

  module Traversal = Graphology__Traversal.MakeTraversal({
    type t = t
    type node = node
    type edge = edge
    type graphAttr<'a> = graphAttr<'a>
    type nodeAttr<'a> = nodeAttr<'a>
    type edgeAttr<'a> = edgeAttr<'a>
  })

  module Utils = Graphology__Utils.MakeUtils({
    type t = t
    type node = node
    type edge = edge
    type graphAttr<'a> = graphAttr<'a>
    type nodeAttr<'a> = nodeAttr<'a>
    type edgeAttr<'a> = edgeAttr<'a>
  })
}
