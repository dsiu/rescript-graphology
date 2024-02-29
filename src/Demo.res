@@uncurried

open Graphology

let log = Console.log
let log2 = Console.log2
// Str

let _ = {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  let g = G.makeGraph()
  g->G.addNode("John", ())
}

let _ = {
  module Dict = RescriptCore.Dict
  module H = Graph.MakeGraph({
    type node = string
    type edge = string
  })
  let h = H.makeGraph()
  "hi"->log
  h->H.addNode("John", ~attr={"lastName": "Doe"}, ())
  h->H.addNode("Peter", ~attr={"lastName": "Egg"}, ())
  //  h->H.addNode("Mary", ~attr={"lastName": "Klein"})
  h->H.addNode("Mary", ())
  h->H.addEdge("John", "Peter", ~attr={"dist": 23}, ())
  h->H.addEdge("Peter", "Mary", ~attr={"dist": 12}, ())

  h->H.inspect->(log2("inspect", _))

  h->H.forEachNode((n, attr) => {
    n->log
    attr->log
    ()
  })
  h
  ->H.mapNodes((n, attr) => {
    n->log
    attr->log
    1
  })
  ->(log2("mapNodes", _))

  let iter = h->H.nodeEntries
  iter->(log2("iter", _))
  let arr = iter->Core__Iterator.toArray
  arr->(log2("arr", _))
  let arr2 = arr->Array.map(({node, attributes}) => {
    node->log
    attributes->log
    node ++ " - " ++ attributes["lastName"]
  })

  arr2->log

  h->H.Traversal.bfs((n, att, depth) => {
    n->log
    att->log
    depth->log
    ()
  })

  h->H.Traversal.dfs((n, att, depth) => {
    n->log
    att->log
    depth->log
    ()
  })

  h->H.Traversal.bfsFromNode("John", (n, att, depth) => {
    n->log
    att->log
    depth->log
    ()
  })
  h->H.ShortestPath.Unweighted.bidirectional("John", "Mary")->(log2("Unweighted bidirection", _))
  h->H.ShortestPath.Unweighted.singleSource("John")->(log2("Unweighted singleSource", _))
  h
  ->H.ShortestPath.Unweighted.singleSourceLength("John")
  ->(log2("Unweighted singleSourceLength", _))
  h
  ->H.ShortestPath.Unweighted.undirectedSingleSourceLength("John")
  ->(log2("Unweighted undirectedSingleSourceLength", _))

  //  h->H.ShortestPath.Dijkstra.bidirectional("John", "Mary")->(log2("Dijkstra bidirection", _))
  h->H.ShortestPath.Dijkstra.singleSource("John", ())->(log2("Dijkstra singleSource", _))

  let dijss = h->H.ShortestPath.Dijkstra.singleSource("John", ())

  dijss->RescriptCore.Dict.keysToArray->(log2("k", _))
  dijss->RescriptCore.Dict.valuesToArray->(log2("v", _))
  dijss->RescriptCore.Dict.get("John")->(log2("John", _))
  dijss->RescriptCore.Dict.get("Peter")->(log2("Peter", _))
  dijss->RescriptCore.Dict.get("Mary")->(log2("Mary", _))
}

{
  // tuples
  module T = Graph.MakeGraph({
    type node = (int, int)
    type edge = string
  })
  let t = T.makeGraph()

  t->T.addNode((0, 0), ~attr={"lastName": "Doe"}, ())
  t->T.addNode((1, 1), ~attr={"lastName": "Egg"}, ())
  t->T.addNode((2, 2), ~attr={"lastName": "Klein"}, ())
  t->T.addEdge((0, 0), (1, 1), ~attr={"dist": 23}, ())
  t->T.addEdge((1, 1), (2, 2), ~attr={"dist": 12}, ())
  //  t
  //  ->T.ShortestPath.Dijkstra.bidirectional((0, 0), (2, 2))
  //  ->(log2("(tuple) Dijkstra bidirection", _))
}

{
  module G = Graph.MakeGraph({
    type node = int
    type edge = string
  })
  let g = G.makeGraph()

  g->G.addNode(1, ())
  g->G.addNode(2, ())
  g->G.addNode(3, ())
  g->G.addNode(4, ())

  g->G.addEdge(1, 2, ~attr={"weight1": 3}, ())
  g->G.addEdge(1, 3, ~attr={"weight1": 2}, ())
  g->G.addEdge(2, 4, ~attr={"weight1": 1}, ())
  g->G.addEdge(3, 4, ~attr={"weight1": 1}, ())
  //  g->G.addEdgeWithKey(10, 1, 2)
  g->G.edge(1, 2)->(log2("edge", _))
  g->G.edges->(log2("edges", _))
  g->G.inspect->(log2("inspect", _))

  g
  ->G.ShortestPath.Dijkstra.singleSource(1, ())
  ->(log2("Dijkstra singleSource", _))

  g
  ->G.ShortestPath.Dijkstra.bidirectional(1, 4, ~weight=#Attr("weight1"), ())
  ->(log2("Dijkstra bidirectional", _))

  let ps = g->G.ShortestPath.Dijkstra.bidirectional(1, 4, ~weight=#Attr("weight1"), ())
  let es = g->G.ShortestPath.Utils.edgePathFromNodePath(ps)
  es->(log2("es", _))
}

{
  module G = Graph.MakeGraph({
    type node = int
    type edge = string
  })
  let g = G.makeGraph()

  g->G.addNode(1, ())
  g->G.addNode(2, ())
  g->G.addNode(3, ())
  g->G.addNode(4, ())

  g->G.addEdge(1, 2, ())
  g->G.addEdge(1, 3, ())
  g->G.addEdge(2, 4, ())
  g->G.addEdge(3, 4, ())

  g->G.inspect->(log2("inspect - layout", _))

  let pos = g->G.Layout.circular
  pos->(log2("pos", _))

  G.Layout.Circular.assign(g, ~options={center: 0.7, scale: 20.0})
  g->G.SVG.render("./graph.svg", ~settings={margin: 20, width: 4096, height: 4096}, () =>
    log("DONE writing to file")
  )

  g->G.inspect->(log2("inspect - layout", _))
}

{
  module G = Graph.MakeGraph({
    type node = int
    type edge = string
  })
  let g = G.makeGraph(
    ~options={
      multi: true,
      allowSelfLoops: false,
      type_: #directed,
    },
    (),
  )
  //  let g = G.makeGraph()

  g->G.inspect->(log2("inspect", ...))
}

let _ = {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  let g = G.makeGraph()
  let (n, b) = g->G.mergeNode("John", ())
  log2(n, b)
  let (n, b) = g->G.mergeNode("John", ())
  log2(n, b)
  let (n, b) = g->G.mergeNode("John", ~attr={"eyes": "blue"}, ())
  log2(n, b)
}
