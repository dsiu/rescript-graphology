open Jest
open Expect
open Graphology

describe("Utils - Assertions", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("isGraph returns true for valid graph", () => {
    let g = G.makeGraph()
    expect(g->G.Utils.isGraph)->toBe(true)
  })

  test("isGraph returns false for non-graph object", () => {
    let notGraph = %raw(`{foo: 'bar'}`)
    expect(notGraph->G.Utils.isGraph)->toBe(false)
  })

  test("isGraph returns false for null", () => {
    let nullValue = %raw(`null`)
    expect(nullValue->G.Utils.isGraph)->toBe(false)
  })
})

describe("Utils - Introspection", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("inferMulti detects non-multi graph", () => {
    let g = G.makeGraph()
    expect(g->G.Utils.inferMulti)->toBe(false)
  })

  test("inferMulti detects non-multi graph by default", () => {
    let g = G.makeGraph(~options={multi: true})
    // inferMulti returns false until there are actually multiple edges
    expect(g->G.Utils.inferMulti)->toBe(false)
  })

  test("inferMulti detects multi graph from edges", () => {
    let g = G.makeGraph(~options={multi: true})
    g->G.addNode("Alice")
    g->G.addNode("Bob")
    g->G.addEdgeWithKey("e1", "Alice", "Bob")
    g->G.addEdgeWithKey("e2", "Alice", "Bob")

    expect(g->G.Utils.inferMulti)->toBe(true)
  })

  test("inferType detects mixed graph type", () => {
    let g = G.makeGraph()
    expect(g->G.Utils.inferType)->toBe("mixed")
  })

  test("inferType detects directed graph type", () => {
    let g = G.makeDirectedGraph()
    expect(g->G.Utils.inferType)->toBe("directed")
  })

  test("inferType detects undirected graph type", () => {
    let g = G.makeUndirectedGraph()
    expect(g->G.Utils.inferType)->toBe("undirected")
  })
})

describe("Utils - Typical Edge Patterns: Clique", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("mergeClique creates complete graph from nodes", () => {
    let g = G.makeUndirectedGraph()

    g->G.Utils.mergeClique(["A", "B", "C"])

    let order = g->G.order
    let size = g->G.size

    // Complete graph K_3 has 3 nodes and 3 edges
    expect((order, size))->toEqual((3, 3))
  })

  test("mergeClique connects all nodes to each other", () => {
    let g = G.makeUndirectedGraph()

    g->G.Utils.mergeClique(["A", "B", "C", "D"])

    // Verify all pairs are connected
    let allConnected =
      g->G.areNeighbors("A", "B") &&
      g->G.areNeighbors("A", "C") &&
      g->G.areNeighbors("A", "D") &&
      g->G.areNeighbors("B", "C") &&
      g->G.areNeighbors("B", "D") &&
      g->G.areNeighbors("C", "D")

    expect(allConnected)->toBe(true)
  })

  test("mergeClique with single node does not add node", () => {
    let g = G.makeGraph()

    g->G.Utils.mergeClique(["A"])

    // mergeClique doesn't add nodes when there's only one
    expect((g->G.order, g->G.size))->toEqual((0, 0))
  })

  test("mergeClique with two nodes creates single edge", () => {
    let g = G.makeUndirectedGraph()

    g->G.Utils.mergeClique(["A", "B"])

    expect((g->G.order, g->G.size))->toEqual((2, 1))
  })

  test("mergeClique does not duplicate existing nodes", () => {
    let g = G.makeUndirectedGraph()
    g->G.addNode("A")

    g->G.Utils.mergeClique(["A", "B", "C"])

    expect(g->G.order)->toBe(3)
  })
})

