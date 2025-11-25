# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Documentation References

**IMPORTANT**: When working with code in this repository, always refer to these official documentation sources:

### ReScript Language Reference
- **URL**: https://rescript-lang.org/llms/manual/llm-full.txt
- **Use for**:
  - ReScript syntax and language features
  - Standard library APIs
  - Type system details
  - External bindings and interop patterns
  - Best practices and idioms

### Graphology Library Reference
- **URL**: https://graphology.github.io
- **Use for**:
  - Graphology API reference
  - Graph data structure concepts
  - Algorithm implementations
  - JavaScript API behavior that this ReScript binding wraps

## Project Overview

This is a ReScript binding for the Graphology JavaScript graph library. It provides type-safe bindings to Graphology's graph data structures and algorithms, including shortest path algorithms, traversal methods, layout algorithms, and import/export functionality (GEXF, SVG).

**Important**: The project is currently on ReScript v12.0.0-rc.5 and has been upgraded to use the latest Graphology libraries that support the JS native Iterator protocol.

## Build Commands

- **Build**: `npm run build` or `yarn build` or `rescript build .`
- **Watch mode**: `npm run watch` or `yarn watch` or `rescript watch .`
- **Clean**: `npm run clean` or `yarn clean` or `rescript clean .`
- **Test**: `npm test` or `yarn test` (runs Jest)
- **Run demo**: `node src/Demo.res.mjs`

## Architecture

### Module System

The codebase uses a functor-based architecture to provide type-safe graph bindings:

1. **Core Type Module** (`Graphology__GraphTypes.res`): Defines the base module type `T` with abstract types for `t` (graph), `node`, `edge`, and attribute types (`graphAttr`, `nodeAttr`, `edgeAttr`). These use extensible object types `{..} as 'a` for flexible attribute handling.

2. **Main Graph Module** (`Graphology__Graph.res`): Contains:
   - `CONFIG` module type for specifying concrete `node` and `edge` types
   - `GRAPH` module type defining the full graph API
   - `MakeGraph` functor that takes a `CONFIG` and produces a `GRAPH` implementation

3. **Iterator Modules**: Separate functor-based modules for iteration:
   - `Graphology__Graph_NodesIter.res`: Node iteration (nodes, forEachNode, mapNodes, filterNodes, nodeEntries, etc.)
   - `Graphology__Graph_EdgesIter.res`: Edge iteration with direction variants (All, Node, InOut, FromTo)
   - `Graphology__Graph_NeighborsIter.res`: Neighbor traversal

4. **Algorithm Modules**: Each algorithm library is in its own functor:
   - `Graphology__ShortestPath.res`: Dijkstra, A*, unweighted shortest paths
   - `Graphology__SimplePath.res`: Simple path algorithms
   - `Graphology__Traversal.res`: BFS, DFS traversal
   - `Graphology__Layout.res`: Circular, CirclePack, Rotation, etc.
   - `Graphology__Generators.res`: Graph generators (karate club, etc.)
   - `Graphology__Utils.res`: Utility functions (isGraph, inferMulti, inferType, mergeClique, mergeCycle, mergePath, mergeStar, renameGraphKeys, updateGraphKeys)

5. **Import/Export Modules**:
   - `Graphology__GEXF.res`: GEXF format import/export
   - `Graphology__SVG.res`: SVG rendering

6. **Top-level Module** (`Graphology.res`): Re-exports all submodules for convenient access.

### Using the Library

To use the library, instantiate a graph with concrete types via the `MakeGraph` functor:

```rescript
module G = Graph.MakeGraph({
  type node = string
  type edge = string
})

let g = G.makeGraph()
g->G.addNode("John")
g->G.addEdge("John", "Mary")
```

All algorithm modules (ShortestPath, Layout, Traversal, etc.) are nested under the instantiated graph module, ensuring type consistency.

### Key Design Patterns

