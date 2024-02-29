module type GRAPH_TYPES = Graphology__GraphTypes.T

module type LAYOUT = {
  include GRAPH_TYPES

  type coord = {x: float, y: float}

  type positions = RescriptCore.Dict.t<coord>
  type options = {
    dimensions?: array<float>,
    center?: float,
    scale?: float,
  }

  let circular: (t, ~options: options=?) => positions
  module Circular: {
    let assign: (t, ~options: options=?) => unit
  }
}

// functor type
module type LAYOUT_F = (C: GRAPH_TYPES) =>
(
  LAYOUT
    with type t = C.t
    and type node = C.node
    and type edge = C.edge
    and type nodeAttr<'a> = C.nodeAttr<'a>
    and type edgeAttr<'a> = C.edgeAttr<'a>
)

module MakeLayout: LAYOUT_F = (C: GRAPH_TYPES) => {
  type t = C.t
  type node = C.node
  type edge = C.edge
  type nodeAttr<'a> = C.nodeAttr<'a>
  type edgeAttr<'a> = C.edgeAttr<'a>

  type coord = {x: float, y: float}
  type positions = RescriptCore.Dict.t<coord>
  type options = {
    dimensions?: array<float>,
    center?: float,
    scale?: float,
  }

  @module("graphology-layout")
  external circular: (t, ~options: options=?) => positions = "circular"

  module Circular = {
    @module("graphology-layout") @scope("circular")
    external assign: (t, ~options: options=?) => unit = "assign"
  }
}
