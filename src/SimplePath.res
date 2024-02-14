module type GRAPH_TYPES = GraphTypes.T

module type SIMPLEPATH = {
  include GRAPH_TYPES

  type opts
  let allSimplePaths: (t, node, node, ~opts: opts=?, unit) => array<array<node>>
  let allSimpleEdgePaths: (t, node, node, ~opts: opts=?, unit) => array<array<edge>>
  let allSimpleEdgeGroupPaths: (t, node, node, ~opts: opts=?, unit) => array<array<array<node>>>
}

// functor type
module type SIMPLEPATH_F = (C: GRAPH_TYPES) =>
(
  SIMPLEPATH
    with type t = C.t
    and type node = C.node
    and type edge = C.edge
    and type nodeAttr<'a> = C.nodeAttr<'a>
    and type edgeAttr<'a> = C.edgeAttr<'a>
)

module MakeSimplePath: SIMPLEPATH_F = (C: GRAPH_TYPES) => {
  type t = C.t
  type node = C.node
  type edge = C.edge
  type nodeAttr<'a> = C.nodeAttr<'a>
  type edgeAttr<'a> = C.edgeAttr<'a>

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
