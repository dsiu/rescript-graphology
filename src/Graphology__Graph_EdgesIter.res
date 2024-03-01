module type GRAPH_TYPES = Graphology__GraphTypes.T

module type EDGES_ITER = {
  include GRAPH_TYPES
  type edges_args = All | Node(node) | FromTo(node, node)

  // Returns an array of relevant edge keys.
  // #.edges
  let edges: (t, edges_args) => array<edge>
  let inEdges: (t, edges_args) => array<edge>
  let outEdges: (t, edges_args) => array<edge>
  let inboundEdges: (t, edges_args) => array<edge>
  let outboundEdges: (t, edges_args) => array<edge>
  let directedEdges: (t, edges_args) => array<edge>
  let undirectedEdges: (t, edges_args) => array<edge>

  // Iterates over relevant edges using a _cb.
  // #.forEachEdge
  type forEachEdge_cb<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => unit

  type forEachEdge_args<'a> =
    | All(forEachEdge_cb<'a>)
    | Node(node, forEachEdge_cb<'a>)
    | FromTo(node, node, forEachEdge_cb<'a>)

  let forEachEdge: (t, forEachEdge_args<'a>) => unit
  let forEachInEdge: (t, forEachEdge_args<'a>) => unit
  let forEachOutEdge: (t, forEachEdge_args<'a>) => unit
  let forEachInboundEdge: (t, forEachEdge_args<'a>) => unit
  let forEachOutboundEdge: (t, forEachEdge_args<'a>) => unit
  let forEachDirectedEdge: (t, forEachEdge_args<'a>) => unit
  let forEachUndirectedEdge: (t, forEachEdge_args<'a>) => unit

  // #.mapEdges
  type mapEdges_cb<'a> = (edge, edgeAttr<'a>, node, node, nodeAttr<'a>, nodeAttr<'a>, bool) => edge

  type mapEdges_args<'a> =
    | All(mapEdges_cb<'a>)
    | Node(node, mapEdges_cb<'a>)
    | FromTo(node, node, mapEdges_cb<'a>)

  let mapEdges: (t, mapEdges_args<'a>) => array<edge>
  let mapInEdges: (t, mapEdges_args<'a>) => array<edge>
  let mapOutEdges: (t, mapEdges_args<'a>) => array<edge>
  let mapInboundEdges: (t, mapEdges_args<'a>) => array<edge>
  let mapOutboundEdges: (t, mapEdges_args<'a>) => array<edge>
  let mapDirectedEdges: (t, mapEdges_args<'a>) => array<edge>
  let mapUndirectedEdges: (t, mapEdges_args<'a>) => array<edge>

  // #.filterEdges
  type filterEdges_cb<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => bool

  type filterEdges_args<'a> =
    | All(filterEdges_cb<'a>)
    | Node(node, filterEdges_cb<'a>)
    | FromTo(node, node, filterEdges_cb<'a>)

  let filterEdges: (t, filterEdges_args<'a>) => array<edge>
  let filterInEdges: (t, filterEdges_args<'a>) => array<edge>
  let filterOutEdges: (t, filterEdges_args<'a>) => array<edge>
  let filterInboundEdges: (t, filterEdges_args<'a>) => array<edge>
  let filterOutboundEdges: (t, filterEdges_args<'a>) => array<edge>
  let filterDirectedEdges: (t, filterEdges_args<'a>) => array<edge>
  let filterUndirectedEdges: (t, filterEdges_args<'a>) => array<edge>

  // #.reduceEdges
  type reduceEdges_cb<'a, 'r> = (
    'r,
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => 'r

  type reduceEdges_args<'a, 'r> =
    | All(reduceEdges_cb<'a, 'r>, 'r)
    | Node(node, reduceEdges_cb<'a, 'r>, 'r)
    | FromTo(node, node, reduceEdges_cb<'a, 'r>, 'r)

  let reduceEdges: (t, reduceEdges_args<'a, 'r>) => 'r
  let reduceInEdges: (t, reduceEdges_args<'a, 'r>) => 'r
  let reduceOutEdges: (t, reduceEdges_args<'a, 'r>) => 'r
  let reduceOutboundEdges: (t, reduceEdges_args<'a, 'r>) => 'r
  let reduceDirectedEdges: (t, reduceEdges_args<'a, 'r>) => 'r
  let reduceUndirectedEdges: (t, reduceEdges_args<'a, 'r>) => 'r

  // #.findEdge
  type findEdge_cb<'a> = (edge, edgeAttr<'a>, node, node, nodeAttr<'a>, nodeAttr<'a>, bool) => unit

  type findEdge_args<'a> =
    | All(findEdge_cb<'a>)
    | Node(node, findEdge_cb<'a>)
    | FromTo(node, node, findEdge_cb<'a>)

  let findEdge: (t, findEdge_args<'a>) => Nullable.t<edge>
  let findInEdge: (t, findEdge_args<'a>) => Nullable.t<edge>
  let findOutEdge: (t, findEdge_args<'a>) => Nullable.t<edge>
  let findInboundEdge: (t, findEdge_args<'a>) => Nullable.t<edge>
  let findOutboundEdge: (t, findEdge_args<'a>) => Nullable.t<edge>
  let findDirectedEdge: (t, findEdge_args<'a>) => Nullable.t<edge>
  let findUndirectedEdge: (t, findEdge_args<'a>) => Nullable.t<edge>

  // #.someEdge
  type someEdge_cb<'a> = (edge, edgeAttr<'a>, node, node, nodeAttr<'a>, nodeAttr<'a>, bool) => bool

  type someEdge_args<'a> =
    | All(someEdge_cb<'a>)
    | Node(node, someEdge_cb<'a>)
    | FromTo(node, node, someEdge_cb<'a>)

  let someEdge: (t, someEdge_args<'a>) => bool
  let someInEdge: (t, someEdge_args<'a>) => bool
  let someOutEdge: (t, someEdge_args<'a>) => bool
  let someInboundEdge: (t, someEdge_args<'a>) => bool
  let someOutboundEdge: (t, someEdge_args<'a>) => bool
  let someDirectedEdge: (t, someEdge_args<'a>) => bool
  let someUndirectedEdge: (t, someEdge_args<'a>) => bool

  // #.everyEdge
  type everyEdge_cb<'a> = (edge, edgeAttr<'a>, node, node, nodeAttr<'a>, nodeAttr<'a>, bool) => bool

  type everyEdge_args<'a> =
    | All(everyEdge_cb<'a>)
    | Node(node, everyEdge_cb<'a>)
    | FromTo(node, node, everyEdge_cb<'a>)

  let everyEdge: (t, everyEdge_args<'a>) => bool
  let everyInEdge: (t, everyEdge_args<'a>) => bool
  let everyOutEdge: (t, everyEdge_args<'a>) => bool
  let everyInboundEdge: (t, everyEdge_args<'a>) => bool
  let everyOutboundEdge: (t, everyEdge_args<'a>) => bool
  let everyDirectedEdge: (t, everyEdge_args<'a>) => bool
  let everyUndirectedEdge: (t, everyEdge_args<'a>) => bool

  //#.edgeEntries
  type edgeIterValue<'a> = {
    edge: edge,
    attributes: edgeAttr<'a>,
    source: node,
    target: node,
    sourceAttributes: nodeAttr<'a>,
    targetAttributes: nodeAttr<'a>,
  }

  type edgeEntries_args<'a> =
    | All
    | Node(node)
    | FromTo(node, node)

  let edgeEntries: (t, edgeEntries_args<'a>) => RescriptCore.Iterator.t<edgeIterValue<'a>>
  let inEdgeEntries: (t, edgeEntries_args<'a>) => RescriptCore.Iterator.t<edgeIterValue<'a>>
  let outEdgeEntries: (t, edgeEntries_args<'a>) => RescriptCore.Iterator.t<edgeIterValue<'a>>
  let inboundEdgeEntries: (t, edgeEntries_args<'a>) => RescriptCore.Iterator.t<edgeIterValue<'a>>
  let outboundEdgeEntries: (t, edgeEntries_args<'a>) => RescriptCore.Iterator.t<edgeIterValue<'a>>
  let directedEdgeEntries: (t, edgeEntries_args<'a>) => RescriptCore.Iterator.t<edgeIterValue<'a>>
  let undirectedEdgeEntries: (t, edgeEntries_args<'a>) => RescriptCore.Iterator.t<edgeIterValue<'a>>
}

// functor type
module type EDGES_ITER_F = (C: GRAPH_TYPES) =>
(
  EDGES_ITER
    with type t = C.t
    and type node = C.node
    and type edge = C.edge
    and type graphAttr<'a> = C.graphAttr<'a>
    and type nodeAttr<'a> = C.nodeAttr<'a>
    and type edgeAttr<'a> = C.edgeAttr<'a>
)

module MakeEdgesIter: EDGES_ITER_F = (C: GRAPH_TYPES) => {
  type t = C.t
  type node = C.node
  type edge = C.edge
  type graphAttr<'a> = C.graphAttr<'a>
  type nodeAttr<'a> = C.nodeAttr<'a>
  type edgeAttr<'a> = C.edgeAttr<'a>

  type edges_args = All | Node(node) | FromTo(node, node)

  let _edges_call = (t, edges_args, allFn, nodeFn, _fromToFn) => {
    switch edges_args {
    | All => allFn(t)
    | Node(node) => nodeFn(t, node)
    | FromTo(source, target) => _fromToFn(t, source, target)
    }
  }

  // #.edges
  @send external _edges: t => array<edge> = "edges"
  @send external _edges_ofNode: (t, node) => array<edge> = "edges"
  @send external _edges_fromTo: (t, node, node) => array<edge> = "edges"

  let edges = (t, edges_args) => {
    _edges_call(t, edges_args, _edges, _edges_ofNode, _edges_fromTo)
  }

  // #.inEdges
  @send external _inEdges: t => array<edge> = "inEdges"
  @send external _inEdges_ofNode: (t, node) => array<edge> = "inEdges"
  @send external _inEdges_fromTo: (t, node, node) => array<edge> = "inEdges"

  let inEdges = (t, edges_args) => {
    _edges_call(t, edges_args, _inEdges, _inEdges_ofNode, _inEdges_fromTo)
  }

  // #.outEdges
  @send external _outEdges: t => array<edge> = "outEdges"
  @send external _outEdges_ofNode: (t, node) => array<edge> = "outEdges"
  @send external _outEdges_fromTo: (t, node, node) => array<edge> = "outEdges"

  let outEdges = (t, edges_args) => {
    _edges_call(t, edges_args, _outEdges, _outEdges_ofNode, _outEdges_fromTo)
  }

  // #. inboundEdges
  @send external _inboundEdges: t => array<edge> = "inboundEdges"
  @send external _inboundEdges_ofNode: (t, node) => array<edge> = "inboundEdges"
  @send external _inboundEdges_fromTo: (t, node, node) => array<edge> = "inboundEdges"

  let inboundEdges = (t, edges_args) => {
    _edges_call(t, edges_args, _inboundEdges, _inboundEdges_ofNode, _inboundEdges_fromTo)
  }

  // #.outboundEdges
  @send external _outboundEdges: t => array<edge> = "outboundEdges"
  @send external _outboundEdges_ofNode: (t, node) => array<edge> = "outboundEdges"
  @send external _outboundEdges_fromTo: (t, node, node) => array<edge> = "outboundEdges"

  let outboundEdges = (t, edges_args) => {
    _edges_call(t, edges_args, _outboundEdges, _outboundEdges_ofNode, _outboundEdges_fromTo)
  }

  // #.directedEdges
  @send external _directedEdges: t => array<edge> = "directedEdges"
  @send external _directedEdges_ofNode: (t, node) => array<edge> = "directedEdges"
  @send external _directedEdges_fromTo: (t, node, node) => array<edge> = "directedEdges"

  let directedEdges = (t, edges_args) => {
    _edges_call(t, edges_args, _directedEdges, _directedEdges_ofNode, _directedEdges_fromTo)
  }

  // #.undirectedEdges
  @send external _undirectedEdges: t => array<edge> = "undirectedEdges"
  @send external _undirectedEdges_ofNode: (t, node) => array<edge> = "undirectedEdges"
  @send external _undirectedEdges_fromTo: (t, node, node) => array<edge> = "undirectedEdges"

  let undirectedEdges = (t, edges_args) => {
    _edges_call(t, edges_args, _undirectedEdges, _undirectedEdges_ofNode, _undirectedEdges_fromTo)
  }

  // Iterates over relevant edges using a _cb.
  type forEachEdge_cb<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => unit

  type forEachEdge_args<'a> =
    | All(forEachEdge_cb<'a>)
    | Node(node, forEachEdge_cb<'a>)
    | FromTo(node, node, forEachEdge_cb<'a>)

  let _forEachEdge_call = (t, forEachEdge_args, allFn, nodeFn, _fromToFn) => {
    switch forEachEdge_args {
    | All(_cb) => allFn(t, _cb)
    | Node(node, _cb) => nodeFn(t, node, _cb)
    | FromTo(source, target, _cb) => _fromToFn(t, source, target, _cb)
    }
  }

  // #.forEachEdge
  @send external _forEachEdge: (t, forEachEdge_cb<'a>) => unit = "forEachEdge"
  @send external _forEachEdge_ofNode: (t, node, forEachEdge_cb<'a>) => unit = "forEachEdge"
  @send
  external _forEachEdge_fromTo: (t, node, node, forEachEdge_cb<'a>) => unit = "forEachEdge"

  let forEachEdge = (t, forEachEdge_args) => {
    _forEachEdge_call(t, forEachEdge_args, _forEachEdge, _forEachEdge_ofNode, _forEachEdge_fromTo)
  }

  // #.forEachInEdge
  @send external _forEachInEdge: (t, forEachEdge_cb<'a>) => unit = "forEachInEdge"
  @send
  external _forEachInEdge_ofNode: (t, node, forEachEdge_cb<'a>) => unit = "forEachInEdge"
  @send
  external _forEachInEdge_fromTo: (t, node, node, forEachEdge_cb<'a>) => unit = "forEachInEdge"

  let forEachInEdge = (t, forEachInEdge_args) => {
    _forEachEdge_call(
      t,
      forEachInEdge_args,
      _forEachInEdge,
      _forEachInEdge_ofNode,
      _forEachInEdge_fromTo,
    )
  }

  // #.forEachOutEdge
  @send external _forEachOutEdge: (t, forEachEdge_cb<'a>) => unit = "forEachOutEdge"
  @send
  external _forEachOutEdge_ofNode: (t, node, forEachEdge_cb<'a>) => unit = "forEachOutEdge"
  @send
  external _forEachOutEdge_fromTo: (t, node, node, forEachEdge_cb<'a>) => unit = "forEachOutEdge"

  let forEachOutEdge = (t, forEachOutEdge_args) => {
    _forEachEdge_call(
      t,
      forEachOutEdge_args,
      _forEachOutEdge,
      _forEachOutEdge_ofNode,
      _forEachOutEdge_fromTo,
    )
  }

  // #.forEachInboundEdge
  @send external _forEachInboundEdge: (t, forEachEdge_cb<'a>) => unit = "forEachInboundEdge"
  @send
  external _forEachInboundEdge_ofNode: (t, node, forEachEdge_cb<'a>) => unit = "forEachInboundEdge"
  @send
  external _forEachInboundEdge_fromTo: (t, node, node, forEachEdge_cb<'a>) => unit =
    "forEachInboundEdge"

  let forEachInboundEdge = (t, forEachInboundEdge_args) => {
    _forEachEdge_call(
      t,
      forEachInboundEdge_args,
      _forEachInboundEdge,
      _forEachInboundEdge_ofNode,
      _forEachInboundEdge_fromTo,
    )
  }

  // #.forEachOutboundEdge
  @send external _forEachOutboundEdge: (t, forEachEdge_cb<'a>) => unit = "forEachOutboundEdge"
  @send
  external _forEachOutboundEdge_ofNode: (t, node, forEachEdge_cb<'a>) => unit =
    "forEachOutboundEdge"
  @send
  external _forEachOutboundEdge_fromTo: (t, node, node, forEachEdge_cb<'a>) => unit =
    "forEachOutboundEdge"

  let forEachOutboundEdge = (t, forEachOutboundEdge_args) => {
    _forEachEdge_call(
      t,
      forEachOutboundEdge_args,
      _forEachOutboundEdge,
      _forEachOutboundEdge_ofNode,
      _forEachOutboundEdge_fromTo,
    )
  }

  // #.forEachDirectedEdge
  @send external _forEachDirectedEdge: (t, forEachEdge_cb<'a>) => unit = "forEachDirectedEdge"
  @send
  external _forEachDirectedEdge_ofNode: (t, node, forEachEdge_cb<'a>) => unit =
    "forEachDirectedEdge"
  @send
  external _forEachDirectedEdge_fromTo: (t, node, node, forEachEdge_cb<'a>) => unit =
    "forEachDirectedEdge"

  let forEachDirectedEdge = (t, forEachDirectedEdge_args) => {
    _forEachEdge_call(
      t,
      forEachDirectedEdge_args,
      _forEachDirectedEdge,
      _forEachDirectedEdge_ofNode,
      _forEachDirectedEdge_fromTo,
    )
  }

  // #.forEachUndirectedEdge
  @send
  external _forEachUndirectedEdge: (t, forEachEdge_cb<'a>) => unit = "forEachUndirectedEdge"
  @send
  external _forEachUndirectedEdge_ofNode: (t, node, forEachEdge_cb<'a>) => unit =
    "forEachUndirectedEdge"
  @send
  external _forEachUndirectedEdge_fromTo: (t, node, node, forEachEdge_cb<'a>) => unit =
    "forEachUndirectedEdge"

  let forEachUndirectedEdge = (t, forEachUndirectedEdge_args) => {
    _forEachEdge_call(
      t,
      forEachUndirectedEdge_args,
      _forEachUndirectedEdge,
      _forEachUndirectedEdge_ofNode,
      _forEachUndirectedEdge_fromTo,
    )
  }

  // #.mapEdges
  type mapEdges_cb<'a> = (edge, edgeAttr<'a>, node, node, nodeAttr<'a>, nodeAttr<'a>, bool) => edge

  type mapEdges_args<'a> =
    | All(mapEdges_cb<'a>)
    | Node(node, mapEdges_cb<'a>)
    | FromTo(node, node, mapEdges_cb<'a>)

  let _mapEdges_call = (t, mapEdges_args, allFn, nodeFn, _fromToFn) => {
    switch mapEdges_args {
    | All(_cb) => allFn(t, _cb)
    | Node(node, _cb) => nodeFn(t, node, _cb)
    | FromTo(source, target, _cb) => _fromToFn(t, source, target, _cb)
    }
  }

  @send external _mapEdges: (t, mapEdges_cb<'a>) => array<edge> = "mapEdges"
  @send external _mapEdges_ofNode: (t, node, mapEdges_cb<'a>) => array<edge> = "mapEdges"
  @send
  external _mapEdges_fromTo: (t, node, node, mapEdges_cb<'a>) => array<edge> = "mapEdges"

  let mapEdges = (t, mapEdges_args) => {
    _mapEdges_call(t, mapEdges_args, _mapEdges, _mapEdges_ofNode, _mapEdges_fromTo)
  }

  @send external _mapInEdges: (t, mapEdges_cb<'a>) => array<edge> = "mapInEdges"
  @send external _mapInEdges_ofNode: (t, node, mapEdges_cb<'a>) => array<edge> = "mapInEdges"
  @send
  external _mapInEdges_fromTo: (t, node, node, mapEdges_cb<'a>) => array<edge> = "mapInEdges"

  let mapInEdges = (t, mapEdges_args) => {
    _mapEdges_call(t, mapEdges_args, _mapInEdges, _mapEdges_ofNode, _mapInEdges_fromTo)
  }

  @send external _mapOutEdges: (t, mapEdges_cb<'a>) => array<edge> = "mapOutEdges"
  @send external _mapOutEdges_ofNode: (t, node, mapEdges_cb<'a>) => array<edge> = "mapOutEdges"
  @send
  external _mapOutEdges_fromTo: (t, node, node, mapEdges_cb<'a>) => array<edge> = "mapOutEdges"

  let mapOutEdges = (t, mapEdges_args) => {
    _mapEdges_call(t, mapEdges_args, _mapOutEdges, _mapEdges_ofNode, _mapOutEdges_fromTo)
  }

  @send external _mapInboundEdges: (t, mapEdges_cb<'a>) => array<edge> = "mapInboundEdges"
  @send
  external _mapInboundEdges_ofNode: (t, node, mapEdges_cb<'a>) => array<edge> = "mapInboundEdges"
  @send
  external _mapInboundEdges_fromTo: (t, node, node, mapEdges_cb<'a>) => array<edge> =
    "mapInboundEdges"

  let mapInboundEdges = (t, mapEdges_args) => {
    _mapEdges_call(
      t,
      mapEdges_args,
      _mapInboundEdges,
      _mapInboundEdges_ofNode,
      _mapInboundEdges_fromTo,
    )
  }

  @send external _mapOutboundEdges: (t, mapEdges_cb<'a>) => array<edge> = "mapOutboundEdges"
  @send
  external _mapOutboundEdges_ofNode: (t, node, mapEdges_cb<'a>) => array<edge> = "mapOutboundEdges"
  @send
  external _mapOutboundEdges_fromTo: (t, node, node, mapEdges_cb<'a>) => array<edge> =
    "mapOutboundEdges"

  let mapOutboundEdges = (t, mapEdges_args) => {
    _mapEdges_call(t, mapEdges_args, _mapOutboundEdges, _mapEdges_ofNode, _mapOutboundEdges_fromTo)
  }

  @send external _mapDirectedEdges: (t, mapEdges_cb<'a>) => array<edge> = "mapDirectedEdges"
  @send
  external _mapDirectedEdges_ofNode: (t, node, mapEdges_cb<'a>) => array<edge> = "mapDirectedEdges"
  @send
  external _mapDirectedEdges_fromTo: (t, node, node, mapEdges_cb<'a>) => array<edge> =
    "mapDirectedEdges"

  let mapDirectedEdges = (t, mapEdges_args) => {
    _mapEdges_call(t, mapEdges_args, _mapDirectedEdges, _mapEdges_ofNode, _mapDirectedEdges_fromTo)
  }

  @send
  external _mapUndirectedEdges: (t, mapEdges_cb<'a>) => array<edge> = "mapUndirectedEdges"
  @send
  external _mapUndirectedEdges_ofNode: (t, node, mapEdges_cb<'a>) => array<edge> =
    "mapUndirectedEdges"
  @send
  external _mapUndirectedEdges_fromTo: (t, node, node, mapEdges_cb<'a>) => array<edge> =
    "mapUndirectedEdges"

  let mapUndirectedEdges = (t, mapEdges_args) => {
    _mapEdges_call(
      t,
      mapEdges_args,
      _mapUndirectedEdges,
      _mapEdges_ofNode,
      _mapUndirectedEdges_fromTo,
    )
  }

  // #.filterEdges
  type filterEdges_cb<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => bool

  type filterEdges_args<'a> =
    | All(filterEdges_cb<'a>)
    | Node(node, filterEdges_cb<'a>)
    | FromTo(node, node, filterEdges_cb<'a>)

  let _filterEdges_call = (t, filterEdges_args, allFn, nodeFn, _fromToFn) => {
    switch filterEdges_args {
    | All(_cb) => allFn(t, _cb)
    | Node(node, _cb) => nodeFn(t, node, _cb)
    | FromTo(source, target, _cb) => _fromToFn(t, source, target, _cb)
    }
  }

  @send external _filterEdges: (t, filterEdges_cb<'a>) => array<edge> = "filterEdges"
  @send
  external _filterEdges_ofNode: (t, node, filterEdges_cb<'a>) => array<edge> = "filterEdges"
  @send
  external _filterEdges_fromTo: (t, node, node, filterEdges_cb<'a>) => array<edge> = "filterEdges"

  let filterEdges = (t, filterEdges_args) => {
    _filterEdges_call(t, filterEdges_args, _filterEdges, _filterEdges_ofNode, _filterEdges_fromTo)
  }

  @send external _filterInEdges: (t, filterEdges_cb<'a>) => array<edge> = "filterInEdges"
  @send
  external _filterInEdges_ofNode: (t, node, filterEdges_cb<'a>) => array<edge> = "filterInEdges"
  @send
  external _filterInEdges_fromTo: (t, node, node, filterEdges_cb<'a>) => array<edge> =
    "filterInEdges"

  let filterInEdges = (t, filterEdges_args) => {
    _filterEdges_call(
      t,
      filterEdges_args,
      _filterInEdges,
      _filterInEdges_ofNode,
      _filterInEdges_fromTo,
    )
  }

  @send external _filterOutEdges: (t, filterEdges_cb<'a>) => array<edge> = "filterOutEdges"
  @send
  external _filterOutEdges_ofNode: (t, node, filterEdges_cb<'a>) => array<edge> = "filterOutEdges"
  @send
  external _filterOutEdges_fromTo: (t, node, node, filterEdges_cb<'a>) => array<edge> =
    "filterOutEdges"

  let filterOutEdges = (t, filterEdges_args) => {
    _filterEdges_call(
      t,
      filterEdges_args,
      _filterOutEdges,
      _filterOutEdges_ofNode,
      _filterOutEdges_fromTo,
    )
  }

  @send
  external _filterInboundEdges: (t, filterEdges_cb<'a>) => array<edge> = "filterInboundEdges"
  @send
  external _filterInboundEdges_ofNode: (t, node, filterEdges_cb<'a>) => array<edge> =
    "filterInboundEdges"
  @send
  external _filterInboundEdges_fromTo: (t, node, node, filterEdges_cb<'a>) => array<edge> =
    "filterInboundEdges"

  let filterInboundEdges = (t, filterEdges_args) => {
    _filterEdges_call(
      t,
      filterEdges_args,
      _filterInboundEdges,
      _filterInboundEdges_ofNode,
      _filterInboundEdges_fromTo,
    )
  }

  @send
  external _filterOutboundEdges: (t, filterEdges_cb<'a>) => array<edge> = "filterOutboundEdges"
  @send
  external _filterOutboundEdges_ofNode: (t, node, filterEdges_cb<'a>) => array<edge> =
    "filterOutboundEdges"
  @send
  external _filterOutboundEdges_fromTo: (t, node, node, filterEdges_cb<'a>) => array<edge> =
    "filterOutboundEdges"

  let filterOutboundEdges = (t, filterEdges_args) => {
    _filterEdges_call(
      t,
      filterEdges_args,
      _filterOutboundEdges,
      _filterOutboundEdges_ofNode,
      _filterOutboundEdges_fromTo,
    )
  }

  @send
  external _filterDirectedEdges: (t, filterEdges_cb<'a>) => array<edge> = "filterDirectedEdges"
  @send
  external _filterDirectedEdges_ofNode: (t, node, filterEdges_cb<'a>) => array<edge> =
    "filterDirectedEdges"
  @send
  external _filterDirectedEdges_fromTo: (t, node, node, filterEdges_cb<'a>) => array<edge> =
    "filterDirectedEdges"

  let filterDirectedEdges = (t, filterEdges_args) => {
    _filterEdges_call(
      t,
      filterEdges_args,
      _filterDirectedEdges,
      _filterDirectedEdges_ofNode,
      _filterDirectedEdges_fromTo,
    )
  }

  @send
  external _filterUndirectedEdges: (t, filterEdges_cb<'a>) => array<edge> = "filterUndirectedEdges"
  @send
  external _filterUndirectedEdges_ofNode: (t, node, filterEdges_cb<'a>) => array<edge> =
    "filterUndirectedEdges"
  @send
  external _filterUndirectedEdges_fromTo: (t, node, node, filterEdges_cb<'a>) => array<edge> =
    "filterUndirectedEdges"

  let filterUndirectedEdges = (t, filterEdges_args) => {
    _filterEdges_call(
      t,
      filterEdges_args,
      _filterUndirectedEdges,
      _filterUndirectedEdges_ofNode,
      _filterUndirectedEdges_fromTo,
    )
  }

  // #.reduceEdges
  type reduceEdges_cb<'a, 'r> = (
    'r,
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => 'r

  type reduceEdges_args<'a, 'r> =
    | All(reduceEdges_cb<'a, 'r>, 'r)
    | Node(node, reduceEdges_cb<'a, 'r>, 'r)
    | FromTo(node, node, reduceEdges_cb<'a, 'r>, 'r)

  let _reduceEdges_call = (t, reduceEdges_args, allFn, nodeFn, _fromToFn) => {
    switch reduceEdges_args {
    | All(_cb, init) => allFn(t, _cb, init)
    | Node(node, _cb, init) => nodeFn(t, node, _cb, init)
    | FromTo(source, target, _cb, init) => _fromToFn(t, source, target, _cb, init)
    }
  }

  @send external _reduceEdges: (t, reduceEdges_cb<'a, 'r>, 'r) => 'r = "reduceEdges"
  @send
  external _reduceEdges_ofNode: (t, node, reduceEdges_cb<'a, 'r>, 'r) => 'r = "reduceEdges"
  @send
  external _reduceEdges_fromTo: (t, node, node, reduceEdges_cb<'a, 'r>, 'r) => 'r = "reduceEdges"

  let reduceEdges = (t, reduceEdges_args) => {
    _reduceEdges_call(t, reduceEdges_args, _reduceEdges, _reduceEdges_ofNode, _reduceEdges_fromTo)
  }

  @send external _reduceInEdges: (t, reduceEdges_cb<'a, 'r>, 'r) => 'r = "reduceInEdges"
  @send
  external _reduceInEdges_ofNode: (t, node, reduceEdges_cb<'a, 'r>, 'r) => 'r = "reduceInEdges"
  @send
  external _reduceInEdges_fromTo: (t, node, node, reduceEdges_cb<'a, 'r>, 'r) => 'r =
    "reduceInEdges"

  let reduceInEdges = (t, reduceEdges_args) => {
    _reduceEdges_call(
      t,
      reduceEdges_args,
      _reduceInEdges,
      _reduceInEdges_ofNode,
      _reduceInEdges_fromTo,
    )
  }

  @send
  external _reduceOutEdges: (t, reduceEdges_cb<'a, 'r>, 'r) => 'r = "reduceOutEdges"
  @send
  external _reduceOutEdges_ofNode: (t, node, reduceEdges_cb<'a, 'r>, 'r) => 'r = "reduceOutEdges"
  @send
  external _reduceOutEdges_fromTo: (t, node, node, reduceEdges_cb<'a, 'r>, 'r) => 'r =
    "reduceOutEdges"

  let reduceOutEdges = (t, reduceEdges_args) => {
    _reduceEdges_call(
      t,
      reduceEdges_args,
      _reduceOutEdges,
      _reduceOutEdges_ofNode,
      _reduceOutEdges_fromTo,
    )
  }

  @send
  external _reduceOutboundEdges: (t, reduceEdges_cb<'a, 'r>, 'r) => 'r = "reduceOutboundEdges"
  @send
  external _reduceOutboundEdges_ofNode: (t, node, reduceEdges_cb<'a, 'r>, 'r) => 'r =
    "reduceOutboundEdges"
  @send
  external _reduceOutboundEdges_fromTo: (t, node, node, reduceEdges_cb<'a, 'r>, 'r) => 'r =
    "reduceOutboundEdges"

  let reduceOutboundEdges = (t, reduceEdges_args) => {
    _reduceEdges_call(
      t,
      reduceEdges_args,
      _reduceOutboundEdges,
      _reduceOutboundEdges_ofNode,
      _reduceOutboundEdges_fromTo,
    )
  }

  @send
  external _reduceDirectedEdges: (t, reduceEdges_cb<'a, 'r>, 'r) => 'r = "reduceDirectedEdges"
  @send
  external _reduceDirectedEdges_ofNode: (t, node, reduceEdges_cb<'a, 'r>, 'r) => 'r =
    "reduceDirectedEdges"
  @send
  external _reduceDirectedEdges_fromTo: (t, node, node, reduceEdges_cb<'a, 'r>, 'r) => 'r =
    "reduceDirectedEdges"

  let reduceDirectedEdges = (t, reduceEdges_args) => {
    _reduceEdges_call(
      t,
      reduceEdges_args,
      _reduceDirectedEdges,
      _reduceDirectedEdges_ofNode,
      _reduceDirectedEdges_fromTo,
    )
  }

  @send
  external _reduceUndirectedEdges: (t, reduceEdges_cb<'a, 'r>, 'r) => 'r = "reduceUndirectedEdges"
  @send
  external _reduceUndirectedEdges_ofNode: (t, node, reduceEdges_cb<'a, 'r>, 'r) => 'r =
    "reduceUndirectedEdges"
  @send
  external _reduceUndirectedEdges_fromTo: (t, node, node, reduceEdges_cb<'a, 'r>, 'r) => 'r =
    "reduceUndirectedEdges"

  let reduceUndirectedEdges = (t, reduceEdges_args) => {
    _reduceEdges_call(
      t,
      reduceEdges_args,
      _reduceUndirectedEdges,
      _reduceUndirectedEdges_ofNode,
      _reduceUndirectedEdges_fromTo,
    )
  }

  // #.findEdge
  type findEdge_cb<'a> = (edge, edgeAttr<'a>, node, node, nodeAttr<'a>, nodeAttr<'a>, bool) => unit

  type findEdge_args<'a> =
    | All(findEdge_cb<'a>)
    | Node(node, findEdge_cb<'a>)
    | FromTo(node, node, findEdge_cb<'a>)

  let _findEdge_call = (t, findEdge_args, allFn, nodeFn, _fromToFn) => {
    switch findEdge_args {
    | All(_cb) => allFn(t, _cb)
    | Node(node, _cb) => nodeFn(t, node, _cb)
    | FromTo(source, target, _cb) => _fromToFn(t, source, target, _cb)
    }
  }

  @send external _findEdge: (t, findEdge_cb<'a>) => Nullable.t<edge> = "findEdges"
  @send
  external _findEdge_ofNode: (t, node, findEdge_cb<'a>) => Nullable.t<edge> = "findEdges"
  @send
  external _findEdge_fromTo: (t, node, node, findEdge_cb<'a>) => Nullable.t<edge> = "findEdges"

  let findEdge = (t, findEdge_args) => {
    _findEdge_call(t, findEdge_args, _findEdge, _findEdge_ofNode, _findEdge_fromTo)
  }

  @send external _findInEdge: (t, findEdge_cb<'a>) => Nullable.t<edge> = "findInEdges"
  @send
  external _findInEdge_ofNode: (t, node, findEdge_cb<'a>) => Nullable.t<edge> = "findInEdges"
  @send
  external _findInEdge_fromTo: (t, node, node, findEdge_cb<'a>) => Nullable.t<edge> = "findInEdges"

  let findInEdge = (t, findEdge_args) => {
    _findEdge_call(t, findEdge_args, _findInEdge, _findInEdge_ofNode, _findInEdge_fromTo)
  }

  @send external _findOutEdge: (t, findEdge_cb<'a>) => Nullable.t<edge> = "findOutEdges"
  @send
  external _findOutEdge_ofNode: (t, node, findEdge_cb<'a>) => Nullable.t<edge> = "findOutEdges"
  @send
  external _findOutEdge_fromTo: (t, node, node, findEdge_cb<'a>) => Nullable.t<edge> =
    "findOutEdges"

  let findOutEdge = (t, findEdge_args) => {
    _findEdge_call(t, findEdge_args, _findOutEdge, _findOutEdge_ofNode, _findOutEdge_fromTo)
  }

  @send
  external _findInboundEdge: (t, findEdge_cb<'a>) => Nullable.t<edge> = "findInboundEdges"
  @send
  external _findInboundEdge_ofNode: (t, node, findEdge_cb<'a>) => Nullable.t<edge> =
    "findInboundEdges"
  @send
  external _findInboundEdge_fromTo: (t, node, node, findEdge_cb<'a>) => Nullable.t<edge> =
    "findInboundEdges"

  let findInboundEdge = (t, findEdge_args) => {
    _findEdge_call(
      t,
      findEdge_args,
      _findInboundEdge,
      _findInboundEdge_ofNode,
      _findInboundEdge_fromTo,
    )
  }

  @send
  external _findOutboundEdge: (t, findEdge_cb<'a>) => Nullable.t<edge> = "findOutboundEdges"
  @send
  external _findOutboundEdge_ofNode: (t, node, findEdge_cb<'a>) => Nullable.t<edge> =
    "findOutboundEdges"
  @send
  external _findOutboundEdge_fromTo: (t, node, node, findEdge_cb<'a>) => Nullable.t<edge> =
    "findOutboundEdges"

  let findOutboundEdge = (t, findEdge_args) => {
    _findEdge_call(
      t,
      findEdge_args,
      _findOutboundEdge,
      _findOutboundEdge_ofNode,
      _findOutboundEdge_fromTo,
    )
  }

  @send
  external _findDirectedEdge: (t, findEdge_cb<'a>) => Nullable.t<edge> = "findDirectedEdges"
  @send
  external _findDirectedEdge_ofNode: (t, node, findEdge_cb<'a>) => Nullable.t<edge> =
    "findDirectedEdges"
  @send
  external _findDirectedEdge_fromTo: (t, node, node, findEdge_cb<'a>) => Nullable.t<edge> =
    "findDirectedEdges"

  let findDirectedEdge = (t, findEdge_args) => {
    _findEdge_call(
      t,
      findEdge_args,
      _findDirectedEdge,
      _findDirectedEdge_ofNode,
      _findDirectedEdge_fromTo,
    )
  }

  @send
  external _findUndirectedEdge: (t, findEdge_cb<'a>) => Nullable.t<edge> = "findUndirectedEdges"
  @send
  external _findUndirectedEdge_ofNode: (t, node, findEdge_cb<'a>) => Nullable.t<edge> =
    "findUndirectedEdges"
  @send
  external _findUndirectedEdge_fromTo: (t, node, node, findEdge_cb<'a>) => Nullable.t<edge> =
    "findUndirectedEdges"

  let findUndirectedEdge = (t, findEdge_args) => {
    _findEdge_call(
      t,
      findEdge_args,
      _findUndirectedEdge,
      _findUndirectedEdge_ofNode,
      _findUndirectedEdge_fromTo,
    )
  }

  // #.someEdge
  type someEdge_cb<'a> = (edge, edgeAttr<'a>, node, node, nodeAttr<'a>, nodeAttr<'a>, bool) => bool

  type someEdge_args<'a> =
    | All(someEdge_cb<'a>)
    | Node(node, someEdge_cb<'a>)
    | FromTo(node, node, someEdge_cb<'a>)

  let _someEdge_call = (t, someEdge_args, allFn, nodeFn, _fromToFn) => {
    switch someEdge_args {
    | All(_cb) => allFn(t, _cb)
    | Node(node, _cb) => nodeFn(t, node, _cb)
    | FromTo(source, target, _cb) => _fromToFn(t, source, target, _cb)
    }
  }

  @send external _someEdge: (t, someEdge_cb<'a>) => bool = "someEdge"
  @send
  external _someEdge_ofNode: (t, node, someEdge_cb<'a>) => bool = "someEdge"
  @send
  external _someEdge_fromTo: (t, node, node, someEdge_cb<'a>) => bool = "someEdge"

  let someEdge = (t, someEdge_args) => {
    _someEdge_call(t, someEdge_args, _someEdge, _someEdge_ofNode, _someEdge_fromTo)
  }

  @send external _someInEdge: (t, someEdge_cb<'a>) => bool = "someInEdge"
  @send
  external _someInEdge_ofNode: (t, node, someEdge_cb<'a>) => bool = "someInEdge"
  @send
  external _someInEdge_fromTo: (t, node, node, someEdge_cb<'a>) => bool = "someInEdge"

  let someInEdge = (t, someEdge_args) => {
    _someEdge_call(t, someEdge_args, _someInEdge, _someInEdge_ofNode, _someInEdge_fromTo)
  }

  @send external _someOutEdge: (t, someEdge_cb<'a>) => bool = "someOutEdge"
  @send
  external _someOutEdge_ofNode: (t, node, someEdge_cb<'a>) => bool = "someOutEdge"
  @send
  external _someOutEdge_fromTo: (t, node, node, someEdge_cb<'a>) => bool = "someOutEdge"

  let someOutEdge = (t, someEdge_args) => {
    _someEdge_call(t, someEdge_args, _someOutEdge, _someOutEdge_ofNode, _someOutEdge_fromTo)
  }

  @send external _someInboundEdge: (t, someEdge_cb<'a>) => bool = "someInboundEdge"
  @send
  external _someInboundEdge_ofNode: (t, node, someEdge_cb<'a>) => bool = "someInboundEdge"
  @send
  external _someInboundEdge_fromTo: (t, node, node, someEdge_cb<'a>) => bool = "someInboundEdge"

  let someInboundEdge = (t, someEdge_args) => {
    _someEdge_call(
      t,
      someEdge_args,
      _someInboundEdge,
      _someInboundEdge_ofNode,
      _someInboundEdge_fromTo,
    )
  }

  @send external _someOutboundEdge: (t, someEdge_cb<'a>) => bool = "someOutboundEdge"
  @send
  external _someOutboundEdge_ofNode: (t, node, someEdge_cb<'a>) => bool = "someOutboundEdge"
  @send
  external _someOutboundEdge_fromTo: (t, node, node, someEdge_cb<'a>) => bool = "someOutboundEdge"

  let someOutboundEdge = (t, someEdge_args) => {
    _someEdge_call(
      t,
      someEdge_args,
      _someOutboundEdge,
      _someOutboundEdge_ofNode,
      _someOutboundEdge_fromTo,
    )
  }

  @send external _someDirectedEdge: (t, someEdge_cb<'a>) => bool = "someDirectedEdge"
  @send
  external _someDirectedEdge_ofNode: (t, node, someEdge_cb<'a>) => bool = "someDirectedEdge"
  @send
  external _someDirectedEdge_fromTo: (t, node, node, someEdge_cb<'a>) => bool = "someDirectedEdge"

  let someDirectedEdge = (t, someEdge_args) => {
    _someEdge_call(
      t,
      someEdge_args,
      _someDirectedEdge,
      _someDirectedEdge_ofNode,
      _someDirectedEdge_fromTo,
    )
  }

  @send external _someUndirectedEdge: (t, someEdge_cb<'a>) => bool = "someUndirectedEdge"
  @send
  external _someUndirectedEdge_ofNode: (t, node, someEdge_cb<'a>) => bool = "someUndirectedEdge"
  @send
  external _someUndirectedEdge_fromTo: (t, node, node, someEdge_cb<'a>) => bool =
    "someUndirectedEdge"

  let someUndirectedEdge = (t, someEdge_args) => {
    _someEdge_call(
      t,
      someEdge_args,
      _someUndirectedEdge,
      _someUndirectedEdge_ofNode,
      _someUndirectedEdge_fromTo,
    )
  }

  // #.everyEdge
  type everyEdge_cb<'a> = (edge, edgeAttr<'a>, node, node, nodeAttr<'a>, nodeAttr<'a>, bool) => bool

  type everyEdge_args<'a> =
    | All(everyEdge_cb<'a>)
    | Node(node, everyEdge_cb<'a>)
    | FromTo(node, node, everyEdge_cb<'a>)

  let _everyEdge_call = (t, everyEdge_args, allFn, nodeFn, _fromToFn) => {
    switch everyEdge_args {
    | All(_cb) => allFn(t, _cb)
    | Node(node, _cb) => nodeFn(t, node, _cb)
    | FromTo(source, target, _cb) => _fromToFn(t, source, target, _cb)
    }
  }

  @send external _everyEdge: (t, everyEdge_cb<'a>) => bool = "everyEdge"
  @send
  external _everyEdge_ofNode: (t, node, everyEdge_cb<'a>) => bool = "everyEdge"
  @send
  external _everyEdge_fromTo: (t, node, node, everyEdge_cb<'a>) => bool = "everyEdge"

  let everyEdge = (t, everyEdge_args) => {
    _everyEdge_call(t, everyEdge_args, _everyEdge, _everyEdge_ofNode, _everyEdge_fromTo)
  }

  @send external _everyInEdge: (t, everyEdge_cb<'a>) => bool = "everyInEdge"
  @send
  external _everyInEdge_ofNode: (t, node, everyEdge_cb<'a>) => bool = "everyInEdge"
  @send
  external _everyInEdge_fromTo: (t, node, node, everyEdge_cb<'a>) => bool = "everyInEdge"

  let everyInEdge = (t, everyEdge_args) => {
    _everyEdge_call(t, everyEdge_args, _everyInEdge, _everyInEdge_ofNode, _everyInEdge_fromTo)
  }

  @send external _everyOutEdge: (t, everyEdge_cb<'a>) => bool = "everyOutEdge"
  @send
  external _everyOutEdge_ofNode: (t, node, everyEdge_cb<'a>) => bool = "everyOutEdge"
  @send
  external _everyOutEdge_fromTo: (t, node, node, everyEdge_cb<'a>) => bool = "everyOutEdge"

  let everyOutEdge = (t, everyEdge_args) => {
    _everyEdge_call(t, everyEdge_args, _everyOutEdge, _everyOutEdge_ofNode, _everyOutEdge_fromTo)
  }

  @send external _everyInboundEdge: (t, everyEdge_cb<'a>) => bool = "everyInboundEdge"
  @send
  external _everyInboundEdge_ofNode: (t, node, everyEdge_cb<'a>) => bool = "everyInboundEdge"
  @send
  external _everyInboundEdge_fromTo: (t, node, node, everyEdge_cb<'a>) => bool = "everyInboundEdge"

  let everyInboundEdge = (t, everyEdge_args) => {
    _everyEdge_call(
      t,
      everyEdge_args,
      _everyInboundEdge,
      _everyInboundEdge_ofNode,
      _everyInboundEdge_fromTo,
    )
  }

  @send external _everyOutboundEdge: (t, everyEdge_cb<'a>) => bool = "everyOutboundEdge"
  @send
  external _everyOutboundEdge_ofNode: (t, node, everyEdge_cb<'a>) => bool = "everyOutboundEdge"
  @send
  external _everyOutboundEdge_fromTo: (t, node, node, everyEdge_cb<'a>) => bool =
    "everyOutboundEdge"

  let everyOutboundEdge = (t, everyEdge_args) => {
    _everyEdge_call(
      t,
      everyEdge_args,
      _everyOutboundEdge,
      _everyOutboundEdge_ofNode,
      _everyOutboundEdge_fromTo,
    )
  }

  @send external _everyDirectedEdge: (t, everyEdge_cb<'a>) => bool = "everyDirectedEdge"
  @send
  external _everyDirectedEdge_ofNode: (t, node, everyEdge_cb<'a>) => bool = "everyDirectedEdge"
  @send
  external _everyDirectedEdge_fromTo: (t, node, node, everyEdge_cb<'a>) => bool =
    "everyDirectedEdge"

  let everyDirectedEdge = (t, everyEdge_args) => {
    _everyEdge_call(
      t,
      everyEdge_args,
      _everyDirectedEdge,
      _everyDirectedEdge_ofNode,
      _everyDirectedEdge_fromTo,
    )
  }

  @send external _everyUndirectedEdge: (t, everyEdge_cb<'a>) => bool = "everyUndirectedEdge"
  @send
  external _everyUndirectedEdge_ofNode: (t, node, everyEdge_cb<'a>) => bool = "everyUndirectedEdge"
  @send
  external _everyUndirectedEdge_fromTo: (t, node, node, everyEdge_cb<'a>) => bool =
    "everyUndirectedEdge"

  let everyUndirectedEdge = (t, everyEdge_args) => {
    _everyEdge_call(
      t,
      everyEdge_args,
      _everyUndirectedEdge,
      _everyUndirectedEdge_ofNode,
      _everyUndirectedEdge_fromTo,
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

  type edgeEntries_args<'a> =
    | All
    | Node(node)
    | FromTo(node, node)

  let _edgeEntries_call = (t, edgeEntries_args, allFn, nodeFn, _fromToFn) => {
    switch edgeEntries_args {
    | All => allFn(t)
    | Node(node) => nodeFn(t, node)
    | FromTo(source, target) => _fromToFn(t, source, target)
    }
  }

  @send external _edgeEntries: t => RescriptCore.Iterator.t<edgeIterValue<'a>> = "edgeEntries"
  @send
  external _edgeEntries_ofNode: (t, node) => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "edgeEntries"
  @send
  external _edgeEntries_fromTo: (t, node, node) => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "edgeEntries"

  let edgeEntries = (t, edgeEntries_args) => {
    _edgeEntries_call(t, edgeEntries_args, _edgeEntries, _edgeEntries_ofNode, _edgeEntries_fromTo)
  }

  @send external _inEdgeEntries: t => RescriptCore.Iterator.t<edgeIterValue<'a>> = "inEdgeEntries"
  @send
  external _inEdgeEntries_ofNode: (t, node) => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "inEdgeEntries"
  @send
  external _inEdgeEntries_fromTo: (t, node, node) => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "inEdgeEntries"

  let inEdgeEntries = (t, edgeEntries_args) => {
    _edgeEntries_call(
      t,
      edgeEntries_args,
      _inEdgeEntries,
      _inEdgeEntries_ofNode,
      _inEdgeEntries_fromTo,
    )
  }

  @send external _outEdgeEntries: t => RescriptCore.Iterator.t<edgeIterValue<'a>> = "outEdgeEntries"
  @send
  external _outEdgeEntries_ofNode: (t, node) => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "outEdgeEntries"
  @send
  external _outEdgeEntries_fromTo: (t, node, node) => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "outEdgeEntries"

  let outEdgeEntries = (t, edgeEntries_args) => {
    _edgeEntries_call(
      t,
      edgeEntries_args,
      _outEdgeEntries,
      _outEdgeEntries_ofNode,
      _outEdgeEntries_fromTo,
    )
  }

  @send
  external _inboundEdgeEntries: t => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "inboundEdgeEntries"
  @send
  external _inboundEdgeEntries_ofNode: (t, node) => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "inboundEdgeEntries"
  @send
  external _inboundEdgeEntries_fromTo: (
    t,
    node,
    node,
  ) => RescriptCore.Iterator.t<edgeIterValue<'a>> = "inboundEdgeEntries"

  let inboundEdgeEntries = (t, edgeEntries_args) => {
    _edgeEntries_call(
      t,
      edgeEntries_args,
      _inboundEdgeEntries,
      _inboundEdgeEntries_ofNode,
      _inboundEdgeEntries_fromTo,
    )
  }

  @send
  external _outboundEdgeEntries: t => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "outboundEdgeEntries"
  @send
  external _outboundEdgeEntries_ofNode: (t, node) => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "outboundEdgeEntries"
  @send
  external _outboundEdgeEntries_fromTo: (
    t,
    node,
    node,
  ) => RescriptCore.Iterator.t<edgeIterValue<'a>> = "outboundEdgeEntries"

  let outboundEdgeEntries = (t, edgeEntries_args) => {
    _edgeEntries_call(
      t,
      edgeEntries_args,
      _outboundEdgeEntries,
      _outboundEdgeEntries_ofNode,
      _outboundEdgeEntries_fromTo,
    )
  }

  @send
  external _directedEdgeEntries: t => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "directedEdgeEntries"
  @send
  external _directedEdgeEntries_ofNode: (t, node) => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "directedEdgeEntries"
  @send
  external _directedEdgeEntries_fromTo: (
    t,
    node,
    node,
  ) => RescriptCore.Iterator.t<edgeIterValue<'a>> = "directedEdgeEntries"

  let directedEdgeEntries = (t, edgeEntries_args) => {
    _edgeEntries_call(
      t,
      edgeEntries_args,
      _directedEdgeEntries,
      _directedEdgeEntries_ofNode,
      _directedEdgeEntries_fromTo,
    )
  }

  @send
  external _undirectedEdgeEntries: t => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "undirectedEdgeEntries"
  @send
  external _undirectedEdgeEntries_ofNode: (t, node) => RescriptCore.Iterator.t<edgeIterValue<'a>> =
    "undirectedEdgeEntries"
  @send
  external _undirectedEdgeEntries_fromTo: (
    t,
    node,
    node,
  ) => RescriptCore.Iterator.t<edgeIterValue<'a>> = "undirectedEdgeEntries"

  let undirectedEdgeEntries = (t, edgeEntries_args) => {
    _edgeEntries_call(
      t,
      edgeEntries_args,
      _undirectedEdgeEntries,
      _undirectedEdgeEntries_ofNode,
      _undirectedEdgeEntries_fromTo,
    )
  }
}