describe("Utils - Typical Edge Patterns: Cycle", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("mergeCycle creates cycle from nodes", () => {
    let g = G.makeUndirectedGraph()

    g->G.Utils.mergeCycle(["A", "B", "C", "D"])

    let order = g->G.order
    let size = g->G.size

    // Cycle has n nodes and n edges
    expect((order, size))->toEqual((4, 4))
  })

  test("mergeCycle connects nodes in circular pattern", () => {
    let g = G.makeUndirectedGraph()

    g->G.Utils.mergeCycle(["A", "B", "C"])

    // Verify cycle: A-B, B-C, C-A
    let isCycle =
      g->G.areNeighbors("A", "B") &&
      g->G.areNeighbors("B", "C") &&
      g->G.areNeighbors("C", "A")

    expect(isCycle)->toBe(true)
  })

  test("mergeCycle with two nodes creates back-and-forth edge", () => {
    let g = G.makeUndirectedGraph()

    g->G.Utils.mergeCycle(["A", "B"])

    // Should create A-B and B-A (or just one edge in undirected)
    expect((g->G.order, g->G.size))->toEqual((2, 1))
  })

  test("mergeCycle each node has degree 2", () => {
    let g = G.makeUndirectedGraph()

    g->G.Utils.mergeCycle(["A", "B", "C", "D", "E"])

    // In a cycle, every node has exactly 2 neighbors
    let allDegree2 =
      g->G.degree("A") === 2 &&
      g->G.degree("B") === 2 &&
      g->G.degree("C") === 2 &&
      g->G.degree("D") === 2 &&
      g->G.degree("E") === 2

    expect(allDegree2)->toBe(true)
  })
})

describe("Utils - Typical Edge Patterns: Path", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("mergePath creates path from nodes", () => {
    let g = G.makeUndirectedGraph()

    g->G.Utils.mergePath(["A", "B", "C", "D"])

    let order = g->G.order
    let size = g->G.size

    // Path has n nodes and n-1 edges
    expect((order, size))->toEqual((4, 3))
  })

  test("mergePath connects nodes in linear sequence", () => {
    let g = G.makeUndirectedGraph()

    g->G.Utils.mergePath(["A", "B", "C", "D"])

    // Verify path: A-B-C-D
    let isPath =
      g->G.areNeighbors("A", "B") &&
      g->G.areNeighbors("B", "C") &&
      g->G.areNeighbors("C", "D") &&
      !(g->G.areNeighbors("A", "C")) &&
      !(g->G.areNeighbors("A", "D"))

    expect(isPath)->toBe(true)
  })

  test("mergePath with single node creates isolated node", () => {
    let g = G.makeGraph()

    g->G.Utils.mergePath(["A"])

    expect((g->G.order, g->G.size))->toEqual((1, 0))
  })

  test("mergePath endpoints have degree 1", () => {
    let g = G.makeUndirectedGraph()

    g->G.Utils.mergePath(["A", "B", "C", "D", "E"])

    // Endpoints have degree 1, middle nodes have degree 2
    let endpointsDegree1 = g->G.degree("A") === 1 && g->G.degree("E") === 1
    let middleNodesDegree2 =
      g->G.degree("B") === 2 &&
      g->G.degree("C") === 2 &&
      g->G.degree("D") === 2

    expect((endpointsDegree1, middleNodesDegree2))->toEqual((true, true))
  })
})

describe("Utils - Typical Edge Patterns: Star", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("mergeStar creates star graph from nodes", () => {
    let g = G.makeUndirectedGraph()

    g->G.Utils.mergeStar(["Center", "A", "B", "C"])

    let order = g->G.order
    let size = g->G.size

    // Star has n nodes and n-1 edges (all connected to center)
    expect((order, size))->toEqual((4, 3))
  })

  test("mergeStar connects all nodes to first node", () => {
    let g = G.makeUndirectedGraph()

    g->G.Utils.mergeStar(["Center", "A", "B", "C"])

    // Verify star: Center is connected to all others
    let isStar =
      g->G.areNeighbors("Center", "A") &&
      g->G.areNeighbors("Center", "B") &&
      g->G.areNeighbors("Center", "C") &&
      !(g->G.areNeighbors("A", "B")) &&
      !(g->G.areNeighbors("B", "C"))

    expect(isStar)->toBe(true)
  })

  test("mergeStar center has degree n-1", () => {
    let g = G.makeUndirectedGraph()

    g->G.Utils.mergeStar(["Center", "A", "B", "C", "D", "E"])

    // Center has degree 5 (connected to all other nodes)
    let centerDegree = g->G.degree("Center")
    // Leaf nodes have degree 1 (connected only to center)
    let leafDegree = g->G.degree("A")

    expect((centerDegree, leafDegree))->toEqual((5, 1))
  })

  test("mergeStar with two nodes creates single edge", () => {
    let g = G.makeUndirectedGraph()

    g->G.Utils.mergeStar(["A", "B"])

    expect((g->G.order, g->G.size))->toEqual((2, 1))
  })

  test("mergeStar with one node creates isolated node", () => {
    let g = G.makeGraph()

    g->G.Utils.mergeStar(["A"])

    expect((g->G.order, g->G.size))->toEqual((1, 0))
  })
})

