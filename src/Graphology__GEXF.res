module type GRAPH_TYPES = Graphology__GraphTypes.T

module type GEXF = {
  include GRAPH_TYPES

  type nodeFormat<'a> = {..} as 'a
  type edgeFormat<'a> = {..} as 'a
  type formatNodeFn<'a, 'f> = (node, nodeAttr<'a>) => nodeFormat<'f>
  type formatEdgeFn<'a, 'f> = (edge, edgeAttr<'a>) => edgeFormat<'f>

  type options<'a, 'n, 'e> = {
    encoding?: string, // "UTF-8"
    formatNode?: formatNodeFn<'a, 'n>, // function returning the node’s data to write.
    formatEdge?: formatNodeFn<'a, 'e>, // function returning the edge’s data to write.
    pretty?: bool, // [default: true]  pretty-print output?
    pedantic?: bool, // [default: false] whether to output a stricter gexf file
    version?: string, // [default: "1.2"] gexf version to emit. Should be one of 1.2 or 1.3.
  }

  let write: (t, ~options: options<'a, 'n, 'e>=?) => string
}

// functor type
module type GEXF_F = (C: GRAPH_TYPES) =>
(
  GEXF
    with type t = C.t
    and type node = C.node
    and type edge = C.edge
    and type graphAttr<'a> = C.graphAttr<'a>
    and type nodeAttr<'a> = C.nodeAttr<'a>
    and type edgeAttr<'a> = C.edgeAttr<'a>
)

module MakeGEXF: GEXF_F = (C: GRAPH_TYPES) => {
  type t = C.t
  type node = C.node
  type edge = C.edge
  type graphAttr<'a> = C.graphAttr<'a>
  type nodeAttr<'a> = C.nodeAttr<'a>
  type edgeAttr<'a> = C.edgeAttr<'a>

  type nodeFormat<'a> = {..} as 'a
  type edgeFormat<'a> = {..} as 'a
  type formatNodeFn<'a, 'f> = (node, nodeAttr<'a>) => nodeFormat<'f>
  type formatEdgeFn<'a, 'f> = (edge, edgeAttr<'a>) => edgeFormat<'f>

  type options<'a, 'n, 'e> = {
    encoding?: string, // "UTF-8"
    formatNode?: formatNodeFn<'a, 'n>, // function returning the node’s data to write.
    formatEdge?: formatNodeFn<'a, 'e>, // function returning the edge’s data to write.
    pretty?: bool, // [default: true]  pretty-print output?
    pedantic?: bool, // [default: false] whether to output a stricter gexf file
    version?: string, // [default: "1.2"] gexf version to emit. Should be one of 1.2 or 1.3.
  }

  @module("graphology-gexf")
  external write: (t, ~options: options<'a, 'n, 'e>=?) => string = "write"
}
