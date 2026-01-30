# rescript-graphology

Type-safe [ReScript](https://rescript-lang.org/) bindings for [Graphology](https://graphology.github.io), a robust and multipurpose JavaScript graph library.

## Overview

This library provides comprehensive ReScript bindings to Graphology's graph data structures and algorithms, including:

- **Graph Creation & Manipulation**: Directed, undirected, multi-graphs with full CRUD operations
- **Algorithms**: Shortest path (Dijkstra, A*, unweighted), simple paths, graph traversal (BFS, DFS)
- **Layout**: Circular, circle pack, rotation, and more
- **Generators**: Built-in graph generators (karate club, Erdős-Rényi, etc.)
- **Import/Export**: GEXF and SVG format support
- **Native Iterator Support**: Leverages JavaScript's native Iterator protocol

## Installation

```sh
yarn add @dsiu/rescript-graphology graphology
```

Add to your `rescript.json`:

```json
{
  "dependencies": ["@dsiu/rescript-graphology"]
}
```

## Quick Start

```rescript
open Graphology

// Create a graph module with concrete types
module G = Graph.MakeGraph({
  type node = string
  type edge = string
})

// Create and populate a graph
let g = G.makeGraph()
g->G.addNode("Alice")
g->G.addNode("Bob")
g->G.addEdge("Alice", "Bob", ~attr={"weight": 1.0})

// Traverse the graph
g->G.Traversal.bfs((node, attributes, depth) => {
  Console.log3("Visiting", node, depth)
})

// Find shortest path (returns Nullable.t<array<node>>)
let path = g->G.ShortestPath.Dijkstra.bidirectional(
  "Alice",
  "Bob",
  ~weight=#Attr("weight")
)
// Handle nullable result
switch path->Nullable.toOption {
| Some(p) => Console.log2("Path found:", p)
| None => Console.log("No path exists")
}

// Apply layout and export
G.Layout.Circular.assign(g)
g->G.SVG.render("./graph.svg", ~settings={
  margin: 20,
  width: 800,
  height: 600
}, () => Console.log("Graph saved!"))
```

## Architecture

The library uses a **functor-based design** for type safety:

```rescript
module G = Graph.MakeGraph({
  type node = string  // or int, (int, int), custom types, etc.
  type edge = string
})
```

This ensures all operations on your graph maintain type consistency. All algorithm modules (ShortestPath, Layout, Traversal, etc.) are automatically available through the instantiated graph module.

## Features

### Graph Types
- Directed, undirected, and mixed graphs
- Multi-graphs (multiple edges between nodes)
- Self-loops support

### Core Operations
- Node and edge CRUD operations with attributes
- Graph, node, and edge attribute management
- Import/export serialization
- Iterator support for nodes, edges, and neighbors

### Algorithms
- **Shortest Path**: Dijkstra, A*, unweighted (bidirectional & single-source)
- **Simple Path**: Simple path finding algorithms
- **Traversal**: BFS, DFS from node or full graph

### Layout Algorithms
- Circular, CirclePack, Rotation
- Utility functions for layout collection and manipulation

### Utilities
- Graph generators (complete, path, cycle, clique, star, etc.)
- Key renaming and updating
- Graph merging utilities (mergeClique, mergePath, mergeStar, mergeCycle)

### Import/Export
- GEXF format (read/write with custom formatters)
- SVG rendering with customizable settings

## API Correctness

**All bindings have been verified against the official Graphology API** (as of 2025-11-25). Key points:

### Nullable Return Types

Some functions return `Nullable.t` because they can return `null`/`undefined`:

- **Find operations**: `findNode`, `findEdge`, `findNeighbor` → `Nullable.t<T>`
- **Shortest paths**: All `bidirectional` functions → `Nullable.t<array<node>>`

```rescript
// Example: Handle nullable results
let node = g->G.NodesIter.findNode((n, _) => n == "Alice")
switch node->Nullable.toOption {
| Some(n) => Console.log2("Found:", n)
| None => Console.log("Not found")
}
```

### Iterator Callback Signatures

Different iteration methods have different callback signatures:

- **Node iteration**: `(node, attributes) => ...`
- **Edge iteration**: `(edge, attributes, source, target, sourceAttributes, targetAttributes, undirected) => ...`
- **Neighbor iteration**: `(neighbor, attributes) => ...` ⚠️ Note: NOT edge information!

## Documentation

- [Graphology Documentation](https://graphology.github.io)
- [ReScript Documentation](https://rescript-lang.org)
- See `src/Demo.res` for comprehensive usage examples

## Development

```sh
# Install dependencies
yarn install

# Build
yarn build

# Watch mode
yarn watch

# Clean
yarn clean

# Run tests
yarn test

# Run demo
node src/Demo.res.mjs
```

### Testing

This project has **comprehensive test coverage with 532 passing tests** across all modules:

- Graph operations (core API)
- Node, Edge, and Neighbor iteration
- Shortest path algorithms
- Traversal algorithms (BFS/DFS)
- Layout algorithms
- Graph generators
- Utility functions
- GEXF import/export
- SVG rendering

Test files use Jest with `@glennsl/rescript-jest`. They should:
- Be placed in the `__tests__` directory
- Follow the naming convention `*_Test.res`
- Use the ReScript Jest bindings for assertions
- Have only one `expect` per test (use tuples for multiple values)

Example test:
```rescript
open Jest
open Expect

describe("Graph Tests", () => {
  test("creates a graph", () => {
    module G = Graph.MakeGraph({
      type node = string
      type edge = string
    })
    let g = G.makeGraph()
    g->G.addNode("Alice")
    expect(g->G.hasNode("Alice"))->toBe(true)
  })

  test("handles nullable find results", () => {
    module G = Graph.MakeGraph({
      type node = string
      type edge = string
    })
    let g = G.makeGraph()
    g->G.addNode("Alice")

    let found = g->G.NodesIter.findNode((n, _) => n == "Alice")
    expect(found)->toEqual(Nullable.make("Alice"))
  })
})
```

## Requirements

- ReScript v12.x or later
- Graphology v0.26.0 or later
- Node.js with ES module support

## License

MIT

## Author

Danny Siu <danny.siu@gmail.com>

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.
