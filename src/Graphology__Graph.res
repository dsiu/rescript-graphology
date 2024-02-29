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
  type edgesVarArgs = All | Node(node) | FromTo(node, node)

  // Returns an array of relevant edge keys.
  // #.edges
  let edges: (t, edgesVarArgs) => array<edge>
  // #.inEdges
  let inEdges: (t, edgesVarArgs) => array<edge>
  // #.outEdges
  let outEdges: (t, edgesVarArgs) => array<edge>
  // #. inboundEdges
  let inboundEdges: (t, edgesVarArgs) => array<edge>
  // #.outboundEdges
  let outboundEdges: (t, edgesVarArgs) => array<edge>
  // #.directedEdges
  let directedEdges: (t, edgesVarArgs) => array<edge>
  // #.undirectedEdges
  let undirectedEdges: (t, edgesVarArgs) => array<edge>

  // todo: forEachEdge call back should have (edge, attributes, source, target, sourceAttributes, targetAttributes)

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

  let forEachEdge: (t, forEachEdgeVarArgs<'a>) => unit
  let forEachInEdge: (t, forEachEdgeVarArgs<'a>) => unit
  let forEachOutEdge: (t, forEachEdgeVarArgs<'a>) => unit
  let forEachInboundEdge: (t, forEachEdgeVarArgs<'a>) => unit
  let forEachOutboundEdge: (t, forEachEdgeVarArgs<'a>) => unit
  let forEachDirectedEdge: (t, forEachEdgeVarArgs<'a>) => unit
  let forEachUndirectedEdge: (t, forEachEdgeVarArgs<'a>) => unit

  // todo:
  // #.forEachInEdge
  // #.forEachOutEdge
  // #.forEachInboundEdge (in + undirected)
  // #.forEachOutboundEdge (out + undirected)
  // #.forEachDirectedEdge
  // #.forEachUndirectedEdge
  let mapEdges: (t, (edge, edgeAttr<'a>) => 'b) => array<'b>
  // todo:
  // #.mapInEdges
  // #.mapOutEdges
  // #.mapInboundEdges (in + undirected)
  // #.mapOutboundEdges (out + undirected)
  // #.mapDirectedEdges
  // #.mapUndirectedEdges
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

  // map
  @send external mapEdges: (t, (edge, edgeAttr<'a>) => 'b) => array<'b> = "mapEdges"

  // filter
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
