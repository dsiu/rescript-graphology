let log = Console.log
let log2 = Console.log2
// Str

module G = Graph.MakeGraph({
  type node = string
  type nodeAttr = {}
  type edge = string
  type edgeAttr = {}
})

let g = G.makeGraph()
let gg = G.makeDirectedGraph()
g->G.addNode("John")

type hNodeAttr = {name: string}
type hEdgeAttr = {dist: int}

module H = Graph.MakeGraph({
  type node = int
  type nodeAttr = hNodeAttr
  type edge = string
  type edgeAttr = hEdgeAttr
})
let h = H.makeGraph()
"hi"->log
h->H.addNode(1, ~attr={name: "John"})
h->H.addNode(2, ~attr={name: "Peter"})
h->H.addNode(3, ~attr={name: "Ken"})
h->H.addEdge(1, 2, ~attr={dist: 23})
h->H.addEdge(2, 3, ~attr={dist: 1})

h->H.inspect->(log2("inspect", _))

h->H.forEachNode((n, attr) => {
  n->log
  attr->log
  ()
})
h
->H.mapNodes((n, attr) => {
  h->H.degree(n)->Int.toString ++ " diu"
})
->(log2("mapNodes", _))

let iter = h->H.nodeEntries
iter->(log2("iter", _))
let arr = iter->Core__Iterator.toArray
arr->(log2("arr", _))
let arr2 = arr->Array.map(({node, attributes}) => {
  node->log
  attributes->log
  node->Int.toString ++ " - " ++ attributes.name
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

h->H.Traversal.bfsFromNode(1, (n, att, depth) => {
  n->log
  att->log
  depth->log
  ()
})
h->H.ShortestPath.Unweighted.bidirectional(1, 2)->(log2("shortestPath bidirection", _))
h->H.ShortestPath.Unweighted.singleSource(1)->(log2("shortestPath singleSource", _))
