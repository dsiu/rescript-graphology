# ReScript-Graphology API Binding Reference

Complete inventory of all bound functions/methods across every module in the ReScript Graphology binding project.

## 1. Core Graph Module - `Graphology__Graph.res`

### Instantiation (Graph Constructors)

| Function | Description |
|----------|-------------|
| `makeGraph` | Create a graph with optional options |
| `makeDirectedGraph` | Create a directed graph |
| `makeUndirectedGraph` | Create an undirected graph |
| `makeMultiGraph` | Create a multigraph |
| `makeMultiDirectedGraph` | Create a directed multigraph |
| `makeMultiUndirectedGraph` | Create an undirected multigraph |
| `from` | Static Graph.from() method |
| `fromDirectedGraph` | Static DirectedGraph.from() method |
| `fromUndirectedGraph` | Static UndirectedGraph.from() method |
| `fromMultiGraph` | Static MultiGraph.from() method |
| `fromMultiDirectedGraph` | Static MultiDirectedGraph.from() method |
| `fromMultiUndirectedGraph` | Static MultiUndirectedGraph.from() method |

### Graph Properties (Getters)

| Function | Description |
|----------|-------------|
| `order` | Get number of nodes |
| `size` | Get number of edges |
| `type_` | Get graph type string |
| `multi` | Check if graph is multigraph |
| `allowSelfLoops` | Check if self-loops are allowed |
| `selfLoopCount` | Get count of self-loops |
| `implementation` | Get implementation string |

### Graph Read Operations

| Function | Description |
|----------|-------------|
| `hasNode` | Check if node exists |
| `hasEdge` | Check if edge exists |
| `edge` | Get edge key between two nodes |
| `degree` | Get node degree |
| `degreeWithoutSelfLoops` | Get degree excluding self-loops |
| `source` | Get source node of edge |
| `target` | Get target node of edge |
| `opposite` | Get opposite node of edge |
| `extremities` | Get both nodes of edge |
| `hasExtremity` | Check if edge has node as extremity |
| `isDirected` | Check if edge is directed |
| `isSelfLoop` | Check if edge is self-loop |
| `areNeighbors` | Check if two nodes are neighbors |

### Graph Mutation Operations

| Function | Description |
|----------|-------------|
| `addNode` | Add node with optional attributes |
| `mergeNode` | Add node or merge if exists |
| `updateNode` | Update node with function |
| `addEdge` | Add edge between nodes |
| `addEdgeWithKey` | Add edge with specific key |
| `mergeEdge` | Add edge or merge if exists |
| `mergeEdgeWithKey` | Add edge with key or merge |
| `updateEdge` | Update edge with function |
| `updateEdgeWithKey` | Update edge with key |
| `dropNode` | Remove node |
| `dropEdge` | Remove edge |
| `clear` | Remove all nodes and edges |
| `clearEdges` | Remove all edges |

### Graph Attributes

| Function | Description |
|----------|-------------|
| `getAttribute` | Get graph attribute by key |
| `getAttributes` | Get all graph attributes |
| `hasAttribute` | Check if attribute exists |
| `setAttribute` | Set graph attribute |
| `updateAttribute` | Update attribute with function |
| `removeAttribute` | Remove attribute |
| `replaceAttributes` | Replace all attributes |
| `mergeAttributes` | Merge attributes |
| `updateAttributes` | Update all attributes with function |

### Node Attributes

| Function | Description |
|----------|-------------|
| `getNodeAttribute` | Get node attribute |
| `getNodeAttributes` | Get all node attributes |
| `hasNodeAttribute` | Check if node has attribute |
| `setNodeAttribute` | Set node attribute |
| `updateNodeAttribute` | Update node attribute |
| `removeNodeAttribute` | Remove node attribute |
| `replaceNodeAttributes` | Replace all node attributes |
| `mergeNodeAttributes` | Merge node attributes |
| `updateNodeAttributes` | Update node attributes |
| `updateEachNodeAttributes` | Update attributes for each node |

