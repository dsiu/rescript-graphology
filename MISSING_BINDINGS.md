# Missing Graphology Bindings

Comparison of the official Graphology API against the existing ReScript bindings. Identifies unbound packages and missing methods within partially-bound modules.

## 1. Entirely Missing Standard Library Packages

### graphology-metrics (`graphology-metrics`)

Graph analysis metrics.

**Graph-level metrics:**
- `density`, `diameter`, `modularity`, `simpleSize`, `weightedSize`, `nodeExtent`, `edgeExtent`

**Node metrics:**
- `weightedDegree`, `weightedInDegree`, `weightedOutDegree`, `weightedInboundDegree`, `weightedOutboundDegree`, `weightedUndirectedDegree`, `weightedDirectedDegree`, `eccentricity`

**Edge metrics:**
- `disparity`, `simmelianStrength`, `chiSquare`, `gSquare`

**Centrality:**
- `betweennessCentrality`, `edgeBetweennessCentrality`, `closenessCentrality`, `degreeCentrality`, `inDegreeCentrality`, `outDegreeCentrality`, `eigenvectorCentrality`, `hits`, `pagerank`

**Layout quality:**
- `edgeUniformity`, `neighborhoodPreservation`, `stress`

---

### graphology-communities-louvain (`graphology-communities-louvain`)

Community detection via Louvain algorithm.

- `louvain` - returns community partition mapping
- `louvain.assign` - assigns communities as node attributes
- `louvain.detailed` - returns detailed result with modularity, dendrogram, move stats

---

### graphology-components (`graphology-components`)

Connected component analysis.

- `connectedComponents`
- `forEachConnectedComponent`
- `forEachConnectedComponentOrder`
- `countConnectedComponents`
- `largestConnectedComponent`
- `largestConnectedComponentSubgraph`
- `cropToLargestConnectedComponent`
- `stronglyConnectedComponents`

---

### graphology-operators (`graphology-operators`)

Graph transformation operators.

**Unary:** `subgraph`, `reverse`
**Binary:** `disjointUnion`, `union`
**Cast:** `toDirected`, `toMixed`, `toMulti`, `toSimple`, `toUndirected`

---

### graphology-dag (`graphology-dag`)

Directed acyclic graph utilities.

- `hasCycle`
- `willCreateCycle`
- `topologicalSort`
- `topologicalGenerations`
- `forEachNodeInTopologicalOrder`
- `forEachTopologicalGeneration`

---

### graphology-cores (`graphology-cores`)

K-core decomposition.

- `coreNumber`
- `kCore`
- `kShell`
- `kCrust`
- `kCorona`
- `kTruss`
- `onionLayers`

---

### graphology-assertions (`graphology-assertions`)

Graph comparison assertions (except `isGraph` which is in Utils).

- `isGraphConstructor`
- `haveSameNodes`, `haveSameNodesDeep`
- `areSameGraphs`, `areSameGraphsDeep`
- `haveSameEdges`, `haveSameEdgesDeep`

---

### graphology-bipartite (`graphology-bipartite`)

- `isBipartiteBy`

---

### graphology-graphml (`graphology-graphml`)

GraphML format parser/writer.

- `parse`
- `write`

---

### graphology-layout-force (`graphology-layout-force`)

Force-directed layout.

- `forceLayout` - synchronous layout computation
- `forceLayout.assign` - assign positions to nodes
- `ForceSupervisor` class (`start`, `stop`, `kill`, `isRunning`)

---

### graphology-layout-forceatlas2 (`graphology-layout-forceatlas2`)

ForceAtlas2 layout algorithm.

- `forceAtlas2` - synchronous computation
- `forceAtlas2.assign` - assign positions
- `forceAtlas2.inferSettings` - auto-configure settings
- `FA2Layout` worker class (`start`, `stop`, `kill`, `isRunning`)

---

### graphology-layout-noverlap (`graphology-layout-noverlap`)

Anti-collision layout.

- `noverlap` - synchronous computation
- `noverlap.assign` - assign positions
- `NoverlapLayout` worker class (`start`, `stop`, `kill`, `isRunning`)

---

### graphology-canvas (`graphology-canvas`)

Canvas rendering.

---

### graphology-indices (`graphology-indices`)

Specialized graph indices (neighborhood index, Louvain index).

---

## 2. Missing Methods in Core Graph Module

### Missing Properties

| Method | Description |
|--------|-------------|
| `directedSize` | Number of directed edges |
| `undirectedSize` | Number of undirected edges |
| `directedSelfLoopCount` | Number of directed self-loops |
| `undirectedSelfLoopCount` | Number of undirected self-loops |

### Missing Read Methods

