// Demo file showcasing the Graphology ReScript bindings
// This demonstrates various graph operations, algorithms, and features
@@warning("-26-32-44-27")
open Graphology

// Convenience logging functions
let log = Console.log
let log2 = Console.log2

// Utility: Write string content to a file
let stringToFile = (str, ~fileName) => {
  open NodeJs
  Fs.writeFileSync(fileName, str->Buffer.fromString)
}

// ============================================================================
// Example 1: Simple Graph Creation
// ============================================================================
// Demonstrates the basic graph instantiation pattern using the MakeGraph functor
let _ = {
  log("=== simple graph ===")

  // Instantiate a graph module with string nodes and edges
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  // Create a default undirected graph
  let g = G.makeGraph()
  g->G.addNode("John")
}

// ============================================================================
// Example 2: Traversal, Iteration, and Shortest Path Algorithms
// ============================================================================
// Demonstrates node/edge iteration, BFS/DFS traversal, and various shortest path algorithms
let _ = {
  log("=== Traversal ===")
  module Dict = Dict
  module H = Graph.MakeGraph({
    type node = string
    type edge = string
  })
  let h = H.makeGraph()

  // Add nodes with attributes (extensible objects)
  h->H.addNode("John", ~attr={"lastName": "Doe"})
  h->H.addNode("Peter", ~attr={"lastName": "Egg"})
  h->H.addNode("Mary")  // Node without attributes

  // Add edges with attributes (distances)
  h->H.addEdge("John", "Peter", ~attr={"dist": 23})
  h->H.addEdge("Peter", "Mary", ~attr={"dist": 12})

  // --- Node Iteration Examples ---

  // forEach: Iterate over all nodes with a side-effect function
  h->H.NodesIter.forEachNode((n, attr) => {
    n->log
    attr->log
    ()
  })

  // map: Transform nodes into new values
  h
  ->H.NodesIter.mapNodes((n, attr) => {
    n->log
    attr->log
    1
  })
  ->(log2("mapNodes", _))

  // Using the native Iterator protocol (new in ReScript v12)
  let iter = h->H.NodesIter.nodeEntries
  iter->(log2("iter", _))

  // Convert iterator to array
  let arr = Array.fromIterator(iter)
  arr->(log2("arr", _))

  // Process node entries (node + attributes)
  let arr2 = arr->Array.map(({node, attributes}) => {
    node->log
    attributes->log
    node ++ " - " ++ attributes["lastName"]
  })
  arr2->log

  // --- Graph Traversal ---

  // Breadth-First Search from all source nodes
  h->H.Traversal.bfs((n, att, depth) => {
    n->log
    att->log
    depth->log
    ()
  })

  // Depth-First Search from all source nodes
  h->H.Traversal.dfs((n, att, depth) => {
    n->log
    att->log
    depth->log
    ()
  })

  // BFS starting from a specific node
  h->H.Traversal.bfsFromNode("John", (n, att, depth) => {
    n->log
    att->log
    depth->log
    ()
  })
  // --- Unweighted Shortest Path Algorithms ---

  // Bidirectional search (unweighted)
  h->H.ShortestPath.Unweighted.bidirectional("John", "Mary")->(log2("Unweighted bidirection", _))

  // Single-source shortest paths (returns path for each reachable node)
  h->H.ShortestPath.Unweighted.singleSource("John")->(log2("Unweighted singleSource", _))

  // Single-source path lengths only
  h
  ->H.ShortestPath.Unweighted.singleSourceLength("John")
  ->(log2("Unweighted singleSourceLength", _))

  // Undirected single-source path lengths
  h
  ->H.ShortestPath.Unweighted.undirectedSingleSourceLength("John")
  ->(log2("Unweighted undirectedSingleSourceLength", _))

  // --- Dijkstra's Algorithm (weighted shortest paths) ---
  log("-- Dijkstra")

  // Single-source Dijkstra (returns dict of paths)
  h->H.ShortestPath.Dijkstra.singleSource("John")->(log2("Dijkstra singleSource", _))

  // Working with Dijkstra results (dict of node -> path)
  let dijss = h->H.ShortestPath.Dijkstra.singleSource("John")
  dijss->Dict.keysToArray->(log2("k", _))
  dijss->Dict.valuesToArray->(log2("v", _))
  dijss->Dict.get("John")->(log2("John", _))
  dijss->Dict.get("Peter")->(log2("Peter", _))
  dijss->Dict.get("Mary")->(log2("Mary", _))

  // --- A* Algorithm (heuristic-based shortest path) ---
  log("-- AStar")
  h->H.ShortestPath.AStar.bidirectional("John", "Mary")->log2("AStar bidirectional")
}

