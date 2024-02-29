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

  // Instantiation
  let makeGraph: (~options: graphOptions=?, unit) => t

  // Specialized Constructors
  let makeDirectedGraph: unit => t
  let makeUndirectedGraph: unit => t
  let makeMultiGraph: unit => t
  let makeMultiDirectedGraph: unit => t
  let makeMultiUndirectedGraph: unit => t

  // Static from method
  let from: ('a, ~options: graphOptions=?, unit) => t
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
  let addNode: (t, node, ~attr: nodeAttr<'a>=?, unit) => unit
  let mergeNode: (t, node, ~attr: nodeAttr<'a>=?, unit) => (node, bool)
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

  // Attributes
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
  let getNodeAttribute: (t, string) => 'a
  let getNodeAttributes: t => nodeAttr<'a>
  let hasNodeAttribute: (t, string) => bool
  let setNodeAttribute: (t, string, 'a) => unit
  let updateNodeAttribute: (t, string, 'a => 'a) => unit
  let removeNodeAttribute: (t, string) => unit
  let replaceNodeAttributes: (t, nodeAttr<'a>) => unit
  let mergeNodeAttributes: (t, nodeAttr<'a>) => unit
  let updateNodeAttributes: (t, nodeAttr<'a> => graphAttr<'a>) => unit
  let updateEachNodeAttributes: (t, (node, nodeAttr<'a>) => nodeAttr<'a>) => unit

  // Edge Attribute
  let getEdgeAttribute: (t, string) => 'a
  let getEdgeAttributes: t => edgeAttr<'a>
  let hasEdgeAttribute: (t, string) => bool
  let setEdgeAttribute: (t, string, 'a) => unit
  let updateEdgeAttribute: (t, string, 'a => 'a) => unit
  let removeEdgeAttribute: (t, string) => unit
  let replaceEdgeAttributes: (t, edgeAttr<'a>) => unit
  let mergeEdgeAttributes: (t, edgeAttr<'a>) => unit
  let updateEdgeAttributes: (t, edgeAttr<'a> => graphAttr<'a>) => unit
  let updateEachEdgeAttributes: (t, (node, edgeAttr<'a>) => edgeAttr<'a>) => unit

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

  // Serialization
  let import: (t, serialized<'g, 'n, 'e>, ~merge: bool=?) => unit
  let export: t => serialized<'g, 'n, 'e>

  // Known methods
  let inspect: t => string

  //
  // Standard Libraries
  //
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

  // Static from method
  @module("graphology") @scope("Graph")
  external from: ('a, ~options: graphOptions=?, unit) => t = "from"
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
  @send external addNode: (t, node, ~attr: nodeAttr<'a>=?, unit) => unit = "addNode"
  @send external mergeNode: (t, node, ~attr: nodeAttr<'a>=?, unit) => (node, bool) = "mergeNode"
  @send external updateNode: (t, node, node => node) => (node, bool) = "updateNode"

  @send external addEdge: (t, node, node, ~attr: edgeAttr<'a>=?, unit) => unit = "addEdge"

  @send
  external addEdgeWithKey: (t, edge, node, node, ~attr: edgeAttr<'a>=?, unit) => unit =
    "addEdgeWithKey"

  @send
  external mergeEdge: (t, node, node, ~attr: edgeAttr<'a>=?, unit) => (edge, bool, bool, bool) =
    "mergeEdge"

  @send
  external mergeEdgeWithKey: (
    t,
    edge,
    node,
    node,
    ~attr: edgeAttr<'a>=?,
    unit,
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
  @send external getNodeAttribute: (t, string) => 'a = "getNodeAttribute"
  @send external getNodeAttributes: t => nodeAttr<'a> = "getNodeAttributes"
  @send external hasNodeAttribute: (t, string) => bool = "hasNodeAttribute"
  @send external setNodeAttribute: (t, string, 'a) => unit = "setNodeAttribute"
  @send external updateNodeAttribute: (t, string, 'a => 'a) => unit = "updateNodeAttribute"
  @send external removeNodeAttribute: (t, string) => unit = "removeNodeAttribute"
  @send external replaceNodeAttributes: (t, nodeAttr<'a>) => unit = "replaceNodeAttributes"
  @send external mergeNodeAttributes: (t, nodeAttr<'a>) => unit = "mergeNodeAttributes"
  @send
  external updateNodeAttributes: (t, nodeAttr<'a> => nodeAttr<'a>) => unit = "updateNodeAttributes"
  @send
  external updateEachNodeAttributes: (t, (node, nodeAttr<'a>) => nodeAttr<'a>) => unit =
    "updateEachNodeAttributes"

  // Edge Attributes
  @send external getEdgeAttribute: (t, string) => 'a = "getEdgeAttribute"
  @send external getEdgeAttributes: t => edgeAttr<'a> = "getEdgeAttributes"
  @send external hasEdgeAttribute: (t, string) => bool = "hasEdgeAttribute"
  @send external setEdgeAttribute: (t, string, 'a) => unit = "setEdgeAttribute"
  @send external updateEdgeAttribute: (t, string, 'a => 'a) => unit = "updateEdgeAttribute"
  @send external removeEdgeAttribute: (t, string) => unit = "removeEdgeAttribute"
  @send external replaceEdgeAttributes: (t, edgeAttr<'a>) => unit = "replaceEdgeAttributes"
  @send external mergeEdgeAttributes: (t, edgeAttr<'a>) => unit = "mergeEdgeAttributes"
  @send
  external updateEdgeAttributes: (t, edgeAttr<'a> => edgeAttr<'a>) => unit = "updateEdgeAttributes"
  @send
  external updateEachEdgeAttributes: (t, (node, edgeAttr<'a>) => edgeAttr<'a>) => unit =
    "updateEachEdgeAttributes"

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

  // Serialization
  @send external import: (t, serialized<'g, 'n, 'e>, ~merge: bool=?) => unit = "import"
  @send external export: t => serialized<'g, 'n, 'e> = "export"

  // Known methods
  @send external inspect: t => string = "inspect"

  //
  // Graphology Stand Libraries
  //
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

  module Traversal = Graphology__Traversal.MakeTraversal({
    type t = t
    type node = node
    type edge = edge
    type graphAttr<'a> = graphAttr<'a>
    type nodeAttr<'a> = nodeAttr<'a>
    type edgeAttr<'a> = edgeAttr<'a>
  })
}
