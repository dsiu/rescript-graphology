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
  type edgesVarArgs = All | Node(node) | FromTo(node, node)

  // Returns an array of relevant edge keys.
  // #.edges
  let edges: (t, edgesVarArgs) => array<edge>
  let inEdges: (t, edgesVarArgs) => array<edge>
  let outEdges: (t, edgesVarArgs) => array<edge>
  let inboundEdges: (t, edgesVarArgs) => array<edge>
  let outboundEdges: (t, edgesVarArgs) => array<edge>
  let directedEdges: (t, edgesVarArgs) => array<edge>
  let undirectedEdges: (t, edgesVarArgs) => array<edge>

  // Iterates over relevant edges using a callback.
  // #.forEachEdge
  type forEachEdgeCallback<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => unit

  type forEachEdgeVarArgs<'a> =
    | All(forEachEdgeCallback<'a>)
    | Node(node, forEachEdgeCallback<'a>)
    | FromTo(node, node, forEachEdgeCallback<'a>)

  let forEachEdge: (t, forEachEdgeVarArgs<'a>) => unit
  let forEachInEdge: (t, forEachEdgeVarArgs<'a>) => unit
  let forEachOutEdge: (t, forEachEdgeVarArgs<'a>) => unit
  let forEachInboundEdge: (t, forEachEdgeVarArgs<'a>) => unit
  let forEachOutboundEdge: (t, forEachEdgeVarArgs<'a>) => unit
  let forEachDirectedEdge: (t, forEachEdgeVarArgs<'a>) => unit
  let forEachUndirectedEdge: (t, forEachEdgeVarArgs<'a>) => unit

  // #.mapEdges
  type mapEdgesCallback<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => edge

  type mapEdgesVarArgs<'a> =
    | All(mapEdgesCallback<'a>)
    | Node(node, mapEdgesCallback<'a>)
    | FromTo(node, node, mapEdgesCallback<'a>)

  let mapEdges: (t, mapEdgesVarArgs<'a>) => array<edge>
  let mapInEdges: (t, mapEdgesVarArgs<'a>) => array<edge>
  let mapOutEdges: (t, mapEdgesVarArgs<'a>) => array<edge>
  let mapInboundEdges: (t, mapEdgesVarArgs<'a>) => array<edge>
  let mapOutboundEdges: (t, mapEdgesVarArgs<'a>) => array<edge>
  let mapDirectedEdges: (t, mapEdgesVarArgs<'a>) => array<edge>
  let mapUndirectedEdges: (t, mapEdgesVarArgs<'a>) => array<edge>

  // #.filterEdges
  type filterEdgesCallback<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => bool

  type filterEdgesVarArgs<'a> =
    | All(filterEdgesCallback<'a>)
    | Node(node, filterEdgesCallback<'a>)
    | FromTo(node, node, filterEdgesCallback<'a>)

  let filterEdges: (t, filterEdgesVarArgs<'a>) => array<edge>
  let filterInEdges: (t, filterEdgesVarArgs<'a>) => array<edge>
  let filterOutEdges: (t, filterEdgesVarArgs<'a>) => array<edge>
  let filterInboundEdges: (t, filterEdgesVarArgs<'a>) => array<edge>
  let filterOutboundEdges: (t, filterEdgesVarArgs<'a>) => array<edge>
  let filterDirectedEdges: (t, filterEdgesVarArgs<'a>) => array<edge>
  let filterUndirectedEdges: (t, filterEdgesVarArgs<'a>) => array<edge>

  // #.reduceEdges
  type reduceEdgesCallback<'a, 'r> = (
    'r,
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => 'r

  type reduceEdgesVarArgs<'a, 'r> =
    | All(reduceEdgesCallback<'a, 'r>, 'r)
    | Node(node, reduceEdgesCallback<'a, 'r>, 'r)
    | FromTo(node, node, reduceEdgesCallback<'a, 'r>, 'r)

  let reduceEdges: (t, reduceEdgesVarArgs<'a, 'r>) => 'r
  let reduceInEdges: (t, reduceEdgesVarArgs<'a, 'r>) => 'r
  let reduceOutEdges: (t, reduceEdgesVarArgs<'a, 'r>) => 'r
  let reduceOutboundEdges: (t, reduceEdgesVarArgs<'a, 'r>) => 'r
  let reduceDirectedEdges: (t, reduceEdgesVarArgs<'a, 'r>) => 'r
  let reduceUndirectedEdges: (t, reduceEdgesVarArgs<'a, 'r>) => 'r

  // #.findEdge
  type findEdgeCallback<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => unit

  type findEdgeVarArgs<'a> =
    | All(findEdgeCallback<'a>)
    | Node(node, findEdgeCallback<'a>)
    | FromTo(node, node, findEdgeCallback<'a>)

  let findEdge: (t, findEdgeVarArgs<'a>) => Nullable.t<edge>
  let findInEdge: (t, findEdgeVarArgs<'a>) => Nullable.t<edge>
  let findOutEdge: (t, findEdgeVarArgs<'a>) => Nullable.t<edge>
  let findInboundEdge: (t, findEdgeVarArgs<'a>) => Nullable.t<edge>
  let findOutboundEdge: (t, findEdgeVarArgs<'a>) => Nullable.t<edge>
  let findDirectedEdge: (t, findEdgeVarArgs<'a>) => Nullable.t<edge>
  let findUndirectedEdge: (t, findEdgeVarArgs<'a>) => Nullable.t<edge>

  // #.someEdge
  type someEdgeCallback<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => bool

  type someEdgeVarArgs<'a> =
    | All(someEdgeCallback<'a>)
    | Node(node, someEdgeCallback<'a>)
    | FromTo(node, node, someEdgeCallback<'a>)

  let someEdge: (t, someEdgeVarArgs<'a>) => bool
  let someInEdge: (t, someEdgeVarArgs<'a>) => bool
  let someOutEdge: (t, someEdgeVarArgs<'a>) => bool
  let someInboundEdge: (t, someEdgeVarArgs<'a>) => bool
  let someOutboundEdge: (t, someEdgeVarArgs<'a>) => bool
  let someDirectedEdge: (t, someEdgeVarArgs<'a>) => bool
  let someUndirectedEdge: (t, someEdgeVarArgs<'a>) => bool

  // #.everyEdge
  type everyEdgeCallback<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => bool

  type everyEdgeVarArgs<'a> =
    | All(everyEdgeCallback<'a>)
    | Node(node, everyEdgeCallback<'a>)
    | FromTo(node, node, everyEdgeCallback<'a>)

  let everyEdge: (t, everyEdgeVarArgs<'a>) => bool
  let everyInEdge: (t, everyEdgeVarArgs<'a>) => bool
  let everyOutEdge: (t, everyEdgeVarArgs<'a>) => bool
  let everyInboundEdge: (t, everyEdgeVarArgs<'a>) => bool
  let everyOutboundEdge: (t, everyEdgeVarArgs<'a>) => bool
  let everyDirectedEdge: (t, everyEdgeVarArgs<'a>) => bool
  let everyUndirectedEdge: (t, everyEdgeVarArgs<'a>) => bool

  //#.edgeEntries
  type edgeIterValue<'a> = {
    edge: edge,
    attributes: edgeAttr<'a>,
    source: node,
    target: node,
    sourceAttributes: nodeAttr<'a>,
    targetAttributes: nodeAttr<'a>,
  }

  type edgeEntriesVarArgs<'a> =
    | All
    | Node(node)
    | FromTo(node, node)

  let edgeEntries: (t, edgeEntriesVarArgs<'a>) => RescriptCore.Iterator.t<edgeIterValue<'a>>
  let inEdgeEntries: (t, edgeEntriesVarArgs<'a>) => RescriptCore.Iterator.t<edgeIterValue<'a>>
  let outEdgeEntries: (t, edgeEntriesVarArgs<'a>) => RescriptCore.Iterator.t<edgeIterValue<'a>>
  let inboundEdgeEntries: (t, edgeEntriesVarArgs<'a>) => RescriptCore.Iterator.t<edgeIterValue<'a>>
  let outboundEdgeEntries: (t, edgeEntriesVarArgs<'a>) => RescriptCore.Iterator.t<edgeIterValue<'a>>
  let directedEdgeEntries: (t, edgeEntriesVarArgs<'a>) => RescriptCore.Iterator.t<edgeIterValue<'a>>
  let undirectedEdgeEntries: (
    t,
    edgeEntriesVarArgs<'a>,
  ) => RescriptCore.Iterator.t<edgeIterValue<'a>>

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
  type edgesVarArgs = All | Node(node) | FromTo(node, node)

  let _edgesVarArgsCall = (t, edgesVarArgs, allFn, nodeFn, fromToFn) => {
    switch edgesVarArgs {
    | All => allFn(t)
    | Node(node) => nodeFn(t, node)
    | FromTo(source, target) => fromToFn(t, source, target)
    }
  }

  // #.edges
  @send external _edges: t => array<edge> = "edges"
  @send external _edgesOfNode: (t, node) => array<edge> = "edges"
  @send external _edgesFromTo: (t, node, node) => array<edge> = "edges"

  let edges = (t, edgesVarArgs) => {
    _edgesVarArgsCall(t, edgesVarArgs, _edges, _edgesOfNode, _edgesFromTo)
  }

  // #.inEdges
  @send external _inEdges: t => array<edge> = "inEdges"
  @send external _inEdgesOfNode: (t, node) => array<edge> = "inEdges"
  @send external _inEdgesFromTo: (t, node, node) => array<edge> = "inEdges"

  let inEdges = (t, edgesVarArgs) => {
    _edgesVarArgsCall(t, edgesVarArgs, _inEdges, _inEdgesOfNode, _inEdgesFromTo)
  }

  // #.outEdges
  @send external _outEdges: t => array<edge> = "outEdges"
  @send external _outEdgesOfNode: (t, node) => array<edge> = "outEdges"
  @send external _outEdgesFromTo: (t, node, node) => array<edge> = "outEdges"

  let outEdges = (t, edgesVarArgs) => {
    _edgesVarArgsCall(t, edgesVarArgs, _outEdges, _outEdgesOfNode, _outEdgesFromTo)
  }

  // #. inboundEdges
  @send external _inboundEdges: t => array<edge> = "inboundEdges"
  @send external _inboundEdgesOfNode: (t, node) => array<edge> = "inboundEdges"
  @send external _inboundEdgesFromTo: (t, node, node) => array<edge> = "inboundEdges"

  let inboundEdges = (t, edgesVarArgs) => {
    _edgesVarArgsCall(t, edgesVarArgs, _inboundEdges, _inboundEdgesOfNode, _inboundEdgesFromTo)
  }

  // #.outboundEdges
  @send external _outboundEdges: t => array<edge> = "outboundEdges"
  @send external _outboundEdgesOfNode: (t, node) => array<edge> = "outboundEdges"
  @send external _outboundEdgesFromTo: (t, node, node) => array<edge> = "outboundEdges"

  let outboundEdges = (t, edgesVarArgs) => {
    _edgesVarArgsCall(t, edgesVarArgs, _outboundEdges, _outboundEdgesOfNode, _outboundEdgesFromTo)
  }

  // #.directedEdges
  @send external _directedEdges: t => array<edge> = "directedEdges"
  @send external _directedEdgesOfNode: (t, node) => array<edge> = "directedEdges"
  @send external _directedEdgesFromTo: (t, node, node) => array<edge> = "directedEdges"

  let directedEdges = (t, edgesVarArgs) => {
    _edgesVarArgsCall(t, edgesVarArgs, _directedEdges, _directedEdgesOfNode, _directedEdgesFromTo)
  }

  // #.undirectedEdges
  @send external _undirectedEdges: t => array<edge> = "undirectedEdges"
  @send external _undirectedEdgesOfNode: (t, node) => array<edge> = "undirectedEdges"
  @send external _undirectedEdgesFromTo: (t, node, node) => array<edge> = "undirectedEdges"

  let undirectedEdges = (t, edgesVarArgs) => {
    _edgesVarArgsCall(
      t,
      edgesVarArgs,
      _undirectedEdges,
      _undirectedEdgesOfNode,
      _undirectedEdgesFromTo,
    )
  }

  // Iterates over relevant edges using a callback.
  type forEachEdgeCallback<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => unit

  type forEachEdgeVarArgs<'a> =
    | All(forEachEdgeCallback<'a>)
    | Node(node, forEachEdgeCallback<'a>)
    | FromTo(node, node, forEachEdgeCallback<'a>)

  let _forEachEdgeVarArgsCall = (t, forEachEdgeVarArgs, allFn, nodeFn, fromToFn) => {
    switch forEachEdgeVarArgs {
    | All(callback) => allFn(t, callback)
    | Node(node, callback) => nodeFn(t, node, callback)
    | FromTo(source, target, callback) => fromToFn(t, source, target, callback)
    }
  }

  // #.forEachEdge
  @send external _forEachEdge: (t, forEachEdgeCallback<'a>) => unit = "forEachEdge"
  @send external _forEachEdgeOfNode: (t, node, forEachEdgeCallback<'a>) => unit = "forEachEdge"
  @send
  external _forEachEdgeFromTo: (t, node, node, forEachEdgeCallback<'a>) => unit = "forEachEdge"

  let forEachEdge = (t, forEachEdgeVarArgs) => {
    _forEachEdgeVarArgsCall(
      t,
      forEachEdgeVarArgs,
      _forEachEdge,
      _forEachEdgeOfNode,
      _forEachEdgeFromTo,
    )
  }

  // #.forEachInEdge
  @send external _forEachInEdge: (t, forEachEdgeCallback<'a>) => unit = "forEachInEdge"
  @send
  external _forEachInEdgeOfNode: (t, node, forEachEdgeCallback<'a>) => unit = "forEachInEdge"
  @send
  external _forEachInEdgeFromTo: (t, node, node, forEachEdgeCallback<'a>) => unit = "forEachInEdge"

  let forEachInEdge = (t, forEachInEdgeVarArgs) => {
    _forEachEdgeVarArgsCall(
      t,
      forEachInEdgeVarArgs,
      _forEachInEdge,
      _forEachInEdgeOfNode,
      _forEachInEdgeFromTo,
    )
  }

  // #.forEachOutEdge
  @send external _forEachOutEdge: (t, forEachEdgeCallback<'a>) => unit = "forEachOutEdge"
  @send
  external _forEachOutEdgeOfNode: (t, node, forEachEdgeCallback<'a>) => unit = "forEachOutEdge"
  @send
  external _forEachOutEdgeFromTo: (t, node, node, forEachEdgeCallback<'a>) => unit =
    "forEachOutEdge"

  let forEachOutEdge = (t, forEachOutEdgeVarArgs) => {
    _forEachEdgeVarArgsCall(
      t,
      forEachOutEdgeVarArgs,
      _forEachOutEdge,
      _forEachOutEdgeOfNode,
      _forEachOutEdgeFromTo,
    )
  }

  // #.forEachInboundEdge
  @send external _forEachInboundEdge: (t, forEachEdgeCallback<'a>) => unit = "forEachInboundEdge"
  @send
  external _forEachInboundEdgeOfNode: (t, node, forEachEdgeCallback<'a>) => unit =
    "forEachInboundEdge"
  @send
  external _forEachInboundEdgeFromTo: (t, node, node, forEachEdgeCallback<'a>) => unit =
    "forEachInboundEdge"

  let forEachInboundEdge = (t, forEachInboundEdgeVarArgs) => {
    _forEachEdgeVarArgsCall(
      t,
      forEachInboundEdgeVarArgs,
      _forEachInboundEdge,
      _forEachInboundEdgeOfNode,
      _forEachInboundEdgeFromTo,
    )
  }

  // #.forEachOutboundEdge
  @send external _forEachOutboundEdge: (t, forEachEdgeCallback<'a>) => unit = "forEachOutboundEdge"
  @send
  external _forEachOutboundEdgeOfNode: (t, node, forEachEdgeCallback<'a>) => unit =
    "forEachOutboundEdge"
  @send
  external _forEachOutboundEdgeFromTo: (t, node, node, forEachEdgeCallback<'a>) => unit =
    "forEachOutboundEdge"

  let forEachOutboundEdge = (t, forEachOutboundEdgeVarArgs) => {
    _forEachEdgeVarArgsCall(
      t,
      forEachOutboundEdgeVarArgs,
      _forEachOutboundEdge,
      _forEachOutboundEdgeOfNode,
      _forEachOutboundEdgeFromTo,
    )
  }

  // #.forEachDirectedEdge
  @send external _forEachDirectedEdge: (t, forEachEdgeCallback<'a>) => unit = "forEachDirectedEdge"
  @send
  external _forEachDirectedEdgeOfNode: (t, node, forEachEdgeCallback<'a>) => unit =
    "forEachDirectedEdge"
  @send
  external _forEachDirectedEdgeFromTo: (t, node, node, forEachEdgeCallback<'a>) => unit =
    "forEachDirectedEdge"

  let forEachDirectedEdge = (t, forEachDirectedEdgeVarArgs) => {
    _forEachEdgeVarArgsCall(
      t,
      forEachDirectedEdgeVarArgs,
      _forEachDirectedEdge,
      _forEachDirectedEdgeOfNode,
      _forEachDirectedEdgeFromTo,
    )
  }

  // #.forEachUndirectedEdge
  @send
  external _forEachUndirectedEdge: (t, forEachEdgeCallback<'a>) => unit = "forEachUndirectedEdge"
  @send
  external _forEachUndirectedEdgeOfNode: (t, node, forEachEdgeCallback<'a>) => unit =
    "forEachUndirectedEdge"
  @send
  external _forEachUndirectedEdgeFromTo: (t, node, node, forEachEdgeCallback<'a>) => unit =
    "forEachUndirectedEdge"

  let forEachUndirectedEdge = (t, forEachUndirectedEdgeVarArgs) => {
    _forEachEdgeVarArgsCall(
      t,
      forEachUndirectedEdgeVarArgs,
      _forEachUndirectedEdge,
      _forEachUndirectedEdgeOfNode,
      _forEachUndirectedEdgeFromTo,
    )
  }

  // #.mapEdges
  type mapEdgesCallback<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => edge

  type mapEdgesVarArgs<'a> =
    | All(mapEdgesCallback<'a>)
    | Node(node, mapEdgesCallback<'a>)
    | FromTo(node, node, mapEdgesCallback<'a>)

  let _mapEdgesVarArgsCall = (t, mapEdgesVarArgs, allFn, nodeFn, fromToFn) => {
    switch mapEdgesVarArgs {
    | All(callback) => allFn(t, callback)
    | Node(node, callback) => nodeFn(t, node, callback)
    | FromTo(source, target, callback) => fromToFn(t, source, target, callback)
    }
  }

  @send external _mapEdges: (t, mapEdgesCallback<'a>) => array<edge> = "mapEdges"
  @send external _mapEdgesOfNode: (t, node, mapEdgesCallback<'a>) => array<edge> = "mapEdges"
  @send
  external _mapEdgesFromTo: (t, node, node, mapEdgesCallback<'a>) => array<edge> = "mapEdges"

  let mapEdges = (t, mapEdgesVarArgs) => {
    _mapEdgesVarArgsCall(t, mapEdgesVarArgs, _mapEdges, _mapEdgesOfNode, _mapEdgesFromTo)
  }

  @send external _mapInEdges: (t, mapEdgesCallback<'a>) => array<edge> = "mapInEdges"
  @send external _mapInEdgesOfNode: (t, node, mapEdgesCallback<'a>) => array<edge> = "mapInEdges"
  @send
  external _mapInEdgesFromTo: (t, node, node, mapEdgesCallback<'a>) => array<edge> = "mapInEdges"

  let mapInEdges = (t, mapEdgesVarArgs) => {
    _mapEdgesVarArgsCall(t, mapEdgesVarArgs, _mapInEdges, _mapEdgesOfNode, _mapInEdgesFromTo)
  }

  @send external _mapOutEdges: (t, mapEdgesCallback<'a>) => array<edge> = "mapOutEdges"
  @send external _mapOutEdgesOfNode: (t, node, mapEdgesCallback<'a>) => array<edge> = "mapOutEdges"
  @send
  external _mapOutEdgesFromTo: (t, node, node, mapEdgesCallback<'a>) => array<edge> = "mapOutEdges"

  let mapOutEdges = (t, mapEdgesVarArgs) => {
    _mapEdgesVarArgsCall(t, mapEdgesVarArgs, _mapOutEdges, _mapEdgesOfNode, _mapOutEdgesFromTo)
  }

  @send external _mapInboundEdges: (t, mapEdgesCallback<'a>) => array<edge> = "mapInboundEdges"
  @send
  external _mapInboundEdgesOfNode: (t, node, mapEdgesCallback<'a>) => array<edge> =
    "mapInboundEdges"
  @send
  external _mapInboundEdgesFromTo: (t, node, node, mapEdgesCallback<'a>) => array<edge> =
    "mapInboundEdges"

  let mapInboundEdges = (t, mapEdgesVarArgs) => {
    _mapEdgesVarArgsCall(
      t,
      mapEdgesVarArgs,
      _mapInboundEdges,
      _mapEdgesOfNode,
      _mapInboundEdgesFromTo,
    )
  }

  @send external _mapOutboundEdges: (t, mapEdgesCallback<'a>) => array<edge> = "mapOutboundEdges"
  @send
  external _mapOutboundEdgesOfNode: (t, node, mapEdgesCallback<'a>) => array<edge> =
    "mapOutboundEdges"
  @send
  external _mapOutboundEdgesFromTo: (t, node, node, mapEdgesCallback<'a>) => array<edge> =
    "mapOutboundEdges"

  let mapOutboundEdges = (t, mapEdgesVarArgs) => {
    _mapEdgesVarArgsCall(
      t,
      mapEdgesVarArgs,
      _mapOutboundEdges,
      _mapEdgesOfNode,
      _mapOutboundEdgesFromTo,
    )
  }

  @send external _mapDirectedEdges: (t, mapEdgesCallback<'a>) => array<edge> = "mapDirectedEdges"
  @send
  external _mapDirectedEdgesOfNode: (t, node, mapEdgesCallback<'a>) => array<edge> =
    "mapDirectedEdges"
  @send
  external _mapDirectedEdgesFromTo: (t, node, node, mapEdgesCallback<'a>) => array<edge> =
    "mapDirectedEdges"

  let mapDirectedEdges = (t, mapEdgesVarArgs) => {
    _mapEdgesVarArgsCall(
      t,
      mapEdgesVarArgs,
      _mapDirectedEdges,
      _mapEdgesOfNode,
      _mapDirectedEdgesFromTo,
    )
  }

  @send
  external _mapUndirectedEdges: (t, mapEdgesCallback<'a>) => array<edge> = "mapUndirectedEdges"
  @send
  external _mapUndirectedEdgesOfNode: (t, node, mapEdgesCallback<'a>) => array<edge> =
    "mapUndirectedEdges"
  @send
  external _mapUndirectedEdgesFromTo: (t, node, node, mapEdgesCallback<'a>) => array<edge> =
    "mapUndirectedEdges"

  let mapUndirectedEdges = (t, mapEdgesVarArgs) => {
    _mapEdgesVarArgsCall(
      t,
      mapEdgesVarArgs,
      _mapUndirectedEdges,
      _mapEdgesOfNode,
      _mapUndirectedEdgesFromTo,
    )
  }

  // #.filterEdges
  type filterEdgesCallback<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => bool

  type filterEdgesVarArgs<'a> =
    | All(filterEdgesCallback<'a>)
    | Node(node, filterEdgesCallback<'a>)
    | FromTo(node, node, filterEdgesCallback<'a>)

  let _filterEdgesVarArgsCall = (t, filterEdgesVarArgs, allFn, nodeFn, fromToFn) => {
    switch filterEdgesVarArgs {
    | All(callback) => allFn(t, callback)
    | Node(node, callback) => nodeFn(t, node, callback)
    | FromTo(source, target, callback) => fromToFn(t, source, target, callback)
    }
  }

  @send external _filterEdges: (t, filterEdgesCallback<'a>) => array<edge> = "filterEdges"
  @send
  external _filterEdgesOfNode: (t, node, filterEdgesCallback<'a>) => array<edge> = "filterEdges"
  @send
  external _filterEdgesFromTo: (t, node, node, filterEdgesCallback<'a>) => array<edge> =
    "filterEdges"

  let filterEdges = (t, filterEdgesVarArgs) => {
    _filterEdgesVarArgsCall(
      t,
      filterEdgesVarArgs,
      _filterEdges,
      _filterEdgesOfNode,
      _filterEdgesFromTo,
    )
  }

  @send external _filterInEdges: (t, filterEdgesCallback<'a>) => array<edge> = "filterInEdges"
  @send
  external _filterInEdgesOfNode: (t, node, filterEdgesCallback<'a>) => array<edge> = "filterInEdges"
  @send
  external _filterInEdgesFromTo: (t, node, node, filterEdgesCallback<'a>) => array<edge> =
    "filterInEdges"

  let filterInEdges = (t, filterEdgesVarArgs) => {
    _filterEdgesVarArgsCall(
      t,
      filterEdgesVarArgs,
      _filterInEdges,
      _filterInEdgesOfNode,
      _filterInEdgesFromTo,
    )
  }

  @send external _filterOutEdges: (t, filterEdgesCallback<'a>) => array<edge> = "filterOutEdges"
  @send
  external _filterOutEdgesOfNode: (t, node, filterEdgesCallback<'a>) => array<edge> =
    "filterOutEdges"
  @send
  external _filterOutEdgesFromTo: (t, node, node, filterEdgesCallback<'a>) => array<edge> =
    "filterOutEdges"

  let filterOutEdges = (t, filterEdgesVarArgs) => {
    _filterEdgesVarArgsCall(
      t,
      filterEdgesVarArgs,
      _filterOutEdges,
      _filterOutEdgesOfNode,
      _filterOutEdgesFromTo,
    )
  }

  @send
  external _filterInboundEdges: (t, filterEdgesCallback<'a>) => array<edge> = "filterInboundEdges"
  @send
  external _filterInboundEdgesOfNode: (t, node, filterEdgesCallback<'a>) => array<edge> =
    "filterInboundEdges"
  @send
  external _filterInboundEdgesFromTo: (t, node, node, filterEdgesCallback<'a>) => array<edge> =
    "filterInboundEdges"

  let filterInboundEdges = (t, filterEdgesVarArgs) => {
    _filterEdgesVarArgsCall(
      t,
      filterEdgesVarArgs,
      _filterInboundEdges,
      _filterInboundEdgesOfNode,
      _filterInboundEdgesFromTo,
    )
  }

  @send
  external _filterOutboundEdges: (t, filterEdgesCallback<'a>) => array<edge> = "filterOutboundEdges"
  @send
  external _filterOutboundEdgesOfNode: (t, node, filterEdgesCallback<'a>) => array<edge> =
    "filterOutboundEdges"
  @send
  external _filterOutboundEdgesFromTo: (t, node, node, filterEdgesCallback<'a>) => array<edge> =
    "filterOutboundEdges"

  let filterOutboundEdges = (t, filterEdgesVarArgs) => {
    _filterEdgesVarArgsCall(
      t,
      filterEdgesVarArgs,
      _filterOutboundEdges,
      _filterOutboundEdgesOfNode,
      _filterOutboundEdgesFromTo,
    )
  }

  @send
  external _filterDirectedEdges: (t, filterEdgesCallback<'a>) => array<edge> = "filterDirectedEdges"
  @send
  external _filterDirectedEdgesOfNode: (t, node, filterEdgesCallback<'a>) => array<edge> =
    "filterDirectedEdges"
  @send
  external _filterDirectedEdgesFromTo: (t, node, node, filterEdgesCallback<'a>) => array<edge> =
    "filterDirectedEdges"

  let filterDirectedEdges = (t, filterEdgesVarArgs) => {
    _filterEdgesVarArgsCall(
      t,
      filterEdgesVarArgs,
      _filterDirectedEdges,
      _filterDirectedEdgesOfNode,
      _filterDirectedEdgesFromTo,
    )
  }

  @send
  external _filterUndirectedEdges: (t, filterEdgesCallback<'a>) => array<edge> =
    "filterUndirectedEdges"
  @send
  external _filterUndirectedEdgesOfNode: (t, node, filterEdgesCallback<'a>) => array<edge> =
    "filterUndirectedEdges"
  @send
  external _filterUndirectedEdgesFromTo: (t, node, node, filterEdgesCallback<'a>) => array<edge> =
    "filterUndirectedEdges"

  let filterUndirectedEdges = (t, filterEdgesVarArgs) => {
    _filterEdgesVarArgsCall(
      t,
      filterEdgesVarArgs,
      _filterUndirectedEdges,
      _filterUndirectedEdgesOfNode,
      _filterUndirectedEdgesFromTo,
    )
  }

  // #.reduceEdges
  type reduceEdgesCallback<'a, 'r> = (
    'r,
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => 'r

  type reduceEdgesVarArgs<'a, 'r> =
    | All(reduceEdgesCallback<'a, 'r>, 'r)
    | Node(node, reduceEdgesCallback<'a, 'r>, 'r)
    | FromTo(node, node, reduceEdgesCallback<'a, 'r>, 'r)

  let _reduceEdgesVarArgsCall = (t, reduceEdgesVarArgs, allFn, nodeFn, fromToFn) => {
    switch reduceEdgesVarArgs {
    | All(callback, init) => allFn(t, callback, init)
    | Node(node, callback, init) => nodeFn(t, node, callback, init)
    | FromTo(source, target, callback, init) => fromToFn(t, source, target, callback, init)
    }
  }

  @send external _reduceEdges: (t, reduceEdgesCallback<'a, 'r>, 'r) => 'r = "reduceEdges"
  @send
  external _reduceEdgesOfNode: (t, node, reduceEdgesCallback<'a, 'r>, 'r) => 'r = "reduceEdges"
  @send
  external _reduceEdgesFromTo: (t, node, node, reduceEdgesCallback<'a, 'r>, 'r) => 'r =
    "reduceEdges"

  let reduceEdges = (t, reduceEdgesVarArgs) => {
    _reduceEdgesVarArgsCall(
      t,
      reduceEdgesVarArgs,
      _reduceEdges,
      _reduceEdgesOfNode,
      _reduceEdgesFromTo,
    )
  }

  @send external _reduceInEdges: (t, reduceEdgesCallback<'a, 'r>, 'r) => 'r = "reduceInEdges"
  @send
  external _reduceInEdgesOfNode: (t, node, reduceEdgesCallback<'a, 'r>, 'r) => 'r = "reduceInEdges"
  @send
  external _reduceInEdgesFromTo: (t, node, node, reduceEdgesCallback<'a, 'r>, 'r) => 'r =
    "reduceInEdges"

  let reduceInEdges = (t, reduceEdgesVarArgs) => {
    _reduceEdgesVarArgsCall(
      t,
      reduceEdgesVarArgs,
      _reduceInEdges,
      _reduceInEdgesOfNode,
      _reduceInEdgesFromTo,
    )
  }

  @send
  external _reduceOutEdges: (t, reduceEdgesCallback<'a, 'r>, 'r) => 'r = "reduceOutEdges"
  @send
  external _reduceOutEdgesOfNode: (t, node, reduceEdgesCallback<'a, 'r>, 'r) => 'r =
    "reduceOutEdges"
  @send
  external _reduceOutEdgesFromTo: (t, node, node, reduceEdgesCallback<'a, 'r>, 'r) => 'r =
    "reduceOutEdges"

  let reduceOutEdges = (t, reduceEdgesVarArgs) => {
    _reduceEdgesVarArgsCall(
      t,
      reduceEdgesVarArgs,
      _reduceOutEdges,
      _reduceOutEdgesOfNode,
      _reduceOutEdgesFromTo,
    )
  }

  @send
  external _reduceOutboundEdges: (t, reduceEdgesCallback<'a, 'r>, 'r) => 'r = "reduceOutboundEdges"
  @send
  external _reduceOutboundEdgesOfNode: (t, node, reduceEdgesCallback<'a, 'r>, 'r) => 'r =
    "reduceOutboundEdges"
  @send
  external _reduceOutboundEdgesFromTo: (t, node, node, reduceEdgesCallback<'a, 'r>, 'r) => 'r =
    "reduceOutboundEdges"

  let reduceOutboundEdges = (t, reduceEdgesVarArgs) => {
    _reduceEdgesVarArgsCall(
      t,
      reduceEdgesVarArgs,
      _reduceOutboundEdges,
      _reduceOutboundEdgesOfNode,
      _reduceOutboundEdgesFromTo,
    )
  }

  @send
  external _reduceDirectedEdges: (t, reduceEdgesCallback<'a, 'r>, 'r) => 'r = "reduceDirectedEdges"
  @send
  external _reduceDirectedEdgesOfNode: (t, node, reduceEdgesCallback<'a, 'r>, 'r) => 'r =
    "reduceDirectedEdges"
  @send
  external _reduceDirectedEdgesFromTo: (t, node, node, reduceEdgesCallback<'a, 'r>, 'r) => 'r =
    "reduceDirectedEdges"

  let reduceDirectedEdges = (t, reduceEdgesVarArgs) => {
    _reduceEdgesVarArgsCall(
      t,
      reduceEdgesVarArgs,
      _reduceDirectedEdges,
      _reduceDirectedEdgesOfNode,
      _reduceDirectedEdgesFromTo,
    )
  }

  @send
  external _reduceUndirectedEdges: (t, reduceEdgesCallback<'a, 'r>, 'r) => 'r =
    "reduceUndirectedEdges"
  @send
  external _reduceUndirectedEdgesOfNode: (t, node, reduceEdgesCallback<'a, 'r>, 'r) => 'r =
    "reduceUndirectedEdges"
  @send
  external _reduceUndirectedEdgesFromTo: (t, node, node, reduceEdgesCallback<'a, 'r>, 'r) => 'r =
    "reduceUndirectedEdges"

  let reduceUndirectedEdges = (t, reduceEdgesVarArgs) => {
    _reduceEdgesVarArgsCall(
      t,
      reduceEdgesVarArgs,
      _reduceUndirectedEdges,
      _reduceUndirectedEdgesOfNode,
      _reduceUndirectedEdgesFromTo,
    )
  }

  // #.findEdge
  type findEdgeCallback<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => unit

  type findEdgeVarArgs<'a> =
    | All(findEdgeCallback<'a>)
    | Node(node, findEdgeCallback<'a>)
    | FromTo(node, node, findEdgeCallback<'a>)

  let _findEdgeVarArgsCall = (t, findEdgeVarArgs, allFn, nodeFn, fromToFn) => {
    switch findEdgeVarArgs {
    | All(callback) => allFn(t, callback)
    | Node(node, callback) => nodeFn(t, node, callback)
    | FromTo(source, target, callback) => fromToFn(t, source, target, callback)
    }
  }

  @send external _findEdge: (t, findEdgeCallback<'a>) => Nullable.t<edge> = "findEdges"
  @send
  external _findEdgeOfNode: (t, node, findEdgeCallback<'a>) => Nullable.t<edge> = "findEdges"
  @send
  external _findEdgeFromTo: (t, node, node, findEdgeCallback<'a>) => Nullable.t<edge> = "findEdges"

  let findEdge = (t, findEdgeVarArgs) => {
    _findEdgeVarArgsCall(t, findEdgeVarArgs, _findEdge, _findEdgeOfNode, _findEdgeFromTo)
  }

  @send external _findInEdge: (t, findEdgeCallback<'a>) => Nullable.t<edge> = "findInEdges"
  @send
  external _findInEdgeOfNode: (t, node, findEdgeCallback<'a>) => Nullable.t<edge> = "findInEdges"
  @send
  external _findInEdgeFromTo: (t, node, node, findEdgeCallback<'a>) => Nullable.t<edge> =
    "findInEdges"

  let findInEdge = (t, findEdgeVarArgs) => {
    _findEdgeVarArgsCall(t, findEdgeVarArgs, _findInEdge, _findInEdgeOfNode, _findInEdgeFromTo)
  }

  @send external _findOutEdge: (t, findEdgeCallback<'a>) => Nullable.t<edge> = "findOutEdges"
  @send
  external _findOutEdgeOfNode: (t, node, findEdgeCallback<'a>) => Nullable.t<edge> = "findOutEdges"
  @send
  external _findOutEdgeFromTo: (t, node, node, findEdgeCallback<'a>) => Nullable.t<edge> =
    "findOutEdges"

  let findOutEdge = (t, findEdgeVarArgs) => {
    _findEdgeVarArgsCall(t, findEdgeVarArgs, _findOutEdge, _findOutEdgeOfNode, _findOutEdgeFromTo)
  }

  @send
  external _findInboundEdge: (t, findEdgeCallback<'a>) => Nullable.t<edge> = "findInboundEdges"
  @send
  external _findInboundEdgeOfNode: (t, node, findEdgeCallback<'a>) => Nullable.t<edge> =
    "findInboundEdges"
  @send
  external _findInboundEdgeFromTo: (t, node, node, findEdgeCallback<'a>) => Nullable.t<edge> =
    "findInboundEdges"

  let findInboundEdge = (t, findEdgeVarArgs) => {
    _findEdgeVarArgsCall(
      t,
      findEdgeVarArgs,
      _findInboundEdge,
      _findInboundEdgeOfNode,
      _findInboundEdgeFromTo,
    )
  }

  @send
  external _findOutboundEdge: (t, findEdgeCallback<'a>) => Nullable.t<edge> = "findOutboundEdges"
  @send
  external _findOutboundEdgeOfNode: (t, node, findEdgeCallback<'a>) => Nullable.t<edge> =
    "findOutboundEdges"
  @send
  external _findOutboundEdgeFromTo: (t, node, node, findEdgeCallback<'a>) => Nullable.t<edge> =
    "findOutboundEdges"

  let findOutboundEdge = (t, findEdgeVarArgs) => {
    _findEdgeVarArgsCall(
      t,
      findEdgeVarArgs,
      _findOutboundEdge,
      _findOutboundEdgeOfNode,
      _findOutboundEdgeFromTo,
    )
  }

  @send
  external _findDirectedEdge: (t, findEdgeCallback<'a>) => Nullable.t<edge> = "findDirectedEdges"
  @send
  external _findDirectedEdgeOfNode: (t, node, findEdgeCallback<'a>) => Nullable.t<edge> =
    "findDirectedEdges"
  @send
  external _findDirectedEdgeFromTo: (t, node, node, findEdgeCallback<'a>) => Nullable.t<edge> =
    "findDirectedEdges"

  let findDirectedEdge = (t, findEdgeVarArgs) => {
    _findEdgeVarArgsCall(
      t,
      findEdgeVarArgs,
      _findDirectedEdge,
      _findDirectedEdgeOfNode,
      _findDirectedEdgeFromTo,
    )
  }

  @send
  external _findUndirectedEdge: (t, findEdgeCallback<'a>) => Nullable.t<edge> =
    "findUndirectedEdges"
  @send
  external _findUndirectedEdgeOfNode: (t, node, findEdgeCallback<'a>) => Nullable.t<edge> =
    "findUndirectedEdges"
  @send
  external _findUndirectedEdgeFromTo: (t, node, node, findEdgeCallback<'a>) => Nullable.t<edge> =
    "findUndirectedEdges"

  let findUndirectedEdge = (t, findEdgeVarArgs) => {
    _findEdgeVarArgsCall(
      t,
      findEdgeVarArgs,
      _findUndirectedEdge,
      _findUndirectedEdgeOfNode,
      _findUndirectedEdgeFromTo,
    )
  }

  // #.someEdge
  type someEdgeCallback<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => bool

  type someEdgeVarArgs<'a> =
    | All(someEdgeCallback<'a>)
    | Node(node, someEdgeCallback<'a>)
    | FromTo(node, node, someEdgeCallback<'a>)

  let _someEdgeVarArgsCall = (t, someEdgeVarArgs, allFn, nodeFn, fromToFn) => {
    switch someEdgeVarArgs {
    | All(callback) => allFn(t, callback)
    | Node(node, callback) => nodeFn(t, node, callback)
    | FromTo(source, target, callback) => fromToFn(t, source, target, callback)
    }
  }

  @send external _someEdge: (t, someEdgeCallback<'a>) => bool = "someEdge"
  @send
  external _someEdgeOfNode: (t, node, someEdgeCallback<'a>) => bool = "someEdge"
  @send
  external _someEdgeFromTo: (t, node, node, someEdgeCallback<'a>) => bool = "someEdge"

  let someEdge = (t, someEdgeVarArgs) => {
    _someEdgeVarArgsCall(t, someEdgeVarArgs, _someEdge, _someEdgeOfNode, _someEdgeFromTo)
  }

  @send external _someInEdge: (t, someEdgeCallback<'a>) => bool = "someInEdge"
  @send
  external _someInEdgeOfNode: (t, node, someEdgeCallback<'a>) => bool = "someInEdge"
  @send
  external _someInEdgeFromTo: (t, node, node, someEdgeCallback<'a>) => bool = "someInEdge"

  let someInEdge = (t, someEdgeVarArgs) => {
    _someEdgeVarArgsCall(t, someEdgeVarArgs, _someInEdge, _someInEdgeOfNode, _someInEdgeFromTo)
  }

  @send external _someOutEdge: (t, someEdgeCallback<'a>) => bool = "someOutEdge"
  @send
  external _someOutEdgeOfNode: (t, node, someEdgeCallback<'a>) => bool = "someOutEdge"
  @send
  external _someOutEdgeFromTo: (t, node, node, someEdgeCallback<'a>) => bool = "someOutEdge"

  let someOutEdge = (t, someEdgeVarArgs) => {
    _someEdgeVarArgsCall(t, someEdgeVarArgs, _someOutEdge, _someOutEdgeOfNode, _someOutEdgeFromTo)
  }

  @send external _someInboundEdge: (t, someEdgeCallback<'a>) => bool = "someInboundEdge"
  @send
  external _someInboundEdgeOfNode: (t, node, someEdgeCallback<'a>) => bool = "someInboundEdge"
  @send
  external _someInboundEdgeFromTo: (t, node, node, someEdgeCallback<'a>) => bool = "someInboundEdge"

  let someInboundEdge = (t, someEdgeVarArgs) => {
    _someEdgeVarArgsCall(
      t,
      someEdgeVarArgs,
      _someInboundEdge,
      _someInboundEdgeOfNode,
      _someInboundEdgeFromTo,
    )
  }

  @send external _someOutboundEdge: (t, someEdgeCallback<'a>) => bool = "someOutboundEdge"
  @send
  external _someOutboundEdgeOfNode: (t, node, someEdgeCallback<'a>) => bool = "someOutboundEdge"
  @send
  external _someOutboundEdgeFromTo: (t, node, node, someEdgeCallback<'a>) => bool =
    "someOutboundEdge"

  let someOutboundEdge = (t, someEdgeVarArgs) => {
    _someEdgeVarArgsCall(
      t,
      someEdgeVarArgs,
      _someOutboundEdge,
      _someOutboundEdgeOfNode,
      _someOutboundEdgeFromTo,
    )
  }

  @send external _someDirectedEdge: (t, someEdgeCallback<'a>) => bool = "someDirectedEdge"
  @send
  external _someDirectedEdgeOfNode: (t, node, someEdgeCallback<'a>) => bool = "someDirectedEdge"
  @send
  external _someDirectedEdgeFromTo: (t, node, node, someEdgeCallback<'a>) => bool =
    "someDirectedEdge"

  let someDirectedEdge = (t, someEdgeVarArgs) => {
    _someEdgeVarArgsCall(
      t,
      someEdgeVarArgs,
      _someDirectedEdge,
      _someDirectedEdgeOfNode,
      _someDirectedEdgeFromTo,
    )
  }

  @send external _someUndirectedEdge: (t, someEdgeCallback<'a>) => bool = "someUndirectedEdge"
  @send
  external _someUndirectedEdgeOfNode: (t, node, someEdgeCallback<'a>) => bool = "someUndirectedEdge"
  @send
  external _someUndirectedEdgeFromTo: (t, node, node, someEdgeCallback<'a>) => bool =
    "someUndirectedEdge"

  let someUndirectedEdge = (t, someEdgeVarArgs) => {
    _someEdgeVarArgsCall(
      t,
      someEdgeVarArgs,
      _someUndirectedEdge,
      _someUndirectedEdgeOfNode,
      _someUndirectedEdgeFromTo,
    )
  }

  // #.everyEdge
  type everyEdgeCallback<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => bool

  type everyEdgeVarArgs<'a> =
    | All(everyEdgeCallback<'a>)
    | Node(node, everyEdgeCallback<'a>)
    | FromTo(node, node, everyEdgeCallback<'a>)

  let _everyEdgeVarArgsCall = (t, everyEdgeVarArgs, allFn, nodeFn, fromToFn) => {
    switch everyEdgeVarArgs {
    | All(callback) => allFn(t, callback)
    | Node(node, callback) => nodeFn(t, node, callback)
    | FromTo(source, target, callback) => fromToFn(t, source, target, callback)
    }
  }

  @send external _everyEdge: (t, everyEdgeCallback<'a>) => bool = "everyEdge"
  @send
  external _everyEdgeOfNode: (t, node, everyEdgeCallback<'a>) => bool = "everyEdge"
  @send
  external _everyEdgeFromTo: (t, node, node, everyEdgeCallback<'a>) => bool = "everyEdge"

  let everyEdge = (t, everyEdgeVarArgs) => {
    _everyEdgeVarArgsCall(t, everyEdgeVarArgs, _everyEdge, _everyEdgeOfNode, _everyEdgeFromTo)
  }

  @send external _everyInEdge: (t, everyEdgeCallback<'a>) => bool = "everyInEdge"
  @send
  external _everyInEdgeOfNode: (t, node, everyEdgeCallback<'a>) => bool = "everyInEdge"
  @send
  external _everyInEdgeFromTo: (t, node, node, everyEdgeCallback<'a>) => bool = "everyInEdge"

  let everyInEdge = (t, everyEdgeVarArgs) => {
    _everyEdgeVarArgsCall(t, everyEdgeVarArgs, _everyInEdge, _everyInEdgeOfNode, _everyInEdgeFromTo)
  }

  @send external _everyOutEdge: (t, everyEdgeCallback<'a>) => bool = "everyOutEdge"
  @send
  external _everyOutEdgeOfNode: (t, node, everyEdgeCallback<'a>) => bool = "everyOutEdge"
  @send
  external _everyOutEdgeFromTo: (t, node, node, everyEdgeCallback<'a>) => bool = "everyOutEdge"

  let everyOutEdge = (t, everyEdgeVarArgs) => {
    _everyEdgeVarArgsCall(
      t,
      everyEdgeVarArgs,
      _everyOutEdge,
      _everyOutEdgeOfNode,
      _everyOutEdgeFromTo,
    )
  }

  @send external _everyInboundEdge: (t, everyEdgeCallback<'a>) => bool = "everyInboundEdge"
  @send
  external _everyInboundEdgeOfNode: (t, node, everyEdgeCallback<'a>) => bool = "everyInboundEdge"
  @send
  external _everyInboundEdgeFromTo: (t, node, node, everyEdgeCallback<'a>) => bool =
    "everyInboundEdge"

  let everyInboundEdge = (t, everyEdgeVarArgs) => {
    _everyEdgeVarArgsCall(
      t,
      everyEdgeVarArgs,
      _everyInboundEdge,
      _everyInboundEdgeOfNode,
      _everyInboundEdgeFromTo,
    )
  }

  @send external _everyOutboundEdge: (t, everyEdgeCallback<'a>) => bool = "everyOutboundEdge"
  @send
  external _everyOutboundEdgeOfNode: (t, node, everyEdgeCallback<'a>) => bool = "everyOutboundEdge"
  @send
  external _everyOutboundEdgeFromTo: (t, node, node, everyEdgeCallback<'a>) => bool =
    "everyOutboundEdge"

  let everyOutboundEdge = (t, everyEdgeVarArgs) => {
    _everyEdgeVarArgsCall(
      t,
      everyEdgeVarArgs,
      _everyOutboundEdge,
      _everyOutboundEdgeOfNode,
      _everyOutboundEdgeFromTo,
    )
  }

  @send external _everyDirectedEdge: (t, everyEdgeCallback<'a>) => bool = "everyDirectedEdge"
  @send
  external _everyDirectedEdgeOfNode: (t, node, everyEdgeCallback<'a>) => bool = "everyDirectedEdge"
  @send
  external _everyDirectedEdgeFromTo: (t, node, node, everyEdgeCallback<'a>) => bool =
    "everyDirectedEdge"

  let everyDirectedEdge = (t, everyEdgeVarArgs) => {
    _everyEdgeVarArgsCall(
      t,
      everyEdgeVarArgs,
      _everyDirectedEdge,
      _everyDirectedEdgeOfNode,
      _everyDirectedEdgeFromTo,
    )
  }

  @send external _everyUndirectedEdge: (t, everyEdgeCallback<'a>) => bool = "everyUndirectedEdge"
  @send
  external _everyUndirectedEdgeOfNode: (t, node, everyEdgeCallback<'a>) => bool =
    "everyUndirectedEdge"
  @send
  external _everyUndirectedEdgeFromTo: (t, node, node, everyEdgeCallback<'a>) => bool =
    "everyUndirectedEdge"

  let everyUndirectedEdge = (t, everyEdgeVarArgs) => {
    _everyEdgeVarArgsCall(
      t,
      everyEdgeVarArgs,
      _everyUndirectedEdge,
      _everyUndirectedEdgeOfNode,
      _everyUndirectedEdgeFromTo,
    )
  }

  //#.edgeEntries
  type edgeIterValue<'a> = {
    edge: edge,
    attributes: edgeAttr<'a>,
    source: node,
    target: node,
    sourceAttributes: nodeAttr<'a>,
    targetAttributes: nodeAttr<'a>,
  }

  type edgeEntriesVarArgs<'a> =
    | All
    | Node(node)
    | FromTo(node, node)

  let _edgeEntriesVarArgsCall = (t, edgeEntriesVarArgs, allFn, nodeFn, fromToFn) => {
    switch edgeEntriesVarArgs {
    | All => allFn(t)
    | Node(node) => nodeFn(t, node)
    | FromTo(source, target) => fromToFn(t, source, target)
    }
  }

  @send external _edgeEntries: t => RescriptCore.Iterator.t<edgeIterValue<'a>> = "edgeEntries"
  @send
  external _edgeEntriesOfNode: (t, node) => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "edgeEntries"
  @send
  external _edgeEntriesFromTo: (t, node, node) => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "edgeEntries"

  let edgeEntries = (t, edgeEntriesVarArgs) => {
    _edgeEntriesVarArgsCall(
      t,
      edgeEntriesVarArgs,
      _edgeEntries,
      _edgeEntriesOfNode,
      _edgeEntriesFromTo,
    )
  }

  @send external _inEdgeEntries: t => RescriptCore.Iterator.t<edgeIterValue<'a>> = "inEdgeEntries"
  @send
  external _inEdgeEntriesOfNode: (t, node) => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "inEdgeEntries"
  @send
  external _inEdgeEntriesFromTo: (t, node, node) => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "inEdgeEntries"

  let inEdgeEntries = (t, edgeEntriesVarArgs) => {
    _edgeEntriesVarArgsCall(
      t,
      edgeEntriesVarArgs,
      _inEdgeEntries,
      _inEdgeEntriesOfNode,
      _inEdgeEntriesFromTo,
    )
  }

  @send external _outEdgeEntries: t => RescriptCore.Iterator.t<edgeIterValue<'a>> = "outEdgeEntries"
  @send
  external _outEdgeEntriesOfNode: (t, node) => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "outEdgeEntries"
  @send
  external _outEdgeEntriesFromTo: (t, node, node) => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "outEdgeEntries"

  let outEdgeEntries = (t, edgeEntriesVarArgs) => {
    _edgeEntriesVarArgsCall(
      t,
      edgeEntriesVarArgs,
      _outEdgeEntries,
      _outEdgeEntriesOfNode,
      _outEdgeEntriesFromTo,
    )
  }

  @send
  external _inboundEdgeEntries: t => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "inboundEdgeEntries"
  @send
  external _inboundEdgeEntriesOfNode: (t, node) => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "inboundEdgeEntries"
  @send
  external _inboundEdgeEntriesFromTo: (
    t,
    node,
    node,
  ) => RescriptCore.Iterator.t<edgeIterValue<'a>> = "inboundEdgeEntries"

  let inboundEdgeEntries = (t, edgeEntriesVarArgs) => {
    _edgeEntriesVarArgsCall(
      t,
      edgeEntriesVarArgs,
      _inboundEdgeEntries,
      _inboundEdgeEntriesOfNode,
      _inboundEdgeEntriesFromTo,
    )
  }

  @send
  external _outboundEdgeEntries: t => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "outboundEdgeEntries"
  @send
  external _outboundEdgeEntriesOfNode: (t, node) => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "outboundEdgeEntries"
  @send
  external _outboundEdgeEntriesFromTo: (
    t,
    node,
    node,
  ) => RescriptCore.Iterator.t<edgeIterValue<'a>> = "outboundEdgeEntries"

  let outboundEdgeEntries = (t, edgeEntriesVarArgs) => {
    _edgeEntriesVarArgsCall(
      t,
      edgeEntriesVarArgs,
      _outboundEdgeEntries,
      _outboundEdgeEntriesOfNode,
      _outboundEdgeEntriesFromTo,
    )
  }

  @send
  external _directedEdgeEntries: t => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "directedEdgeEntries"
  @send
  external _directedEdgeEntriesOfNode: (t, node) => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "directedEdgeEntries"
  @send
  external _directedEdgeEntriesFromTo: (
    t,
    node,
    node,
  ) => RescriptCore.Iterator.t<edgeIterValue<'a>> = "directedEdgeEntries"

  let directedEdgeEntries = (t, edgeEntriesVarArgs) => {
    _edgeEntriesVarArgsCall(
      t,
      edgeEntriesVarArgs,
      _directedEdgeEntries,
      _directedEdgeEntriesOfNode,
      _directedEdgeEntriesFromTo,
    )
  }

  @send
  external _undirectedEdgeEntries: t => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "undirectedEdgeEntries"
  @send
  external _undirectedEdgeEntriesOfNode: (t, node) => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "undirectedEdgeEntries"
  @send
  external _undirectedEdgeEntriesFromTo: (
    t,
    node,
    node,
  ) => RescriptCore.Iterator.t<edgeIterValue<'a>> = "undirectedEdgeEntries"

  let undirectedEdgeEntries = (t, edgeEntriesVarArgs) => {
    _edgeEntriesVarArgsCall(
      t,
      edgeEntriesVarArgs,
      _undirectedEdgeEntries,
      _undirectedEdgeEntriesOfNode,
      _undirectedEdgeEntriesFromTo,
    )
  }

  //  type edgeIterValue<'a> = {edge: edge, attributes: edgeAttr<'a>}
  //  @send external edgeEntries: t => RescriptCore.Iterator.t<edgeIterValue<'a>> = "edgeEntries"

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