// ============================================================================
// Example 3: Graph with Tuple Nodes
// ============================================================================
// Demonstrates using tuples as node identifiers (e.g., for grid coordinates)
{
  module T = Graph.MakeGraph({
    type node = (int, int)  // Coordinates
    type edge = string
  })
  let t = T.makeGraph()

  // Add nodes at coordinate positions
  t->T.addNode((0, 0), ~attr={"lastName": "Doe"})
  t->T.addNode((1, 1), ~attr={"lastName": "Egg"})
  t->T.addNode((2, 2), ~attr={"lastName": "Klein"})

  // Connect coordinate nodes
  t->T.addEdge((0, 0), (1, 1), ~attr={"dist": 23})
  t->T.addEdge((1, 1), (2, 2), ~attr={"dist": 12})
}

// ============================================================================
// Example 4: Weighted Shortest Paths with Edge Attributes
// ============================================================================
// Demonstrates using edge weight attributes and converting node paths to edge paths
{
  log("=== Shortest Path ===")
  module G = Graph.MakeGraph({
    type node = int
    type edge = string
  })
  let g = G.makeGraph()

  // Build a simple weighted graph
  g->G.addNode(1)
  g->G.addNode(2)
  g->G.addNode(3)
  g->G.addNode(4)

  // Add edges with custom weight attribute
  g->G.addEdge(1, 2, ~attr={"weight1": 3})
  g->G.addEdge(1, 3, ~attr={"weight1": 2})
  g->G.addEdge(2, 4, ~attr={"weight1": 1})
  g->G.addEdge(3, 4, ~attr={"weight1": 1})

  // Query edge information
  g->G.edge(1, 2)->(log2("edge", _))
  g->G.EdgesIter.edges(All)->(log2("edges", _))
  g->G.EdgesIter.edges(Node(1))->(log2("edges", _))

  // Dijkstra with default weight (1 for each edge)
  g
  ->G.ShortestPath.Dijkstra.singleSource(1)
  ->(log2("Dijkstra singleSource", _))

  // Dijkstra with custom weight attribute
  g
  ->G.ShortestPath.Dijkstra.bidirectional(1, 4, ~weight=#Attr("weight1"))
  ->(log2("Dijkstra bidirectional", _))

  // Convert node path to edge path
  let ps = g->G.ShortestPath.Dijkstra.bidirectional(1, 4, ~weight=#Attr("weight1"))
  let es = g->G.ShortestPath.Utils.edgePathFromNodePath(ps)
  es->(log2("es", _))
}

// ============================================================================
// Example 5: Layout Algorithms and SVG Export
// ============================================================================
// Demonstrates applying circular layout and rendering to SVG file
{
  log("=== Layout Circular / write to file ===")
  module G = Graph.MakeGraph({
    type node = int
    type edge = string
  })
  let g = G.makeGraph()

  // Create a simple graph
  g->G.addNode(1)
  g->G.addNode(2)
  g->G.addNode(3)
  g->G.addNode(4)

  g->G.addEdge(1, 2)
  g->G.addEdge(1, 3)
  g->G.addEdge(2, 4)
  g->G.addEdge(3, 4)

  // Compute circular layout positions
  let pos = g->G.Layout.Circular.circular

  // Assign circular layout with custom options to the graph
  G.Layout.Circular.assign(g, ~options={center: 0.7, scale: 20.0})

  // Render graph to SVG file
  g->G.SVG.render("./graph.svg", ~settings={margin: 20, width: 4096, height: 4096}, () =>
    log("DONE writing to file")
  )
}

// ============================================================================
// Example 6: Graph Options (Multi-edges, Directed, Self-loops)
// ============================================================================
// Demonstrates creating a graph with specific options
{
  module G = Graph.MakeGraph({
    type node = int
    type edge = string
  })

  // Create a directed multigraph without self-loops
  let g = G.makeGraph(
    ~options={
      multi: true,           // Allow multiple edges between same nodes
      allowSelfLoops: false, // Disallow edges from node to itself
      type_: #directed,      // Directed graph
    },
  )
}

// ============================================================================
// Example 7: Graph Import/Export and mergeNode
// ============================================================================
// Demonstrates merging nodes (add if not exists), and exporting/importing graphs
let _ = {
  log("=== export / import ===")
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  // mergeNode: adds node if it doesn't exist, returns (node, wasAdded)
  let g = G.makeGraph()
  let (n, b) = g->G.mergeNode("John")  // First merge: added = true
  let (n, b) = g->G.mergeNode("John")  // Second merge: added = false (already exists)
  let (n, b) = g->G.mergeNode("John", ~attr={"eyes": "blue"})  // Merge with attributes

  // Export and import demo
  let g = G.makeGraph()
  let _ = g->G.mergeEdgeWithKey("T->E", "Thomas", "Eric", ~attr={"type": "KNOWS"})
  g->G.setAttribute("name", "My Graph")

  // Export graph to a serializable format
  let exported = g->G.export

  // Import into a new graph instance
  let h = G.makeGraph()
  h->G.import(exported)
  h->G.addNode("John")
}

// ============================================================================
// Example 8: Edge Iteration with Variants
// ============================================================================
// Demonstrates querying edges using variant arguments (All, Node, FromTo)
let _ = {
  log("=== EdgesIter ===")
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  // Create a multigraph (allows multiple edges between same nodes)
  let g = G.makeGraph(~options={multi: true})

  // Add edges with custom keys
  let _ = g->G.mergeEdgeWithKey("T->R", "Thomas", "Rosaline")
  let _ = g->G.mergeEdgeWithKey("T->E", "Thomas", "Emmett")
  let _ = g->G.mergeEdgeWithKey("C->T", "Catherine", "Thomas")
  let _ = g->G.mergeEdgeWithKey("R->C", "Rosaline", "Catherine")
  let _ = g->G.mergeEdgeWithKey("J->D1", "John", "Daniel")
  let _ = g->G.mergeEdgeWithKey("J->D2", "John", "Daniel")  // Second edge between John and Daniel

  // Query edges using variant arguments
  g->G.EdgesIter.edges(All)->(log2("g-G.edges", _))
  // Returns: ['T->R', 'T->E', 'C->T', 'R->C', 'J->D1', 'J->D2']

  g->G.EdgesIter.edges(Node("Thomas"))->(log2("g-G.edges('Thomas')", _))
  // Returns: ['T->R', 'T->E', 'C->T'] (all edges touching Thomas)

  g->G.EdgesIter.edges(FromTo("John", "Daniel"))->(log2("g-G.edges('John', 'Daniel')", _))
  // Returns: ['J->D1', 'J->D2'] (both edges from John to Daniel)
}

// ============================================================================
// Example 9: BFS Traversal and GEXF Export
// ============================================================================
// Demonstrates building a tree structure, BFS traversal, and exporting to GEXF format
let _ = {
  log("=== BFS ===")
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  // Build a tree structure for BFS demo
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

  // Export to GEXF format with custom formatters
  let gexfStrWithOptions = g->G.GEXF.write(
    ~options={
      version: "1.3",
      formatNode: (key, _attributes) => {
        // Custom node formatter for GEXF export
        {
          "label": key,
          // Can include attributes and viz properties:
          // "attributes": {"age": _attributes["age"], "name": _attributes["name"]},
          // "viz": {"color": "#666", "x": _attributes["x"], "y": _attributes["y"],
          //         "shape": "circle", "size": 20},
        }
      },
      formatEdge: (key, attributes) => {
        // Custom edge formatter for GEXF export
        {
          "weight": attributes["weight"],
          // Can include label, attributes, and viz properties:
          // "label": key,
          // "attributes": {"number": attributes["number"]},
          // "viz": {"color": "#FF0", "shape": "dotted", "thickness": 20},
        }
      },
    },
  )

  // Export with default options
  let gexfStr = g->G.GEXF.write(~options={version: "1.3"})

  // Perform BFS traversal, logging each node and its depth
  "bfs"->log
  g->G.Traversal.bfs((n, att, depth) => {
    log2(n, depth)
  })
}

// ============================================================================
// Example 10: Graph Pattern Utilities
// ============================================================================
// Demonstrates common graph patterns: clique, cycle, path, star
let _ = {
  module G = Graph.MakeGraph({
    type node = int
    type edge = int
  })

  // Clique: fully-connected subgraph (all nodes connected to each other)
  let g = G.makeGraph()
  g->G.Utils.mergeClique([1, 2, 3])
  g->G.EdgesIter.edges(All)->Array.map(e => g->G.extremities(e))->log

  // Cycle: circular path (last node connects back to first)
  let g = G.makeGraph()
  g->G.Utils.mergeCycle([1, 2, 3, 4, 5])
  g->G.EdgesIter.edges(All)->Array.map(e => g->G.extremities(e))->log

  // Path: linear sequence of nodes
  let g = G.makeGraph()
  g->G.Utils.mergePath([1, 2, 3, 4, 5])
  g->G.EdgesIter.edges(All)->Array.map(e => g->G.extremities(e))->log

  // Star: one central node connected to all others
  let g = G.makeGraph()
  g->G.Utils.mergeStar([1, 2, 3, 4, 5])  // 1 is the center
  g->G.EdgesIter.edges(All)->Array.map(e => g->G.extremities(e))->log
}

// ============================================================================
// Example 11: Renaming Graph Keys with Maps
// ============================================================================
// Demonstrates renaming nodes and edges using dictionaries
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

  // Create mapping dictionaries
  let nodeMap = Dict.make()
  nodeMap->Dict.set("Martha", 1)
  nodeMap->Dict.set("Catherine", 2)
  nodeMap->Dict.set("John", 3)

  let edgeMap = Dict.make()
  edgeMap->Dict.set("M->C", "rel1")
  edgeMap->Dict.set("C->J", "rel2")

  // Rename keys according to the maps
  let renamedGraph = g->G.Utils.renameGraphKeys(nodeMap, edgeMap)

  renamedGraph->G.NodesIter.nodes->log
  renamedGraph->G.EdgesIter.edges(All)->log
}

// ============================================================================
// Example 12: Updating Graph Keys with Functions
// ============================================================================
// Demonstrates renaming nodes and edges using transformer functions
let _ = {
  log("=== updateGraphKeys ===")
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

  // Update keys using transformer functions (more flexible than maps)
  let updatedGraph = g->G.Utils.updateGraphKeys(
    // Node transformer: (key, attributes) => newKey
    (key, _) => {
      switch key {
      | "Martha" => 4
      | "Catherine" => 5
      | _ => 6
      }
    },
    // Edge transformer: (key, attributes) => newKey
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

// ============================================================================
// Example 13: Layout Algorithms (CirclePack, Rotation, Position Collection)
// ============================================================================
// Demonstrates various layout algorithms and collecting layout information
let _ = {
  log("=== layout ===")
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  let g = G.makeGraph()

  g->G.addNode("Martha")
  g->G.addNode("Catherine")
  g->G.addNode("John")

  // Apply circle pack layout (assigns x, y positions to nodes)
  G.Layout.CirclePack.assign(g)

  // Apply rotation layout (rotates node positions)
  G.Layout.Rotation.assign(g, 10.0)  // Rotate by 10 degrees

  // Collect layout information
  let layout = g->G.Layout.Utils.collectLayout
  let layout = g->G.Layout.Utils.collectLayoutAsFlatArray

  // Compute circle pack positions (without assigning to graph)
  let positions = G.Layout.CirclePack.circlePack(g)

  // Circle pack with hierarchy attributes
  let positions = G.Layout.CirclePack.circlePack(
    g,
    ~options={hierarchyAttributes: ["degree", "community"]},
  )
}

// ============================================================================
// Example 14: Graph Generators and GEXF Export
// ============================================================================
// Demonstrates built-in graph generators (like Zachary's Karate Club)
let _ = {
  "generators"->log
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  // Helper module for writing GEXF files
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

  // Generate Zachary's Karate Club graph (famous social network dataset)
  let g = G.Generators.karateClub(G.Generators.DirectedGraph)
  // Optionally export to GEXF:
  // g->GEXF.writeToFile("karateClub.gexf")
}
