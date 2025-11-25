open Jest
open Expect
open Graphology

describe("Graph - Neighbors Iterator", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  describe("neighbors", () => {
    test("returns empty array for isolated node", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      expect(g->G.NeighborsIter.neighbors(Node("A")))->toEqual([])
    })

    test("returns neighbors between two nodes", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdge("A", "B")
      g->G.addEdge("B", "C")

      let result = g->G.NeighborsIter.neighbors(Node("B"))
      let hasA = result->Array.includes("A")
      let hasC = result->Array.includes("C")
      expect((result->Array.length, hasA, hasC))->toEqual((2, true, true))
    })

    test("returns neighbors of specific node", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdge("A", "B")
      g->G.addEdge("A", "C")

      let result = g->G.NeighborsIter.neighbors(Node("A"))
      let hasB = result->Array.includes("B")
      let hasC = result->Array.includes("C")
      expect((result->Array.length, hasB, hasC))->toEqual((2, true, true))
    })
  })

  describe("inNeighbors and outNeighbors", () => {
    test("distinguishes between incoming and outgoing neighbors", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdge("A", "B")
      g->G.addEdge("C", "B")

      let inNbrs = g->G.NeighborsIter.inNeighbors(Node("B"))
      let outNbrs = g->G.NeighborsIter.outNeighbors(Node("B"))

      let hasA = inNbrs->Array.includes("A")
      let hasC = inNbrs->Array.includes("C")
      expect((inNbrs->Array.length, hasA, hasC, outNbrs->Array.length))->toEqual((2, true, true, 0))
    })

    test("handles outgoing neighbors correctly", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdge("A", "B")
      g->G.addEdge("A", "C")

      let result = g->G.NeighborsIter.outNeighbors(Node("A"))
      let hasB = result->Array.includes("B")
      let hasC = result->Array.includes("C")
      expect((result->Array.length, hasB, hasC))->toEqual((2, true, true))
    })
  })

  describe("forEachNeighbor", () => {
    test("iterates over all neighbors of node", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdge("A", "B")
      g->G.addEdge("A", "C")

      let count = ref(0)
      g->G.NeighborsIter.forEachNeighbor(Node("A", (_neighbor, _attr) => {
        count := count.contents + 1
      }))

      expect(count.contents)->toBe(2)
    })

    test("provides neighbor node and attributes", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B", ~attr={"score": 100})
      g->G.addEdge("A", "B")

      let neighborName = ref("")
      let score = ref(0)

      g->G.NeighborsIter.forEachNeighbor(Node("A", (neighbor, attr) => {
        neighborName := neighbor
        score := attr["score"]
      }))

      expect((neighborName.contents, score.contents))->toEqual(("B", 100))
    })

    test("does nothing for isolated node", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")

      let count = ref(0)
      g->G.NeighborsIter.forEachNeighbor(Node("A", (_neighbor, _attr) => {
        count := count.contents + 1
      }))

      expect(count.contents)->toBe(0)
    })
  })

  describe("mapNeighbors", () => {
    test("maps over neighbors of node", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdge("A", "B")
      g->G.addEdge("A", "C")

      let result = g->G.NeighborsIter.mapNeighbors(Node("A", (neighbor, _attr) => neighbor))
      let hasB = result->Array.includes("B")
      let hasC = result->Array.includes("C")
      expect((result->Array.length, hasB, hasC))->toEqual((2, true, true))
    })

    test("transforms neighbor data", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B", ~attr={"score": 10})
      g->G.addNode("C", ~attr={"score": 20})
      g->G.addEdge("A", "B")
      g->G.addEdge("A", "C")

      let scores = g->G.NeighborsIter.mapNeighbors(Node("A", (_neighbor, attr) => attr["score"]))
      let has10 = scores->Array.includes(10)
      let has20 = scores->Array.includes(20)
      expect((has10, has20))->toEqual((true, true))
    })

    test("returns empty array for isolated node", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")

      let result = g->G.NeighborsIter.mapNeighbors(Node("A", (neighbor, _attr) => neighbor))
      expect(result)->toEqual([])
    })
  })

  describe("reduceNeighbors", () => {
    test("counts neighbors", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B", ~attr={"score": 10})
      g->G.addNode("C", ~attr={"score": 20})
      g->G.addEdge("A", "B")
      g->G.addEdge("A", "C")

      let count = g->G.NeighborsIter.reduceNeighbors(Node("A",
        (acc, _edge, _edgeAttr, _source, _target, _sourceAttr, _targetAttr, _undirected) => {
          acc + 1
        }, 0
      ))

      expect(count)->toBe(2)
    })

    test("accumulates target nodes", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "A", "C")

      let targets = g->G.NeighborsIter.reduceNeighbors(Node("A",
        (acc, _edge, _edgeAttr, _source, target, _sourceAttr, _targetAttr, _undirected) => {
          acc->Array.concat([target])
        }, []
      ))

      let hasB = targets->Array.includes("B")
      let hasC = targets->Array.includes("C")
      expect((targets->Array.length, hasB, hasC))->toEqual((2, true, true))
    })

    test("returns initial value for isolated node", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")

      let result = g->G.NeighborsIter.reduceNeighbors(Node("A",
        (acc, _edge, _edgeAttr, _source, _target, _sourceAttr, _targetAttr, _undirected) => {
          acc + 1
        }, 0
      ))

      expect(result)->toBe(0)
    })
  })

  describe("someNeighbor", () => {
    test("returns true if any neighbor matches", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B", ~attr={"score": 10})
      g->G.addNode("C", ~attr={"score": 20})
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "A", "C")

      let result = g->G.NeighborsIter.someNeighbor(Node("A",
        (_edge, _edgeAttr, _source, target, _sourceAttr, _targetAttr, _undirected) => {
          target == "C"
        }
      ))

      expect(result)->toBe(true)
    })

    test("returns false if no edge matches", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B", ~attr={"score": 10})
      g->G.addEdgeWithKey("e1", "A", "B")

      let result = g->G.NeighborsIter.someNeighbor(Node("A",
        (edge, _edgeAttr, _source, _target, _sourceAttr, _targetAttr, _undirected) => {
          edge == "e2"
        }
      ))

      expect(result)->toBe(false)
    })

    test("returns false for isolated node", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")

      let result = g->G.NeighborsIter.someNeighbor(Node("A",
        (_edge, _edgeAttr, _source, _target, _sourceAttr, _targetAttr, _undirected) => true
      ))

      expect(result)->toBe(false)
    })
  })

  describe("everyNeighbor", () => {
    test("returns true if all neighbors match", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B", ~attr={"score": 20})
      g->G.addNode("C", ~attr={"score": 30})
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "A", "C")

      let result = g->G.NeighborsIter.everyNeighbor(Node("A",
        (_edge, _edgeAttr, _source, target, _sourceAttr, _targetAttr, _undirected) => {
          ["B", "C"]->Array.includes(target)
        }
      ))

      expect(result)->toBe(true)
    })

    test("returns false if any neighbor doesn't match", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B", ~attr={"score": 10})
      g->G.addNode("C", ~attr={"score": 30})
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "A", "C")

      let result = g->G.NeighborsIter.everyNeighbor(Node("A",
        (_edge, _edgeAttr, _source, target, _sourceAttr, _targetAttr, _undirected) => {
          target == "B"
        }
      ))

      expect(result)->toBe(false)
    })

    test("returns true for isolated node", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")

      let result = g->G.NeighborsIter.everyNeighbor(Node("A",
        (_edge, _edgeAttr, _source, _target, _sourceAttr, _targetAttr, _undirected) => false
      ))

      expect(result)->toBe(true)
    })
  })

  describe("neighborEntries", () => {
    test("returns iterator for node with no neighbors", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")

      let iter = g->G.NeighborsIter.neighborEntries(Node("A"))
      let next = iter->Iterator.next
      expect(next.done)->toBe(true)
    })

    test("iterates over neighbor entries", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "A", "C")

      let iter = g->G.NeighborsIter.neighborEntries(Node("A"))
      let count = ref(0)

      let rec collect = () => {
        let next = iter->Iterator.next
        if !next.done {
          count := count.contents + 1
          collect()
        }
      }
      collect()

      expect(count.contents)->toBe(2)
    })

    test("provides neighbor entry details", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B", ~attr={"role": "friend"})
      g->G.addEdgeWithKey("e1", "A", "B", ~attr={"weight": 10})

      let iter = g->G.NeighborsIter.neighborEntries(Node("A"))
      let next = iter->Iterator.next

      switch next.value {
      | Some(entry) =>
          expect((next.done, entry.edge, entry.source, entry.target))
            ->toEqual((false, "e1", "A", "B"))
      | None => fail("Expected entry value")
      }
    })
  })

  describe("inNeighbors and outNeighbors with forEachNeighbor", () => {
    test("iterates over incoming neighbors", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdge("A", "B")
      g->G.addEdge("C", "B")

      let count = ref(0)
      g->G.NeighborsIter.forEachInNeighbor(Node("B", (_neighbor, _attr) => {
        count := count.contents + 1
      }))

      expect(count.contents)->toBe(2)
    })

    test("iterates over outgoing neighbors", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdge("A", "B")
      g->G.addEdge("A", "C")

      let neighbors = []
      g->G.NeighborsIter.forEachOutNeighbor(Node("A", (neighbor, _attr) => {
        neighbors->Array.push(neighbor)
      }))

      let hasB = neighbors->Array.includes("B")
      let hasC = neighbors->Array.includes("C")
      expect((neighbors->Array.length, hasB, hasC))->toEqual((2, true, true))
    })
  })

  describe("Integration Tests", () => {
    test("combines multiple neighbor iteration methods", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B", ~attr={"active": true, "score": 10})
      g->G.addNode("C", ~attr={"active": false, "score": 20})
      g->G.addNode("D", ~attr={"active": true, "score": 30})
      g->G.addEdgeWithKey("e1", "A", "B")
      g->G.addEdgeWithKey("e2", "A", "C")
      g->G.addEdgeWithKey("e3", "A", "D")

      let edgeCount = g->G.NeighborsIter.reduceNeighbors(Node("A",
        (acc, _edge, _edgeAttr, _source, _target, _sourceAttr, _targetAttr, _undirected) => {
          acc + 1
        }, 0
      ))

      let hasC = g->G.NeighborsIter.someNeighbor(Node("A",
        (_edge, _edgeAttr, _source, target, _sourceAttr, _targetAttr, _undirected) => {
          target == "C"
        }
      ))

      let allNeighbors = g->G.NeighborsIter.neighbors(Node("A"))

      expect((edgeCount, hasC, allNeighbors->Array.length))->toEqual((3, true, 3))
    })

    test("works with undirected graph", () => {
      let g = G.makeUndirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdge("A", "B")
      g->G.addEdge("B", "C")

      let neighborsOfB = g->G.NeighborsIter.neighbors(Node("B"))
      let hasA = neighborsOfB->Array.includes("A")
      let hasC = neighborsOfB->Array.includes("C")

      expect((neighborsOfB->Array.length, hasA, hasC))->toEqual((2, true, true))
    })

    test("distinguishes in/out neighbors in directed graph", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addNode("C")
      g->G.addEdge("A", "B")
      g->G.addEdge("B", "C")

      let inNbrs = g->G.NeighborsIter.inNeighbors(Node("B"))
      let outNbrs = g->G.NeighborsIter.outNeighbors(Node("B"))
      let allNbrs = g->G.NeighborsIter.neighbors(Node("B"))

      expect((inNbrs->Array.length, outNbrs->Array.length, allNbrs->Array.length))
        ->toEqual((1, 1, 2))
    })
  })
})
