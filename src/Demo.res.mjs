// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Nodefs from "node:fs";
import * as Graphology__Graph from "./Graphology__Graph.res.mjs";

function log(prim) {
  console.log(prim);
}

function log2(prim0, prim1) {
  console.log(prim0, prim1);
}

function stringToFile(str, fileName) {
  Nodefs.writeFileSync(fileName, Buffer.from(str));
}

var G = Graphology__Graph.MakeGraph({});

var g = G.makeGraph(undefined);

G.addNode(g, "John", undefined);

var H = Graphology__Graph.MakeGraph({});

var h = H.makeGraph(undefined);

console.log("hi");

H.addNode(h, "John", {
      lastName: "Doe"
    });

H.addNode(h, "Peter", {
      lastName: "Egg"
    });

H.addNode(h, "Mary", undefined);

H.addEdge(h, "John", "Peter", {
      dist: 23
    });

H.addEdge(h, "Peter", "Mary", {
      dist: 12
    });

((function (__x) {
        console.log("inspect", __x);
      })(H.inspect(h)));

H.NodesIter.forEachNode(h, (function (n, attr) {
        console.log(n);
        console.log(attr);
      }));

((function (__x) {
        console.log("mapNodes", __x);
      })(H.NodesIter.mapNodes(h, (function (n, attr) {
              console.log(n);
              console.log(attr);
              return 1;
            }))));

var iter = H.NodesIter.nodeEntries(h);

((function (__x) {
        console.log("iter", __x);
      })(iter));

var arr = Array.from(iter);

((function (__x) {
        console.log("arr", __x);
      })(arr));

var arr2 = arr.map(function (param) {
      var attributes = param.attributes;
      var node = param.node;
      console.log(node);
      console.log(attributes);
      return node + " - " + attributes.lastName;
    });

console.log(arr2);

H.Traversal.bfs(h, (function (n, att, depth) {
        console.log(n);
        console.log(att);
        console.log(depth);
      }));

H.Traversal.dfs(h, (function (n, att, depth) {
        console.log(n);
        console.log(att);
        console.log(depth);
      }));

H.Traversal.bfsFromNode(h, "John", (function (n, att, depth) {
        console.log(n);
        console.log(att);
        console.log(depth);
      }));

((function (__x) {
        console.log("Unweighted bidirection", __x);
      })(H.ShortestPath.Unweighted.bidirectional(h, "John", "Mary")));

((function (__x) {
        console.log("Unweighted singleSource", __x);
      })(H.ShortestPath.Unweighted.singleSource(h, "John")));

((function (__x) {
        console.log("Unweighted singleSourceLength", __x);
      })(H.ShortestPath.Unweighted.singleSourceLength(h, "John")));

((function (__x) {
        console.log("Unweighted undirectedSingleSourceLength", __x);
      })(H.ShortestPath.Unweighted.undirectedSingleSourceLength(h, "John")));

((function (__x) {
        console.log("Dijkstra singleSource", __x);
      })(H.ShortestPath.Dijkstra.singleSource(h, "John", undefined)));

var dijss = H.ShortestPath.Dijkstra.singleSource(h, "John", undefined);

((function (__x) {
        console.log("k", __x);
      })(Object.keys(dijss)));

((function (__x) {
        console.log("v", __x);
      })(Object.values(dijss)));

((function (__x) {
        console.log("John", __x);
      })(dijss["John"]));

((function (__x) {
        console.log("Peter", __x);
      })(dijss["Peter"]));

((function (__x) {
        console.log("Mary", __x);
      })(dijss["Mary"]));

var T = Graphology__Graph.MakeGraph({});

var t = T.makeGraph(undefined);

T.addNode(t, [
      0,
      0
    ], {
      lastName: "Doe"
    });

T.addNode(t, [
      1,
      1
    ], {
      lastName: "Egg"
    });

T.addNode(t, [
      2,
      2
    ], {
      lastName: "Klein"
    });

T.addEdge(t, [
      0,
      0
    ], [
      1,
      1
    ], {
      dist: 23
    });

T.addEdge(t, [
      1,
      1
    ], [
      2,
      2
    ], {
      dist: 12
    });

var G$1 = Graphology__Graph.MakeGraph({});