| Method | Description |
|--------|-------------|
| `inDegree` | Incoming edge count |
| `outDegree` | Outgoing edge count |
| `directedDegree` | Directed edge count (in + out) |
| `undirectedDegree` | Undirected edge count |
| `inDegreeWithoutSelfLoops` | Incoming edges minus self-loops |
| `outDegreeWithoutSelfLoops` | Outgoing edges minus self-loops |
| `directedDegreeWithoutSelfLoops` | Directed edges minus self-loops |
| `undirectedDegreeWithoutSelfLoops` | Undirected edges minus self-loops |
| `isUndirected` | Check if edge is undirected |
| `directedEdge` | Get directed edge between two nodes |
| `undirectedEdge` | Get undirected edge between two nodes |
| `hasDirectedEdge` | Check directed edge existence |
| `hasUndirectedEdge` | Check undirected edge existence |
| `areDirectedNeighbors` | Check directed adjacency |
| `areUndirectedNeighbors` | Check undirected adjacency |
| `areInNeighbors` | Check in-neighbor relationship |
| `areOutNeighbors` | Check out-neighbor relationship |
| `areInboundNeighbors` | Check inbound neighbor (in + undirected) |
| `areOutboundNeighbors` | Check outbound neighbor (out + undirected) |

### Missing Mutation Methods

| Method | Description |
|--------|-------------|
| `addDirectedEdge` | Add a directed edge |
| `addUndirectedEdge` | Add an undirected edge |
| `addDirectedEdgeWithKey` | Add directed edge with explicit key |
| `addUndirectedEdgeWithKey` | Add undirected edge with explicit key |
| `mergeDirectedEdge` | Merge a directed edge |
| `mergeUndirectedEdge` | Merge an undirected edge |
| `mergeDirectedEdgeWithKey` | Merge directed edge with key |
| `mergeUndirectedEdgeWithKey` | Merge undirected edge with key |
| `updateDirectedEdge` | Update a directed edge |
| `updateUndirectedEdge` | Update an undirected edge |
| `updateDirectedEdgeWithKey` | Update directed edge with key |
| `updateUndirectedEdgeWithKey` | Update undirected edge with key |
| `dropDirectedEdge` | Drop a directed edge by source/target |
| `dropUndirectedEdge` | Drop an undirected edge by source/target |

### Missing Utility Methods

| Method | Description |
|--------|-------------|
| `copy` | Deep copy the graph |
| `emptyCopy` | Copy graph structure without nodes/edges |
| `nullCopy` | Copy graph settings only |
| `toJSON` | Serialize graph to JSON |

---

## 3. Missing Methods in Already-Bound Modules

### Traversal (`Graphology__Traversal.res`)

- Missing `mode` option parameter for early termination (returning `true` from callback to stop traversal)

### Generators (`Graphology__Generators.res`)

- `star` - Star graph generator
- `barabasiAlbert` - Barabasi-Albert preferential attachment generator

### Utils (`Graphology__Utils.res`)

- `isGraphConstructor`
- `addEdge`, `copyEdge`, `mergeEdge`, `updateEdge` (edge helpers)
- `addNode`, `copyNode` (node helpers)

---

## 4. Summary

| Package | npm name | Status | Priority |
|---------|----------|--------|----------|
| graphology (core) | `graphology` | Partially bound (~35 methods missing) | High |
| graphology-metrics | `graphology-metrics` | Not bound | High |
| graphology-communities-louvain | `graphology-communities-louvain` | Not bound | High |
| graphology-components | `graphology-components` | Not bound | High |
| graphology-operators | `graphology-operators` | Not bound | High |
| graphology-dag | `graphology-dag` | Not bound | Medium |
| graphology-cores | `graphology-cores` | Not bound | Medium |
| graphology-layout-forceatlas2 | `graphology-layout-forceatlas2` | Not bound | Medium |
| graphology-layout-force | `graphology-layout-force` | Not bound | Medium |
| graphology-layout-noverlap | `graphology-layout-noverlap` | Not bound | Medium |
| graphology-assertions | `graphology-assertions` | Not bound (except `isGraph`) | Low |
| graphology-graphml | `graphology-graphml` | Not bound | Low |
| graphology-bipartite | `graphology-bipartite` | Not bound | Low |
| graphology-canvas | `graphology-canvas` | Not bound | Low |
| graphology-indices | `graphology-indices` | Not bound | Low |
| graphology-generators | `graphology-generators` | Mostly bound (2 missing) | Low |
| graphology-traversal | `graphology-traversal` | Mostly bound (missing options) | Low |
| graphology-utils | `graphology-utils` | Mostly bound | Low |
| graphology-shortest-path | `graphology-shortest-path` | Fully bound | Done |
| graphology-simple-path | `graphology-simple-path` | Fully bound | Done |
| graphology-layout | `graphology-layout` | Fully bound | Done |
| graphology-gexf | `graphology-gexf` | Fully bound | Done |
| graphology-svg | `graphology-svg` | Fully bound | Done |
