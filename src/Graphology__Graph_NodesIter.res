module type GRAPH_TYPES = Graphology__GraphTypes.T

module type NODES_ITER = {
  include GRAPH_TYPES

  let nodes: t => array<node>
  let forEachNode: (t, (node, nodeAttr<'a>) => unit) => unit
  let mapNodes: (t, (node, nodeAttr<'a>) => 'b) => array<'b>
  let filterNodes: (t, (node, nodeAttr<'a>) => bool) => array<node>
  let reduceNodes: (t, ('r, node, nodeAttr<'a>) => 'r, 'r) => 'r
  let findNode: (t, (node, nodeAttr<'a>) => bool) => Nullable.t<node>
  let someNode: (t, (node, nodeAttr<'a>) => bool) => bool
  let everyNode: (t, (node, nodeAttr<'a>) => bool) => bool

  type nodeIterValue<'a> = {node: node, attributes: nodeAttr<'a>}
  let nodeEntries: t => Iterator.t<nodeIterValue<'a>>
}

// functor type
module type NODES_ITER_F = (C: GRAPH_TYPES) =>
(
  NODES_ITER
    with type t = C.t
    and type node = C.node
    and type edge = C.edge
    and type graphAttr<'a> = C.graphAttr<'a>
    and type nodeAttr<'a> = C.nodeAttr<'a>
    and type edgeAttr<'a> = C.edgeAttr<'a>
)

module MakeNodesIter: NODES_ITER_F = (C: GRAPH_TYPES) => {
  type t = C.t
  type node = C.node
  type edge = C.edge
  type graphAttr<'a> = C.graphAttr<'a>
  type nodeAttr<'a> = C.nodeAttr<'a>
  type edgeAttr<'a> = C.edgeAttr<'a>


  @send external nodes: t => array<node> = "nodes"
  @send external forEachNode: (t, (node, nodeAttr<'a>) => unit) => unit = "forEachNode"
  @send external mapNodes: (t, (node, nodeAttr<'a>) => 'b) => array<'b> = "mapNodes"
  @send external filterNodes: (t, (node, nodeAttr<'a>) => bool) => array<node> = "filterNodes"
  @send external reduceNodes: (t, ('r, node, nodeAttr<'a>) => 'r, 'r) => 'r = "reduceNodes"
  @send external findNode: (t, (node, nodeAttr<'a>) => bool) => Nullable.t<node> = "findNode"
  @send external someNode: (t, (node, nodeAttr<'a>) => bool) => bool = "someNode"
  @send external everyNode: (t, (node, nodeAttr<'a>) => bool) => bool = "everyNode"

  type nodeIterValue<'a> = {node: C.node, attributes: C.nodeAttr<'a>}
  @send external nodeEntries: t => Iterator.t<nodeIterValue<'a>> = "nodeEntries"
}
