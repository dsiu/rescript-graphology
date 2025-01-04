@@uncurried

open Graphology

let log = Console.log
let log2 = Console.log2
// Str

// todo: refactor
let stringToFile = (str, ~fileName) => {
  open NodeJs
  Fs.writeFileSync(fileName, str->Buffer.fromString)
}

// https://www.geeksforgeeks.org/a-search-algorithm/

// make the map
// https://media.geeksforgeeks.org/wp-content/uploads/a_-search-algorithm-1.png

// tuples
module G = Graph.MakeGraph({
  type node = string
  type edge = string
})
let g = G.makeUndirectedGraph()

let makeNodeKey = ((r, c)) => {
  `${r->Int.toString},${c->Int.toString}`
}

let addNode = (r, c) => {
  let key = makeNodeKey((r, c))
  let (key', _added) = g->G.mergeNode(key, ~attr={"x": c, "y": r})
  key'
}

let _ = g->G.mergeNode(addNode(0, 0))
let _ = g->G.mergeEdge(addNode(0, 0), addNode(0, 1))
let _ = g->G.mergeEdge(addNode(0, 0), addNode(1, 0))

let _ = g->G.mergeEdge(addNode(0, 1), addNode(0, 0))
let _ = g->G.mergeEdge(addNode(0, 1), addNode(0, 2))
let _ = g->G.mergeEdge(addNode(0, 1), addNode(1, 1))

let _ = g->G.mergeEdge(addNode(0, 2), addNode(0, 1))
let _ = g->G.mergeEdge(addNode(0, 2), addNode(0, 3))
let _ = g->G.mergeEdge(addNode(0, 2), addNode(1, 2))

let _ = g->G.mergeEdge(addNode(0, 3), addNode(0, 2))
let _ = g->G.mergeEdge(addNode(0, 3), addNode(1, 3))

let _ = g->G.mergeEdge(addNode(1, 0), addNode(0, 0))
let _ = g->G.mergeEdge(addNode(1, 0), addNode(1, 1))

let _ = g->G.mergeEdge(addNode(1, 1), addNode(0, 1))
let _ = g->G.mergeEdge(addNode(1, 1), addNode(1, 0))
let _ = g->G.mergeEdge(addNode(1, 1), addNode(1, 2))

let _ = g->G.mergeEdge(addNode(1, 2), addNode(0, 2))
let _ = g->G.mergeEdge(addNode(1, 2), addNode(1, 1))
let _ = g->G.mergeEdge(addNode(1, 2), addNode(1, 3))

let _ = g->G.mergeEdge(addNode(1, 3), addNode(0, 3))
let _ = g->G.mergeEdge(addNode(1, 3), addNode(1, 2))
let _ = g->G.mergeEdge(addNode(1, 3), addNode(1, 4))

let _ = g->G.mergeEdge(addNode(2, 2), addNode(1, 2))
let _ = g->G.mergeEdge(addNode(2, 2), addNode(3, 2))

let _ = g->G.mergeEdge(addNode(2, 5), addNode(2, 6))
let _ = g->G.mergeEdge(addNode(2, 5), addNode(3, 5))

let _ = g->G.mergeEdge(addNode(2, 6), addNode(2, 5))
let _ = g->G.mergeEdge(addNode(2, 6), addNode(2, 7))
let _ = g->G.mergeEdge(addNode(2, 6), addNode(3, 6))

let _ = g->G.mergeEdge(addNode(3, 1), addNode(3, 2))

let _ = g->G.mergeEdge(addNode(3, 2), addNode(2, 2))
let _ = g->G.mergeEdge(addNode(3, 2), addNode(3, 1))
let _ = g->G.mergeEdge(addNode(3, 2), addNode(3, 3))

let _ = g->G.mergeEdge(addNode(3, 3), addNode(3, 2))
let _ = g->G.mergeEdge(addNode(3, 3), addNode(3, 4))

let _ = g->G.mergeEdge(addNode(3, 4), addNode(3, 3))
let _ = g->G.mergeEdge(addNode(3, 4), addNode(3, 5))

let _ = g->G.mergeEdge(addNode(3, 5), addNode(2, 5))
let _ = g->G.mergeEdge(addNode(3, 5), addNode(3, 4))
let _ = g->G.mergeEdge(addNode(3, 5), addNode(3, 6))

let _ = g->G.mergeEdge(addNode(3, 6), addNode(2, 6))
let _ = g->G.mergeEdge(addNode(3, 6), addNode(3, 5))
let _ = g->G.mergeEdge(addNode(3, 6), addNode(3, 7))

let _ = g->G.mergeEdge(addNode(3, 7), addNode(2, 7))
let _ = g->G.mergeEdge(addNode(3, 7), addNode(3, 6))

module GEXF = {
  let writeToFile = (g, filename) => {
    let gexfStrWithOptions = g->G.GEXF.write(
      ~options={
        version: "1.3",
        formatNode: (key, _attributes) => {
          {
            "label": key,
            "attributes": {
              "name": key,
              "x": (_attributes["x"]->Float.parseInt *. 100.0)->Float.toFixed(~digits=2),
              "y": (_attributes["y"]->Float.parseInt *. 100.0)->Float.toFixed(~digits=2),
            },
          }
        },
        formatEdge: (key, _attributes) => {
          {
            "label": key,
            "attributes": {
              "name": key,
            },
          }
        },
      },
    )

    gexfStrWithOptions->stringToFile(~fileName=filename)
  }
}

let manDistance = (node, finalTarget) => {
  node->log
  finalTarget->log
  //Math.Int.abs(x1 - x2) + Math.Int.abs(y1 - y2)
  1
}

g->G.inspect->log
g->GEXF.writeToFile("astar.gexf")
let res = g->G.ShortestPath.AStar.bidirectional(
  addNode(0, 0),
  addNode(3, 7),
  ~weight=#Getter(
    (e, _) => {
      e->log
      1
    },
  ),
  ~heuristic=(node, finalTarget) => {
    let d = manDistance(node, finalTarget)
    node->(log2("node", _))
    finalTarget->(log2("finalTarget", _))
    d->(log2("d", _))
    d
  },
)

res->log
