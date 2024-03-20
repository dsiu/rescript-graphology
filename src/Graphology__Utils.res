module type GRAPH_TYPES = Graphology__GraphTypes.T

module type UTILS = {
  include GRAPH_TYPES

  // Assertions
  let isGraph: t => bool
  // isGraphConstructor probably not needed
  // let isGraphConstructor: t => bool

  // Introspection
  let inferMulti: t => bool
  let inferType: t => string

  // Typical edge patterns
  let mergeClique: (t, array<node>) => unit
  let mergeCycle: (t, array<node>) => unit
  let mergePath: (t, array<node>) => unit
  let mergeStar: (t, array<node>) => unit

  //  Miscellaneous helpers
  type nodeKeyMapping<'a> = RescriptCore.Dict.t<'a>
  type edgeKeyMapping<'a> = RescriptCore.Dict.t<'a>
  let renameGraphKeys: (t, nodeKeyMapping<'a>, edgeKeyMapping<'b>) => t

  type nodeKeyUpdater<'a, 'b> = (node, nodeAttr<'a>) => 'b
  type edgeKeyUpdater<'a, 'b> = (edge, edgeAttr<'a>) => 'b
  let updateGraphKeys: (t, nodeKeyUpdater<'a, 'b>, edgeKeyUpdater<'c, 'd>) => t
}

// functor type
module type UTILS_F = (C: GRAPH_TYPES) =>
(
  UTILS
    with type t = C.t
    and type node = C.node
    and type edge = C.edge
    and type graphAttr<'a> = C.graphAttr<'a>
    and type nodeAttr<'a> = C.nodeAttr<'a>
    and type edgeAttr<'a> = C.edgeAttr<'a>
)

module MakeUtils: UTILS_F = (C: GRAPH_TYPES) => {
  type t = C.t
  type node = C.node
  type edge = C.edge
  type graphAttr<'a> = C.graphAttr<'a>
  type nodeAttr<'a> = C.nodeAttr<'a>
  type edgeAttr<'a> = C.edgeAttr<'a>

  // Assertions
  @module("graphology-utils")
  external isGraph: t => bool = "isGraph"
  //  external isGraphConstructor: t => bool = "isGraphConstructor"

  // Introspection
  @module("graphology-utils")
  external inferMulti: t => bool = "inferMulti"

  @module("graphology-utils")
  external inferType: t => string = "inferType"

  // Typical edge patterns
  @module("graphology-utils")
  external mergeClique: (t, array<node>) => unit = "mergeClique"

  @module("graphology-utils")
  external mergeCycle: (t, array<node>) => unit = "mergeCycle"

  @module("graphology-utils")
  external mergePath: (t, array<node>) => unit = "mergePath"

  @module("graphology-utils")
  external mergeStar: (t, array<node>) => unit = "mergeStar"

  //  Miscellaneous helpers
  type nodeKeyMapping<'a> = RescriptCore.Dict.t<'a>
  type edgeKeyMapping<'a> = RescriptCore.Dict.t<'a>

  @module("graphology-utils")
  external renameGraphKeys: (t, nodeKeyMapping<'a>, edgeKeyMapping<'b>) => t = "renameGraphKeys"

  type nodeKeyUpdater<'a, 'b> = (node, nodeAttr<'a>) => 'b
  type edgeKeyUpdater<'a, 'b> = (edge, edgeAttr<'a>) => 'b
  @module("graphology-utils")
  external updateGraphKeys: (t, nodeKeyUpdater<'a, 'b>, edgeKeyUpdater<'c, 'd>) => t =
    "updateGraphKeys"
}
