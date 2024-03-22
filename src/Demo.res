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

let _ = {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  let g = G.makeGraph()
  g->G.addNode("John")
}

let _ = {
  module Dict = RescriptCore.Dict
  module H = Graph.MakeGraph({
    type node = string
    type edge = string
  })
  let h = H.makeGraph()
  "hi"->log
  h->H.addNode("John", ~attr={"lastName": "Doe"})
  h->H.addNode("Peter", ~attr={"lastName": "Egg"})
  //  h->H.addNode("Mary", ~attr={"lastName": "Klein"})
  h->H.addNode("Mary")
  h->H.addEdge("John", "Peter", ~attr={"dist": 23})
  h->H.addEdge("Peter", "Mary", ~attr={"dist": 12})

  h->H.inspect->(log2("inspect", _))

  h->H.NodesIter.forEachNode((n, attr) => {
    n->log
    attr->log
    ()
  })
  h
  ->H.NodesIter.mapNodes((n, attr) => {
    n->log
    attr->log
    1
  })
  ->(log2("mapNodes", _))

  let iter = h->H.NodesIter.nodeEntries
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
  h->H.ShortestPath.Dijkstra.singleSource("John")->(log2("Dijkstra singleSource", _))

  let dijss = h->H.ShortestPath.Dijkstra.singleSource("John")

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

  t->T.addNode((0, 0), ~attr={"lastName": "Doe"})
  t->T.addNode((1, 1), ~attr={"lastName": "Egg"})
  t->T.addNode((2, 2), ~attr={"lastName": "Klein"})
  t->T.addEdge((0, 0), (1, 1), ~attr={"dist": 23})
  t->T.addEdge((1, 1), (2, 2), ~attr={"dist": 12})
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

  g->G.addNode(1)
  g->G.addNode(2)
  g->G.addNode(3)
  g->G.addNode(4)

  g->G.addEdge(1, 2, ~attr={"weight1": 3})
  g->G.addEdge(1, 3, ~attr={"weight1": 2})
  g->G.addEdge(2, 4, ~attr={"weight1": 1})
  g->G.addEdge(3, 4, ~attr={"weight1": 1})
  //  g->G.addEdgeWithKey(10, 1, 2)
  g->G.edge(1, 2)->(log2("edge", _))
  g->G.EdgesIter.edges(All)->(log2("edges", _))
  g->G.EdgesIter.edges(Node(1))->(log2("edges", _))
  g->G.inspect->(log2("inspect", _))

  g
  ->G.ShortestPath.Dijkstra.singleSource(1)
  ->(log2("Dijkstra singleSource", _))

  g
  ->G.ShortestPath.Dijkstra.bidirectional(1, 4, ~weight=#Attr("weight1"))
  ->(log2("Dijkstra bidirectional", _))

  let ps = g->G.ShortestPath.Dijkstra.bidirectional(1, 4, ~weight=#Attr("weight1"))
  let es = g->G.ShortestPath.Utils.edgePathFromNodePath(ps)
  es->(log2("es", _))
}

{
  module G = Graph.MakeGraph({
    type node = int
    type edge = string
  })
  let g = G.makeGraph()

  g->G.addNode(1)
  g->G.addNode(2)
  g->G.addNode(3)
  g->G.addNode(4)

  g->G.addEdge(1, 2)
  g->G.addEdge(1, 3)
  g->G.addEdge(2, 4)
  g->G.addEdge(3, 4)

  g->G.inspect->(log2("inspect - layout", _))

  let pos = g->G.Layout.Circular.circular
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
  let (n, b) = g->G.mergeNode("John")
  log2(n, b)
  let (n, b) = g->G.mergeNode("John")
  log2(n, b)
  let (n, b) = g->G.mergeNode("John", ~attr={"eyes": "blue"})
  log2(n, b)

  let g = G.makeGraph()

  let _ = g->G.mergeEdgeWithKey("T->E", "Thomas", "Eric", ~attr={"type": "KNOWS"})
  g->G.setAttribute("name", "My Graph")
  let exported = g->G.export

  exported->(log2("exported", _))

  let h = G.makeGraph()
  h->G.import(exported)
  h->G.addNode("John")
  h->(log2("imported", _))
}

let _ = {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  let g = G.makeGraph(~options={multi: true})

  let _ = g->G.mergeEdgeWithKey("T->R", "Thomas", "Rosaline")
  let _ = g->G.mergeEdgeWithKey("T->E", "Thomas", "Emmett")
  let _ = g->G.mergeEdgeWithKey("C->T", "Catherine", "Thomas")
  let _ = g->G.mergeEdgeWithKey("R->C", "Rosaline", "Catherine")
  let _ = g->G.mergeEdgeWithKey("J->D1", "John", "Daniel")
  let _ = g->G.mergeEdgeWithKey("J->D2", "John", "Daniel")

  // Using the array-returning methods:
  g->G.EdgesIter.edges(All)->(log2("g-G.edges", _))
  //>>> ['T->R', 'T->E', 'C->T', 'R->C']
  g->G.EdgesIter.edges(Node("Thomas"))->(log2("g-G.edges('Thomas')", _))
  //>>> ['T->R', 'T->E', 'C->T']

  g->G.EdgesIter.edges(FromTo("John", "Daniel"))->(log2("g-G.edges('John', 'Daniel')", _))

  //>>> ['J->D1', 'J->D2']
}

// use Graphology's built in BFS
let _ = {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  let g = G.makeGraph()
  let _ = g->G.mergeEdge("1", "2")
  let _ = g->G.mergeEdge("1", "3")
  let _ = g->G.mergeEdge("1", "4")
  let _ = g->G.mergeEdge("2", "5")
  let _ = g->G.mergeEdge("2", "6")
  let _ = g->G.mergeEdge("4", "7")
  let _ = g->G.mergeEdge("4", "8")
  let _ = g->G.mergeEdge("5", "9")
  let _ = g->G.mergeEdge("5", "10")
  let _ = g->G.mergeEdge("7", "11")
  let _ = g->G.mergeEdge("7", "12")

  //    let pos = g->G.Layout.circular
  //    G.Layout.Circular.assign(g, ~options={center: 0.7, scale: 20.0})

  let gexfStrWithOptions = g->G.GEXF.write(
    ~options={
      version: "1.3",
      formatNode: (key, attributes) => {
        {
          "label": key,
          //          "attributes": {
          //            "age": attributes["age"],
          //            "name": attributes["name"],
          //          },
          //          "viz": {
          //            "color": "#666",
          //            "x": attributes["x"],
          //            "y": attributes["y"],
          //            "shape": "circle",
          //            "size": 20,
          //          },
        }
      },
      formatEdge: (key, attributes) => {
        {
          //          "label": key,
          //          "attributes": {
          //            "number": attributes["number"],
          //          },
          "weight": attributes["weight"],
          //          "viz": {
          //            "color": "#FF0",
          //            "x": attributes["x"],
          //            "y": attributes["y"],
          //            "shape": "dotted",
          //            "thickness": 20,
          //          },
        }
      },
    },
  )

  g->G.inspect->(log2("inspect", _))
  let gexfStr = g->G.GEXF.write(~options={version: "1.3"})

  "---"->log
  gexfStr->(log2("gexfStr", _))

  //  gexfStrWithOptions->(log2("gexfStr", _))
  "---"->log

  "bfs"->log
  g->G.Traversal.bfs((n, att, depth) => {
    log2(n, depth)
  })
}

let _ = {
  module G = Graph.MakeGraph({
    type node = int
    type edge = int
  })

  let g = G.makeGraph()
  g->G.Utils.mergeClique([1, 2, 3])
  g->G.EdgesIter.edges(All)->Array.map(e => g->G.extremities(e))->log

  let g = G.makeGraph()
  g->G.Utils.mergeCycle([1, 2, 3, 4, 5])
  g->G.EdgesIter.edges(All)->Array.map(e => g->G.extremities(e))->log

  let g = G.makeGraph()
  g->G.Utils.mergePath([1, 2, 3, 4, 5])
  g->G.EdgesIter.edges(All)->Array.map(e => g->G.extremities(e))->log

  let g = G.makeGraph()
  g->G.Utils.mergeStar([1, 2, 3, 4, 5])
  g->G.EdgesIter.edges(All)->Array.map(e => g->G.extremities(e))->log
}

let _ = {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  let g = G.makeGraph()

  g->G.addNode("Martha")
  g->G.addNode("Catherine")
  g->G.addNode("John")

  g->G.addEdgeWithKey("M->C", "Martha", "Catherine")
  g->G.addEdgeWithKey("C->J", "Catherine", "John")

  open RescriptCore
  let nodeMap = Dict.make()
  nodeMap->Dict.set("Martha", 1)
  nodeMap->Dict.set("Catherine", 2)
  nodeMap->Dict.set("John", 3)

  let edgeMap = Dict.make()
  edgeMap->Dict.set("M->C", "rel1")
  edgeMap->Dict.set("C->J", "rel2")

  let renamedGraph = g->G.Utils.renameGraphKeys(nodeMap, edgeMap)

  renamedGraph->G.NodesIter.nodes->log
  renamedGraph->G.EdgesIter.edges(All)->log
}

let _ = {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  let g = G.makeGraph()

  g->G.addNode("Martha")
  g->G.addNode("Catherine")
  g->G.addNode("John")

  g->G.addEdgeWithKey("M->C", "Martha", "Catherine")
  g->G.addEdgeWithKey("C->J", "Catherine", "John")

  let updatedGraph = g->G.Utils.updateGraphKeys(
    (key, _) => {
      switch key {
      | "Martha" => 4
      | "Catherine" => 5
      | _ => 6
      }
    },
    (key, _) => {
      switch key {
      | "M->C" => "rel3"
      | _ => "rel4"
      }
    },
  )

  updatedGraph->G.NodesIter.nodes->log
  updatedGraph->G.EdgesIter.edges(All)->log
}

let _ = {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  let g = G.makeGraph()

  g->G.addNode("Martha")
  g->G.addNode("Catherine")
  g->G.addNode("John")

  //  g->G.inspect->log

  G.Layout.CirclePack.assign(g)
  g->G.inspect->(log2("circlePack", _))

  G.Layout.Rotation.assign(g, 10.0)
  g->G.inspect->(log2("rotation", _))

  let layout = g->G.Layout.Utils.collectLayout
  layout->(log2("collectLayout", _))

  let layout = g->G.Layout.Utils.collectLayoutAsFlatArray
  layout->(log2("collectLayoutAsFlatArray", _))

  let positions = G.Layout.CirclePack.circlePack(g)
  //  positions->log
  let positions = G.Layout.CirclePack.circlePack(
    g,
    ~options={hierarchyAttributes: ["degree", "community"]},
  )
  //  positions->log
}

let _ = {
  "generators"->log
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

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

  let g = G.Generators.karateClub(G.Generators.DirectedGraph)
  g->G.inspect->(log2("complete", _))
  g->GEXF.writeToFile("karateClub.gexf")
}