var g$1 = G$1.makeGraph(undefined);

G$1.addNode(g$1, 1, undefined);

G$1.addNode(g$1, 2, undefined);

G$1.addNode(g$1, 3, undefined);

G$1.addNode(g$1, 4, undefined);

G$1.addEdge(g$1, 1, 2, {
      weight1: 3
    });

G$1.addEdge(g$1, 1, 3, {
      weight1: 2
    });

G$1.addEdge(g$1, 2, 4, {
      weight1: 1
    });

G$1.addEdge(g$1, 3, 4, {
      weight1: 1
    });

((function (__x) {
        console.log("edge", __x);
      })(G$1.edge(g$1, 1, 2)));

((function (__x) {
        console.log("edges", __x);
      })(G$1.EdgesIter.edges(g$1, "All")));

((function (__x) {
        console.log("edges", __x);
      })(G$1.EdgesIter.edges(g$1, {
            TAG: "Node",
            _0: 1
          })));

((function (__x) {
        console.log("inspect", __x);
      })(G$1.inspect(g$1)));

((function (__x) {
        console.log("Dijkstra singleSource", __x);
      })(G$1.ShortestPath.Dijkstra.singleSource(g$1, 1, undefined)));

((function (__x) {
        console.log("Dijkstra bidirectional", __x);
      })(G$1.ShortestPath.Dijkstra.bidirectional(g$1, 1, 4, {
            NAME: "Attr",
            VAL: "weight1"
          })));

var ps = G$1.ShortestPath.Dijkstra.bidirectional(g$1, 1, 4, {
      NAME: "Attr",
      VAL: "weight1"
    });

var es = G$1.ShortestPath.Utils.edgePathFromNodePath(g$1, ps);

((function (__x) {
        console.log("es", __x);
      })(es));

var G$2 = Graphology__Graph.MakeGraph({});

var g$2 = G$2.makeGraph(undefined);

G$2.addNode(g$2, 1, undefined);

G$2.addNode(g$2, 2, undefined);

G$2.addNode(g$2, 3, undefined);

G$2.addNode(g$2, 4, undefined);

G$2.addEdge(g$2, 1, 2, undefined);

G$2.addEdge(g$2, 1, 3, undefined);

G$2.addEdge(g$2, 2, 4, undefined);

G$2.addEdge(g$2, 3, 4, undefined);

((function (__x) {
        console.log("inspect - layout", __x);
      })(G$2.inspect(g$2)));

var pos = G$2.Layout.Circular.circular(g$2, undefined);

((function (__x) {
        console.log("pos", __x);
      })(pos));

G$2.Layout.Circular.assign(g$2, {
      center: 0.7,
      scale: 20.0
    });

G$2.SVG.render(g$2, "./graph.svg", {
      margin: 20,
      width: 4096,
      height: 4096
    }, (function () {
        console.log("DONE writing to file");
      }));

((function (__x) {
        console.log("inspect - layout", __x);
      })(G$2.inspect(g$2)));

var G$3 = Graphology__Graph.MakeGraph({});

var g$3 = G$3.makeGraph({
      allowSelfLoops: false,
      multi: true,
      type: "directed"
    });

var prim0 = G$3.inspect(g$3);

console.log(prim0, "inspect");

var G$4 = Graphology__Graph.MakeGraph({});

var g$4 = G$4.makeGraph(undefined);

var match = G$4.mergeNode(g$4, "John", undefined);

console.log(match[0], match[1]);

var match$1 = G$4.mergeNode(g$4, "John", undefined);

console.log(match$1[0], match$1[1]);

var match$2 = G$4.mergeNode(g$4, "John", {
      eyes: "blue"
    });

console.log(match$2[0], match$2[1]);

var g$5 = G$4.makeGraph(undefined);

G$4.mergeEdgeWithKey(g$5, "T->E", "Thomas", "Eric", {
      type: "KNOWS"
    });

G$4.setAttribute(g$5, "name", "My Graph");

var exported = G$4.$$export(g$5);

((function (__x) {
        console.log("exported", __x);
      })(exported));

var h$1 = G$4.makeGraph(undefined);

G$4.$$import(h$1, exported, undefined);

G$4.addNode(h$1, "John", undefined);

