module type GRAPH_TYPES = Graphology__GraphTypes.T

module type NEIGHBORS_ITER = {
  include GRAPH_TYPES
  type neighbors_args = All | Node(node) | FromTo(node, node)

  // Returns an array of relevant edge keys.
  // #.edges
  let neighbors: (t, neighbors_args) => array<edge>
  let inNeighbors: (t, neighbors_args) => array<edge>
  let outNeighbors: (t, neighbors_args) => array<edge>
  let inboundNeighbors: (t, neighbors_args) => array<edge>
  let outboundNeighbors: (t, neighbors_args) => array<edge>
  let directedNeighbors: (t, neighbors_args) => array<edge>
  let undirectedNeighbors: (t, neighbors_args) => array<edge>

  // Iterates over relevant edges using a _cb.
  // #.forEachNeighbor
  type forEachNeighbor_cb<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => unit

  type forEachNeighbor_args<'a> =
    | All(forEachNeighbor_cb<'a>)
    | Node(node, forEachNeighbor_cb<'a>)
    | FromTo(node, node, forEachNeighbor_cb<'a>)

  let forEachNeighbor: (t, forEachNeighbor_args<'a>) => unit
  let forEachInNeighbor: (t, forEachNeighbor_args<'a>) => unit
  let forEachOutNeighbor: (t, forEachNeighbor_args<'a>) => unit
  let forEachInboundNeighbor: (t, forEachNeighbor_args<'a>) => unit
  let forEachOutboundNeighbor: (t, forEachNeighbor_args<'a>) => unit
  let forEachDirectedNeighbor: (t, forEachNeighbor_args<'a>) => unit
  let forEachUndirectedNeighbor: (t, forEachNeighbor_args<'a>) => unit

  // #.mapNeighbors
  type mapNeighbors_cb<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => edge

  type mapNeighbors_args<'a> =
    | All(mapNeighbors_cb<'a>)
    | Node(node, mapNeighbors_cb<'a>)
    | FromTo(node, node, mapNeighbors_cb<'a>)

  let mapNeighbors: (t, mapNeighbors_args<'a>) => array<edge>
  let mapInNeighbors: (t, mapNeighbors_args<'a>) => array<edge>
  let mapOutNeighbors: (t, mapNeighbors_args<'a>) => array<edge>
  let mapInboundNeighbors: (t, mapNeighbors_args<'a>) => array<edge>
  let mapOutboundNeighbors: (t, mapNeighbors_args<'a>) => array<edge>
  let mapDirectedNeighbors: (t, mapNeighbors_args<'a>) => array<edge>
  let mapUndirectedNeighbors: (t, mapNeighbors_args<'a>) => array<edge>

  // #.filterEdges
  type filterNeighbors_cb<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => bool

  type filterNeighbors_args<'a> =
    | All(filterNeighbors_cb<'a>)
    | Node(node, filterNeighbors_cb<'a>)
    | FromTo(node, node, filterNeighbors_cb<'a>)

  let filterNeighbors: (t, filterNeighbors_args<'a>) => array<edge>
  let filterInNeighbors: (t, filterNeighbors_args<'a>) => array<edge>
  let filterOutNeighbors: (t, filterNeighbors_args<'a>) => array<edge>
  let filterInboundNeighbors: (t, filterNeighbors_args<'a>) => array<edge>
  let filterOutboundNeighbors: (t, filterNeighbors_args<'a>) => array<edge>
  let filterDirectedNeighbors: (t, filterNeighbors_args<'a>) => array<edge>
  let filterUndirectedNeighbors: (t, filterNeighbors_args<'a>) => array<edge>

  // #.reduceEdges
  type reduceNeighbors_cb<'a, 'r> = (
    'r,
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => 'r

  type reduceNeighbors_args<'a, 'r> =
    | All(reduceNeighbors_cb<'a, 'r>, 'r)
    | Node(node, reduceNeighbors_cb<'a, 'r>, 'r)
    | FromTo(node, node, reduceNeighbors_cb<'a, 'r>, 'r)

  let reduceNeighbors: (t, reduceNeighbors_args<'a, 'r>) => 'r
  let reduceInNeighbors: (t, reduceNeighbors_args<'a, 'r>) => 'r
  let reduceOutNeighbors: (t, reduceNeighbors_args<'a, 'r>) => 'r
  let reduceOutboundNeighbors: (t, reduceNeighbors_args<'a, 'r>) => 'r
  let reduceDirectedNeighbors: (t, reduceNeighbors_args<'a, 'r>) => 'r
  let reduceUndirectedNeighbors: (t, reduceNeighbors_args<'a, 'r>) => 'r

  // #.findEdge
  type findNeighbor_cb<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => unit

  type findNeighbor_args<'a> =
    | All(findNeighbor_cb<'a>)
    | Node(node, findNeighbor_cb<'a>)
    | FromTo(node, node, findNeighbor_cb<'a>)

  let findNeighbor: (t, findNeighbor_args<'a>) => Nullable.t<edge>
  let findInNeighbor: (t, findNeighbor_args<'a>) => Nullable.t<edge>
  let findOutNeighbor: (t, findNeighbor_args<'a>) => Nullable.t<edge>
  let findInboundNeighbor: (t, findNeighbor_args<'a>) => Nullable.t<edge>
  let findOutboundNeighbor: (t, findNeighbor_args<'a>) => Nullable.t<edge>
  let findDirectedNeighbor: (t, findNeighbor_args<'a>) => Nullable.t<edge>
  let findUndirectedNeighbor: (t, findNeighbor_args<'a>) => Nullable.t<edge>

  // #.someEdge
  type someNeighbor_cb<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => bool

  type someNeighbor_args<'a> =
    | All(someNeighbor_cb<'a>)
    | Node(node, someNeighbor_cb<'a>)
    | FromTo(node, node, someNeighbor_cb<'a>)

  let someNeighbor: (t, someNeighbor_args<'a>) => bool
  let someInNeighbor: (t, someNeighbor_args<'a>) => bool
  let someOutNeighbor: (t, someNeighbor_args<'a>) => bool
  let someInboundNeighbor: (t, someNeighbor_args<'a>) => bool
  let someOutboundNeighbor: (t, someNeighbor_args<'a>) => bool
  let someDirectedNeighbor: (t, someNeighbor_args<'a>) => bool
  let someUndirectedNeighbor: (t, someNeighbor_args<'a>) => bool

  // #.everyEdge
  type everyNeighbor_cb<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => bool

  type everyNeighbor_args<'a> =
    | All(everyNeighbor_cb<'a>)
    | Node(node, everyNeighbor_cb<'a>)
    | FromTo(node, node, everyNeighbor_cb<'a>)

  let everyNeighbor: (t, everyNeighbor_args<'a>) => bool
  let everyInNeighbor: (t, everyNeighbor_args<'a>) => bool
  let everyOutNeighbor: (t, everyNeighbor_args<'a>) => bool
  let everyInboundNeighbor: (t, everyNeighbor_args<'a>) => bool
  let everyOutboundNeighbor: (t, everyNeighbor_args<'a>) => bool
  let everyDirectedNeighbor: (t, everyNeighbor_args<'a>) => bool
  let everyUndirectedNeighbor: (t, everyNeighbor_args<'a>) => bool

  //#.edgeEntries
  type neighborIterValue<'a> = {
    edge: edge,
    attributes: edgeAttr<'a>,
    source: node,
    target: node,
    sourceAttributes: nodeAttr<'a>,
    targetAttributes: nodeAttr<'a>,
  }

  type neighborEntries_args<'a> =
    | All
    | Node(node)
    | FromTo(node, node)

  let neighborEntries: (
    t,
    neighborEntries_args<'a>,
  ) => RescriptCore.Iterator.t<neighborIterValue<'a>>
  let inNeighborEntries: (
    t,
    neighborEntries_args<'a>,
  ) => RescriptCore.Iterator.t<neighborIterValue<'a>>
  let outNeighborEntries: (
    t,
    neighborEntries_args<'a>,
  ) => RescriptCore.Iterator.t<neighborIterValue<'a>>
  let inboundNeighborEntries: (
    t,
    neighborEntries_args<'a>,
  ) => RescriptCore.Iterator.t<neighborIterValue<'a>>
  let outboundNeighborEntries: (
    t,
    neighborEntries_args<'a>,
  ) => RescriptCore.Iterator.t<neighborIterValue<'a>>
  let directedNeighborEntries: (
    t,
    neighborEntries_args<'a>,
  ) => RescriptCore.Iterator.t<neighborIterValue<'a>>
  let undirectedNeighborEntries: (
    t,
    neighborEntries_args<'a>,
  ) => RescriptCore.Iterator.t<neighborIterValue<'a>>
}

// functor type
module type NEIGHBORS_ITER_F = (C: GRAPH_TYPES) =>
(
  NEIGHBORS_ITER
    with type t = C.t
    and type node = C.node
    and type edge = C.edge
    and type graphAttr<'a> = C.graphAttr<'a>
    and type nodeAttr<'a> = C.nodeAttr<'a>
    and type edgeAttr<'a> = C.edgeAttr<'a>
)

module MakeNeighborsIter: NEIGHBORS_ITER_F = (C: GRAPH_TYPES) => {
  type t = C.t
  type node = C.node
  type edge = C.edge
  type graphAttr<'a> = C.graphAttr<'a>
  type nodeAttr<'a> = C.nodeAttr<'a>
  type edgeAttr<'a> = C.edgeAttr<'a>

  type neighbors_args = All | Node(node) | FromTo(node, node)

  let _neighbors_call = (t, neighbors_args, allFn, nodeFn, _fromToFn) => {
    switch neighbors_args {
    | All => allFn(t)
    | Node(node) => nodeFn(t, node)
    | FromTo(source, target) => _fromToFn(t, source, target)
    }
  }

  // #.edges
  @send external _neighbors: t => array<edge> = "neighbors"
  @send external _neighbors_ofNode: (t, node) => array<edge> = "neighbors"
  @send external _neighbors_fromTo: (t, node, node) => array<edge> = "neighbors"

  let neighbors = (t, neighbors_args) => {
    _neighbors_call(t, neighbors_args, _neighbors, _neighbors_ofNode, _neighbors_fromTo)
  }

  // #.inEdges
  @send external _inNeighbors: t => array<edge> = "inNeighbors"
  @send external _inNeighbors_ofNode: (t, node) => array<edge> = "inNeighbors"
  @send external _inNeighbors_fromTo: (t, node, node) => array<edge> = "inNeighbors"

  let inNeighbors = (t, neighbors_args) => {
    _neighbors_call(t, neighbors_args, _inNeighbors, _inNeighbors_ofNode, _inNeighbors_fromTo)
  }

  // #.outEdges
  @send external _outNeighbors: t => array<edge> = "outNeighbors"
  @send external _outNeighbors_ofNode: (t, node) => array<edge> = "outNeighbors"
  @send external _outNeighbors_fromTo: (t, node, node) => array<edge> = "outNeighbors"

  let outNeighbors = (t, neighbors_args) => {
    _neighbors_call(t, neighbors_args, _outNeighbors, _outNeighbors_ofNode, _outNeighbors_fromTo)
  }

  // #. inboundEdges
  @send external _inboundNeighbors: t => array<edge> = "inboundNeighbors"
  @send external _inboundNeighbors_ofNode: (t, node) => array<edge> = "inboundNeighbors"
  @send external _inboundNeighbors_fromTo: (t, node, node) => array<edge> = "inboundNeighbors"

  let inboundNeighbors = (t, neighbors_args) => {
    _neighbors_call(
      t,
      neighbors_args,
      _inboundNeighbors,
      _inboundNeighbors_ofNode,
      _inboundNeighbors_fromTo,
    )
  }

  // #.outboundEdges
  @send external _outboundNeighbors: t => array<edge> = "outboundNeighbors"
  @send external _outboundNeighbors_ofNode: (t, node) => array<edge> = "outboundNeighbors"
  @send external _outboundNeighbors_fromTo: (t, node, node) => array<edge> = "outboundNeighbors"

  let outboundNeighbors = (t, neighbors_args) => {
    _neighbors_call(
      t,
      neighbors_args,
      _outboundNeighbors,
      _outboundNeighbors_ofNode,
      _outboundNeighbors_fromTo,
    )
  }

  // #.directedEdges
  @send external _directedNeighbors: t => array<edge> = "directedNeighbors"
  @send external _directedNeighbors_ofNode: (t, node) => array<edge> = "directedNeighbors"
  @send external _directedNeighbors_fromTo: (t, node, node) => array<edge> = "directedNeighbors"

  let directedNeighbors = (t, neighbors_args) => {
    _neighbors_call(
      t,
      neighbors_args,
      _directedNeighbors,
      _directedNeighbors_ofNode,
      _directedNeighbors_fromTo,
    )
  }

  // #.undirectedEdges
  @send external _undirectedNeighbors: t => array<edge> = "undirectedNeighbors"
  @send external _undirectedNeighbors_ofNode: (t, node) => array<edge> = "undirectedNeighbors"
  @send external _undirectedNeighbors_fromTo: (t, node, node) => array<edge> = "undirectedNeighbors"

  let undirectedNeighbors = (t, neighbors_args) => {
    _neighbors_call(
      t,
      neighbors_args,
      _undirectedNeighbors,
      _undirectedNeighbors_ofNode,
      _undirectedNeighbors_fromTo,
    )
  }

  // #.forEachNeighbor
  type forEachNeighbor_cb<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => unit

  type forEachNeighbor_args<'a> =
    | All(forEachNeighbor_cb<'a>)
    | Node(node, forEachNeighbor_cb<'a>)
    | FromTo(node, node, forEachNeighbor_cb<'a>)

  let _forEachNeighbor_call = (t, forEachNeighbor_args, allFn, nodeFn, _fromToFn) => {
    switch forEachNeighbor_args {
    | All(_cb) => allFn(t, _cb)
    | Node(node, _cb) => nodeFn(t, node, _cb)
    | FromTo(source, target, _cb) => _fromToFn(t, source, target, _cb)
    }
  }

  // #.forEachEdge
  @send external _forEachNeighbor: (t, forEachNeighbor_cb<'a>) => unit = "forEachNeighbor"
  @send
  external _forEachNeighbor_ofNode: (t, node, forEachNeighbor_cb<'a>) => unit = "forEachNeighbor"
  @send
  external _forEachNeighbor_fromTo: (t, node, node, forEachNeighbor_cb<'a>) => unit =
    "forEachNeighbor"

  let forEachNeighbor = (t, forEachNeighbor_args) => {
    _forEachNeighbor_call(
      t,
      forEachNeighbor_args,
      _forEachNeighbor,
      _forEachNeighbor_ofNode,
      _forEachNeighbor_fromTo,
    )
  }

  // #.forEachInEdge
  @send external _forEachInNeighbor: (t, forEachNeighbor_cb<'a>) => unit = "forEachInNeighbor"
  @send
  external _forEachInNeighbor_ofNode: (t, node, forEachNeighbor_cb<'a>) => unit =
    "forEachInNeighbor"
  @send
  external _forEachInNeighbor_fromTo: (t, node, node, forEachNeighbor_cb<'a>) => unit =
    "forEachInNeighbor"

  let forEachInNeighbor = (t, forEachNeighbor_args) => {
    _forEachNeighbor_call(
      t,
      forEachNeighbor_args,
      _forEachInNeighbor,
      _forEachInNeighbor_ofNode,
      _forEachInNeighbor_fromTo,
    )
  }

  // #.forEachOutNeighbor
  @send external _forEachOutNeighbor: (t, forEachNeighbor_cb<'a>) => unit = "forEachOutNeighbor"
  @send
  external _forEachOutNeighbor_ofNode: (t, node, forEachNeighbor_cb<'a>) => unit =
    "forEachOutNeighbor"
  @send
  external _forEachOutNeighbor_fromTo: (t, node, node, forEachNeighbor_cb<'a>) => unit =
    "forEachOutNeighbor"

  let forEachOutNeighbor = (t, forEachNeighbor_args) => {
    _forEachNeighbor_call(
      t,
      forEachNeighbor_args,
      _forEachOutNeighbor,
      _forEachOutNeighbor_ofNode,
      _forEachOutNeighbor_fromTo,
    )
  }

  // #.forEachInboundEdge
  @send
  external _forEachInboundNeighbor: (t, forEachNeighbor_cb<'a>) => unit = "forEachInboundNeighbor"
  @send
  external _forEachInboundNeighbor_ofNode: (t, node, forEachNeighbor_cb<'a>) => unit =
    "forEachInboundNeighbor"
  @send
  external _forEachInboundNeighbor_fromTo: (t, node, node, forEachNeighbor_cb<'a>) => unit =
    "forEachInboundNeighbor"

  let forEachInboundNeighbor = (t, forEachNeighbor_args) => {
    _forEachNeighbor_call(
      t,
      forEachNeighbor_args,
      _forEachInboundNeighbor,
      _forEachInboundNeighbor_ofNode,
      _forEachInboundNeighbor_fromTo,
    )
  }

  // #.forEachOutboundEdge
  @send
  external _forEachOutboundNeighbor: (t, forEachNeighbor_cb<'a>) => unit = "forEachOutboundNeighbor"
  @send
  external _forEachOutboundNeighbor_ofNode: (t, node, forEachNeighbor_cb<'a>) => unit =
    "forEachOutboundNeighbor"
  @send
  external _forEachOutboundNeighbor_fromTo: (t, node, node, forEachNeighbor_cb<'a>) => unit =
    "forEachOutboundNeighbor"

  let forEachOutboundNeighbor = (t, forEachNeighbor_args) => {
    _forEachNeighbor_call(
      t,
      forEachNeighbor_args,
      _forEachOutboundNeighbor,
      _forEachOutboundNeighbor_ofNode,
      _forEachOutboundNeighbor_fromTo,
    )
  }

  // #.forEachDirectedEdge
  @send
  external _forEachDirectedNeighbor: (t, forEachNeighbor_cb<'a>) => unit = "forEachDirectedNeighbor"
  @send
  external _forEachDirectedNeighbor_ofNode: (t, node, forEachNeighbor_cb<'a>) => unit =
    "forEachDirectedNeighbor"
  @send
  external _forEachDirectedNeighbor_fromTo: (t, node, node, forEachNeighbor_cb<'a>) => unit =
    "forEachDirectedNeighbor"

  let forEachDirectedNeighbor = (t, forEachNeighbor_args) => {
    _forEachNeighbor_call(
      t,
      forEachNeighbor_args,
      _forEachDirectedNeighbor,
      _forEachDirectedNeighbor_ofNode,
      _forEachDirectedNeighbor_fromTo,
    )
  }

  // #.forEachUndirectedEdge
  @send
  external _forEachUndirectedNeighbor: (t, forEachNeighbor_cb<'a>) => unit =
    "forEachUndirectedNeighbor"
  @send
  external _forEachUndirectedNeighbor_ofNode: (t, node, forEachNeighbor_cb<'a>) => unit =
    "forEachUndirectedNeighbor"
  @send
  external _forEachUndirectedNeighbor_fromTo: (t, node, node, forEachNeighbor_cb<'a>) => unit =
    "forEachUndirectedNeighbor"

  let forEachUndirectedNeighbor = (t, forEachUndirectedNeighbor_args) => {
    _forEachNeighbor_call(
      t,
      forEachUndirectedNeighbor_args,
      _forEachUndirectedNeighbor,
      _forEachUndirectedNeighbor_ofNode,
      _forEachUndirectedNeighbor_fromTo,
    )
  }

  // #.mapNeighbors
  type mapNeighbors_cb<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => edge

  type mapNeighbors_args<'a> =
    | All(mapNeighbors_cb<'a>)
    | Node(node, mapNeighbors_cb<'a>)
    | FromTo(node, node, mapNeighbors_cb<'a>)

  let _mapNeighbors_call = (t, mapNeighbors_args, allFn, nodeFn, _fromToFn) => {
    switch mapNeighbors_args {
    | All(_cb) => allFn(t, _cb)
    | Node(node, _cb) => nodeFn(t, node, _cb)
    | FromTo(source, target, _cb) => _fromToFn(t, source, target, _cb)
    }
  }

  @send external _mapNeighbors: (t, mapNeighbors_cb<'a>) => array<edge> = "mapNeighbors"
  @send
  external _mapNeighbors_ofNode: (t, node, mapNeighbors_cb<'a>) => array<edge> = "mapNeighbors"
  @send
  external _mapNeighbors_fromTo: (t, node, node, mapNeighbors_cb<'a>) => array<edge> =
    "mapNeighbors"

  let mapNeighbors = (t, mapNeighbors_args) => {
    _mapNeighbors_call(
      t,
      mapNeighbors_args,
      _mapNeighbors,
      _mapNeighbors_ofNode,
      _mapNeighbors_fromTo,
    )
  }

  @send external _mapInNeighbors: (t, mapNeighbors_cb<'a>) => array<edge> = "mapInNeighbors"
  @send
  external _mapInNeighbors_ofNode: (t, node, mapNeighbors_cb<'a>) => array<edge> = "mapInNeighbors"
  @send
  external _mapInNeighbors_fromTo: (t, node, node, mapNeighbors_cb<'a>) => array<edge> =
    "mapInNeighbors"

  let mapInNeighbors = (t, mapNeighbors_args) => {
    _mapNeighbors_call(
      t,
      mapNeighbors_args,
      _mapInNeighbors,
      _mapInNeighbors_ofNode,
      _mapInNeighbors_fromTo,
    )
  }

  @send external _mapOutNeighbors: (t, mapNeighbors_cb<'a>) => array<edge> = "mapOutNeighbors"
  @send
  external _mapOutNeighbors_ofNode: (t, node, mapNeighbors_cb<'a>) => array<edge> =
    "mapOutNeighbors"
  @send
  external _mapOutNeighbors_fromTo: (t, node, node, mapNeighbors_cb<'a>) => array<edge> =
    "mapOutNeighbors"

  let mapOutNeighbors = (t, mapNeighbors_args) => {
    _mapNeighbors_call(
      t,
      mapNeighbors_args,
      _mapOutNeighbors,
      _mapOutNeighbors_ofNode,
      _mapOutNeighbors_fromTo,
    )
  }

  @send
  external _mapInboundNeighbors: (t, mapNeighbors_cb<'a>) => array<edge> = "mapInboundNeighbors"
  @send
  external _mapInboundNeighbors_ofNode: (t, node, mapNeighbors_cb<'a>) => array<edge> =
    "mapInboundNeighbors"
  @send
  external _mapInboundNeighbors_fromTo: (t, node, node, mapNeighbors_cb<'a>) => array<edge> =
    "mapInboundNeighbors"

  let mapInboundNeighbors = (t, mapNeighbors_args) => {
    _mapNeighbors_call(
      t,
      mapNeighbors_args,
      _mapInboundNeighbors,
      _mapInboundNeighbors_ofNode,
      _mapInboundNeighbors_fromTo,
    )
  }

  @send
  external _mapOutboundNeighbors: (t, mapNeighbors_cb<'a>) => array<edge> = "mapOutboundNeighbors"
  @send
  external _mapOutboundNeighbors_ofNode: (t, node, mapNeighbors_cb<'a>) => array<edge> =
    "mapOutboundNeighbors"
  @send
  external _mapOutboundNeighbors_fromTo: (t, node, node, mapNeighbors_cb<'a>) => array<edge> =
    "mapOutboundNeighbors"

  let mapOutboundNeighbors = (t, mapNeighbors_args) => {
    _mapNeighbors_call(
      t,
      mapNeighbors_args,
      _mapOutboundNeighbors,
      _mapOutboundNeighbors_ofNode,
      _mapOutboundNeighbors_fromTo,
    )
  }

  @send
  external _mapDirectedNeighbors: (t, mapNeighbors_cb<'a>) => array<edge> = "mapDirectedNeighbors"
  @send
  external _mapDirectedNeighbors_ofNode: (t, node, mapNeighbors_cb<'a>) => array<edge> =
    "mapDirectedNeighbors"
  @send
  external _mapDirectedNeighbors_fromTo: (t, node, node, mapNeighbors_cb<'a>) => array<edge> =
    "mapDirectedNeighbors"

  let mapDirectedNeighbors = (t, mapNeighbors_args) => {
    _mapNeighbors_call(
      t,
      mapNeighbors_args,
      _mapDirectedNeighbors,
      _mapDirectedNeighbors_ofNode,
      _mapDirectedNeighbors_fromTo,
    )
  }

  @send
  external _mapUndirectedNeighbors: (t, mapNeighbors_cb<'a>) => array<edge> =
    "mapUndirectedNeighbors"
  @send
  external _mapUndirectedNeighbors_ofNode: (t, node, mapNeighbors_cb<'a>) => array<edge> =
    "mapUndirectedNeighbors"
  @send
  external _mapUndirectedNeighbors_fromTo: (t, node, node, mapNeighbors_cb<'a>) => array<edge> =
    "mapUndirectedNeighbors"

  let mapUndirectedNeighbors = (t, mapNeighbors_args) => {
    _mapNeighbors_call(
      t,
      mapNeighbors_args,
      _mapUndirectedNeighbors,
      _mapUndirectedNeighbors_ofNode,
      _mapUndirectedNeighbors_fromTo,
    )
  }

  // #.filterNeighbors
  type filterNeighbors_cb<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => bool

  type filterNeighbors_args<'a> =
    | All(filterNeighbors_cb<'a>)
    | Node(node, filterNeighbors_cb<'a>)
    | FromTo(node, node, filterNeighbors_cb<'a>)

  let _filterNeighbors_call = (t, filterNeighbors_args, allFn, nodeFn, _fromToFn) => {
    switch filterNeighbors_args {
    | All(_cb) => allFn(t, _cb)
    | Node(node, _cb) => nodeFn(t, node, _cb)
    | FromTo(source, target, _cb) => _fromToFn(t, source, target, _cb)
    }
  }

  @send external _filterNeighbors: (t, filterNeighbors_cb<'a>) => array<edge> = "filterNeighbors"
  @send
  external _filterNeighbors_ofNode: (t, node, filterNeighbors_cb<'a>) => array<edge> =
    "filterNeighbors"
  @send
  external _filterNeighbors_fromTo: (t, node, node, filterNeighbors_cb<'a>) => array<edge> =
    "filterNeighbors"

  let filterNeighbors = (t, filterNeighbors_args) => {
    _filterNeighbors_call(
      t,
      filterNeighbors_args,
      _filterNeighbors,
      _filterNeighbors_ofNode,
      _filterNeighbors_fromTo,
    )
  }

  @send
  external _filterInNeighbors: (t, filterNeighbors_cb<'a>) => array<edge> = "filterInNeighbors"
  @send
  external _filterInNeighbors_ofNode: (t, node, filterNeighbors_cb<'a>) => array<edge> =
    "filterInNeighbors"
  @send
  external _filterInNeighbors_fromTo: (t, node, node, filterNeighbors_cb<'a>) => array<edge> =
    "filterInNeighbors"

  let filterInNeighbors = (t, filterNeighbors_args) => {
    _filterNeighbors_call(
      t,
      filterNeighbors_args,
      _filterInNeighbors,
      _filterInNeighbors_ofNode,
      _filterInNeighbors_fromTo,
    )
  }

  @send
  external _filterOutNeighbors: (t, filterNeighbors_cb<'a>) => array<edge> = "filterOutNeighbors"
  @send
  external _filterOutNeighbors_ofNode: (t, node, filterNeighbors_cb<'a>) => array<edge> =
    "filterOutNeighbors"
  @send
  external _filterOutNeighbors_fromTo: (t, node, node, filterNeighbors_cb<'a>) => array<edge> =
    "filterOutNeighbors"

  let filterOutNeighbors = (t, filterNeighbors_args) => {
    _filterNeighbors_call(
      t,
      filterNeighbors_args,
      _filterOutNeighbors,
      _filterOutNeighbors_ofNode,
      _filterOutNeighbors_fromTo,
    )
  }

  @send
  external _filterInboundNeighbors: (t, filterNeighbors_cb<'a>) => array<edge> =
    "filterInboundNeighbors"
  @send
  external _filterInboundNeighbors_ofNode: (t, node, filterNeighbors_cb<'a>) => array<edge> =
    "filterInboundNeighbors"
  @send
  external _filterInboundNeighbors_fromTo: (t, node, node, filterNeighbors_cb<'a>) => array<edge> =
    "filterInboundNeighbors"

  let filterInboundNeighbors = (t, filterNeighbors_args) => {
    _filterNeighbors_call(
      t,
      filterNeighbors_args,
      _filterInboundNeighbors,
      _filterInboundNeighbors_ofNode,
      _filterInboundNeighbors_fromTo,
    )
  }

  @send
  external _filterOutboundNeighbors: (t, filterNeighbors_cb<'a>) => array<edge> =
    "filterOutboundNeighbors"
  @send
  external _filterOutboundNeighbors_ofNode: (t, node, filterNeighbors_cb<'a>) => array<edge> =
    "filterOutboundNeighbors"
  @send
  external _filterOutboundNeighbors_fromTo: (t, node, node, filterNeighbors_cb<'a>) => array<edge> =
    "filterOutboundNeighbors"

  let filterOutboundNeighbors = (t, filterNeighbors_args) => {
    _filterNeighbors_call(
      t,
      filterNeighbors_args,
      _filterOutboundNeighbors,
      _filterOutboundNeighbors_ofNode,
      _filterOutboundNeighbors_fromTo,
    )
  }

  @send
  external _filterDirectedNeighbors: (t, filterNeighbors_cb<'a>) => array<edge> =
    "filterDirectedNeighbors"
  @send
  external _filterDirectedNeighbors_ofNode: (t, node, filterNeighbors_cb<'a>) => array<edge> =
    "filterDirectedNeighbors"
  @send
  external _filterDirectedNeighbors_fromTo: (t, node, node, filterNeighbors_cb<'a>) => array<edge> =
    "filterDirectedNeighbors"

  let filterDirectedNeighbors = (t, filterNeighbors_args) => {
    _filterNeighbors_call(
      t,
      filterNeighbors_args,
      _filterDirectedNeighbors,
      _filterDirectedNeighbors_ofNode,
      _filterDirectedNeighbors_fromTo,
    )
  }

  @send
  external _filterUndirectedNeighbors: (t, filterNeighbors_cb<'a>) => array<edge> =
    "filterUndirectedNeighbors"
  @send
  external _filterUndirectedNeighbors_ofNode: (t, node, filterNeighbors_cb<'a>) => array<edge> =
    "filterUndirectedNeighbors"
  @send
  external _filterUndirectedNeighbors_fromTo: (
    t,
    node,
    node,
    filterNeighbors_cb<'a>,
  ) => array<edge> = "filterUndirectedNeighbors"

  let filterUndirectedNeighbors = (t, filterNeighbors_args) => {
    _filterNeighbors_call(
      t,
      filterNeighbors_args,
      _filterUndirectedNeighbors,
      _filterUndirectedNeighbors_ofNode,
      _filterUndirectedNeighbors_fromTo,
    )
  }

  // #.reduceNeighbors
  type reduceNeighbors_cb<'a, 'r> = (
    'r,
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => 'r

  type reduceNeighbors_args<'a, 'r> =
    | All(reduceNeighbors_cb<'a, 'r>, 'r)
    | Node(node, reduceNeighbors_cb<'a, 'r>, 'r)
    | FromTo(node, node, reduceNeighbors_cb<'a, 'r>, 'r)

  let _reduceNeighbors_call = (t, reduceNeighbors_args, allFn, nodeFn, _fromToFn) => {
    switch reduceNeighbors_args {
    | All(_cb, init) => allFn(t, _cb, init)
    | Node(node, _cb, init) => nodeFn(t, node, _cb, init)
    | FromTo(source, target, _cb, init) => _fromToFn(t, source, target, _cb, init)
    }
  }

  @send external _reduceNeighbors: (t, reduceNeighbors_cb<'a, 'r>, 'r) => 'r = "reduceNeighbors"
  @send
  external _reduceNeighbors_ofNode: (t, node, reduceNeighbors_cb<'a, 'r>, 'r) => 'r =
    "reduceNeighbors"
  @send
  external _reduceNeighbors_fromTo: (t, node, node, reduceNeighbors_cb<'a, 'r>, 'r) => 'r =
    "reduceNeighbors"

  let reduceNeighbors = (t, reduceNeighbors_args) => {
    _reduceNeighbors_call(
      t,
      reduceNeighbors_args,
      _reduceNeighbors,
      _reduceNeighbors_ofNode,
      _reduceNeighbors_fromTo,
    )
  }

  @send external _reduceInNeighbors: (t, reduceNeighbors_cb<'a, 'r>, 'r) => 'r = "reduceInNeighbors"
  @send
  external _reduceInNeighbors_ofNode: (t, node, reduceNeighbors_cb<'a, 'r>, 'r) => 'r =
    "reduceInNeighbors"
  @send
  external _reduceInNeighbors_fromTo: (t, node, node, reduceNeighbors_cb<'a, 'r>, 'r) => 'r =
    "reduceInNeighbors"

  let reduceInNeighbors = (t, reduceNeighbors_args) => {
    _reduceNeighbors_call(
      t,
      reduceNeighbors_args,
      _reduceInNeighbors,
      _reduceInNeighbors_ofNode,
      _reduceInNeighbors_fromTo,
    )
  }

  @send
  external _reduceOutNeighbors: (t, reduceNeighbors_cb<'a, 'r>, 'r) => 'r = "reduceOutNeighbors"
  @send
  external _reduceOutNeighbors_ofNode: (t, node, reduceNeighbors_cb<'a, 'r>, 'r) => 'r =
    "reduceOutNeighbors"
  @send
  external _reduceOutNeighbors_fromTo: (t, node, node, reduceNeighbors_cb<'a, 'r>, 'r) => 'r =
    "reduceOutNeighbors"

  let reduceOutNeighbors = (t, reduceNeighbors_args) => {
    _reduceNeighbors_call(
      t,
      reduceNeighbors_args,
      _reduceOutNeighbors,
      _reduceOutNeighbors_ofNode,
      _reduceOutNeighbors_fromTo,
    )
  }

  @send
  external _reduceOutboundNeighbors: (t, reduceNeighbors_cb<'a, 'r>, 'r) => 'r =
    "reduceOutboundNeighbors"
  @send
  external _reduceOutboundNeighbors_ofNode: (t, node, reduceNeighbors_cb<'a, 'r>, 'r) => 'r =
    "reduceOutboundNeighbors"
  @send
  external _reduceOutboundNeighbors_fromTo: (t, node, node, reduceNeighbors_cb<'a, 'r>, 'r) => 'r =
    "reduceOutboundNeighbors"

  let reduceOutboundNeighbors = (t, reduceNeighbors_args) => {
    _reduceNeighbors_call(
      t,
      reduceNeighbors_args,
      _reduceOutboundNeighbors,
      _reduceOutboundNeighbors_ofNode,
      _reduceOutboundNeighbors_fromTo,
    )
  }

  @send
  external _reduceDirectedNeighbors: (t, reduceNeighbors_cb<'a, 'r>, 'r) => 'r =
    "reduceDirectedNeighbors"
  @send
  external _reduceDirectedNeighbors_ofNode: (t, node, reduceNeighbors_cb<'a, 'r>, 'r) => 'r =
    "reduceDirectedNeighbors"
  @send
  external _reduceDirectedNeighbors_fromTo: (t, node, node, reduceNeighbors_cb<'a, 'r>, 'r) => 'r =
    "reduceDirectedNeighbors"

  let reduceDirectedNeighbors = (t, reduceNeighbors_args) => {
    _reduceNeighbors_call(
      t,
      reduceNeighbors_args,
      _reduceDirectedNeighbors,
      _reduceDirectedNeighbors_ofNode,
      _reduceDirectedNeighbors_fromTo,
    )
  }

  @send
  external _reduceUndirectedNeighbors: (t, reduceNeighbors_cb<'a, 'r>, 'r) => 'r =
    "reduceUndirectedNeighbors"
  @send
  external _reduceUndirectedNeighbors_ofNode: (t, node, reduceNeighbors_cb<'a, 'r>, 'r) => 'r =
    "reduceUndirectedNeighbors"
  @send
  external _reduceUndirectedNeighbors_fromTo: (
    t,
    node,
    node,
    reduceNeighbors_cb<'a, 'r>,
    'r,
  ) => 'r = "reduceUndirectedNeighbors"

  let reduceUndirectedNeighbors = (t, reduceNeighbors_args) => {
    _reduceNeighbors_call(
      t,
      reduceNeighbors_args,
      _reduceUndirectedNeighbors,
      _reduceUndirectedNeighbors_ofNode,
      _reduceUndirectedNeighbors_fromTo,
    )
  }

  // #.findEdge
  type findNeighbor_cb<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => unit

  type findNeighbor_args<'a> =
    | All(findNeighbor_cb<'a>)
    | Node(node, findNeighbor_cb<'a>)
    | FromTo(node, node, findNeighbor_cb<'a>)

  let _findNeighbor_call = (t, findNeighbor_args, allFn, nodeFn, _fromToFn) => {
    switch findNeighbor_args {
    | All(_cb) => allFn(t, _cb)
    | Node(node, _cb) => nodeFn(t, node, _cb)
    | FromTo(source, target, _cb) => _fromToFn(t, source, target, _cb)
    }
  }

  @send external _findNeighbor: (t, findNeighbor_cb<'a>) => Nullable.t<edge> = "findNeighbors"
  @send
  external _findNeighbor_ofNode: (t, node, findNeighbor_cb<'a>) => Nullable.t<edge> =
    "findNeighbors"
  @send
  external _findNeighbor_fromTo: (t, node, node, findNeighbor_cb<'a>) => Nullable.t<edge> =
    "findNeighbors"

  let findNeighbor = (t, findNeighbor_args) => {
    _findNeighbor_call(
      t,
      findNeighbor_args,
      _findNeighbor,
      _findNeighbor_ofNode,
      _findNeighbor_fromTo,
    )
  }

  @send external _findInNeighbor: (t, findNeighbor_cb<'a>) => Nullable.t<edge> = "findInNeighbors"
  @send
  external _findInNeighbor_ofNode: (t, node, findNeighbor_cb<'a>) => Nullable.t<edge> =
    "findInNeighbors"
  @send
  external _findInNeighbor_fromTo: (t, node, node, findNeighbor_cb<'a>) => Nullable.t<edge> =
    "findInNeighbors"

  let findInNeighbor = (t, findNeighbor_args) => {
    _findNeighbor_call(
      t,
      findNeighbor_args,
      _findInNeighbor,
      _findInNeighbor_ofNode,
      _findInNeighbor_fromTo,
    )
  }

  @send external _findOutNeighbor: (t, findNeighbor_cb<'a>) => Nullable.t<edge> = "findOutNeighbors"
  @send
  external _findOutNeighbor_ofNode: (t, node, findNeighbor_cb<'a>) => Nullable.t<edge> =
    "findOutNeighbors"
  @send
  external _findOutNeighbor_fromTo: (t, node, node, findNeighbor_cb<'a>) => Nullable.t<edge> =
    "findOutNeighbors"

  let findOutNeighbor = (t, findNeighbor_args) => {
    _findNeighbor_call(
      t,
      findNeighbor_args,
      _findOutNeighbor,
      _findOutNeighbor_ofNode,
      _findOutNeighbor_fromTo,
    )
  }

  @send
  external _findInboundNeighbor: (t, findNeighbor_cb<'a>) => Nullable.t<edge> =
    "findInboundNeighbors"
  @send
  external _findInboundNeighbor_ofNode: (t, node, findNeighbor_cb<'a>) => Nullable.t<edge> =
    "findInboundNeighbors"
  @send
  external _findInboundNeighbor_fromTo: (t, node, node, findNeighbor_cb<'a>) => Nullable.t<edge> =
    "findInboundNeighbors"

  let findInboundNeighbor = (t, findNeighbor_args) => {
    _findNeighbor_call(
      t,
      findNeighbor_args,
      _findInboundNeighbor,
      _findInboundNeighbor_ofNode,
      _findInboundNeighbor_fromTo,
    )
  }

  @send
  external _findOutboundNeighbor: (t, findNeighbor_cb<'a>) => Nullable.t<edge> =
    "findOutboundNeighbors"
  @send
  external _findOutboundNeighbor_ofNode: (t, node, findNeighbor_cb<'a>) => Nullable.t<edge> =
    "findOutboundNeighbors"
  @send
  external _findOutboundNeighbor_fromTo: (t, node, node, findNeighbor_cb<'a>) => Nullable.t<edge> =
    "findOutboundNeighbors"

  let findOutboundNeighbor = (t, findNeighbor_args) => {
    _findNeighbor_call(
      t,
      findNeighbor_args,
      _findOutboundNeighbor,
      _findOutboundNeighbor_ofNode,
      _findOutboundNeighbor_fromTo,
    )
  }

  @send
  external _findDirectedNeighbor: (t, findNeighbor_cb<'a>) => Nullable.t<edge> =
    "findDirectedNeighbors"
  @send
  external _findDirectedNeighbor_ofNode: (t, node, findNeighbor_cb<'a>) => Nullable.t<edge> =
    "findDirectedNeighbors"
  @send
  external _findDirectedNeighbor_fromTo: (t, node, node, findNeighbor_cb<'a>) => Nullable.t<edge> =
    "findDirectedNeighbors"

  let findDirectedNeighbor = (t, findNeighbor_args) => {
    _findNeighbor_call(
      t,
      findNeighbor_args,
      _findDirectedNeighbor,
      _findDirectedNeighbor_ofNode,
      _findDirectedNeighbor_fromTo,
    )
  }

  @send
  external _findUndirectedNeighbor: (t, findNeighbor_cb<'a>) => Nullable.t<edge> =
    "findUndirectedNeighbors"
  @send
  external _findUndirectedNeighbor_ofNode: (t, node, findNeighbor_cb<'a>) => Nullable.t<edge> =
    "findUndirectedNeighbors"
  @send
  external _findUndirectedNeighbor_fromTo: (
    t,
    node,
    node,
    findNeighbor_cb<'a>,
  ) => Nullable.t<edge> = "findUndirectedNeighbors"

  let findUndirectedNeighbor = (t, findNeighbor_args) => {
    _findNeighbor_call(
      t,
      findNeighbor_args,
      _findUndirectedNeighbor,
      _findUndirectedNeighbor_ofNode,
      _findUndirectedNeighbor_fromTo,
    )
  }

  // #.someEdge
  type someNeighbor_cb<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => bool

  type someNeighbor_args<'a> =
    | All(someNeighbor_cb<'a>)
    | Node(node, someNeighbor_cb<'a>)
    | FromTo(node, node, someNeighbor_cb<'a>)

  let _someNeighbor_call = (t, someNeighbor_args, allFn, nodeFn, _fromToFn) => {
    switch someNeighbor_args {
    | All(_cb) => allFn(t, _cb)
    | Node(node, _cb) => nodeFn(t, node, _cb)
    | FromTo(source, target, _cb) => _fromToFn(t, source, target, _cb)
    }
  }

  @send external _someNeighbor: (t, someNeighbor_cb<'a>) => bool = "someNeighbor"
  @send
  external _someNeighbor_ofNode: (t, node, someNeighbor_cb<'a>) => bool = "someNeighbor"
  @send
  external _someNeighbor_fromTo: (t, node, node, someNeighbor_cb<'a>) => bool = "someNeighbor"

  let someNeighbor = (t, someNeighbor_args) => {
    _someNeighbor_call(
      t,
      someNeighbor_args,
      _someNeighbor,
      _someNeighbor_ofNode,
      _someNeighbor_fromTo,
    )
  }

  @send external _someInNeighbor: (t, someNeighbor_cb<'a>) => bool = "someInNeighbor"
  @send
  external _someInNeighbor_ofNode: (t, node, someNeighbor_cb<'a>) => bool = "someInNeighbor"
  @send
  external _someInNeighbor_fromTo: (t, node, node, someNeighbor_cb<'a>) => bool = "someInNeighbor"

  let someInNeighbor = (t, someNeighbor_args) => {
    _someNeighbor_call(
      t,
      someNeighbor_args,
      _someInNeighbor,
      _someInNeighbor_ofNode,
      _someInNeighbor_fromTo,
    )
  }

  @send external _someOutNeighbor: (t, someNeighbor_cb<'a>) => bool = "someOutNeighbor"
  @send
  external _someOutNeighbor_ofNode: (t, node, someNeighbor_cb<'a>) => bool = "someOutNeighbor"
  @send
  external _someOutNeighbor_fromTo: (t, node, node, someNeighbor_cb<'a>) => bool = "someOutNeighbor"

  let someOutNeighbor = (t, someNeighbor_args) => {
    _someNeighbor_call(
      t,
      someNeighbor_args,
      _someOutNeighbor,
      _someOutNeighbor_ofNode,
      _someOutNeighbor_fromTo,
    )
  }

  @send external _someInboundNeighbor: (t, someNeighbor_cb<'a>) => bool = "someInboundNeighbor"
  @send
  external _someInboundNeighbor_ofNode: (t, node, someNeighbor_cb<'a>) => bool =
    "someInboundNeighbor"
  @send
  external _someInboundNeighbor_fromTo: (t, node, node, someNeighbor_cb<'a>) => bool =
    "someInboundNeighbor"

  let someInboundNeighbor = (t, someNeighbor_args) => {
    _someNeighbor_call(
      t,
      someNeighbor_args,
      _someInboundNeighbor,
      _someInboundNeighbor_ofNode,
      _someInboundNeighbor_fromTo,
    )
  }

  @send external _someOutboundNeighbor: (t, someNeighbor_cb<'a>) => bool = "someOutboundNeighbor"
  @send
  external _someOutboundNeighbor_ofNode: (t, node, someNeighbor_cb<'a>) => bool =
    "someOutboundNeighbor"
  @send
  external _someOutboundNeighbor_fromTo: (t, node, node, someNeighbor_cb<'a>) => bool =
    "someOutboundNeighbor"

  let someOutboundNeighbor = (t, someNeighbor_args) => {
    _someNeighbor_call(
      t,
      someNeighbor_args,
      _someOutboundNeighbor,
      _someOutboundNeighbor_ofNode,
      _someOutboundNeighbor_fromTo,
    )
  }

  @send external _someDirectedNeighbor: (t, someNeighbor_cb<'a>) => bool = "someDirectedNeighbor"
  @send
  external _someDirectedNeighbor_ofNode: (t, node, someNeighbor_cb<'a>) => bool =
    "someDirectedNeighbor"
  @send
  external _someDirectedNeighbor_fromTo: (t, node, node, someNeighbor_cb<'a>) => bool =
    "someDirectedNeighbor"

  let someDirectedNeighbor = (t, someNeighbor_args) => {
    _someNeighbor_call(
      t,
      someNeighbor_args,
      _someDirectedNeighbor,
      _someDirectedNeighbor_ofNode,
      _someDirectedNeighbor_fromTo,
    )
  }

  @send
  external _someUndirectedNeighbor: (t, someNeighbor_cb<'a>) => bool = "someUndirectedNeighbor"
  @send
  external _someUndirectedNeighbor_ofNode: (t, node, someNeighbor_cb<'a>) => bool =
    "someUndirectedNeighbor"
  @send
  external _someUndirectedNeighbor_fromTo: (t, node, node, someNeighbor_cb<'a>) => bool =
    "someUndirectedNeighbor"

  let someUndirectedNeighbor = (t, someNeighbor_args) => {
    _someNeighbor_call(
      t,
      someNeighbor_args,
      _someUndirectedNeighbor,
      _someUndirectedNeighbor_ofNode,
      _someUndirectedNeighbor_fromTo,
    )
  }

  // #.everyEdge
  type everyNeighbor_cb<'a> = (
    edge,
    edgeAttr<'a>,
    node,
    node,
    nodeAttr<'a>,
    nodeAttr<'a>,
    bool,
  ) => bool

  type everyNeighbor_args<'a> =
    | All(everyNeighbor_cb<'a>)
    | Node(node, everyNeighbor_cb<'a>)
    | FromTo(node, node, everyNeighbor_cb<'a>)

  let _everyNeighbor_call = (t, everyNeighbor_args, allFn, nodeFn, _fromToFn) => {
    switch everyNeighbor_args {
    | All(_cb) => allFn(t, _cb)
    | Node(node, _cb) => nodeFn(t, node, _cb)
    | FromTo(source, target, _cb) => _fromToFn(t, source, target, _cb)
    }
  }

  @send external _everyNeighbor: (t, everyNeighbor_cb<'a>) => bool = "everyNeighbor"
  @send
  external _everyNeighbor_ofNode: (t, node, everyNeighbor_cb<'a>) => bool = "everyNeighbor"
  @send
  external _everyNeighbor_fromTo: (t, node, node, everyNeighbor_cb<'a>) => bool = "everyNeighbor"

  let everyNeighbor = (t, everyNeighbor_args) => {
    _everyNeighbor_call(
      t,
      everyNeighbor_args,
      _everyNeighbor,
      _everyNeighbor_ofNode,
      _everyNeighbor_fromTo,
    )
  }

  @send external _everyInNeighbor: (t, everyNeighbor_cb<'a>) => bool = "everyInNeighbor"
  @send
  external _everyInNeighbor_ofNode: (t, node, everyNeighbor_cb<'a>) => bool = "everyInNeighbor"
  @send
  external _everyInNeighbor_fromTo: (t, node, node, everyNeighbor_cb<'a>) => bool =
    "everyInNeighbor"

  let everyInNeighbor = (t, everyNeighbor_args) => {
    _everyNeighbor_call(
      t,
      everyNeighbor_args,
      _everyInNeighbor,
      _everyInNeighbor_ofNode,
      _everyInNeighbor_fromTo,
    )
  }

  @send external _everyOutNeighbor: (t, everyNeighbor_cb<'a>) => bool = "everyOutNeighbor"
  @send
  external _everyOutNeighbor_ofNode: (t, node, everyNeighbor_cb<'a>) => bool = "everyOutNeighbor"
  @send
  external _everyOutNeighbor_fromTo: (t, node, node, everyNeighbor_cb<'a>) => bool =
    "everyOutNeighbor"

  let everyOutNeighbor = (t, everyNeighbor_args) => {
    _everyNeighbor_call(
      t,
      everyNeighbor_args,
      _everyOutNeighbor,
      _everyOutNeighbor_ofNode,
      _everyOutNeighbor_fromTo,
    )
  }

  @send external _everyInboundNeighbor: (t, everyNeighbor_cb<'a>) => bool = "everyInboundNeighbor"
  @send
  external _everyInboundNeighbor_ofNode: (t, node, everyNeighbor_cb<'a>) => bool =
    "everyInboundNeighbor"
  @send
  external _everyInboundNeighbor_fromTo: (t, node, node, everyNeighbor_cb<'a>) => bool =
    "everyInboundNeighbor"

  let everyInboundNeighbor = (t, everyNeighbor_args) => {
    _everyNeighbor_call(
      t,
      everyNeighbor_args,
      _everyInboundNeighbor,
      _everyInboundNeighbor_ofNode,
      _everyInboundNeighbor_fromTo,
    )
  }

  @send external _everyOutboundNeighbor: (t, everyNeighbor_cb<'a>) => bool = "everyOutboundNeighbor"
  @send
  external _everyOutboundNeighbor_ofNode: (t, node, everyNeighbor_cb<'a>) => bool =
    "everyOutboundNeighbor"
  @send
  external _everyOutboundNeighbor_fromTo: (t, node, node, everyNeighbor_cb<'a>) => bool =
    "everyOutboundNeighbor"

  let everyOutboundNeighbor = (t, everyNeighbor_args) => {
    _everyNeighbor_call(
      t,
      everyNeighbor_args,
      _everyOutboundNeighbor,
      _everyOutboundNeighbor_ofNode,
      _everyOutboundNeighbor_fromTo,
    )
  }

  @send external _everyDirectedNeighbor: (t, everyNeighbor_cb<'a>) => bool = "everyDirectedNeighbor"
  @send
  external _everyDirectedNeighbor_ofNode: (t, node, everyNeighbor_cb<'a>) => bool =
    "everyDirectedNeighbor"
  @send
  external _everyDirectedNeighbor_fromTo: (t, node, node, everyNeighbor_cb<'a>) => bool =
    "everyDirectedNeighbor"

  let everyDirectedNeighbor = (t, everyNeighbor_args) => {
    _everyNeighbor_call(
      t,
      everyNeighbor_args,
      _everyDirectedNeighbor,
      _everyDirectedNeighbor_ofNode,
      _everyDirectedNeighbor_fromTo,
    )
  }

  @send
  external _everyUndirectedNeighbor: (t, everyNeighbor_cb<'a>) => bool = "everyUndirectedNeighbor"
  @send
  external _everyUndirectedNeighbor_ofNode: (t, node, everyNeighbor_cb<'a>) => bool =
    "everyUndirectedNeighbor"
  @send
  external _everyUndirectedNeighbor_fromTo: (t, node, node, everyNeighbor_cb<'a>) => bool =
    "everyUndirectedNeighbor"

  let everyUndirectedNeighbor = (t, everyNeighbor_args) => {
    _everyNeighbor_call(
      t,
      everyNeighbor_args,
      _everyUndirectedNeighbor,
      _everyUndirectedNeighbor_ofNode,
      _everyUndirectedNeighbor_fromTo,
    )
  }

  //#.edgeEntries
  type neighborIterValue<'a> = {
    edge: edge,
    attributes: edgeAttr<'a>,
    source: node,
    target: node,
    sourceAttributes: nodeAttr<'a>,
    targetAttributes: nodeAttr<'a>,
  }

  type neighborEntries_args<'a> =
    | All
    | Node(node)
    | FromTo(node, node)

  let _neighborEntries_call = (t, neighborEntries_args, allFn, nodeFn, _fromToFn) => {
    switch neighborEntries_args {
    | All => allFn(t)
    | Node(node) => nodeFn(t, node)
    | FromTo(source, target) => _fromToFn(t, source, target)
    }
  }

  @send
  external _neighborEntries: t => RescriptCore.Iterator.t<neighborIterValue<'a>> = "neighborEntries"
  @send
  external _neighborEntries_ofNode: (t, node) => RescriptCore.Iterator.t<neighborIterValue<'a>> =
    "neighborEntries"
  @send
  external _neighborEntries_fromTo: (
    t,
    node,
    node,
  ) => RescriptCore.Iterator.t<neighborIterValue<'a>> = "neighborEntries"

  let neighborEntries = (t, neighborEntries_args) => {
    _neighborEntries_call(
      t,
      neighborEntries_args,
      _neighborEntries,
      _neighborEntries_ofNode,
      _neighborEntries_fromTo,
    )
  }

  @send
  external _inNeighborEntries: t => RescriptCore.Iterator.t<neighborIterValue<'a>> =
    "inNeighborEntries"
  @send
  external _inNeighborEntries_ofNode: (t, node) => RescriptCore.Iterator.t<neighborIterValue<'a>> =
    "inNeighborEntries"
  @send
  external _inNeighborEntries_fromTo: (
    t,
    node,
    node,
  ) => RescriptCore.Iterator.t<neighborIterValue<'a>> = "inNeighborEntries"

  let inNeighborEntries = (t, neighborEntries_args) => {
    _neighborEntries_call(
      t,
      neighborEntries_args,
      _inNeighborEntries,
      _inNeighborEntries_ofNode,
      _inNeighborEntries_fromTo,
    )
  }

  @send
  external _outNeighborEntries: t => RescriptCore.Iterator.t<neighborIterValue<'a>> =
    "outNeighborEntries"
  @send
  external _outNeighborEntries_ofNode: (t, node) => RescriptCore.Iterator.t<neighborIterValue<'a>> =
    "outNeighborEntries"
  @send
  external _outNeighborEntries_fromTo: (
    t,
    node,
    node,
  ) => RescriptCore.Iterator.t<neighborIterValue<'a>> = "outNeighborEntries"

  let outNeighborEntries = (t, neighborEntries_args) => {
    _neighborEntries_call(
      t,
      neighborEntries_args,
      _outNeighborEntries,
      _outNeighborEntries_ofNode,
      _outNeighborEntries_fromTo,
    )
  }

  @send
  external _inboundNeighborEntries: t => RescriptCore.Iterator.t<neighborIterValue<'a>> =
    "inboundNeighborEntries"
  @send
  external _inboundNeighborEntries_ofNode: (
    t,
    node,
  ) => RescriptCore.Iterator.t<neighborIterValue<'a>> = "inboundNeighborEntries"
  @send
  external _inboundNeighborEntries_fromTo: (
    t,
    node,
    node,
  ) => RescriptCore.Iterator.t<neighborIterValue<'a>> = "inboundNeighborEntries"

  let inboundNeighborEntries = (t, neighborEntries_args) => {
    _neighborEntries_call(
      t,
      neighborEntries_args,
      _inboundNeighborEntries,
      _inboundNeighborEntries_ofNode,
      _inboundNeighborEntries_fromTo,
    )
  }

  @send
  external _outboundNeighborEntries: t => RescriptCore.Iterator.t<neighborIterValue<'a>> =
    "outboundNeighborEntries"
  @send
  external _outboundNeighborEntries_ofNode: (
    t,
    node,
  ) => RescriptCore.Iterator.t<neighborIterValue<'a>> = "outboundNeighborEntries"
  @send
  external _outboundNeighborEntries_fromTo: (
    t,
    node,
    node,
  ) => RescriptCore.Iterator.t<neighborIterValue<'a>> = "outboundNeighborEntries"

  let outboundNeighborEntries = (t, neighborEntries_args) => {
    _neighborEntries_call(
      t,
      neighborEntries_args,
      _outboundNeighborEntries,
      _outboundNeighborEntries_ofNode,
      _outboundNeighborEntries_fromTo,
    )
  }

  @send
  external _directedNeighborEntries: t => RescriptCore.Iterator.t<neighborIterValue<'a>> =
    "directedNeighborEntries"
  @send
  external _directedNeighborEntries_ofNode: (
    t,
    node,
  ) => RescriptCore.Iterator.t<neighborIterValue<'a>> = "directedNeighborEntries"
  @send
  external _directedNeighborEntries_fromTo: (
    t,
    node,
    node,
  ) => RescriptCore.Iterator.t<neighborIterValue<'a>> = "directedNeighborEntries"

  let directedNeighborEntries = (t, neighborEntries_args) => {
    _neighborEntries_call(
      t,
      neighborEntries_args,
      _directedNeighborEntries,
      _directedNeighborEntries_ofNode,
      _directedNeighborEntries_fromTo,
    )
  }

  @send
  external _undirectedNeighborEntries: t => RescriptCore.Iterator.t<neighborIterValue<'a>> =
    "undirectedNeighborEntries"
  @send
  external _undirectedNeighborEntries_ofNode: (
    t,
    node,
  ) => RescriptCore.Iterator.t<neighborIterValue<'a>> = "undirectedNeighborEntries"
  @send
  external _undirectedNeighborEntries_fromTo: (
    t,
    node,
    node,
  ) => RescriptCore.Iterator.t<neighborIterValue<'a>> = "undirectedNeighborEntries"

  let undirectedNeighborEntries = (t, neighborEntries_args) => {
    _neighborEntries_call(
      t,
      neighborEntries_args,
      _undirectedNeighborEntries,
      _undirectedNeighborEntries_ofNode,
      _undirectedNeighborEntries_fromTo,
    )
  }
}
