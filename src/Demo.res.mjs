// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Graphology__Graph from "./Graphology__Graph.res.mjs";

function log(prim) {
  console.log(prim);
}

function log2(prim0, prim1) {
  console.log(prim0, prim1);
}

var G = Graphology__Graph.MakeGraph({});

var g = G.makeGraph(undefined, undefined);

G.addNode(g, "John", undefined, undefined);

var H = Graphology__Graph.MakeGraph({});

var h = H.makeGraph(undefined, undefined);

console.log("hi");

H.addNode(h, "John", {
      lastName: "Doe"
    }, undefined);

H.addNode(h, "Peter", {
      lastName: "Egg"
    }, undefined);

H.addNode(h, "Mary", undefined, undefined);

H.addEdge(h, "John", "Peter", {
      dist: 23
    }, undefined);

H.addEdge(h, "Peter", "Mary", {
      dist: 12
    }, undefined);

((function (__x) {
        console.log("inspect", __x);
      })(H.inspect(h)));

H.forEachNode(h, (function (n, attr) {
        console.log(n);
        console.log(attr);
      }));

((function (__x) {
        console.log("mapNodes", __x);
      })(H.mapNodes(h, (function (n, attr) {
              console.log(n);
              console.log(attr);
              return 1;
            }))));

var iter = H.nodeEntries(h);

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
      })(H.ShortestPath.Dijkstra.singleSource(h, "John", undefined, undefined)));

var dijss = H.ShortestPath.Dijkstra.singleSource(h, "John", undefined, undefined);

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

var t = T.makeGraph(undefined, undefined);

T.addNode(t, [
      0,
      0
    ], {
      lastName: "Doe"
    }, undefined);

T.addNode(t, [
      1,
      1
    ], {
      lastName: "Egg"
    }, undefined);

T.addNode(t, [
      2,
      2
    ], {
      lastName: "Klein"
    }, undefined);

T.addEdge(t, [
      0,
      0
    ], [
      1,
      1
    ], {
      dist: 23
    }, undefined);

T.addEdge(t, [
      1,
      1
    ], [
      2,
      2
    ], {
      dist: 12
    }, undefined);

var G$1 = Graphology__Graph.MakeGraph({});

var g$1 = G$1.makeGraph(undefined, undefined);

G$1.addNode(g$1, 1, undefined, undefined);

G$1.addNode(g$1, 2, undefined, undefined);

G$1.addNode(g$1, 3, undefined, undefined);

G$1.addNode(g$1, 4, undefined, undefined);

G$1.addEdge(g$1, 1, 2, {
      weight1: 3
    }, undefined);

G$1.addEdge(g$1, 1, 3, {
      weight1: 2
    }, undefined);

G$1.addEdge(g$1, 2, 4, {
      weight1: 1
    }, undefined);

G$1.addEdge(g$1, 3, 4, {
      weight1: 1
    }, undefined);

((function (__x) {
        console.log("edge", __x);
      })(G$1.edge(g$1, 1, 2)));

((function (__x) {
        console.log("edges", __x);
      })(G$1.edges(g$1)));

((function (__x) {
        console.log("inspect", __x);
      })(G$1.inspect(g$1)));

((function (__x) {
        console.log("Dijkstra singleSource", __x);
      })(G$1.ShortestPath.Dijkstra.singleSource(g$1, 1, undefined, undefined)));

((function (__x) {
        console.log("Dijkstra bidirectional", __x);
      })(G$1.ShortestPath.Dijkstra.bidirectional(g$1, 1, 4, {
            NAME: "Attr",
            VAL: "weight1"
          }, undefined)));

var ps = G$1.ShortestPath.Dijkstra.bidirectional(g$1, 1, 4, {
      NAME: "Attr",
      VAL: "weight1"
    }, undefined);

var es = G$1.ShortestPath.Utils.edgePathFromNodePath(g$1, ps);

((function (__x) {
        console.log("es", __x);
      })(es));

var G$2 = Graphology__Graph.MakeGraph({});

var g$2 = G$2.makeGraph(undefined, undefined);

G$2.addNode(g$2, 1, undefined, undefined);

G$2.addNode(g$2, 2, undefined, undefined);

G$2.addNode(g$2, 3, undefined, undefined);

G$2.addNode(g$2, 4, undefined, undefined);

G$2.addEdge(g$2, 1, 2, undefined, undefined);

G$2.addEdge(g$2, 1, 3, undefined, undefined);

G$2.addEdge(g$2, 2, 4, undefined, undefined);

G$2.addEdge(g$2, 3, 4, undefined, undefined);

((function (__x) {
        console.log("inspect - layout", __x);
      })(G$2.inspect(g$2)));

var pos = G$2.Layout.circular(g$2, undefined);

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
    }, undefined);

var prim0 = G$3.inspect(g$3);

console.log(prim0, "inspect");

export {
  log ,
  log2 ,
}
/* G Not a pure module */
