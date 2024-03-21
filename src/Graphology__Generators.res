module type GRAPH_TYPES = Graphology__GraphTypes.T

module type GENERATORS = {
  include GRAPH_TYPES
}

// functor type
module type GENERATORS_F = (C: GRAPH_TYPES) =>
(
  GENERATORS
    with type t = C.t
    and type node = C.node
    and type edge = C.edge
    and type graphAttr<'a> = C.graphAttr<'a>
    and type nodeAttr<'a> = C.nodeAttr<'a>
    and type edgeAttr<'a> = C.edgeAttr<'a>
)

module MakeGenerators: GENERATORS_F = (C: GRAPH_TYPES) => {
  type t = C.t
  type node = C.node
  type edge = C.edge
  type graphAttr<'a> = C.graphAttr<'a>
  type nodeAttr<'a> = C.nodeAttr<'a>
  type edgeAttr<'a> = C.edgeAttr<'a>
}
