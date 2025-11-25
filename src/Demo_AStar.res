// ============================================================================
// A* Pathfinding Algorithm Demonstration
// ============================================================================
// This file demonstrates the A* (A-star) shortest path algorithm using the
// Graphology library. A* is an informed search algorithm that uses heuristics
// to efficiently find the shortest path between two nodes in a graph.
//
// Reference: https://www.geeksforgeeks.org/a-search-algorithm/
// Grid visualization: https://media.geeksforgeeks.org/wp-content/uploads/a_-search-algorithm-1.png
//
// The example creates a grid-based graph where:
// - Nodes represent grid positions (row, column)
// - Edges connect adjacent cells
// - A* algorithm finds the shortest path from (0,0) to (3,7)
// ============================================================================

open Graphology

// Utility functions for logging
let log = Console.log
let log2 = Console.log2

// ============================================================================
// File I/O Utility
// ============================================================================
// Writes a string to a file using Node.js file system APIs
let stringToFile = (str, ~fileName) => {
  open NodeJs
  Fs.writeFileSync(fileName, str->Buffer.fromString)
}

// ============================================================================
// Graph Module Instantiation
// ============================================================================
// Create a graph module with string-based node and edge keys
// This allows us to use coordinate strings like "0,0" as node identifiers
module G = Graph.MakeGraph({
  type node = string
  type edge = string
})

// Create an undirected graph to represent the 2D grid
let g = G.makeUndirectedGraph()

// ============================================================================
// Node Key Generation
// ============================================================================
// Convert grid coordinates (row, column) into a string key like "0,0"
// This provides a unique identifier for each grid cell
let makeNodeKey = ((r, c)) => {
  `${r->Int.toString},${c->Int.toString}`
}

// ============================================================================
// Node Creation Helper
// ============================================================================
// Creates or retrieves a node at the given grid position (row, column)
// - Generates a unique key from coordinates
// - Uses mergeNode to avoid duplicates (idempotent operation)
// - Stores x,y coordinates as node attributes for layout/visualization
// - Returns the node key for use in edge creation
let addNode = (r, c) => {
  let key = makeNodeKey((r, c))
  // mergeNode returns (key, wasAdded) tuple; we only need the key
  let (key', _added) = g->G.mergeNode(key, ~attr={"x": c, "y": r})
  key'
}

// ============================================================================
// Grid Graph Construction
// ============================================================================
// Build a sparse grid graph representing a pathfinding problem.
// This creates a non-contiguous grid with the following structure:
//
//   0   1   2   3   4   5   6   7  (columns)
// 0 *---*---*---*
// 1 *---*---*---*---*
// 2         *           *---*---*
// 3     *---*---*---*---*---*---*
//
// Where:
// - * represents a node (grid cell)
// - --- represents an edge (walkable connection)
// - Empty spaces represent obstacles/gaps
//
// This layout demonstrates A* navigating around obstacles.
// ============================================================================

// Row 0: Horizontal path from (0,0) to (0,3)
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

// Row 1: Horizontal path from (1,0) to (1,4)
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

// Row 2: Disconnected sections - (2,2) and (2,5)-(2,7)
let _ = g->G.mergeEdge(addNode(2, 2), addNode(1, 2))
let _ = g->G.mergeEdge(addNode(2, 2), addNode(3, 2))

let _ = g->G.mergeEdge(addNode(2, 5), addNode(2, 6))
let _ = g->G.mergeEdge(addNode(2, 5), addNode(3, 5))

let _ = g->G.mergeEdge(addNode(2, 6), addNode(2, 5))
let _ = g->G.mergeEdge(addNode(2, 6), addNode(2, 7))
let _ = g->G.mergeEdge(addNode(2, 6), addNode(3, 6))

// Row 3: Long horizontal path from (3,1) to (3,7)
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

// ============================================================================
// GEXF Export Module
// ============================================================================
// Provides functionality to export the graph to GEXF (Graph Exchange XML Format)
// GEXF is a standard format for graph visualization tools like Gephi
module GEXF = {
  // Export graph to GEXF file with custom formatting
  let writeToFile = (g, filename) => {
    let gexfStrWithOptions = g->G.GEXF.write(
      ~options={
        version: "1.3",
        // Format node data for GEXF export
        formatNode: (key, _attributes) => {
          {
            "label": key,
            "attributes": {
              "name": key,
              // Scale coordinates by 100 for better visualization
              "x": (_attributes["x"]->Float.parseInt *. 100.0)->Float.toFixed(~digits=2),
              "y": (_attributes["y"]->Float.parseInt *. 100.0)->Float.toFixed(~digits=2),
            },
          }
        },
        // Format edge data for GEXF export
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

    // Write GEXF string to file
    gexfStrWithOptions->stringToFile(~fileName=filename)
  }
}

// ============================================================================
// Heuristic Function: Manhattan Distance
// ============================================================================
// The A* algorithm requires a heuristic function to estimate the distance
// from any node to the target. Manhattan distance (L1 norm) is ideal for
// grid-based graphs where you can only move horizontally or vertically.
//
// Formula: |x1 - x2| + |y1 - y2|
//
// NOTE: This is currently stubbed to return 1 for demonstration purposes.
// A proper implementation would parse the coordinate strings and calculate
// the actual Manhattan distance.
let manDistance = (node, finalTarget) => {
  node->log
  finalTarget->log
  // TODO: Parse node keys like "0,0" to extract coordinates and compute:
  // Math.Int.abs(x1 - x2) + Math.Int.abs(y1 - y2)
  1  // Placeholder: uniform cost (degrades A* to Dijkstra)
}

// ============================================================================
// Run A* Algorithm
// ============================================================================

// Display graph structure for debugging
g->G.inspect->log

// Export graph to GEXF format for visualization in Gephi or similar tools
g->GEXF.writeToFile("astar.gexf")

// Execute bidirectional A* search from (0,0) to (3,7)
// Bidirectional search runs A* from both ends simultaneously for better performance
let res = g->G.ShortestPath.AStar.bidirectional(
  addNode(0, 0),    // Start node
  addNode(3, 7),    // Goal node
  // Weight function: assigns cost to traversing each edge
  // Currently returns uniform cost of 1 (unweighted graph)
  ~weight=#Getter(
    (e, _) => {
      e->log  // Log edge being evaluated
      1       // Each edge has cost 1
    },
  ),
  // Heuristic function: estimates remaining distance to goal
  // A* uses this to prioritize promising paths
  ~heuristic=(node, finalTarget) => {
    let d = manDistance(node, finalTarget)
    node->(log2("node", _))
    finalTarget->(log2("finalTarget", _))
    d->(log2("d", _))
    d
  },
)

// Display the shortest path found
// Expected: array of node keys representing the path from (0,0) to (3,7)
res->log