describe("Utils - Miscellaneous: renameGraphKeys", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("renameGraphKeys renames nodes", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addEdgeWithKey("e1", "A", "B")

    let nodeMapping = Dict.fromArray([("A", "X"), ("B", "Y")])
    let edgeMapping = Dict.fromArray([])

    let g2 = g->G.Utils.renameGraphKeys(nodeMapping, edgeMapping)

    let hasOldNodes = g2->G.hasNode("A") || g2->G.hasNode("B")
    let hasNewNodes = g2->G.hasNode("X") && g2->G.hasNode("Y")

    expect((hasOldNodes, hasNewNodes))->toEqual((false, true))
  })

  test("renameGraphKeys renames edges", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addEdgeWithKey("e1", "A", "B")

    let nodeMapping = Dict.fromArray([])
    let edgeMapping = Dict.fromArray([("e1", "edge1")])

    let g2 = g->G.Utils.renameGraphKeys(nodeMapping, edgeMapping)

    let hasOldEdge = g2->G.hasEdge("e1")
    let hasNewEdge = g2->G.hasEdge("edge1")

    expect((hasOldEdge, hasNewEdge))->toEqual((false, true))
  })

  test("renameGraphKeys preserves node attributes", () => {
    let g = G.makeGraph()
    g->G.addNode("A", ~attr={"value": 42})

    let nodeMapping = Dict.fromArray([("A", "X")])
    let edgeMapping = Dict.fromArray([])

    let g2 = g->G.Utils.renameGraphKeys(nodeMapping, edgeMapping)

    let attr = g2->G.getNodeAttributes("X")
    expect(attr["value"])->toEqual(42)
  })

  test("renameGraphKeys preserves edge attributes", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addEdgeWithKey("e1", "A", "B", ~attr={"weight": 10})

    let nodeMapping = Dict.fromArray([])
    let edgeMapping = Dict.fromArray([("e1", "edge1")])

    let g2 = g->G.Utils.renameGraphKeys(nodeMapping, edgeMapping)

    let attr = g2->G.getEdgeAttributes("edge1")
    expect(attr["weight"])->toEqual(10)
  })

  test("renameGraphKeys with empty mappings returns copy", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addEdge("A", "B")

    let nodeMapping = Dict.fromArray([])
    let edgeMapping = Dict.fromArray([])

    let g2 = g->G.Utils.renameGraphKeys(nodeMapping, edgeMapping)

    let hasNodes = g2->G.hasNode("A") && g2->G.hasNode("B")
    let order = g2->G.order
    let size = g2->G.size

    expect((hasNodes, order, size))->toEqual((true, 2, 1))
  })
})

