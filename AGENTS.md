# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Documentation References

**IMPORTANT**: When working with code in this repository, always refer to these official documentation sources:

### ReScript Language Reference
- **ALWAYS USE THIS FOR RESCRIPT CODE**: https://rescript-lang.org/llms/manual/llms.txt
- **LLM Full Documentation**: https://rescript-lang.org/llms/manual/llm-full.txt
- **Language Manual**: https://rescript-lang.org/docs/manual/introduction
- **Use for**:
  - ReScript syntax and language features
  - Standard library APIs
  - Type system details
  - External bindings and interop patterns
  - Best practices and idioms
- Ensure suggestions match this version. Refer to the indexed ReScript manual and LLM documentation.
- When dealing with promises, prefer using `async/await` syntax.
- Never ever use the `Belt` or `Js` modules, these are legacy.
- Always use the `JSON.t` type for json.
- Module with React components do require a signature file (`.resi`) for Vite HMR to work. Only the React components can be exposed from the javascript.

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
   - **VERIFIED**: `reduceNodes` correctly returns generic `'r` type (accumulated result)
   - **VERIFIED**: `findNode` returns `Nullable.t<node>` (can return `undefined` if no match found)
   - Callbacks receive: `(node, attributes)`
   - `nodeEntries` returns an iterator over `{node, attributes}` objects

2. **EdgesIter module**:
   - Edge iteration uses variant arguments: `All`, `Node(nodeKey)`, `InOut(nodeKey)`, `FromTo(source, target)`
   - **VERIFIED**: Edge callbacks receive: `(edge, edgeAttr, source, target, sourceAttr, targetAttr, undirected)`
   - **VERIFIED**: `findEdge` callback returns `bool` (predicate function)
   - **VERIFIED**: `findEdge` returns `Nullable.t<edge>` (can return `undefined` if no match found)
   - `reduceEdges` returns generic `'r` type
   - `edgeEntries` iterator provides: `{edge, attributes, source, target, sourceAttributes, targetAttributes}`

3. **NeighborsIter module**:
   - **VERIFIED**: `neighbors` function returns an array of **neighbor node keys** (not edge keys)
   - **VERIFIED**: Neighbor iteration callbacks receive: `(neighbor, attributes)` - NOT edge information
   - **VERIFIED**: `reduceNeighbors` callback: `(accumulator, neighbor, attributes) => 'r`
   - **VERIFIED**: `someNeighbor` and `everyNeighbor` callbacks: `(neighbor, attributes) => bool`
   - **VERIFIED**: `findNeighbor` callback: `(neighbor, attributes) => bool`, returns `Nullable.t<edge>`
   - Use `neighbors(Node("A"))` to get neighbors of a specific node (not `neighbors(All)`)
   - **VERIFIED**: `neighborEntries` iterator provides: `{neighbor, attributes}` (not edge information)
   - The module focuses on neighbor nodes and their attributes, not the edges connecting them

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

## API Verification and Correctness

**CRITICAL**: All bindings have been verified against the official Graphology API documentation at https://graphology.github.io (as of 2025-11-25).

### Key API Differences Between Iteration Methods

1. **Node Iteration** - Callbacks receive: `(node, attributes)`
   - Returns: Arrays of nodes, generic types for reduce, `Nullable.t<node>` for find

2. **Edge Iteration** - Callbacks receive: `(edge, attributes, source, target, sourceAttributes, targetAttributes, undirected)`
   - Returns: Arrays of edges, generic types for reduce, `Nullable.t<edge>` for find

3. **Neighbor Iteration** - Callbacks receive: `(neighbor, attributes)` (NOT edge information!)
   - Returns: Arrays of neighbor nodes, generic types for reduce, `Nullable.t<edge>` for find
   - This is the most commonly misunderstood API - neighbors are nodes, not edges

### Nullable Return Types

The following functions return `Nullable.t` because they can return `null`/`undefined`:

- **Node iteration**: `findNode` → `Nullable.t<node>`
- **Edge iteration**: `findEdge` → `Nullable.t<edge>`
- **Neighbor iteration**: `findNeighbor` → `Nullable.t<edge>`
- **Shortest paths**: All `bidirectional` functions → `Nullable.t<array<node>>`
  - `Unweighted.bidirectional(source, target)` → `Nullable.t<array<node>>`
  - `Dijkstra.bidirectional(source, target, ~weight)` → `Nullable.t<array<node>>`
  - `AStar.bidirectional(source, target, ~weight, ~heuristic)` → `Nullable.t<array<node>>`

### Handling Nullable Results in Tests

```rescript
// Pattern 1: Using Nullable.make for equality
let result = g->G.NodesIter.findNode(predicate)
expect(result)->toEqual(Nullable.make("expectedNode"))

// Pattern 2: Using pattern matching for complex logic
let result = g->G.NodesIter.findNode(predicate)
switch result->Nullable.toOption {
| Some(node) => expect(node)->toBe("expectedNode")
| None => fail("Expected to find a node")
}

// Pattern 3: For shortest paths
let path = g->G.ShortestPath.Unweighted.bidirectional("A", "C")
expect(path)->toEqual(Nullable.make(["A", "B", "C"]))
```

## Test Compliance Review Process

**CRITICAL**: When reviewing or modifying tests, follow this systematic process to ensure API compliance:

### 1. Before Making Changes
- **ALWAYS** consult the official Graphology documentation first: https://graphology.github.io
- **NEVER** assume API behavior - verify against official docs
- Check both the API reference AND design choices: https://graphology.github.io/design-choices.html

