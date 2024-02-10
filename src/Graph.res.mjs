// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Graphology from "graphology";
import * as Caml_option from "rescript/lib/es6/caml_option.js";
import * as GraphologyTraversal from "graphology-traversal";
import * as GraphologySimplePath from "graphology-simple-path";
import * as GraphologyShortestPath from "graphology-shortest-path";

function MakeGraph(C) {
  return {
          makeGraph: (function (prim) {
              return new (Graphology.default.Graph)(prim !== undefined ? Caml_option.valFromOption(prim) : undefined);
            }),
          makeDirectedGraph: (function (prim) {
              return new (Graphology.default.DirectedGraph)();
            }),
          makeUndirectedGraph: (function (prim) {
              return new (Graphology.default.UndirectedGraph)();
            }),
          makeMultiGraph: (function (prim) {
              return new (Graphology.default.MultiGraph)();
            }),
          makeMultiDirectedGraph: (function (prim) {
              return new Graphology.MultiDirectedGraph();
            }),
          makeMultiUndirectedGraph: (function (prim) {
              return new Graphology.MultiUndirectedGraph();
            }),
          order: (function (prim) {
              return prim.order;
            }),
          size: (function (prim) {
              return prim.size;
            }),
          type_: (function (prim) {
              return prim.type;
            }),
          multi: (function (prim) {
              return prim.multi;
            }),
          allowSelfLoops: (function (prim) {
              return prim.allowSelfLoops;
            }),
          selfLoopCount: (function (prim) {
              return prim.selfLoopCount;
            }),
          implementation: (function (prim) {
              return prim.implementation;
            }),
          hasNode: (function (prim0, prim1) {
              return prim0.hasNode(prim1);
            }),
          hasEdge: (function (prim0, prim1) {
              return prim0.hasEdge(prim1);
            }),
          edge: (function (prim0, prim1, prim2) {
              return prim0.edge(prim1, prim2);
            }),
          degree: (function (prim0, prim1) {
              return prim0.degree(prim1);
            }),
          degreeWithoutSelfLoops: (function (prim0, prim1) {
              return prim0.degreeWithoutSelfLoops(prim1);
            }),
          source: (function (prim0, prim1) {
              return prim0.source(prim1);
            }),
          target: (function (prim0, prim1) {
              return prim0.target(prim1);
            }),
          opposite: (function (prim0, prim1, prim2) {
              return prim0.opposite(prim1, prim2);
            }),
          extremities: (function (prim0, prim1) {
              return prim0.extremities(prim1);
            }),
          hasExtremity: (function (prim0, prim1, prim2) {
              return prim0.hasExtremity(prim1, prim2);
            }),
          isDirected: (function (prim0, prim1) {
              return prim0.isDirected(prim1);
            }),
          isSelfLoop: (function (prim0, prim1) {
              return prim0.isSelfLoop(prim1);
            }),
          areNeighbors: (function (prim0, prim1, prim2) {
              return prim0.areNeighbors(prim1, prim2);
            }),
          addNode: (function (prim0, prim1, prim2) {
              prim0.addNode(prim1, prim2 !== undefined ? Caml_option.valFromOption(prim2) : undefined);
            }),
          updateNode: (function (prim0, prim1, prim2) {
              return prim0.updateNode(prim1, prim2);
            }),
          addEdge: (function (prim0, prim1, prim2, prim3) {
              prim0.addEdge(prim1, prim2, prim3 !== undefined ? Caml_option.valFromOption(prim3) : undefined);
            }),
          addEdgeWithKey: (function (prim0, prim1, prim2, prim3, prim4) {
              prim0.addEdgeWithKey(prim1, prim2, prim3, prim4 !== undefined ? Caml_option.valFromOption(prim4) : undefined);
            }),
          mergeEdge: (function (prim0, prim1, prim2, prim3) {
              return prim0.mergeEdge(prim1, prim2, prim3 !== undefined ? Caml_option.valFromOption(prim3) : undefined);
            }),
          mergeEdgeWithKey: (function (prim0, prim1, prim2, prim3, prim4) {
              return mergeEdgeWithKey(prim0, prim1, prim2, prim3, prim4 !== undefined ? Caml_option.valFromOption(prim4) : undefined);
            }),
          updateEdge: (function (prim0, prim1, prim2, prim3) {
              return updateEdge(prim0, prim1, prim2, prim3);
            }),
          updateEdgeWithKey: (function (prim0, prim1, prim2, prim3, prim4) {
              return updateEdgeWithKey(prim0, prim1, prim2, prim3, prim4);
            }),
          dropEdge: (function (prim0, prim1) {
              prim0.dropEdge(prim1);
            }),
          dropNode: (function (prim0, prim1) {
              prim0.dropNode(prim1);
            }),
          clear: (function (prim) {
              prim.clear();
            }),
          clearEdges: (function (prim) {
              prim.clearEdges();
            }),
          nodes: (function (prim) {
              return prim.nodes();
            }),
          forEachNode: (function (prim0, prim1) {
              prim0.forEachNode(prim1);
            }),
          mapNodes: (function (prim0, prim1) {
              return prim0.mapNodes(prim1);
            }),
          filterNodes: (function (prim0, prim1) {
              return prim0.filterNodes(prim1);
            }),
          reduceNodes: (function (prim0, prim1, prim2) {
              return prim0.reduceNodes(prim1, prim2);
            }),
          findNode: (function (prim0, prim1) {
              return prim0.findNode(prim1);
            }),
          someNode: (function (prim0, prim1) {
              return prim0.someNode(prim1);
            }),
          everyNode: (function (prim0, prim1) {
              return prim0.everyNode(prim1);
            }),
          nodeEntries: (function (prim) {
              return prim.nodeEntries();
            }),
          edges: (function (prim) {
              return prim.edges();
            }),
          forEachEdge: (function (prim0, prim1) {
              prim0.forEachEdge(prim1);
            }),
          mapEdges: (function (prim0, prim1) {
              return prim0.mapEdges(prim1);
            }),
          filterEdges: (function (prim0, prim1) {
              return prim0.filterEdges(prim1);
            }),
          reduceEdges: (function (prim0, prim1, prim2) {
              return prim0.reduceEdges(prim1, prim2);
            }),
          findEdge: (function (prim0, prim1) {
              return prim0.findEdge(prim1);
            }),
          someEdge: (function (prim0, prim1) {
              return prim0.someEdge(prim1);
            }),
          everyEdge: (function (prim0, prim1) {
              return prim0.everyEdge(prim1);
            }),
          edgeEntries: (function (prim) {
              return prim.edgeEntries();
            }),
          neighbors: (function (prim) {
              return prim.neighbors();
            }),
          forEachNeighbor: (function (prim0, prim1) {
              prim0.forEachNeighbor(prim1);
            }),
          mapNeighbors: (function (prim0, prim1) {
              return prim0.mapNeighbors(prim1);
            }),
          filterNeighbors: (function (prim0, prim1) {
              return prim0.filterNeighbors(prim1);
            }),
          reduceNeighbors: (function (prim0, prim1, prim2) {
              return prim0.reduceNeighbors(prim1, prim2);
            }),
          findNeighbor: (function (prim0, prim1) {
              return prim0.findNeighbor(prim1);
            }),
          someNeighbor: (function (prim0, prim1) {
              return prim0.someNeighbor(prim1);
            }),
          everyNeighbor: (function (prim0, prim1) {
              return prim0.everyNeighbor(prim1);
            }),
          neighborEntries: (function (prim) {
              return prim.neighborEntries();
            }),
          inspect: (function (prim) {
              return prim.inspect();
            }),
          ShortestPath: {
            Unweighted: {
              bidirectional: (function (prim0, prim1, prim2) {
                  return GraphologyShortestPath.unweighted.bidirectional(prim0, prim1, prim2);
                }),
              singleSource: (function (prim0, prim1) {
                  return GraphologyShortestPath.unweighted.singleSource(prim0, prim1);
                }),
              singleSourceLength: (function (prim0, prim1) {
                  return GraphologyShortestPath.unweighted.singleSourceLength(prim0, prim1);
                }),
              undirectedSingleSourceLength: (function (prim0, prim1) {
                  return GraphologyShortestPath.unweighted.undirectedSingleSourceLength(prim0, prim1);
                })
            },
            Dijkstra: {
              bidirectional: (function (prim0, prim1, prim2, prim3) {
                  return GraphologyShortestPath.dijkstra.bidirectional(prim0, prim1, prim2, prim3.VAL);
                }),
              singleSource: (function (prim0, prim1) {
                  return GraphologyShortestPath.dijkstra.singleSource(prim0, prim1);
                })
            },
            Utils: {
              edgePathFromNodePath: (function (prim0, prim1) {
                  return GraphologyShortestPath.utils.edgePathFromNodePath(prim0, prim1);
                })
            }
          },
          SimplePath: {
            allSimplePaths: (function (prim0, prim1, prim2, prim3) {
                return GraphologySimplePath.allSimplePaths(prim0, prim1, prim2, prim3 !== undefined ? Caml_option.valFromOption(prim3) : undefined);
              }),
            allSimpleEdgePaths: (function (prim0, prim1, prim2, prim3) {
                return GraphologySimplePath.allSimpleEdgePaths(prim0, prim1, prim2, prim3 !== undefined ? Caml_option.valFromOption(prim3) : undefined);
              }),
            allSimpleEdgeGroupPaths: (function (prim0, prim1, prim2, prim3) {
                return GraphologySimplePath.allSimpleEdgeGroupPaths(prim0, prim1, prim2, prim3 !== undefined ? Caml_option.valFromOption(prim3) : undefined);
              })
          },
          Traversal: {
            bfs: (function (prim0, prim1) {
                GraphologyTraversal.bfs(prim0, prim1);
              }),
            bfsFromNode: (function (prim0, prim1, prim2) {
                GraphologyTraversal.bfsFromNode(prim0, prim1, prim2);
              }),
            dfs: (function (prim0, prim1) {
                GraphologyTraversal.dfs(prim0, prim1);
              }),
            dfsFromNode: (function (prim0, prim1, prim2) {
                GraphologyTraversal.dfsFromNode(prim0, prim1, prim2);
              })
          }
        };
}

export {
  MakeGraph ,
}
/* graphology Not a pure module */
