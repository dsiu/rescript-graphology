// Generated by ReScript, PLEASE EDIT WITH CARE


function MakeEdgesIter(C) {
  let _edges_call = (t, edges_args, allFn, nodeFn, _fromToFn) => {
    if (typeof edges_args !== "object") {
      return allFn(t);
    } else if (edges_args.TAG === "Node") {
      return nodeFn(t, edges_args._0);
    } else {
      return _fromToFn(t, edges_args._0, edges_args._1);
    }
  };
  let edges = (t, edges_args) => _edges_call(t, edges_args, prim => prim.edges(), (prim0, prim1) => prim0.edges(prim1), (prim0, prim1, prim2) => prim0.edges(prim1, prim2));
  let inEdges = (t, edges_args) => _edges_call(t, edges_args, prim => prim.inEdges(), (prim0, prim1) => prim0.inEdges(prim1), (prim0, prim1, prim2) => prim0.inEdges(prim1, prim2));
  let outEdges = (t, edges_args) => _edges_call(t, edges_args, prim => prim.outEdges(), (prim0, prim1) => prim0.outEdges(prim1), (prim0, prim1, prim2) => prim0.outEdges(prim1, prim2));
  let inboundEdges = (t, edges_args) => _edges_call(t, edges_args, prim => prim.inboundEdges(), (prim0, prim1) => prim0.inboundEdges(prim1), (prim0, prim1, prim2) => prim0.inboundEdges(prim1, prim2));
  let outboundEdges = (t, edges_args) => _edges_call(t, edges_args, prim => prim.outboundEdges(), (prim0, prim1) => prim0.outboundEdges(prim1), (prim0, prim1, prim2) => prim0.outboundEdges(prim1, prim2));
  let directedEdges = (t, edges_args) => _edges_call(t, edges_args, prim => prim.directedEdges(), (prim0, prim1) => prim0.directedEdges(prim1), (prim0, prim1, prim2) => prim0.directedEdges(prim1, prim2));
  let undirectedEdges = (t, edges_args) => _edges_call(t, edges_args, prim => prim.undirectedEdges(), (prim0, prim1) => prim0.undirectedEdges(prim1), (prim0, prim1, prim2) => prim0.undirectedEdges(prim1, prim2));
  let _forEachEdge_call = (t, forEachEdge_args, allFn, nodeFn, _fromToFn) => {
    switch (forEachEdge_args.TAG) {
      case "All" :
        return allFn(t, forEachEdge_args._0);
      case "Node" :
        return nodeFn(t, forEachEdge_args._0, forEachEdge_args._1);
      case "FromTo" :
        return _fromToFn(t, forEachEdge_args._0, forEachEdge_args._1, forEachEdge_args._2);
    }
  };
  let forEachEdge = (t, forEachEdge_args) => _forEachEdge_call(t, forEachEdge_args, (prim0, prim1) => {
    prim0.forEachEdge(prim1);
  }, (prim0, prim1, prim2) => {
    prim0.forEachEdge(prim1, prim2);
  }, (prim0, prim1, prim2, prim3) => {
    prim0.forEachEdge(prim1, prim2, prim3);
  });
  let forEachInEdge = (t, forEachInEdge_args) => _forEachEdge_call(t, forEachInEdge_args, (prim0, prim1) => {
    prim0.forEachInEdge(prim1);
  }, (prim0, prim1, prim2) => {
    prim0.forEachInEdge(prim1, prim2);
  }, (prim0, prim1, prim2, prim3) => {
    prim0.forEachInEdge(prim1, prim2, prim3);
  });
  let forEachOutEdge = (t, forEachOutEdge_args) => _forEachEdge_call(t, forEachOutEdge_args, (prim0, prim1) => {
    prim0.forEachOutEdge(prim1);
  }, (prim0, prim1, prim2) => {
    prim0.forEachOutEdge(prim1, prim2);
  }, (prim0, prim1, prim2, prim3) => {
    prim0.forEachOutEdge(prim1, prim2, prim3);
  });
  let forEachInboundEdge = (t, forEachInboundEdge_args) => _forEachEdge_call(t, forEachInboundEdge_args, (prim0, prim1) => {
    prim0.forEachInboundEdge(prim1);
  }, (prim0, prim1, prim2) => {
    prim0.forEachInboundEdge(prim1, prim2);
  }, (prim0, prim1, prim2, prim3) => {
    prim0.forEachInboundEdge(prim1, prim2, prim3);
  });
  let forEachOutboundEdge = (t, forEachOutboundEdge_args) => _forEachEdge_call(t, forEachOutboundEdge_args, (prim0, prim1) => {
    prim0.forEachOutboundEdge(prim1);
  }, (prim0, prim1, prim2) => {
    prim0.forEachOutboundEdge(prim1, prim2);
  }, (prim0, prim1, prim2, prim3) => {
    prim0.forEachOutboundEdge(prim1, prim2, prim3);
  });
  let forEachDirectedEdge = (t, forEachDirectedEdge_args) => _forEachEdge_call(t, forEachDirectedEdge_args, (prim0, prim1) => {
    prim0.forEachDirectedEdge(prim1);
  }, (prim0, prim1, prim2) => {
    prim0.forEachDirectedEdge(prim1, prim2);
  }, (prim0, prim1, prim2, prim3) => {
    prim0.forEachDirectedEdge(prim1, prim2, prim3);
  });
  let forEachUndirectedEdge = (t, forEachUndirectedEdge_args) => _forEachEdge_call(t, forEachUndirectedEdge_args, (prim0, prim1) => {
    prim0.forEachUndirectedEdge(prim1);
  }, (prim0, prim1, prim2) => {
    prim0.forEachUndirectedEdge(prim1, prim2);
  }, (prim0, prim1, prim2, prim3) => {
    prim0.forEachUndirectedEdge(prim1, prim2, prim3);
  });
  let _mapEdges_call = (t, mapEdges_args, allFn, nodeFn, _fromToFn) => {
    switch (mapEdges_args.TAG) {
      case "All" :
        return allFn(t, mapEdges_args._0);
      case "Node" :
        return nodeFn(t, mapEdges_args._0, mapEdges_args._1);
      case "FromTo" :
        return _fromToFn(t, mapEdges_args._0, mapEdges_args._1, mapEdges_args._2);
    }
  };
  let mapEdges = (t, mapEdges_args) => _mapEdges_call(t, mapEdges_args, (prim0, prim1) => prim0.mapEdges(prim1), (prim0, prim1, prim2) => prim0.mapEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.mapEdges(prim1, prim2, prim3));
  let mapInEdges = (t, mapEdges_args) => _mapEdges_call(t, mapEdges_args, (prim0, prim1) => prim0.mapInEdges(prim1), (prim0, prim1, prim2) => prim0.mapEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.mapInEdges(prim1, prim2, prim3));
  let mapOutEdges = (t, mapEdges_args) => _mapEdges_call(t, mapEdges_args, (prim0, prim1) => prim0.mapOutEdges(prim1), (prim0, prim1, prim2) => prim0.mapEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.mapOutEdges(prim1, prim2, prim3));
  let mapInboundEdges = (t, mapEdges_args) => _mapEdges_call(t, mapEdges_args, (prim0, prim1) => prim0.mapInboundEdges(prim1), (prim0, prim1, prim2) => prim0.mapInboundEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.mapInboundEdges(prim1, prim2, prim3));
  let mapOutboundEdges = (t, mapEdges_args) => _mapEdges_call(t, mapEdges_args, (prim0, prim1) => prim0.mapOutboundEdges(prim1), (prim0, prim1, prim2) => prim0.mapEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.mapOutboundEdges(prim1, prim2, prim3));
  let mapDirectedEdges = (t, mapEdges_args) => _mapEdges_call(t, mapEdges_args, (prim0, prim1) => prim0.mapDirectedEdges(prim1), (prim0, prim1, prim2) => prim0.mapEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.mapDirectedEdges(prim1, prim2, prim3));
  let mapUndirectedEdges = (t, mapEdges_args) => _mapEdges_call(t, mapEdges_args, (prim0, prim1) => prim0.mapUndirectedEdges(prim1), (prim0, prim1, prim2) => prim0.mapEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.mapUndirectedEdges(prim1, prim2, prim3));
  let _filterEdges_call = (t, filterEdges_args, allFn, nodeFn, _fromToFn) => {
    switch (filterEdges_args.TAG) {
      case "All" :
        return allFn(t, filterEdges_args._0);
      case "Node" :
        return nodeFn(t, filterEdges_args._0, filterEdges_args._1);
      case "FromTo" :
        return _fromToFn(t, filterEdges_args._0, filterEdges_args._1, filterEdges_args._2);
    }
  };
  let filterEdges = (t, filterEdges_args) => _filterEdges_call(t, filterEdges_args, (prim0, prim1) => prim0.filterEdges(prim1), (prim0, prim1, prim2) => prim0.filterEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.filterEdges(prim1, prim2, prim3));
  let filterInEdges = (t, filterEdges_args) => _filterEdges_call(t, filterEdges_args, (prim0, prim1) => prim0.filterInEdges(prim1), (prim0, prim1, prim2) => prim0.filterInEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.filterInEdges(prim1, prim2, prim3));
  let filterOutEdges = (t, filterEdges_args) => _filterEdges_call(t, filterEdges_args, (prim0, prim1) => prim0.filterOutEdges(prim1), (prim0, prim1, prim2) => prim0.filterOutEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.filterOutEdges(prim1, prim2, prim3));
  let filterInboundEdges = (t, filterEdges_args) => _filterEdges_call(t, filterEdges_args, (prim0, prim1) => prim0.filterInboundEdges(prim1), (prim0, prim1, prim2) => prim0.filterInboundEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.filterInboundEdges(prim1, prim2, prim3));
  let filterOutboundEdges = (t, filterEdges_args) => _filterEdges_call(t, filterEdges_args, (prim0, prim1) => prim0.filterOutboundEdges(prim1), (prim0, prim1, prim2) => prim0.filterOutboundEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.filterOutboundEdges(prim1, prim2, prim3));
  let filterDirectedEdges = (t, filterEdges_args) => _filterEdges_call(t, filterEdges_args, (prim0, prim1) => prim0.filterDirectedEdges(prim1), (prim0, prim1, prim2) => prim0.filterDirectedEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.filterDirectedEdges(prim1, prim2, prim3));
  let filterUndirectedEdges = (t, filterEdges_args) => _filterEdges_call(t, filterEdges_args, (prim0, prim1) => prim0.filterUndirectedEdges(prim1), (prim0, prim1, prim2) => prim0.filterUndirectedEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.filterUndirectedEdges(prim1, prim2, prim3));
  let _reduceEdges_call = (t, reduceEdges_args, allFn, nodeFn, _fromToFn) => {
    switch (reduceEdges_args.TAG) {
      case "All" :
        return allFn(t, reduceEdges_args._0, reduceEdges_args._1);
      case "Node" :
        return nodeFn(t, reduceEdges_args._0, reduceEdges_args._1, reduceEdges_args._2);
      case "FromTo" :
        return _fromToFn(t, reduceEdges_args._0, reduceEdges_args._1, reduceEdges_args._2, reduceEdges_args._3);
    }
  };
  let reduceEdges = (t, reduceEdges_args) => _reduceEdges_call(t, reduceEdges_args, (prim0, prim1, prim2) => prim0.reduceEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.reduceEdges(prim1, prim2, prim3), (prim0, prim1, prim2, prim3, prim4) => prim0.reduceEdges(prim1, prim2, prim3, prim4));
  let reduceInEdges = (t, reduceEdges_args) => _reduceEdges_call(t, reduceEdges_args, (prim0, prim1, prim2) => prim0.reduceInEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.reduceInEdges(prim1, prim2, prim3), (prim0, prim1, prim2, prim3, prim4) => prim0.reduceInEdges(prim1, prim2, prim3, prim4));
  let reduceOutEdges = (t, reduceEdges_args) => _reduceEdges_call(t, reduceEdges_args, (prim0, prim1, prim2) => prim0.reduceOutEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.reduceOutEdges(prim1, prim2, prim3), (prim0, prim1, prim2, prim3, prim4) => prim0.reduceOutEdges(prim1, prim2, prim3, prim4));
  let reduceOutboundEdges = (t, reduceEdges_args) => _reduceEdges_call(t, reduceEdges_args, (prim0, prim1, prim2) => prim0.reduceOutboundEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.reduceOutboundEdges(prim1, prim2, prim3), (prim0, prim1, prim2, prim3, prim4) => prim0.reduceOutboundEdges(prim1, prim2, prim3, prim4));
  let reduceDirectedEdges = (t, reduceEdges_args) => _reduceEdges_call(t, reduceEdges_args, (prim0, prim1, prim2) => prim0.reduceDirectedEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.reduceDirectedEdges(prim1, prim2, prim3), (prim0, prim1, prim2, prim3, prim4) => prim0.reduceDirectedEdges(prim1, prim2, prim3, prim4));
  let reduceUndirectedEdges = (t, reduceEdges_args) => _reduceEdges_call(t, reduceEdges_args, (prim0, prim1, prim2) => prim0.reduceUndirectedEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.reduceUndirectedEdges(prim1, prim2, prim3), (prim0, prim1, prim2, prim3, prim4) => prim0.reduceUndirectedEdges(prim1, prim2, prim3, prim4));
  let _findEdge_call = (t, findEdge_args, allFn, nodeFn, _fromToFn) => {
    switch (findEdge_args.TAG) {
      case "All" :
        return allFn(t, findEdge_args._0);
      case "Node" :
        return nodeFn(t, findEdge_args._0, findEdge_args._1);
      case "FromTo" :
        return _fromToFn(t, findEdge_args._0, findEdge_args._1, findEdge_args._2);
    }
  };
  let findEdge = (t, findEdge_args) => _findEdge_call(t, findEdge_args, (prim0, prim1) => prim0.findEdges(prim1), (prim0, prim1, prim2) => prim0.findEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.findEdges(prim1, prim2, prim3));
  let findInEdge = (t, findEdge_args) => _findEdge_call(t, findEdge_args, (prim0, prim1) => prim0.findInEdges(prim1), (prim0, prim1, prim2) => prim0.findInEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.findInEdges(prim1, prim2, prim3));
  let findOutEdge = (t, findEdge_args) => _findEdge_call(t, findEdge_args, (prim0, prim1) => prim0.findOutEdges(prim1), (prim0, prim1, prim2) => prim0.findOutEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.findOutEdges(prim1, prim2, prim3));
  let findInboundEdge = (t, findEdge_args) => _findEdge_call(t, findEdge_args, (prim0, prim1) => prim0.findInboundEdges(prim1), (prim0, prim1, prim2) => prim0.findInboundEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.findInboundEdges(prim1, prim2, prim3));
  let findOutboundEdge = (t, findEdge_args) => _findEdge_call(t, findEdge_args, (prim0, prim1) => prim0.findOutboundEdges(prim1), (prim0, prim1, prim2) => prim0.findOutboundEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.findOutboundEdges(prim1, prim2, prim3));
  let findDirectedEdge = (t, findEdge_args) => _findEdge_call(t, findEdge_args, (prim0, prim1) => prim0.findDirectedEdges(prim1), (prim0, prim1, prim2) => prim0.findDirectedEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.findDirectedEdges(prim1, prim2, prim3));
  let findUndirectedEdge = (t, findEdge_args) => _findEdge_call(t, findEdge_args, (prim0, prim1) => prim0.findUndirectedEdges(prim1), (prim0, prim1, prim2) => prim0.findUndirectedEdges(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.findUndirectedEdges(prim1, prim2, prim3));
  let _someEdge_call = (t, someEdge_args, allFn, nodeFn, _fromToFn) => {
    switch (someEdge_args.TAG) {
      case "All" :
        return allFn(t, someEdge_args._0);
      case "Node" :
        return nodeFn(t, someEdge_args._0, someEdge_args._1);
      case "FromTo" :
        return _fromToFn(t, someEdge_args._0, someEdge_args._1, someEdge_args._2);
    }
  };
  let someEdge = (t, someEdge_args) => _someEdge_call(t, someEdge_args, (prim0, prim1) => prim0.someEdge(prim1), (prim0, prim1, prim2) => prim0.someEdge(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.someEdge(prim1, prim2, prim3));
  let someInEdge = (t, someEdge_args) => _someEdge_call(t, someEdge_args, (prim0, prim1) => prim0.someInEdge(prim1), (prim0, prim1, prim2) => prim0.someInEdge(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.someInEdge(prim1, prim2, prim3));
  let someOutEdge = (t, someEdge_args) => _someEdge_call(t, someEdge_args, (prim0, prim1) => prim0.someOutEdge(prim1), (prim0, prim1, prim2) => prim0.someOutEdge(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.someOutEdge(prim1, prim2, prim3));
  let someInboundEdge = (t, someEdge_args) => _someEdge_call(t, someEdge_args, (prim0, prim1) => prim0.someInboundEdge(prim1), (prim0, prim1, prim2) => prim0.someInboundEdge(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.someInboundEdge(prim1, prim2, prim3));
  let someOutboundEdge = (t, someEdge_args) => _someEdge_call(t, someEdge_args, (prim0, prim1) => prim0.someOutboundEdge(prim1), (prim0, prim1, prim2) => prim0.someOutboundEdge(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.someOutboundEdge(prim1, prim2, prim3));
  let someDirectedEdge = (t, someEdge_args) => _someEdge_call(t, someEdge_args, (prim0, prim1) => prim0.someDirectedEdge(prim1), (prim0, prim1, prim2) => prim0.someDirectedEdge(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.someDirectedEdge(prim1, prim2, prim3));
  let someUndirectedEdge = (t, someEdge_args) => _someEdge_call(t, someEdge_args, (prim0, prim1) => prim0.someUndirectedEdge(prim1), (prim0, prim1, prim2) => prim0.someUndirectedEdge(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.someUndirectedEdge(prim1, prim2, prim3));
  let _everyEdge_call = (t, everyEdge_args, allFn, nodeFn, _fromToFn) => {
    switch (everyEdge_args.TAG) {
      case "All" :
        return allFn(t, everyEdge_args._0);
      case "Node" :
        return nodeFn(t, everyEdge_args._0, everyEdge_args._1);
      case "FromTo" :
        return _fromToFn(t, everyEdge_args._0, everyEdge_args._1, everyEdge_args._2);
    }
  };
  let everyEdge = (t, everyEdge_args) => _everyEdge_call(t, everyEdge_args, (prim0, prim1) => prim0.everyEdge(prim1), (prim0, prim1, prim2) => prim0.everyEdge(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.everyEdge(prim1, prim2, prim3));
  let everyInEdge = (t, everyEdge_args) => _everyEdge_call(t, everyEdge_args, (prim0, prim1) => prim0.everyInEdge(prim1), (prim0, prim1, prim2) => prim0.everyInEdge(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.everyInEdge(prim1, prim2, prim3));
  let everyOutEdge = (t, everyEdge_args) => _everyEdge_call(t, everyEdge_args, (prim0, prim1) => prim0.everyOutEdge(prim1), (prim0, prim1, prim2) => prim0.everyOutEdge(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.everyOutEdge(prim1, prim2, prim3));
  let everyInboundEdge = (t, everyEdge_args) => _everyEdge_call(t, everyEdge_args, (prim0, prim1) => prim0.everyInboundEdge(prim1), (prim0, prim1, prim2) => prim0.everyInboundEdge(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.everyInboundEdge(prim1, prim2, prim3));
  let everyOutboundEdge = (t, everyEdge_args) => _everyEdge_call(t, everyEdge_args, (prim0, prim1) => prim0.everyOutboundEdge(prim1), (prim0, prim1, prim2) => prim0.everyOutboundEdge(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.everyOutboundEdge(prim1, prim2, prim3));
  let everyDirectedEdge = (t, everyEdge_args) => _everyEdge_call(t, everyEdge_args, (prim0, prim1) => prim0.everyDirectedEdge(prim1), (prim0, prim1, prim2) => prim0.everyDirectedEdge(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.everyDirectedEdge(prim1, prim2, prim3));
  let everyUndirectedEdge = (t, everyEdge_args) => _everyEdge_call(t, everyEdge_args, (prim0, prim1) => prim0.everyUndirectedEdge(prim1), (prim0, prim1, prim2) => prim0.everyUndirectedEdge(prim1, prim2), (prim0, prim1, prim2, prim3) => prim0.everyUndirectedEdge(prim1, prim2, prim3));
  let _edgeEntries_call = (t, edgeEntries_args, allFn, nodeFn, _fromToFn) => {
    if (typeof edgeEntries_args !== "object") {
      return allFn(t);
    } else if (edgeEntries_args.TAG === "Node") {
      return nodeFn(t, edgeEntries_args._0);
    } else {
      return _fromToFn(t, edgeEntries_args._0, edgeEntries_args._1);
    }
  };
  let edgeEntries = (t, edgeEntries_args) => _edgeEntries_call(t, edgeEntries_args, prim => prim.edgeEntries(), (prim0, prim1) => prim0.edgeEntries(prim1), (prim0, prim1, prim2) => prim0.edgeEntries(prim1, prim2));
  let inEdgeEntries = (t, edgeEntries_args) => _edgeEntries_call(t, edgeEntries_args, prim => prim.inEdgeEntries(), (prim0, prim1) => prim0.inEdgeEntries(prim1), (prim0, prim1, prim2) => prim0.inEdgeEntries(prim1, prim2));
  let outEdgeEntries = (t, edgeEntries_args) => _edgeEntries_call(t, edgeEntries_args, prim => prim.outEdgeEntries(), (prim0, prim1) => prim0.outEdgeEntries(prim1), (prim0, prim1, prim2) => prim0.outEdgeEntries(prim1, prim2));
  let inboundEdgeEntries = (t, edgeEntries_args) => _edgeEntries_call(t, edgeEntries_args, prim => prim.inboundEdgeEntries(), (prim0, prim1) => prim0.inboundEdgeEntries(prim1), (prim0, prim1, prim2) => prim0.inboundEdgeEntries(prim1, prim2));
  let outboundEdgeEntries = (t, edgeEntries_args) => _edgeEntries_call(t, edgeEntries_args, prim => prim.outboundEdgeEntries(), (prim0, prim1) => prim0.outboundEdgeEntries(prim1), (prim0, prim1, prim2) => prim0.outboundEdgeEntries(prim1, prim2));
  let directedEdgeEntries = (t, edgeEntries_args) => _edgeEntries_call(t, edgeEntries_args, prim => prim.directedEdgeEntries(), (prim0, prim1) => prim0.directedEdgeEntries(prim1), (prim0, prim1, prim2) => prim0.directedEdgeEntries(prim1, prim2));
  let undirectedEdgeEntries = (t, edgeEntries_args) => _edgeEntries_call(t, edgeEntries_args, prim => prim.undirectedEdgeEntries(), (prim0, prim1) => prim0.undirectedEdgeEntries(prim1), (prim0, prim1, prim2) => prim0.undirectedEdgeEntries(prim1, prim2));
  return {
    edges: edges,
    inEdges: inEdges,
    outEdges: outEdges,
    inboundEdges: inboundEdges,
    outboundEdges: outboundEdges,
    directedEdges: directedEdges,
    undirectedEdges: undirectedEdges,
    forEachEdge: forEachEdge,
    forEachInEdge: forEachInEdge,
    forEachOutEdge: forEachOutEdge,
    forEachInboundEdge: forEachInboundEdge,
    forEachOutboundEdge: forEachOutboundEdge,
    forEachDirectedEdge: forEachDirectedEdge,
    forEachUndirectedEdge: forEachUndirectedEdge,
    mapEdges: mapEdges,
    mapInEdges: mapInEdges,
    mapOutEdges: mapOutEdges,
    mapInboundEdges: mapInboundEdges,
    mapOutboundEdges: mapOutboundEdges,
    mapDirectedEdges: mapDirectedEdges,
    mapUndirectedEdges: mapUndirectedEdges,
    filterEdges: filterEdges,
    filterInEdges: filterInEdges,
    filterOutEdges: filterOutEdges,
    filterInboundEdges: filterInboundEdges,
    filterOutboundEdges: filterOutboundEdges,
    filterDirectedEdges: filterDirectedEdges,
    filterUndirectedEdges: filterUndirectedEdges,
    reduceEdges: reduceEdges,
    reduceInEdges: reduceInEdges,
    reduceOutEdges: reduceOutEdges,
    reduceOutboundEdges: reduceOutboundEdges,
    reduceDirectedEdges: reduceDirectedEdges,
    reduceUndirectedEdges: reduceUndirectedEdges,
    findEdge: findEdge,
    findInEdge: findInEdge,
    findOutEdge: findOutEdge,
    findInboundEdge: findInboundEdge,
    findOutboundEdge: findOutboundEdge,
    findDirectedEdge: findDirectedEdge,
    findUndirectedEdge: findUndirectedEdge,
    someEdge: someEdge,
    someInEdge: someInEdge,
    someOutEdge: someOutEdge,
    someInboundEdge: someInboundEdge,
    someOutboundEdge: someOutboundEdge,
    someDirectedEdge: someDirectedEdge,
    someUndirectedEdge: someUndirectedEdge,
    everyEdge: everyEdge,
    everyInEdge: everyInEdge,
    everyOutEdge: everyOutEdge,
    everyInboundEdge: everyInboundEdge,
    everyOutboundEdge: everyOutboundEdge,
    everyDirectedEdge: everyDirectedEdge,
    everyUndirectedEdge: everyUndirectedEdge,
    edgeEntries: edgeEntries,
    inEdgeEntries: inEdgeEntries,
    outEdgeEntries: outEdgeEntries,
    inboundEdgeEntries: inboundEdgeEntries,
    outboundEdgeEntries: outboundEdgeEntries,
    directedEdgeEntries: directedEdgeEntries,
    undirectedEdgeEntries: undirectedEdgeEntries
  };
}

export {
  MakeEdgesIter,
}
/* No side effect */