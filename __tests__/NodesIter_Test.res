open Jest
open Expect
open Graphology

describe("Graph - Nodes Iterator", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  describe("nodes", () => {
    test("returns empty array for empty graph", () => {
      let g = G.makeGraph()
      expect(g->G.NodesIter.nodes)->toEqual([])
    })

    test("returns all node keys", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      g->G.addNode("Charlie")
      let nodeList = g->G.NodesIter.nodes
      let hasAlice = nodeList->Array.includes("Alice")
      let hasBob = nodeList->Array.includes("Bob")
      let hasCharlie = nodeList->Array.includes("Charlie")
      expect((nodeList->Array.length, hasAlice, hasBob, hasCharlie))->toEqual((3, true, true, true))
    })

    test("reflects current graph state", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      let initialCount = g->G.NodesIter.nodes->Array.length

      g->G.dropNode("Alice")
      let afterDrop = g->G.NodesIter.nodes
      expect((initialCount, afterDrop->Array.length, afterDrop))->toEqual((2, 1, ["Bob"]))
    })
  })

  describe("forEachNode", () => {
    test("iterates over all nodes", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"age": 30})
      g->G.addNode("Bob", ~attr={"age": 25})
      g->G.addNode("Charlie", ~attr={"age": 35})

      let count = ref(0)
      g->G.NodesIter.forEachNode((_node, _attr) => {
        count := count.contents + 1
      })
      expect(count.contents)->toBe(3)
    })

    test("provides node attributes", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"age": 30, "city": "NYC"})

      let age = ref(0)
      let city = ref("")
      g->G.NodesIter.forEachNode((_node, attr) => {
        age := attr["age"]
        city := attr["city"]
      })
      expect((age.contents, city.contents))->toEqual((30, "NYC"))
    })

    test("does nothing for empty graph", () => {
      let g = G.makeGraph()
      let count = ref(0)
      g->G.NodesIter.forEachNode((_node, _attr) => {
        count := count.contents + 1
      })
      expect(count.contents)->toBe(0)
    })

    test("can modify node attributes during iteration", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"score": 10})
      g->G.addNode("Bob", ~attr={"score": 20})

      g->G.NodesIter.forEachNode((node, attr) => {
        let newScore = attr["score"] + 5
        g->G.setNodeAttribute(node, "score", newScore)
      })

      let aliceScore = g->G.getNodeAttribute("Alice", "score")
      let bobScore = g->G.getNodeAttribute("Bob", "score")
      expect((aliceScore, bobScore))->toEqual((15, 25))
    })
  })

  describe("mapNodes", () => {
    test("maps over all nodes", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      g->G.addNode("Charlie")

      let result = g->G.NodesIter.mapNodes((node, _attr) => node)
      let hasAlice = result->Array.includes("Alice")
      let hasBob = result->Array.includes("Bob")
      let hasCharlie = result->Array.includes("Charlie")
      expect((result->Array.length, hasAlice, hasBob, hasCharlie))->toEqual((3, true, true, true))
    })

    test("transforms node data", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"age": 30})
      g->G.addNode("Bob", ~attr={"age": 25})

      let ages = g->G.NodesIter.mapNodes((_node, attr) => attr["age"])
      let has30 = ages->Array.includes(30)
      let has25 = ages->Array.includes(25)
      expect((has30, has25))->toEqual((true, true))
    })

    test("returns empty array for empty graph", () => {
      let g = G.makeGraph()
      let result = g->G.NodesIter.mapNodes((node, _attr) => node)
      expect(result)->toEqual([])
    })

    test("can create complex objects from nodes", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"age": 30, "city": "NYC"})
      g->G.addNode("Bob", ~attr={"age": 25, "city": "LA"})

      let result = g->G.NodesIter.mapNodes((node, attr) => {
        "name": node,
        "age": attr["age"],
        "city": attr["city"],
      })

      expect(result->Array.length)->toBe(2)
    })
  })

  describe("filterNodes", () => {
    test("filters nodes by predicate", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"age": 30})
      g->G.addNode("Bob", ~attr={"age": 25})
      g->G.addNode("Charlie", ~attr={"age": 35})

      let result = g->G.NodesIter.filterNodes((_node, attr) => attr["age"] > 28)
      let hasAlice = result->Array.includes("Alice")
      let hasCharlie = result->Array.includes("Charlie")
      expect((result->Array.length, hasAlice, hasCharlie))->toEqual((2, true, true))
    })

    test("returns all nodes when predicate is true", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")

      let result = g->G.NodesIter.filterNodes((_node, _attr) => true)
      expect(result->Array.length)->toBe(2)
    })

    test("returns empty array when predicate is false", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")

      let result = g->G.NodesIter.filterNodes((_node, _attr) => false)
      expect(result)->toEqual([])
    })

    test("filters by node name", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      g->G.addNode("Alex")

      let result = g->G.NodesIter.filterNodes((node, _attr) =>
        node->String.startsWith("A")
      )
      let hasAlice = result->Array.includes("Alice")
      let hasAlex = result->Array.includes("Alex")
      expect((result->Array.length, hasAlice, hasAlex))->toEqual((2, true, true))
    })

    test("returns empty array for empty graph", () => {
      let g = G.makeGraph()
      let result = g->G.NodesIter.filterNodes((_node, _attr) => true)
      expect(result)->toEqual([])
    })
  })

  describe("reduceNodes", () => {
    test("collects nodes matching condition", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"score": 10})
      g->G.addNode("Bob", ~attr={"score": 20})
      g->G.addNode("Charlie", ~attr={"score": 15})

      let result = g->G.NodesIter.reduceNodes((acc, node, attr) => {
        if attr["score"] > 12 {
          acc->Array.concat([node])
        } else {
          acc
        }
      }, [])

      let hasBob = result->Array.includes("Bob")
      let hasCharlie = result->Array.includes("Charlie")
      expect((result->Array.length, hasBob, hasCharlie))->toEqual((2, true, true))
    })

    test("filters and collects node names", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      g->G.addNode("Alex")

      let result = g->G.NodesIter.reduceNodes((acc, node, _attr) => {
        if node->String.startsWith("A") {
          acc->Array.concat([node])
        } else {
          acc
        }
      }, [])

      let hasAlice = result->Array.includes("Alice")
      let hasAlex = result->Array.includes("Alex")
      expect((result->Array.length, hasAlice, hasAlex))->toEqual((2, true, true))
    })

    test("returns empty array for empty graph", () => {
      let g = G.makeGraph()
      let result = g->G.NodesIter.reduceNodes((acc, node, _attr) => acc->Array.concat([node]), [])
      expect(result)->toEqual([])
    })

    test("collects all nodes", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"age": 30})
      g->G.addNode("Bob", ~attr={"age": 25})
      g->G.addNode("Charlie", ~attr={"age": 35})

      let result = g->G.NodesIter.reduceNodes((acc, node, _attr) => {
        acc->Array.concat([node])
      }, [])

      expect(result->Array.length)->toBe(3)
    })
  })

  describe("findNode", () => {
    test("finds first node matching predicate", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"age": 30})
      g->G.addNode("Bob", ~attr={"age": 25})
      g->G.addNode("Charlie", ~attr={"age": 35})

      let result = g->G.NodesIter.findNode((_node, attr) => attr["age"] > 28)
      switch result->Nullable.toOption {
      | Some(node) => {
          let isValid = ["Alice", "Charlie"]->Array.includes(node)
          expect(isValid)->toBe(true)
        }
      | None => fail("Expected to find a node")
      }
    })

    test("finds node by name", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")

      let result = g->G.NodesIter.findNode((node, _attr) => node == "Bob")
      expect(result)->toEqual(Nullable.make("Bob"))
    })

    test("finds node by attribute value", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"role": "admin"})
      g->G.addNode("Bob", ~attr={"role": "user"})
      g->G.addNode("Charlie", ~attr={"role": "admin"})

      let result = g->G.NodesIter.findNode((_node, attr) => attr["role"] == "admin")
      switch result->Nullable.toOption {
      | Some(node) => {
          let isValid = ["Alice", "Charlie"]->Array.includes(node)
          expect(isValid)->toBe(true)
        }
      | None => fail("Expected to find a node")
      }
    })
  })

  describe("someNode", () => {
    test("returns true if any node matches", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"age": 30})
      g->G.addNode("Bob", ~attr={"age": 25})

      let result = g->G.NodesIter.someNode((_node, attr) => attr["age"] > 28)
      expect(result)->toBe(true)
    })

    test("returns false if no node matches", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"age": 30})
      g->G.addNode("Bob", ~attr={"age": 25})

      let result = g->G.NodesIter.someNode((_node, attr) => attr["age"] > 40)
      expect(result)->toBe(false)
    })

    test("returns false for empty graph", () => {
      let g = G.makeGraph()
      let result = g->G.NodesIter.someNode((_node, _attr) => true)
      expect(result)->toBe(false)
    })

    test("checks node existence by name", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")

      let hasAlice = g->G.NodesIter.someNode((node, _attr) => node == "Alice")
      let hasCharlie = g->G.NodesIter.someNode((node, _attr) => node == "Charlie")

      expect((hasAlice, hasCharlie))->toEqual((true, false))
    })
  })

  describe("everyNode", () => {
    test("returns true if all nodes match", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"age": 30})
      g->G.addNode("Bob", ~attr={"age": 25})
      g->G.addNode("Charlie", ~attr={"age": 35})

      let result = g->G.NodesIter.everyNode((_node, attr) => attr["age"] > 20)
      expect(result)->toBe(true)
    })

    test("returns false if any node doesn't match", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"age": 30})
      g->G.addNode("Bob", ~attr={"age": 25})
      g->G.addNode("Charlie", ~attr={"age": 18})

      let result = g->G.NodesIter.everyNode((_node, attr) => attr["age"] > 20)
      expect(result)->toBe(false)
    })

    test("returns true for empty graph", () => {
      let g = G.makeGraph()
      let result = g->G.NodesIter.everyNode((_node, _attr) => false)
      expect(result)->toBe(true)
    })

    test("validates all nodes meet condition", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"age": 30})
      g->G.addNode("Bob", ~attr={"age": 25})

      let allHaveValidAge = g->G.NodesIter.everyNode((_node, attr) => {
        attr["age"] >= 0
      })
      expect(allHaveValidAge)->toBe(true)
    })
  })

  describe("nodeEntries", () => {
    test("returns iterator for empty graph", () => {
      let g = G.makeGraph()
      let iter = g->G.NodesIter.nodeEntries
      let next = iter->Iterator.next
      expect(next.done)->toBe(true)
    })

    test("iterates over node entries", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"age": 30})
      g->G.addNode("Bob", ~attr={"age": 25})

      let iter = g->G.NodesIter.nodeEntries
      let nodes = []

      let rec collect = () => {
        let next = iter->Iterator.next
        if !next.done {
          switch next.value {
          | Some(entry) => {
              nodes->Array.push(entry.node)
              collect()
            }
          | None => ()
          }
        }
      }
      collect()

      let hasAlice = nodes->Array.includes("Alice")
      let hasBob = nodes->Array.includes("Bob")
      expect((nodes->Array.length, hasAlice, hasBob))->toEqual((2, true, true))
    })

    test("provides node and attributes", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"age": 30, "city": "NYC"})

      let iter = g->G.NodesIter.nodeEntries
      let next = iter->Iterator.next

      switch next.value {
      | Some(entry) =>
          expect((next.done, entry.node, entry.attributes["age"], entry.attributes["city"]))
            ->toEqual((false, "Alice", 30, "NYC"))
      | None => fail("Expected entry value")
      }
    })

    test("iterator respects JS iterator protocol", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      g->G.addNode("Charlie")

      let iter = g->G.NodesIter.nodeEntries
      let count = ref(0)

      let rec iterate = () => {
        let next = iter->Iterator.next
        if !next.done {
          count := count.contents + 1
          iterate()
        }
      }
      iterate()

      expect(count.contents)->toBe(3)
    })

    test("completed iterator stays done", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")

      let iter = g->G.NodesIter.nodeEntries
      let _first = iter->Iterator.next
      let second = iter->Iterator.next
      let third = iter->Iterator.next

      expect((second.done, third.done))->toEqual((true, true))
    })
  })

  describe("Integration Tests", () => {
    test("combines multiple iteration methods", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"age": 30, "active": true})
      g->G.addNode("Bob", ~attr={"age": 25, "active": false})
      g->G.addNode("Charlie", ~attr={"age": 35, "active": true})

      let activeUsers = g->G.NodesIter.filterNodes((_node, attr) => attr["active"] == true)
      let hasOlderUser = g->G.NodesIter.someNode((_node, attr) => attr["age"] > 30)
      let allNodes = g->G.NodesIter.nodes

      expect((activeUsers->Array.length, hasOlderUser, allNodes->Array.length))->toEqual((2, true, 3))
    })

    test("iteration after graph modification", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      g->G.addNode("Charlie")

      let initialCount = g->G.NodesIter.nodes->Array.length

      g->G.dropNode("Bob")
      let afterDropCount = g->G.NodesIter.nodes->Array.length
      let remaining = g->G.NodesIter.filterNodes((node, _attr) => node != "Alice")

      expect((initialCount, afterDropCount, remaining))->toEqual((3, 2, ["Charlie"]))
    })

    test("works with directed graph", () => {
      let g = G.makeDirectedGraph()
      g->G.addNode("A")
      g->G.addNode("B")
      g->G.addEdge("A", "B")

      let nodes = g->G.NodesIter.nodes
      let allValid = g->G.NodesIter.everyNode((node, _attr) => ["A", "B"]->Array.includes(node))

      expect((nodes->Array.length, allValid))->toEqual((2, true))
    })

    test("works with multi graph", () => {
      let g = G.makeMultiGraph()
      g->G.addNode("A", ~attr={"type": "source"})
      g->G.addNode("B", ~attr={"type": "target"})
      g->G.addNode("C", ~attr={"type": "target"})

      let targets = g->G.NodesIter.filterNodes((_node, attr) => attr["type"] == "target")
      expect(targets->Array.length)->toBe(2)
    })
  })
})