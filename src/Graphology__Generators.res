@@uncurried

module type GRAPH_TYPES = Graphology__GraphTypes.T

module type GENERATORS = {
  include GRAPH_TYPES

  type graphType =
    | Graph
    | DirectedGraph
    | UndirectedGraph
    | MultiGraph
    | MultiDirectedGraph
    | MultiUndirectedGraph

  // Classic Graphs
  let complete: (graphType, int) => t
  let empty: (graphType, int) => t
  let ladder: (graphType, int) => t
  let path: (graphType, int) => t

  // Community Graphs
  let caveman: (graphType, int, int) => t
  let connectedCaveman: (graphType, int, int) => t

  // Random Graphs
  //
  // Clusters
  type clustersOpts = {
    order: int,
    size: int,
    clusters: int,
    clusterDensity?: float,
    rng?: unit => float,
  }
  let clusters: (graphType, clustersOpts) => t

  // Erdos-Renyi
  type erdosRenyiOpts = {
    order: int,
    probability: float,
    approximateSize: int,
    rng?: unit => float,
  }
  let erdosRenyi: (graphType, erdosRenyiOpts) => t

  // Girvan-Newman
  type girvanNewmanOpts = {
    zOut: int,
    rng?: unit => float,
  }
  let girvanNewman: (graphType, girvanNewmanOpts) => t

  // Small Graphs
  //
  // Krackhardt Kite
  let krackhardtKite: graphType => t

  // Social Graphs
  //
  // Florentine Families
  let florentineFamilies: graphType => t

  // Karate Club
  let karateClub: graphType => t
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

  type graphCtor = unit => t

  type graphType =
    | Graph
    | DirectedGraph
    | UndirectedGraph
    | MultiGraph
    | MultiDirectedGraph
    | MultiUndirectedGraph

  // Graph Constructors
  @module("graphology") @scope("default") @val
  external makeGraph: graphCtor = "Graph"

  @module("graphology") @scope("default") @val
  external makeDirectedGraph: graphCtor = "DirectedGraph"

  @module("graphology") @scope("default") @val
  external makeUndirectedGraph: graphCtor = "UndirectedGraph"

  @module("graphology") @scope("default") @val
  external makeMultiGraph: graphCtor = "MultiGraph"

  @module("graphology") @scope("default") @val
  external makeMultiDirectedGraph: graphCtor = "MultiDirectedGraph"

  @module("graphology") @scope("default") @val
  external makeMultiUndirectedGraph: graphCtor = "MultiUndirectedGraph"

  // internal helper to select the correct graph constructor
  let classicGraphGenHelper = (fn, graphType, int) => {
    switch graphType {
    | Graph => fn(makeGraph, int)
    | DirectedGraph => fn(makeDirectedGraph, int)
    | UndirectedGraph => fn(makeUndirectedGraph, int)
    | MultiGraph => fn(makeMultiGraph, int)
    | MultiDirectedGraph => fn(makeMultiDirectedGraph, int)
    | MultiUndirectedGraph => fn(makeMultiUndirectedGraph, int)
    }
  }

  // Classic Graphs
  @module("graphology-generators") @scope("classic")
  external _complete: (graphCtor, int) => t = "complete"
  let complete = (graphType, order) => classicGraphGenHelper(_complete, graphType, order)

  @module("graphology-generators") @scope("classic")
  external _empty: (graphCtor, int) => t = "empty"
  let empty = (graphType, order) => classicGraphGenHelper(_empty, graphType, order)

  @module("graphology-generators") @scope("classic")
  external _ladder: (graphCtor, int) => t = "ladder"
  let ladder = (graphType, length) => classicGraphGenHelper(_ladder, graphType, length)

  @module("graphology-generators") @scope("classic")
  external _path: (graphCtor, int) => t = "path"
  let path = (graphType, order) => classicGraphGenHelper(_path, graphType, order)