describe("Utils - Miscellaneous: updateGraphKeys", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("updateGraphKeys updates node keys based on node data", () => {
    let g = G.makeGraph()
    g->G.addNode("1", ~attr={"name": "Alice"})
    g->G.addNode("2", ~attr={"name": "Bob"})
    g->G.addEdgeWithKey("e1", "1", "2")

    let nodeKeyUpdater = (node, attr) => {
      switch attr["name"] {
      | name => name
      | exception _ => node
      }
    }
    let edgeKeyUpdater = (_edge, _attr) => "e1"

    let g2 = g->G.Utils.updateGraphKeys(nodeKeyUpdater, edgeKeyUpdater)

    let hasNewNodes = g2->G.hasNode("Alice") && g2->G.hasNode("Bob")
    let hasOldNodes = g2->G.hasNode("1") || g2->G.hasNode("2")

    expect((hasNewNodes, hasOldNodes))->toEqual((true, false))
  })

  test("updateGraphKeys updates edge keys based on edge data", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addEdgeWithKey("e1", "A", "B", ~attr={"type": "friend"})

    let nodeKeyUpdater = (node, _attr) => node
    let edgeKeyUpdater = (_edge, attr) => {
      switch attr["type"] {
      | t => t
      | exception _ => "unknown"
      }
    }

    let g2 = g->G.Utils.updateGraphKeys(nodeKeyUpdater, edgeKeyUpdater)

    let hasNewEdge = g2->G.hasEdge("friend")
    let hasOldEdge = g2->G.hasEdge("e1")

    expect((hasNewEdge, hasOldEdge))->toEqual((true, false))
  })

  test("updateGraphKeys preserves attributes", () => {
    let g = G.makeGraph()
    g->G.addNode("1", ~attr={"value": 100})

    let nodeKeyUpdater = (node, _attr) => `node_${node}`
    let edgeKeyUpdater = (edge, _attr) => edge

    let g2 = g->G.Utils.updateGraphKeys(nodeKeyUpdater, edgeKeyUpdater)

    let attr = g2->G.getNodeAttributes("node_1")
    expect(attr["value"])->toEqual(100)
  })

  test("updateGraphKeys handles graph structure correctly", () => {
    let g = G.makeGraph()
    g->G.addNode("A", ~attr={"id": 1})
    g->G.addNode("B", ~attr={"id": 2})
    g->G.addEdgeWithKey("e1", "A", "B")

    let nodeKeyUpdater = (_node, attr) => {
      switch attr["id"] {
      | id => `n${Belt.Int.toString(id)}`
      | exception _ => "unknown"
      }
    }
    let edgeKeyUpdater = (edge, _attr) => edge

    let g2 = g->G.Utils.updateGraphKeys(nodeKeyUpdater, edgeKeyUpdater)

    // Verify the renamed nodes are properly connected
    let hasEdge = g2->G.areNeighbors("n1", "n2")
    let order = g2->G.order
    let size = g2->G.size

    expect((hasEdge, order, size))->toEqual((true, 2, 1))
  })
})

describe("Utils - Integration with Other Operations", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("pattern functions work with directed graphs", () => {
    let g = G.makeDirectedGraph()

    g->G.Utils.mergePath(["A", "B", "C"])

    // In directed graph, path should be A->B->C
    let hasForwardEdges = g->G.areNeighbors("A", "B") && g->G.areNeighbors("B", "C")

    expect(hasForwardEdges)->toBe(true)
  })

  test("can apply patterns to existing graph", () => {
    let g = G.makeUndirectedGraph()
    g->G.addNode("X")

    g->G.Utils.mergePath(["A", "B", "C"])

    // Graph should have original node plus path nodes
    let order = g->G.order
    let hasX = g->G.hasNode("X")

    expect((order, hasX))->toEqual((4, true))
  })

  test("pattern functions can be combined", () => {
    let g = G.makeUndirectedGraph()

    // Create a path and a star
    g->G.Utils.mergePath(["A", "B", "C"])
    g->G.Utils.mergeStar(["C", "D", "E"])

    // C should be connected to B (from path) and D, E (from star)
    let cDegree = g->G.degree("C")
    let order = g->G.order

    expect((order, cDegree))->toEqual((5, 3))
  })

  test("renameGraphKeys maintains graph topology", () => {
    let g = G.makeUndirectedGraph()
    g->G.Utils.mergePath(["A", "B", "C", "D"])

    let nodeMapping = Dict.fromArray([("A", "1"), ("B", "2"), ("C", "3"), ("D", "4")])
    let edgeMapping = Dict.fromArray([])

    let g2 = g->G.Utils.renameGraphKeys(nodeMapping, edgeMapping)

    // Verify path structure is maintained: 1-2-3-4
    let isPath =
      g2->G.areNeighbors("1", "2") &&
      g2->G.areNeighbors("2", "3") &&
      g2->G.areNeighbors("3", "4")

    expect(isPath)->toBe(true)
  })
})