((function (__x) {
        console.log("imported", __x);
      })(h$1));

var G$5 = Graphology__Graph.MakeGraph({});

var g$6 = G$5.makeGraph({
      multi: true
    });

G$5.mergeEdgeWithKey(g$6, "T->R", "Thomas", "Rosaline", undefined);

G$5.mergeEdgeWithKey(g$6, "T->E", "Thomas", "Emmett", undefined);

G$5.mergeEdgeWithKey(g$6, "C->T", "Catherine", "Thomas", undefined);

G$5.mergeEdgeWithKey(g$6, "R->C", "Rosaline", "Catherine", undefined);

G$5.mergeEdgeWithKey(g$6, "J->D1", "John", "Daniel", undefined);

G$5.mergeEdgeWithKey(g$6, "J->D2", "John", "Daniel", undefined);

((function (__x) {
        console.log("g-G.edges", __x);
      })(G$5.EdgesIter.edges(g$6, "All")));

((function (__x) {
        console.log("g-G.edges('Thomas')", __x);
      })(G$5.EdgesIter.edges(g$6, {
            TAG: "Node",
            _0: "Thomas"
          })));

((function (__x) {
        console.log("g-G.edges('John', 'Daniel')", __x);
      })(G$5.EdgesIter.edges(g$6, {
            TAG: "FromTo",
            _0: "John",
            _1: "Daniel"
          })));

var G$6 = Graphology__Graph.MakeGraph({});

var g$7 = G$6.makeGraph(undefined);

G$6.mergeEdge(g$7, "1", "2", undefined);

G$6.mergeEdge(g$7, "1", "3", undefined);

G$6.mergeEdge(g$7, "1", "4", undefined);

G$6.mergeEdge(g$7, "2", "5", undefined);

G$6.mergeEdge(g$7, "2", "6", undefined);

G$6.mergeEdge(g$7, "4", "7", undefined);

G$6.mergeEdge(g$7, "4", "8", undefined);

G$6.mergeEdge(g$7, "5", "9", undefined);

G$6.mergeEdge(g$7, "5", "10", undefined);

G$6.mergeEdge(g$7, "7", "11", undefined);

G$6.mergeEdge(g$7, "7", "12", undefined);

G$6.GEXF.write(g$7, {
      formatNode: (function (key, attributes) {
          return {
                  label: key
                };
        }),
      formatEdge: (function (key, attributes) {
          return {
                  weight: attributes.weight
                };
        }),
      version: "1.3"
    });

((function (__x) {
        console.log("inspect", __x);
      })(G$6.inspect(g$7)));

var gexfStr = G$6.GEXF.write(g$7, {
      version: "1.3"
    });

console.log("---");

((function (__x) {
        console.log("gexfStr", __x);
      })(gexfStr));

console.log("---");

console.log("bfs");

G$6.Traversal.bfs(g$7, (function (n, att, depth) {
        console.log(n, depth);
      }));

var G$7 = Graphology__Graph.MakeGraph({});

var g$8 = G$7.makeGraph(undefined);

G$7.Utils.mergeClique(g$8, [
      1,
      2,
      3
    ]);

var prim = G$7.EdgesIter.edges(g$8, "All").map(function (e) {
      return G$7.extremities(g$8, e);
    });

console.log(prim);

var g$9 = G$7.makeGraph(undefined);

G$7.Utils.mergeCycle(g$9, [
      1,
      2,
      3,
      4,
      5
    ]);

var prim$1 = G$7.EdgesIter.edges(g$9, "All").map(function (e) {
      return G$7.extremities(g$9, e);
    });

console.log(prim$1);

var g$10 = G$7.makeGraph(undefined);

G$7.Utils.mergePath(g$10, [
      1,
      2,
      3,
      4,
      5
    ]);

var prim$2 = G$7.EdgesIter.edges(g$10, "All").map(function (e) {
      return G$7.extremities(g$10, e);
    });

console.log(prim$2);

var g$11 = G$7.makeGraph(undefined);

G$7.Utils.mergeStar(g$11, [
      1,
      2,
      3,
      4,
      5
    ]);

var prim$3 = G$7.EdgesIter.edges(g$11, "All").map(function (e) {
      return G$7.extremities(g$11, e);
    });

