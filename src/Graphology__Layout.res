module type GRAPH_TYPES = Graphology__GraphTypes.T

module type LAYOUT = {
  include GRAPH_TYPES

  type coord = {x: float, y: float}

  type positions = RescriptCore.Dict.t<coord>

  module Circular: {
    type options = {
      dimensions?: array<string>, // attribute names of x and y
      center?: float,
      scale?: float,
    }

    let circular: (t, ~options: options=?) => positions
    let assign: (t, ~options: options=?) => unit
  }

  module Random: {
    type options = {
      dimensions?: array<string>,
      rng?: unit => float,
      center?: float,
      scale?: float,
    }

    let random: (t, ~options: options=?) => positions
    let assign: (t, ~options: options=?) => unit
  }

  module CirclePack: {
    type options = {
      attributes?: {"x": string, "y": string},
      center?: float,
      hierarchyAttributes?: array<string>,
      rng?: unit => float,
      scale?: float,
    }

    let circlePack: (t, ~options: options=?) => positions
    let assign: (t, ~options: options=?) => unit
  }

  module Rotation: {
    type options = {
      dimensions?: array<string>,
      degrees?: bool,
      centeredOnZero?: bool,
    }
    let rotation: (t, float, ~options: options=?) => positions
    let assign: (t, float, ~options: options=?) => unit
  }

  module Utils: {
    type options = {
      dimensions?: array<string>,
      exhaustive?: bool,
    }
    let collectLayout: (t, ~options: options=?) => RescriptCore.Dict.t<coord>

    type dimOption = {dimensions?: array<string>}
    let collectLayoutAsFlatArray: (t, ~options: dimOption=?) => array<coord>

    type layout = RescriptCore.Dict.t<coord>
    let assignLayout: (t, layout, ~options: dimOption=?) => unit
    let assignLayoutAsFlatArray: (t, layout, ~options: dimOption=?) => array<coord>
  }
}

// functor type
module type LAYOUT_F = (C: GRAPH_TYPES) =>
(
  LAYOUT
    with type t = C.t
    and type node = C.node
    and type edge = C.edge
    and type graphAttr<'a> = C.graphAttr<'a>
    and type nodeAttr<'a> = C.nodeAttr<'a>
    and type edgeAttr<'a> = C.edgeAttr<'a>
)

module MakeLayout: LAYOUT_F = (C: GRAPH_TYPES) => {
  type t = C.t
  type node = C.node
  type edge = C.edge
  type graphAttr<'a> = C.graphAttr<'a>
  type nodeAttr<'a> = C.nodeAttr<'a>
  type edgeAttr<'a> = C.edgeAttr<'a>

  type coord = {x: float, y: float}
  type positions = RescriptCore.Dict.t<coord>

  module Circular = {
    type options = {
      dimensions?: array<string>,
      center?: float,
      scale?: float,
    }

    @module("graphology-layout")
    external circular: (t, ~options: options=?) => positions = "circular"

    @module("graphology-layout") @scope("circular")
    external assign: (t, ~options: options=?) => unit = "assign"
  }

  module Random = {
    type options = {
      dimensions?: array<string>,
      rng?: unit => float,
      center?: float,
      scale?: float,
    }

    @module("graphology-layout")
    external random: (t, ~options: options=?) => positions = "random"

    @module("graphology-layout") @scope("random")
    external assign: (t, ~options: options=?) => unit = "assign"
  }

  module CirclePack = {
    type options = {
      attributes?: {"x": string, "y": string},
      center?: float,
      hierarchyAttributes?: array<string>,
      rng?: unit => float,
      scale?: float,
    }

    @module("graphology-layout")
    external circlePack: (t, ~options: options=?) => positions = "circlepack"

    @module("graphology-layout") @scope("circlepack")
    external assign: (t, ~options: options=?) => unit = "assign"
  }

  module Rotation = {
    type options = {
      dimensions?: array<string>,
      degrees?: bool,
      centeredOnZero?: bool,
    }
    @module("graphology-layout")
    external rotation: (t, float, ~options: options=?) => positions = "rotation"

    @module("graphology-layout") @scope("rotation")
    external assign: (t, float, ~options: options=?) => unit = "assign"
  }

  module Utils = {
    type options = {
      dimensions?: array<string>,
      exhaustive?: bool,
    }

    @module("graphology-layout/utils.js")
    external collectLayout: (t, ~options: options=?) => RescriptCore.Dict.t<coord> = "collectLayout"

    type dimOption = {dimensions?: array<string>}

    @module("graphology-layout/utils.js")
    external collectLayoutAsFlatArray: (t, ~options: dimOption=?) => array<coord> =
      "collectLayoutAsFlatArray"

    type layout = RescriptCore.Dict.t<coord>

    @module("graphology-layout/utils.js")
    external assignLayout: (t, layout, ~options: dimOption=?) => unit = "assignLayout"

    @module("graphology-layout/utils.js")
    external assignLayoutAsFlatArray: (t, layout, ~options: dimOption=?) => array<coord> =
      "assignLayoutAsFlatArray"
  }
}
