# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-01-30

### Added

- Initial release with comprehensive ReScript bindings for Graphology
- **Core Graph Operations**: Full CRUD operations for nodes and edges with attributes
- **Graph Types**: Support for directed, undirected, multi-graphs, and mixed graphs
- **Algorithms**:
  - Shortest path: Dijkstra, A*, unweighted (bidirectional & single-source)
  - Simple path algorithms
  - Graph traversal: BFS, DFS
- **Layout Algorithms**: Circular, CirclePack, Rotation
- **Graph Generators**: Complete, path, cycle, clique, star, karate club, etc.
- **Import/Export**: GEXF format and SVG rendering
- **Iterator Support**: Native JavaScript Iterator protocol for nodes, edges, and neighbors
- **Utility Functions**: Graph merging, key renaming, type inference

### Technical Details

- Built for ReScript v12.x with ES modules
- Functor-based architecture for type safety
- 532 passing tests with comprehensive coverage
- Verified against official Graphology API documentation