- **Functors for Type Safety**: The functor pattern ensures that graph types, node types, and edge types remain consistent across all operations and algorithm invocations.
- **Module Composition**: The `GRAPH` module signature includes all iterator and algorithm modules, making them accessible through a single instantiation.
- **Native Iterator Support**: Recent upgrade added support for JavaScript's native Iterator protocol (e.g., `nodeEntries` returns `Iterator.t<nodeIterValue<'a>>`).

## Configuration

- **Package manager**: Yarn 4.11.0 (configured via `packageManager` field)
- **Module system**: ES modules with in-source builds (`.res.mjs` suffix)
- **Source directory**: `src/` with subdirectories
- **Dependencies**: Uses `rescript-nodejs` for Node.js bindings

## Testing

This project uses Jest with `@glennsl/rescript-jest` for testing:

- **Test directory**: `__tests__/`
- **Naming convention**: `*_Test.res` (e.g., `Graphology_Test.res`)
- **Test framework**: Jest 27.3.1 with Babel for transpilation
- **ReScript bindings**: `@glennsl/rescript-jest` (ReScript v12 fork)

### Jest Configuration

The project uses Jest with Babel transformation to handle ES modules:
- Test files match pattern: `**/__tests__/*_Test.res.(js|ts|jsx|tsx|mjs)`
- Babel preset-env configured for Node.js with CommonJS modules
- Transform ignore patterns configured for ReScript packages
- Test script: `npm test` runs all tests in the `__tests__/` directory

### Writing Tests

```rescript
open Jest
open Expect

describe("Test Suite Name", () => {
  test("test description", () => {
    expect(actualValue)->toEqual(expectedValue)
  })
})
```

## Test Coverage

The project has comprehensive test coverage across all modules:
- **Graph_Test.res**: Core graph operations (329 total tests across all modules)
- **NodesIter_Test.res**: Node iteration functions
- **EdgesIter_Test.res**: Edge iteration functions
- **ShortestPath_Test.res**: Shortest path algorithms
- **SimplePath_Test.res**: Simple path algorithms
- **Traversal_Test.res**: BFS/DFS traversal
- **Layout_Test.res**: Layout algorithms
- **Generators_Test.res**: Graph generators
- **Utils_Test.res**: Utility functions (80 tests)
- **GEXF_Test.res**: GEXF import/export
- **SVG_Test.res**: SVG rendering

### Key Testing Patterns

**IMPORTANT**: Each test must have only a single `expect` statement. Use tuples to test multiple values:

```rescript
// CORRECT - Single expect with tuple
test("returns multiple values", () => {
  let result1 = doSomething()
  let result2 = doSomethingElse()
  expect((result1, result2))->toEqual((expected1, expected2))
})

// INCORRECT - Multiple expects
test("returns multiple values", () => {
  expect(doSomething())->toEqual(expected1)  // ❌ Don't do this
  expect(doSomethingElse())->toEqual(expected2)  // ❌ Don't do this
})
```

#### Graph Operations

- Use `areNeighbors` to check if two nodes are connected (not `hasEdge` with source/target)
- Use `hasEdge` with an edge key to check if a specific edge exists
- Pattern functions (`mergeClique`, `mergePath`, `mergeStar`, `mergeCycle`) may behave differently with single nodes
- Use parentheses when negating function calls: `!(g->G.areNeighbors("A", "B"))`

#### Iterator Modules

The iterator modules (`NodesIter`, `EdgesIter`, `NeighborsIter`) are accessed as nested modules:

```rescript
// Correct way to access iterator functions
g->G.NodesIter.nodes         // Get all nodes
g->G.EdgesIter.edges(All)    // Get all edges
g->G.NeighborsIter.neighbors(Node("A"))  // Get neighbors of node A
```

**Key Iterator Module Behaviors**:

1. **NodesIter module**:
   - `reduceNodes` has a quirky return type of `array<node>` (not generic `'r`) in the current binding
   - When using `reduceNodes`, accumulate into arrays rather than other types
   - `nodeEntries` returns an iterator over `{node, attributes}` objects

2. **EdgesIter module**:
   - Edge iteration uses variant arguments: `All`, `Node(nodeKey)`, `InOut(nodeKey)`, `FromTo(source, target)`
   - Edge callbacks receive: `(edge, edgeAttr, source, target, sourceAttr, targetAttr, undirected)`
   - `findEdge` callback returns `unit` (not `bool`) - avoid using this function until API is clarified
   - `reduceEdges` works correctly and returns generic `'r` type
   - `edgeEntries` iterator provides: `{edge, attributes, source, target, sourceAttributes, targetAttributes}`

3. **NeighborsIter module**:
   - **IMPORTANT**: Despite type signature saying `array<edge>`, the `neighbors` function actually returns an array of **neighbor node keys**, not edge keys
   - Neighbor iteration callbacks receive edge-related parameters: `(edge, edgeAttr, source, target, sourceAttr, targetAttr, undirected)`
   - Use `neighbors(Node("A"))` to get neighbors of a specific node (not `neighbors(All)`)
   - `neighborEntries` iterator provides edge information for each neighbor connection
   - The module iterates over the edges connecting to neighbors, providing both edge and neighbor node information

4. **Common Iterator Patterns**:
   - Variant arguments must wrap callbacks: `All((arg1, arg2) => ...)` not `All(arg1, arg2 => ...)`
   - Iterator protocol: check `next.done`, access `next.value` which is `Option<T>`
   - Use recursive functions to consume iterators completely:
     ```rescript
     let rec collect = () => {
       let next = iter->Iterator.next
       if !next.done {
         // Process next.value
         collect()
       }
     }
     ```

#### Graph Types

- Default `makeGraph()` creates a simple undirected graph (no multi-edges, no mixed edges)
- Use `makeDirectedGraph()`, `makeUndirectedGraph()`, `makeMultiGraph()`, etc. for specific graph types
- There is no `makeMixedGraph()` - use `makeGraph()` with appropriate options if mixed edges are needed
- Methods like `addDirectedEdge` and `addUndirectedEdge` are not available on all graph types

#### ReScript v12 Best Practices

**IMPORTANT**: ReScript v12 introduced breaking changes in the standard library APIs. Always use the modern APIs:

- Use `Array.includes` instead of deprecated `Js.Array2.includes`
- Use `Array.push` instead of deprecated `Js.Array2.push`
  - **Breaking change**: Returns `unit` (not array length like in v11)
  - **No need for `->ignore`**: Since it returns `unit`, you can call it directly
  - Example:
    ```rescript
    // ReScript v11 (deprecated)
    arr->Js.Array2.push(item)->ignore  // Returns length, need to ignore

    // ReScript v12 (correct)
    arr->Array.push(item)  // Returns unit, no ignore needed
    ```
- Use `String.startsWith` instead of `Js.String2.startsWith`
- Use `Dict.get` instead of deprecated `Js.Dict.get` for dict operations
- Attribute objects use extensible object types `{..} as 'a` - access with `obj["key"]` syntax

**Migration Tip**: Run `rescript-tools migrate-all <project-root>` to automatically migrate deprecated APIs, but always review the changes as some migrations may need manual adjustments.

## Notes

- Some demo code in `Demo.res` includes commented-out sections and experimental iterator usage
- Warning suppressions (`@@warning("-26-32-44-27")`) are used in demo files
- The project includes several `.gexf` graph files for testing/demo purposes
- ensure each test has only a single expect statement, using tuples where multiple results need to be tested.
- remember to use conventional commits spec for commit message
- remember to run tests and make sure all tests passes before committing any changes