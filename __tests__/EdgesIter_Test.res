open Jest
open Expect
open Graphology

describe("Graph - Edges Iterator", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  describe("edges", () => {
    test("returns empty array for graph without edges", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      expect(g->G.EdgesIter.edges(All))->toEqual([])
    })

    test("returns all edges with All arg", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "B", "C")

      let result = g->G.EdgesIter.edges(All)
      let hasE1 = result->Array.includes("e1")
      let hasE2 = result->Array.includes("e2")
      expect((result->Array.length, hasE1, hasE2))->toEqual((2, true, true))
    })

    test("returns edges for specific node", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "B", "C")

      let result = g->G.EdgesIter.edges(Node("B"))
      expect(result->Array.length)->toBe(2)
    })

    test("returns edges between two nodes", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addEdgeWithKey("e1", "A", "B")

      let result = g->G.EdgesIter.edges(FromTo("A", "B"))
      expect(result)->toEqual(["e1"])
    })
  })

  describe("inEdges and outEdges", () => {
    test("distinguishes between incoming and outgoing edges", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "C", "B")

      let inEdges = g->G.EdgesIter.inEdges(Node("B"))
      let outEdges = g->G.EdgesIter.outEdges(Node("B"))

      expect((inEdges->Array.length, outEdges->Array.length))->toEqual((2, 0))
    })

    test("handles outgoing edges correctly", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "A", "C")

      let result = g->G.EdgesIter.outEdges(Node("A"))
      let hasE1 = result->Array.includes("e1")
      let hasE2 = result->Array.includes("e2")
      expect((result->Array.length, hasE1, hasE2))->toEqual((2, true, true))
    })
  })

  describe("directedEdges and undirectedEdges", () => {
    test("returns all directed edges in directed graph", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "B", "C")

      let result = g->G.EdgesIter.directedEdges(All)
      let hasE1 = result->Array.includes("e1")
      let hasE2 = result->Array.includes("e2")
      expect((result->Array.length, hasE1, hasE2))->toEqual((2, true, true))
    })

    test("returns all undirected edges in undirected graph", () => {
      let g = G.makeUndirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "B", "C")

      let result = g->G.EdgesIter.undirectedEdges(All)
      expect(result->Array.length)->toBe(2)
    })
  })

  describe("forEachEdge", () => {
    test("iterates over all edges", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "B", "C")

      let count = ref(0)
      g->G.EdgesIter.forEachEdge(All((_edge, _attr, _source, _target, _sAttr, _tAttr, _undirected) => {
        count := count.contents + 1
      }))

      expect(count.contents)->toBe(2)
    })

    test("provides edge details", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addEdgeWithKey("e1", "A", "B", ~attr={"weight": 5})

      let edgeKey = ref("")
      let weight = ref(0)
      let source = ref("")
      let target = ref("")

      g->G.EdgesIter.forEachEdge(All((edge, attr, src, tgt, _sAttr, _tAttr, _undirected) => {
        edgeKey := edge
        weight := attr["weight"]
        source := src
        target := tgt
      }))

      expect((edgeKey.contents, weight.contents, source.contents, target.contents))
        ->toEqual(("e1", 5, "A", "B"))
    })

    test("iterates over edges of specific node", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "B", "C")
      g->G.addEdgeWithKey("e3", "C", "A")

      let count = ref(0)
      g->G.EdgesIter.forEachEdge(Node("B", (_edge, _attr, _source, _target, _sAttr, _tAttr, _undirected) => {
        count := count.contents + 1
      }))

      expect(count.contents)->toBe(2)
    })
  })

  describe("mapEdges", () => {
    test("maps over all edges", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "B", "C")

      let result = g->G.EdgesIter.mapEdges(All((edge, _attr, _source, _target, _sAttr, _tAttr, _undirected) => edge))
      let hasE1 = result->Array.includes("e1")
      let hasE2 = result->Array.includes("e2")
      expect((result->Array.length, hasE1, hasE2))->toEqual((2, true, true))
    })

    test("transforms edge data", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addEdgeWithKey("e1", "A", "B", ~attr={"weight": 10})
      g->G.addEdgeWithKey("e2", "B", "A", ~attr={"weight": 20})

      let result = g->G.EdgesIter.mapEdges(All((_edge, _attr, source, target, _sAttr, _tAttr, _undirected) => {
        source ++ "->" ++ target
      }))

      let hasAB = result->Array.includes("A->B")
      let hasBA = result->Array.includes("B->A")
      expect((result->Array.length, hasAB, hasBA))->toEqual((2, true, true))
    })

    test("returns empty array for graph without edges", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      let result = g->G.EdgesIter.mapEdges(All((edge, _attr, _source, _target, _sAttr, _tAttr, _undirected) => edge))
      expect(result)->toEqual([])
    })
  })

  describe("filterEdges", () => {
    test("filters edges by predicate", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B", ~attr={"weight": 5})
      g->G.addEdgeWithKey("e2", "B", "C", ~attr={"weight": 15})
      g->G.addEdgeWithKey("e3", "C", "A", ~attr={"weight": 8})

      let result = g->G.EdgesIter.filterEdges(All((_edge, attr, _source, _target, _sAttr, _tAttr, _undirected) => {
        attr["weight"] > 10
      }))

      expect(result)->toEqual(["e2"])
    })

    test("filters by source node", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "B", "C")
      g->G.addEdgeWithKey("e3", "A", "C")

      let result = g->G.EdgesIter.filterEdges(All((_edge, _attr, source, _target, _sAttr, _tAttr, _undirected) => {
        source == "A"
      }))

      let hasE1 = result->Array.includes("e1")
      let hasE3 = result->Array.includes("e3")
      expect((result->Array.length, hasE1, hasE3))->toEqual((2, true, true))
    })

    test("returns all edges when predicate is true", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addEdgeWithKey("e1", "A", "B")

      let result = g->G.EdgesIter.filterEdges(All((_edge, _attr, _source, _target, _sAttr, _tAttr, _undirected) => true))
      expect(result->Array.length)->toBe(1)
    })

    test("returns empty array when predicate is false", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addEdgeWithKey("e1", "A", "B")

      let result = g->G.EdgesIter.filterEdges(All((_edge, _attr, _source, _target, _sAttr, _tAttr, _undirected) => false))
      expect(result)->toEqual([])
    })
  })

  describe("reduceEdges", () => {
    test("reduces edges to single value", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B", ~attr={"weight": 10})
      g->G.addEdgeWithKey("e2", "B", "C", ~attr={"weight": 20})
      g->G.addEdgeWithKey("e3", "C", "A", ~attr={"weight": 15})

      let total = g->G.EdgesIter.reduceEdges(All((acc, _edge, attr, _source, _target, _sAttr, _tAttr, _undirected) => {
        acc + attr["weight"]
      }, 0))

      expect(total)->toBe(45)
    })

    test("accumulates edge keys", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "B", "C")

      let keys = g->G.EdgesIter.reduceEdges(All((acc, edge, _attr, _source, _target, _sAttr, _tAttr, _undirected) => {
        acc->Array.concat([edge])
      }, []))

      let hasE1 = keys->Array.includes("e1")
      let hasE2 = keys->Array.includes("e2")
      expect((keys->Array.length, hasE1, hasE2))->toEqual((2, true, true))
    })

    test("returns initial value for empty graph", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      let result = g->G.EdgesIter.reduceEdges(All((acc, _edge, _attr, _source, _target, _sAttr, _tAttr, _undirected) => acc + 1, 0))
      expect(result)->toBe(0)
    })
  })


  describe("someEdge", () => {
    test("returns true if any edge matches", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B", ~attr={"weight": 5})
      g->G.addEdgeWithKey("e2", "B", "C", ~attr={"weight": 15})

      let result = g->G.EdgesIter.someEdge(All((_edge, attr, _source, _target, _sAttr, _tAttr, _undirected) => {
        attr["weight"] > 10
      }))

      expect(result)->toBe(true)
    })

    test("returns false if no edge matches", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addEdgeWithKey("e1", "A", "B", ~attr={"weight": 5})

      let result = g->G.EdgesIter.someEdge(All((_edge, attr, _source, _target, _sAttr, _tAttr, _undirected) => {
        attr["weight"] > 10
      }))

      expect(result)->toBe(false)
    })

    test("returns false for empty graph", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      let result = g->G.EdgesIter.someEdge(All((_edge, _attr, _source, _target, _sAttr, _tAttr, _undirected) => true))
      expect(result)->toBe(false)
    })
  })

  describe("everyEdge", () => {
    test("returns true if all edges match", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B", ~attr={"weight": 15})
      g->G.addEdgeWithKey("e2", "B", "C", ~attr={"weight": 20})

      let result = g->G.EdgesIter.everyEdge(All((_edge, attr, _source, _target, _sAttr, _tAttr, _undirected) => {
        attr["weight"] > 10
      }))

      expect(result)->toBe(true)
    })

    test("returns false if any edge doesn't match", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B", ~attr={"weight": 5})
      g->G.addEdgeWithKey("e2", "B", "C", ~attr={"weight": 20})

      let result = g->G.EdgesIter.everyEdge(All((_edge, attr, _source, _target, _sAttr, _tAttr, _undirected) => {
        attr["weight"] > 10
      }))

      expect(result)->toBe(false)
    })

    test("returns true for empty graph", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      let result = g->G.EdgesIter.everyEdge(All((_edge, _attr, _source, _target, _sAttr, _tAttr, _undirected) => false))
      expect(result)->toBe(true)
    })
  })

  describe("edgeEntries", () => {
    test("returns iterator for empty graph", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      let iter = g->G.EdgesIter.edgeEntries(All)
      let next = iter->Iterator.next
      expect(next.done)->toBe(true)
    })

    test("iterates over edge entries", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "B", "C")

      let iter = g->G.EdgesIter.edgeEntries(All)
      let edges = []

      let rec collect = () => {
        let next = iter->Iterator.next
        if !next.done {
          switch next.value {
          | Some(entry) => {
              edges->Array.push(entry.edge)
              collect()
            }
          | None => ()
          }
        }
      }
      collect()

      let hasE1 = edges->Array.includes("e1")
      let hasE2 = edges->Array.includes("e2")
      expect((edges->Array.length, hasE1, hasE2))->toEqual((2, true, true))
    })

    test("provides edge details", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addEdgeWithKey("e1", "A", "B", ~attr={"weight": 10})

      let iter = g->G.EdgesIter.edgeEntries(All)
      let next = iter->Iterator.next

      switch next.value {
      | Some(entry) =>
          expect((next.done, entry.edge, entry.source, entry.target, entry.attributes["weight"]))
            ->toEqual((false, "e1", "A", "B", 10))
      | None => fail("Expected entry value")
      }
    })

    test("iterates over edges of specific node", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "B", "C")
      g->G.addEdgeWithKey("e3", "C", "A")

      let iter = g->G.EdgesIter.edgeEntries(Node("B"))
      let count = ref(0)

      let rec iterate = () => {
        let next = iter->Iterator.next
        if !next.done {
          count := count.contents + 1
          iterate()
        }
      }
      iterate()

      expect(count.contents)->toBe(2)
    })
  })

  describe("Integration Tests", () => {
    test("combines multiple edge iteration methods", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B", ~attr={"weight": 5, "active": true})
      g->G.addEdgeWithKey("e2", "B", "C", ~attr={"weight": 15, "active": false})
      g->G.addEdgeWithKey("e3", "C", "A", ~attr={"weight": 10, "active": true})

      let activeEdges = g->G.EdgesIter.filterEdges(All((_edge, attr, _source, _target, _sAttr, _tAttr, _undirected) => {
        attr["active"] == true
      }))

      let hasHeavyEdge = g->G.EdgesIter.someEdge(All((_edge, attr, _source, _target, _sAttr, _tAttr, _undirected) => {
        attr["weight"] > 10
      }))

      let allEdges = g->G.EdgesIter.edges(All)

      expect((activeEdges->Array.length, hasHeavyEdge, allEdges->Array.length))->toEqual((2, true, 3))
    })

    test("works with undirected graph", () => {
      let g = G.makeUndirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "B", "C")

      let edges = g->G.EdgesIter.edges(All)
      let undirectedEdges = g->G.EdgesIter.undirectedEdges(All)

      expect((edges->Array.length, undirectedEdges->Array.length))->toEqual((2, 2))
    })

    test("works with multi-directed graph", () => {
      let g = G.makeMultiDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "A", "B")

      let allEdges = g->G.EdgesIter.edges(All)
      let directed = g->G.EdgesIter.directedEdges(All)

      expect((allEdges->Array.length, directed->Array.length))->toEqual((2, 2))
    })
  })
})