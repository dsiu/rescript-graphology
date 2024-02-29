module type GRAPH_TYPES = Graphology__GraphTypes.T

module type SVG = {
  include GRAPH_TYPES

  type nodeEdgeSettings = {color?: string}
  type settings = {
    margin?: int,
    width?: int,
    height?: int,
    nodes?: nodeEdgeSettings,
    edges?: nodeEdgeSettings,
  }

  let render: (t, string, ~settings: settings=?, unit => unit) => unit
}

// functor type
module type SVG_F = (C: GRAPH_TYPES) =>
(
  SVG
    with type t = C.t
    and type node = C.node
    and type edge = C.edge
    and type nodeAttr<'a> = C.nodeAttr<'a>
    and type edgeAttr<'a> = C.edgeAttr<'a>
)

module MakeSVG: SVG_F = (C: GRAPH_TYPES) => {
  type t = C.t
  type node = C.node
  type edge = C.edge
  type nodeAttr<'a> = C.nodeAttr<'a>
  type edgeAttr<'a> = C.edgeAttr<'a>

  type nodeEdgeSettings = {color?: string}
  type settings = {
    margin?: int,
    width?: int,
    height?: int,
    nodes?: nodeEdgeSettings,
    edges?: nodeEdgeSettings,
  }

  @module("graphology-svg")
  external render: (t, string, ~settings: settings=?, unit => unit) => unit = "default"
}
