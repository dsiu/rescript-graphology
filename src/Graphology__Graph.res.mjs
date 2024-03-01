// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Graphology from "graphology";
import * as Caml_option from "rescript/lib/es6/caml_option.js";
import * as Graphology__SVG from "./Graphology__SVG.res.mjs";
import * as Graphology__Layout from "./Graphology__Layout.res.mjs";
import * as Graphology__Traversal from "./Graphology__Traversal.res.mjs";
import * as Graphology__SimplePath from "./Graphology__SimplePath.res.mjs";
import * as Graphology__ShortestPath from "./Graphology__ShortestPath.res.mjs";
import * as Graphology__Graph_EdgesIter from "./Graphology__Graph_EdgesIter.res.mjs";
import * as Graphology__Graph_NodesIter from "./Graphology__Graph_NodesIter.res.mjs";
import * as Graphology__Graph_NeighborsIter from "./Graphology__Graph_NeighborsIter.res.mjs";

function MakeGraph(C) {
  var NodesIter = Graphology__Graph_NodesIter.MakeNodesIter({});
  var EdgesIter = Graphology__Graph_EdgesIter.MakeEdgesIter({});
  var NeighborsIter = Graphology__Graph_NeighborsIter.MakeNeighborsIter({});
  var Layout = Graphology__Layout.MakeLayout({});
  var ShortestPath = Graphology__ShortestPath.MakeShortestPath({});
  var SimplePath = Graphology__SimplePath.MakeSimplePath({});
  var SVG = Graphology__SVG.MakeSVG({});
  var Traversal = Graphology__Traversal.MakeTraversal({});
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
          from: (function (prim0, prim1) {
              return Graphology.Graph.from(prim0, prim1 !== undefined ? Caml_option.valFromOption(prim1) : undefined);
            }),
          fromDirectedGraph: (function (prim) {
              return Graphology.DirectedGraph.from(prim);
            }),
          fromUndirectedGraph: (function (prim) {
              return Graphology.UndirectedGraph.from(prim);
            }),
          fromMultiGraph: (function (prim) {
              return Graphology.MultiGraph.from(prim);
            }),
          fromMultiDirectedGraph: (function (prim) {
              return Graphology.MultiDirectedGraph.from(prim);
            }),
          fromMultiUndirectedGraph: (function (prim) {
              return Graphology.MultiUndirectedGraph.from(prim);
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
          mergeNode: (function (prim0, prim1, prim2) {
              return prim0.mergeNode(prim1, prim2 !== undefined ? Caml_option.valFromOption(prim2) : undefined);
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
              return prim0.mergeEdgeWithKey(prim1, prim2, prim3, prim4 !== undefined ? Caml_option.valFromOption(prim4) : undefined);
            }),
          updateEdge: (function (prim0, prim1, prim2, prim3) {
              return prim0.updateEdge(prim1, prim2, prim3);
            }),
          updateEdgeWithKey: (function (prim0, prim1, prim2, prim3, prim4) {
              return prim0.updateEdgeWithKey(prim1, prim2, prim3, prim4);
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
          getAttribute: (function (prim0, prim1) {
              return prim0.getAttribute(prim1);
            }),
          getAttributes: (function (prim) {
              return prim.getAttributes();
            }),
          hasAttribute: (function (prim0, prim1) {
              return prim0.hasAttribute(prim1);
            }),
          setAttribute: (function (prim0, prim1, prim2) {
              prim0.setAttribute(prim1, prim2);
            }),
          updateAttribute: (function (prim0, prim1, prim2) {
              prim0.updateAttribute(prim1, prim2);
            }),
          removeAttribute: (function (prim0, prim1) {
              prim0.removeAttribute(prim1);
            }),
          replaceAttributes: (function (prim0, prim1) {
              prim0.replaceAttributes(prim1);
            }),
          mergeAttributes: (function (prim0, prim1) {
              prim0.mergeAttributes(prim1);
            }),
          updateAttributes: (function (prim0, prim1) {
              prim0.updateAttributes(prim1);
            }),
          getNodeAttribute: (function (prim0, prim1, prim2) {
              return prim0.getNodeAttribute(prim1, prim2);
            }),
          getNodeAttributes: (function (prim0, prim1) {
              return prim0.getNodeAttributes(prim1);
            }),
          hasNodeAttribute: (function (prim0, prim1, prim2) {
              return prim0.hasNodeAttribute(prim1, prim2);
            }),
          setNodeAttribute: (function (prim0, prim1, prim2, prim3) {
              prim0.setNodeAttribute(prim1, prim2, prim3);
            }),
          updateNodeAttribute: (function (prim0, prim1, prim2, prim3) {
              prim0.updateNodeAttribute(prim1, prim2, prim3);
            }),
          removeNodeAttribute: (function (prim0, prim1, prim2) {
              prim0.removeNodeAttribute(prim1, prim2);
            }),
          replaceNodeAttributes: (function (prim0, prim1, prim2) {
              prim0.replaceNodeAttributes(prim1, prim2);
            }),
          mergeNodeAttributes: (function (prim0, prim1, prim2) {
              prim0.mergeNodeAttributes(prim1, prim2);
            }),
          updateNodeAttributes: (function (prim0, prim1, prim2) {
              prim0.updateNodeAttributes(prim1, prim2);
            }),
          updateEachNodeAttributes: (function (prim0, prim1) {
              prim0.updateEachNodeAttributes(prim1);
            }),
          getEdgeAttribute: (function (prim0, prim1, prim2) {
              return prim0.getEdgeAttribute(prim1, prim2);
            }),
          getEdgeAttributes: (function (prim0, prim1) {
              return prim0.getEdgeAttributes(prim1);
            }),
          hasEdgeAttribute: (function (prim0, prim1, prim2) {
              return prim0.hasEdgeAttribute(prim1, prim2);
            }),
          setEdgeAttribute: (function (prim0, prim1, prim2, prim3) {
              prim0.setEdgeAttribute(prim1, prim2, prim3);
            }),
          updateEdgeAttribute: (function (prim0, prim1, prim2, prim3) {
              prim0.updateEdgeAttribute(prim1, prim2, prim3);
            }),
          removeEdgeAttribute: (function (prim0, prim1, prim2) {
              prim0.removeEdgeAttribute(prim1, prim2);
            }),
          replaceEdgeAttributes: (function (prim0, prim1, prim2) {
              prim0.replaceEdgeAttributes(prim1, prim2);
            }),
          mergeEdgeAttributes: (function (prim0, prim1, prim2) {
              prim0.mergeEdgeAttributes(prim1, prim2);
            }),
          updateEdgeAttributes: (function (prim0, prim1, prim2) {
              prim0.updateEdgeAttributes(prim1, prim2);
            }),
          updateEachEdgeAttributes: (function (prim0, prim1) {
              prim0.updateEachEdgeAttributes(prim1);
            }),
          NodesIter: NodesIter,
          EdgesIter: EdgesIter,
          NeighborsIter: NeighborsIter,
          $$import: (function (prim0, prim1, prim2) {
              prim0.import(prim1, prim2 !== undefined ? Caml_option.valFromOption(prim2) : undefined);
            }),
          $$export: (function (prim) {
              return prim.export();
            }),
          inspect: (function (prim) {
              return prim.inspect();
            }),
          Layout: Layout,
          ShortestPath: ShortestPath,
          SimplePath: SimplePath,
          SVG: SVG,
          Traversal: Traversal
        };
}

export {
  MakeGraph ,
}
/* graphology Not a pure module */