  // Community Graphs
  let cavemanGraphGenHelper = (fn, graphType, l, k) => {
    switch graphType {
    | Graph => fn(makeGraph, l, k)
    | DirectedGraph => fn(makeDirectedGraph, l, k)
    | UndirectedGraph => fn(makeUndirectedGraph, l, k)
    | MultiGraph => fn(makeMultiGraph, l, k)
    | MultiDirectedGraph => fn(makeMultiDirectedGraph, l, k)
    | MultiUndirectedGraph => fn(makeMultiUndirectedGraph, l, k)
    }
  }

  @module("graphology-generators") @scope("community")
  external _caveman: (graphCtor, int, int) => t = "caveman"
  let caveman = (graphType, l, k) => cavemanGraphGenHelper(_caveman, graphType, l, k)

  @module("graphology-generators") @scope("community")
  external _connectedCaveman: (graphCtor, int, int) => t = "connectedCaveman"
  let connectedCaveman = (graphType, l, k) =>
    cavemanGraphGenHelper(_connectedCaveman, graphType, l, k)

  // Random Graphs
  let graphGenWithOptHelper = (fn, graphType, options) => {
    switch graphType {
    | Graph => fn(makeGraph, options)
    | DirectedGraph => fn(makeDirectedGraph, options)
    | UndirectedGraph => fn(makeUndirectedGraph, options)
    | MultiGraph => fn(makeMultiGraph, options)
    | MultiDirectedGraph => fn(makeMultiDirectedGraph, options)
    | MultiUndirectedGraph => fn(makeMultiUndirectedGraph, options)
    }
  }

  // Clusters
  type clustersOpts = {
    order: int,
    size: int,
    clusters: int,
    clusterDensity?: float,
    rng?: unit => float,
  }

  @module("graphology-generators") @scope("random")
  external _clusters: (graphCtor, clustersOpts) => t = "clusters"
  let clusters = (graphType, options) => graphGenWithOptHelper(_clusters, graphType, options)

  // Erdos-Renyi
  type erdosRenyiOpts = {
    order: int,
    probability: float,
    approximateSize: int,
    rng?: unit => float,
  }

  @module("graphology-generators") @scope("random")
  external _erdosRenyi: (graphCtor, erdosRenyiOpts) => t = "erdosRenyi"
  let erdosRenyi = (graphType, options) => graphGenWithOptHelper(_erdosRenyi, graphType, options)

  // Girvan-Newman
  type girvanNewmanOpts = {
    zOut: int,
    rng?: unit => float,
  }

  @module("graphology-generators") @scope("random")
  external _girvanNewman: (graphCtor, girvanNewmanOpts) => t = "girvanNewman"
  let girvanNewman = (graphType, options) =>
    graphGenWithOptHelper(_girvanNewman, graphType, options)

  // Small Graphs
  //
  let graphGenNoOptHelper = (fn, graphType) => {
    switch graphType {
    | Graph => fn(makeGraph)
    | DirectedGraph => fn(makeDirectedGraph)
    | UndirectedGraph => fn(makeUndirectedGraph)
    | MultiGraph => fn(makeMultiGraph)
    | MultiDirectedGraph => fn(makeMultiDirectedGraph)
    | MultiUndirectedGraph => fn(makeMultiUndirectedGraph)
    }
  }
  // Krackhardt Kite
  @module("graphology-generators") @scope("small")
  external _krackhardtKite: graphCtor => t = "krackhardtKite"
  let krackhardtKite = graphType => graphGenNoOptHelper(_krackhardtKite, graphType)

  // Florentine Families
  @module("graphology-generators") @scope("social")
  external _florentineFamilies: graphCtor => t = "florentineFamilies"
  let florentineFamilies = graphType => graphGenNoOptHelper(_florentineFamilies, graphType)

  // Karate Club
  @module("graphology-generators") @scope("social")
  external _karateClub: graphCtor => t = "karateClub"
  let karateClub = graphType => graphGenNoOptHelper(_karateClub, graphType)
}