### Edge Attributes

| Function | Description |
|----------|-------------|
| `getEdgeAttribute` | Get edge attribute |
| `getEdgeAttributes` | Get all edge attributes |
| `hasEdgeAttribute` | Check if edge has attribute |
| `setEdgeAttribute` | Set edge attribute |
| `updateEdgeAttribute` | Update edge attribute |
| `removeEdgeAttribute` | Remove edge attribute |
| `replaceEdgeAttributes` | Replace all edge attributes |
| `mergeEdgeAttributes` | Merge edge attributes |
| `updateEdgeAttributes` | Update edge attributes |
| `updateEachEdgeAttributes` | Update attributes for each edge |

### Serialization

| Function | Description |
|----------|-------------|
| `import` | Import graph from serialized format |
| `export` | Export graph to serialized format |
| `inspect` | Get string representation |

## 2. Node Iteration Module - `Graphology__Graph_NodesIter.res`

| Function | Description |
|----------|-------------|
| `nodes` | Get array of all nodes |
| `forEachNode` | Iterate over nodes with callback |
| `mapNodes` | Transform nodes with callback |
| `filterNodes` | Filter nodes with predicate |
| `reduceNodes` | Reduce nodes to accumulator |
| `findNode` | Find first node matching predicate |
| `someNode` | Check if any node matches predicate |
| `everyNode` | Check if all nodes match predicate |
| `nodeEntries` | Get iterator over node entries with attributes |

## 3. Edge Iteration Module - `Graphology__Graph_EdgesIter.res`

### Edge Array Operations

Each function exists in 7 directional variants: base, `in`, `out`, `inbound`, `outbound`, `directed`, `undirected`.

| Function | Description |
|----------|-------------|
| `edges` | Get array of edges |
| `inEdges` | Get incoming edges |
| `outEdges` | Get outgoing edges |
| `inboundEdges` | Get inbound edges |
| `outboundEdges` | Get outbound edges |
| `directedEdges` | Get directed edges |
| `undirectedEdges` | Get undirected edges |

### Edge Iteration Callbacks

All exist in 7 directional variants:

| Function | Description |
|----------|-------------|
| `forEachEdge` | Iterate over edges with callback |
| `mapEdges` | Transform edges with callback |
| `filterEdges` | Filter edges with predicate |
| `reduceEdges` | Reduce edges to accumulator |
| `findEdge` | Find first edge matching predicate |
| `someEdge` | Check if any edge matches predicate |
| `everyEdge` | Check if all edges match predicate |
| `edgeEntries` | Get iterator over edge entries |

## 4. Neighbor Iteration Module - `Graphology__Graph_NeighborsIter.res`

All functions exist in 7 directional variants: base, `in`, `out`, `inbound`, `outbound`, `directed`, `undirected`.

| Function | Description |
|----------|-------------|
| `neighbors` | Get array of neighbor nodes |
| `forEachNeighbor` | Iterate over neighbors with callback |
| `mapNeighbors` | Transform neighbors with callback |
| `filterNeighbors` | Filter neighbors with predicate |
| `reduceNeighbors` | Reduce neighbors to accumulator |
| `findNeighbor` | Find first neighbor matching predicate |
| `someNeighbor` | Check if any neighbor matches predicate |
| `everyNeighbor` | Check if all neighbors match predicate |
| `neighborEntries` | Get iterator over neighbor entries |

## 5. Shortest Path Module - `Graphology__ShortestPath.res`

### Unweighted Shortest Path

| Function | Description |
|----------|-------------|
| `Unweighted.bidirectional` | Bidirectional unweighted shortest path |
| `Unweighted.singleSource` | All paths from source node |
| `Unweighted.singleSourceLength` | All path lengths from source |
| `Unweighted.undirectedSingleSourceLength` | Path lengths treating graph as undirected |

### Dijkstra's Algorithm