### 2. Key Areas to Verify

#### Callback Signatures
Different iteration methods have COMPLETELY different callback signatures - verify each one:

```rescript
// Node iteration callbacks: (node, attributes)
g->G.NodesIter.forEachNode((node, attr) => ...)

// Edge iteration callbacks: (edge, attr, source, target, sourceAttr, targetAttr, undirected)
g->G.EdgesIter.forEachEdge(All((edge, attr, src, tgt, sAttr, tAttr, undirected) => ...))

// Neighbor iteration callbacks: (neighbor, attributes) - NOT edge info!
g->G.NeighborsIter.forEachNeighbor(Node("A", (neighbor, attr) => ...))
```

**Common Mistake**: Confusing neighbor iteration with edge iteration. Neighbors are NODES, not edges!

#### Return Types
- **Find operations**: Return `Nullable.t<T>` (not direct values)
  - `findNode`, `findEdge`, `findNeighbor` all return nullable
- **Shortest paths**: ALL `bidirectional` functions return `Nullable.t<array<node>>`
- **Reduce operations**: Return generic `'r` type (accumulated result type)

#### Design Choices Compliance
- **String-based keys**: Graphology coerces all keys to strings internally
  - Using `type node = int` is OK - Graphology will coerce to string
  - Don't assume numeric ordering of integer keys
- **No insertion order**: Never rely on iteration order matching insertion order
- **Return values**: `addNode`/`addEdge` return the element, other methods return graph for chaining
- **Errors throw**: Graphology throws errors rather than returning error codes

### 3. Test Compliance Checklist

When reviewing tests, verify:
- ✅ Callback signatures match official API exactly
- ✅ Nullable returns are handled with `Nullable.make()` or `.toOption`
- ✅ No assumptions about insertion order
- ✅ No assumptions about key types (strings vs integers)
- ✅ Each test has only ONE expect statement (use tuples for multiple values)
- ✅ Tests don't rely on implementation details

### 4. Common Mistakes to Avoid

❌ **WRONG**: Assuming `neighbors` returns edges
```rescript
// This is WRONG - neighbors returns array of NODES, not edges
let neighborEdges = g->G.NeighborsIter.neighbors(Node("A"))
```

✅ **CORRECT**: Understanding neighbors returns nodes
```rescript
// This is CORRECT - neighbors returns array of neighbor NODES
let neighborNodes = g->G.NeighborsIter.neighbors(Node("A"))
```

❌ **WRONG**: Not handling nullable returns
```rescript
// This is WRONG - findNode returns Nullable.t<node>
let node = g->G.NodesIter.findNode(predicate)
expect(node)->toBe("Alice")  // Type error!
```

✅ **CORRECT**: Handling nullable with Nullable.make or pattern matching
```rescript
// CORRECT - using Nullable.make
let node = g->G.NodesIter.findNode(predicate)
expect(node)->toEqual(Nullable.make("Alice"))

// CORRECT - using pattern matching
switch node->Nullable.toOption {
| Some(n) => expect(n)->toBe("Alice")
| None => fail("Expected to find node")
}
```

❌ **WRONG**: Using wrong callback signatures
```rescript
// This is WRONG - neighbor callbacks only receive (neighbor, attributes)
g->G.NeighborsIter.forEachNeighbor(Node("A",
  (edge, attr, source, target, sAttr, tAttr, undirected) => ...  // WRONG!
))
```

✅ **CORRECT**: Using correct callback signatures
```rescript
// CORRECT - neighbor callbacks receive (neighbor, attributes)
g->G.NeighborsIter.forEachNeighbor(Node("A",
  (neighbor, attr) => ...  // CORRECT!
))
```

### 5. Verification Results

**Latest comprehensive test compliance review (2025-11-25)**:
- ✅ All 532 tests reviewed and verified against official API
- ✅ 12 test files fully compliant with Graphology API
- ✅ No API compliance issues found
- ✅ All callback signatures verified correct
- ✅ All nullable returns handled properly
- ✅ All design choices respected (string keys, no order guarantees, etc.)

**Test Files Verified**:
1. Graph_Test.res - Core operations ✅
2. NodesIter_Test.res - Node iteration ✅
3. EdgesIter_Test.res - Edge iteration ✅
4. NeighborsIter_Test.res - Neighbor iteration ✅
5. ShortestPath_Test.res - Shortest path algorithms ✅
6. Traversal_Test.res - BFS/DFS traversal ✅
7. Layout_Test.res - Layout algorithms ✅
8. Generators_Test.res - Graph generators ✅
9. Utils_Test.res - Utility functions ✅
10. SimplePath_Test.res - Simple path algorithms ✅
11. GEXF_Test.res - GEXF import/export ✅
12. SVG_Test.res - SVG rendering ✅

## Notes

- Some demo code in `Demo.res` includes commented-out sections and experimental iterator usage
- Warning suppressions (`@@warning("-26-32-44-27")`) are used in demo files
- The project includes several `.gexf` graph files for testing/demo purposes
- Ensure each test has only a single expect statement, using tuples where multiple results need to be tested
- Remember to use conventional commits spec for commit message
- Remember to run tests and make sure all tests passes before committing any changes
- **ALWAYS verify bindings against official documentation**: https://graphology.github.io is the single source of truth for the Graphology API
- Remember https://graphology.github.io/design-choices.html contains the design choices for Graphology - this is the authoritative source
