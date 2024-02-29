module type GRAPH_TYPES = Graphology__GraphTypes.T

module type TRAVERSAL = {
  include GRAPH_TYPES

  let bfs: (t, (node, nodeAttr<'a>, int) => unit) => unit
  let bfsFromNode: (t, node, (node, nodeAttr<'a>, int) => unit) => unit
  let dfs: (t, (node, nodeAttr<'a>, int) => unit) => unit
  let dfsFromNode: (t, node, (node, nodeAttr<'a>, int) => unit) => unit
}

// functor type
module type TRAVERSAL_F = (C: GRAPH_TYPES) =>
(
  TRAVERSAL
    with type t = C.t
    and type node = C.node
    and type edge = C.edge
    and type nodeAttr<'a> = C.nodeAttr<'a>
    and type edgeAttr<'a> = C.edgeAttr<'a>
)

module MakeTraversal: TRAVERSAL_F = (C: GRAPH_TYPES) => {
  type t = C.t
  type node = C.node
  type edge = C.edge
  type nodeAttr<'a> = C.nodeAttr<'a>
  type edgeAttr<'a> = C.edgeAttr<'a>

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