console.log(prim$3);

var G$8 = Graphology__Graph.MakeGraph({});

var g$12 = G$8.makeGraph(undefined);

G$8.addNode(g$12, "Martha", undefined);

G$8.addNode(g$12, "Catherine", undefined);

G$8.addNode(g$12, "John", undefined);

G$8.addEdgeWithKey(g$12, "M->C", "Martha", "Catherine", undefined);

G$8.addEdgeWithKey(g$12, "C->J", "Catherine", "John", undefined);

var nodeMap = {};

nodeMap["Martha"] = 1;

nodeMap["Catherine"] = 2;

nodeMap["John"] = 3;

var edgeMap = {};

edgeMap["M->C"] = "rel1";

edgeMap["C->J"] = "rel2";

var renamedGraph = G$8.Utils.renameGraphKeys(g$12, nodeMap, edgeMap);

var prim$4 = G$8.NodesIter.nodes(renamedGraph);

console.log(prim$4);

var prim$5 = G$8.EdgesIter.edges(renamedGraph, "All");

console.log(prim$5);

var G$9 = Graphology__Graph.MakeGraph({});

var g$13 = G$9.makeGraph(undefined);

G$9.addNode(g$13, "Martha", undefined);

G$9.addNode(g$13, "Catherine", undefined);

G$9.addNode(g$13, "John", undefined);

G$9.addEdgeWithKey(g$13, "M->C", "Martha", "Catherine", undefined);

G$9.addEdgeWithKey(g$13, "C->J", "Catherine", "John", undefined);

var updatedGraph = G$9.Utils.updateGraphKeys(g$13, (function (key, param) {
        switch (key) {
          case "Catherine" :
              return 5;
          case "Martha" :
              return 4;
          default:
            return 6;
        }
      }), (function (key, param) {
        if (key === "M->C") {
          return "rel3";
        } else {
          return "rel4";
        }
      }));

var prim$6 = G$9.NodesIter.nodes(updatedGraph);

console.log(prim$6);

var prim$7 = G$9.EdgesIter.edges(updatedGraph, "All");

console.log(prim$7);

var G$10 = Graphology__Graph.MakeGraph({});

var g$14 = G$10.makeGraph(undefined);

G$10.addNode(g$14, "Martha", undefined);

G$10.addNode(g$14, "Catherine", undefined);

G$10.addNode(g$14, "John", undefined);

G$10.Layout.CirclePack.assign(g$14, undefined);

((function (__x) {
        console.log("circlePack", __x);
      })(G$10.inspect(g$14)));

G$10.Layout.Rotation.assign(g$14, 10.0, undefined);

((function (__x) {
        console.log("rotation", __x);
      })(G$10.inspect(g$14)));

var layout = G$10.Layout.Utils.collectLayout(g$14, undefined);

((function (__x) {
        console.log("collectLayout", __x);
      })(layout));

var layout$1 = G$10.Layout.Utils.collectLayoutAsFlatArray(g$14, undefined);

((function (__x) {
        console.log("collectLayoutAsFlatArray", __x);
      })(layout$1));

G$10.Layout.CirclePack.circlePack(g$14, undefined);

G$10.Layout.CirclePack.circlePack(g$14, {
      hierarchyAttributes: [
        "degree",
        "community"
      ]
    });

console.log("generators");

var G$11 = Graphology__Graph.MakeGraph({});

function writeToFile(g, filename) {
  var gexfStrWithOptions = G$11.GEXF.write(g, {
        formatNode: (function (key, _attributes) {
            return {
                    label: key,
                    attributes: {
                      name: key
                    }
                  };
          }),
        formatEdge: (function (key, _attributes) {
            return {
                    label: key,
                    attributes: {
                      name: key
                    }
                  };
          }),
        version: "1.3"
      });
  stringToFile(gexfStrWithOptions, filename);
}

var g$15 = G$11.Generators.karateClub("DirectedGraph");

((function (__x) {
        console.log("complete", __x);
      })(G$11.inspect(g$15)));

writeToFile(g$15, "karateClub.gexf");

export {
  log ,
  log2 ,
  stringToFile ,
}
/* G Not a pure module */