| Function | Description |
|----------|-------------|
| `Dijkstra.bidirectional` | Bidirectional Dijkstra with optional weight |
| `Dijkstra.singleSource` | All weighted paths from source |

### A* Algorithm

| Function | Description |
|----------|-------------|
| `AStar.bidirectional` | A* shortest path with optional weight and heuristic |

### Utilities

| Function | Description |
|----------|-------------|
| `Utils.edgePathFromNodePath` | Convert node path to edge path |

## 6. Simple Path Module - `Graphology__SimplePath.res`

| Function | Description |
|----------|-------------|
| `allSimplePaths` | Find all simple paths between nodes |
| `allSimpleEdgePaths` | Find all simple edge paths between nodes |
| `allSimpleEdgeGroupPaths` | Find all simple edge group paths |

## 7. Traversal Module - `Graphology__Traversal.res`

| Function | Description |
|----------|-------------|
| `bfs` | BFS starting from all nodes |
| `bfsFromNode` | BFS starting from specific node |
| `dfs` | DFS starting from all nodes |
| `dfsFromNode` | DFS starting from specific node |

## 8. Layout Module - `Graphology__Layout.res`

| Function | Description |
|----------|-------------|
| `Circular.circular` | Compute circular layout |
| `Circular.assign` | Assign circular layout to graph |
| `Random.random` | Compute random layout |
| `Random.assign` | Assign random layout to graph |
| `CirclePack.circlePack` | Compute circle pack layout |
| `CirclePack.assign` | Assign circle pack layout to graph |
| `Rotation.rotation` | Compute rotated layout |
| `Rotation.assign` | Assign rotated layout to graph |
| `Utils.collectLayout` | Collect positions from node attributes |
| `Utils.collectLayoutAsFlatArray` | Collect positions as flat array |
| `Utils.assignLayout` | Assign positions to nodes from dict |
| `Utils.assignLayoutAsFlatArray` | Assign positions from flat array |

## 9. Generators Module - `Graphology__Generators.res`

| Category | Function | Description |
|----------|----------|-------------|
| Classic | `complete` | Complete graph with n nodes |
| Classic | `empty` | Empty graph with n nodes |
| Classic | `ladder` | Ladder graph |
| Classic | `path` | Path graph with n nodes |
| Community | `caveman` | Caveman graph |
| Community | `connectedCaveman` | Connected caveman graph |
| Random | `clusters` | Random clustered graph |
| Random | `erdosRenyi` | Erdos-Renyi random graph |
| Random | `girvanNewman` | Girvan-Newman random graph |
| Small | `krackhardtKite` | Krackhardt kite graph |
| Social | `florentineFamilies` | Florentine families graph |
| Social | `karateClub` | Karate club graph |

## 10. Utilities Module - `Graphology__Utils.res`

| Function | Description |
|----------|-------------|
| `isGraph` | Check if object is a graph |
| `inferMulti` | Detect if graph is multigraph |
| `inferType` | Infer graph type |
| `mergeClique` | Add clique pattern to graph |
| `mergeCycle` | Add cycle pattern to graph |
| `mergePath` | Add path pattern to graph |
| `mergeStar` | Add star pattern to graph |
| `renameGraphKeys` | Rename node and edge keys |
| `updateGraphKeys` | Update node and edge keys with functions |

## 11. GEXF Module - `Graphology__GEXF.res`

| Function | Description |
|----------|-------------|
| `write` | Write graph to GEXF format string |

## 12. SVG Module - `Graphology__SVG.res`

| Function | Description |
|----------|-------------|
| `render` | Render graph to SVG file with optional settings |

## Summary Statistics

| Category | Count |
|----------|-------|
| Core Graph Methods | 70+ |
| Iterator Methods (nodes, edges, neighbors) | 210+ |
| Algorithm Methods | 15+ |
| Layout Methods | 12 |
| Generator Methods | 12 |
| Utility Methods | 9 |
| Import/Export | 2 |
| **Total Bound Functions** | **300+** |
