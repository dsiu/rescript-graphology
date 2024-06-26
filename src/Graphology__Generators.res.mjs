// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Graphology from "graphology";
import * as GraphologyGenerators from "graphology-generators";

function MakeGenerators(C) {
  var classicGraphGenHelper = function (fn, graphType, $$int) {
    switch (graphType) {
      case "Graph" :
          return fn(Graphology.default.Graph, $$int);
      case "DirectedGraph" :
          return fn(Graphology.default.DirectedGraph, $$int);
      case "UndirectedGraph" :
          return fn(Graphology.default.UndirectedGraph, $$int);
      case "MultiGraph" :
          return fn(Graphology.default.MultiGraph, $$int);
      case "MultiDirectedGraph" :
          return fn(Graphology.default.MultiDirectedGraph, $$int);
      case "MultiUndirectedGraph" :
          return fn(Graphology.default.MultiUndirectedGraph, $$int);
      
    }
  };
  var complete = function (graphType, order) {
    return classicGraphGenHelper((function (prim0, prim1) {
                  return GraphologyGenerators.classic.complete(prim0, prim1);
                }), graphType, order);
  };
  var empty = function (graphType, order) {
    return classicGraphGenHelper((function (prim0, prim1) {
                  return GraphologyGenerators.classic.empty(prim0, prim1);
                }), graphType, order);
  };
  var ladder = function (graphType, length) {
    return classicGraphGenHelper((function (prim0, prim1) {
                  return GraphologyGenerators.classic.ladder(prim0, prim1);
                }), graphType, length);
  };
  var path = function (graphType, order) {
    return classicGraphGenHelper((function (prim0, prim1) {
                  return GraphologyGenerators.classic.path(prim0, prim1);
                }), graphType, order);
  };
  var cavemanGraphGenHelper = function (fn, graphType, l, k) {
    switch (graphType) {
      case "Graph" :
          return fn(Graphology.default.Graph, l, k);
      case "DirectedGraph" :
          return fn(Graphology.default.DirectedGraph, l, k);
      case "UndirectedGraph" :
          return fn(Graphology.default.UndirectedGraph, l, k);
      case "MultiGraph" :
          return fn(Graphology.default.MultiGraph, l, k);
      case "MultiDirectedGraph" :
          return fn(Graphology.default.MultiDirectedGraph, l, k);
      case "MultiUndirectedGraph" :
          return fn(Graphology.default.MultiUndirectedGraph, l, k);
      
    }
  };
  var caveman = function (graphType, l, k) {
    return cavemanGraphGenHelper((function (prim0, prim1, prim2) {
                  return GraphologyGenerators.community.caveman(prim0, prim1, prim2);
                }), graphType, l, k);
  };
  var connectedCaveman = function (graphType, l, k) {
    return cavemanGraphGenHelper((function (prim0, prim1, prim2) {
                  return GraphologyGenerators.community.connectedCaveman(prim0, prim1, prim2);
                }), graphType, l, k);
  };
  var graphGenWithOptHelper = function (fn, graphType, options) {
    switch (graphType) {
      case "Graph" :
          return fn(Graphology.default.Graph, options);
      case "DirectedGraph" :
          return fn(Graphology.default.DirectedGraph, options);
      case "UndirectedGraph" :
          return fn(Graphology.default.UndirectedGraph, options);
      case "MultiGraph" :
          return fn(Graphology.default.MultiGraph, options);
      case "MultiDirectedGraph" :
          return fn(Graphology.default.MultiDirectedGraph, options);
      case "MultiUndirectedGraph" :
          return fn(Graphology.default.MultiUndirectedGraph, options);
      
    }
  };
  var clusters = function (graphType, options) {
    return graphGenWithOptHelper((function (prim0, prim1) {
                  return GraphologyGenerators.random.clusters(prim0, prim1);
                }), graphType, options);
  };
  var erdosRenyi = function (graphType, options) {
    return graphGenWithOptHelper((function (prim0, prim1) {
                  return GraphologyGenerators.random.erdosRenyi(prim0, prim1);
                }), graphType, options);
  };
  var girvanNewman = function (graphType, options) {
    return graphGenWithOptHelper((function (prim0, prim1) {
                  return GraphologyGenerators.random.girvanNewman(prim0, prim1);
                }), graphType, options);
  };
  var graphGenNoOptHelper = function (fn, graphType) {
    switch (graphType) {
      case "Graph" :
          return fn(Graphology.default.Graph);
      case "DirectedGraph" :
          return fn(Graphology.default.DirectedGraph);
      case "UndirectedGraph" :
          return fn(Graphology.default.UndirectedGraph);
      case "MultiGraph" :
          return fn(Graphology.default.MultiGraph);
      case "MultiDirectedGraph" :
          return fn(Graphology.default.MultiDirectedGraph);
      case "MultiUndirectedGraph" :
          return fn(Graphology.default.MultiUndirectedGraph);
      
    }
  };
  var krackhardtKite = function (graphType) {
    return graphGenNoOptHelper((function (prim) {
                  return GraphologyGenerators.small.krackhardtKite(prim);
                }), graphType);
  };
  var florentineFamilies = function (graphType) {
    return graphGenNoOptHelper((function (prim) {
                  return GraphologyGenerators.social.florentineFamilies(prim);
                }), graphType);
  };
  var karateClub = function (graphType) {
    return graphGenNoOptHelper((function (prim) {
                  return GraphologyGenerators.social.karateClub(prim);
                }), graphType);
  };
  return {
          complete: complete,
          empty: empty,
          ladder: ladder,
          path: path,
          caveman: caveman,
          connectedCaveman: connectedCaveman,
          clusters: clusters,
          erdosRenyi: erdosRenyi,
          girvanNewman: girvanNewman,
          krackhardtKite: krackhardtKite,
          florentineFamilies: florentineFamilies,
          karateClub: karateClub
        };
}

export {
  MakeGenerators ,
}
/* graphology Not a pure module */
