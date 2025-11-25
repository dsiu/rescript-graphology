open Jest
open Expect
open Graphology

describe("SimplePath - All Simple Paths", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  let createTestGraph = () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addNode("C")
    g->G.addNode("D")

    // Create multiple paths from A to D
    g->G.addEdge("A", "B")
    g->G.addEdge("B", "D")
    g->G.addEdge("A", "C")
    g->G.addEdge("C", "D")
    g->G.addEdge("B", "C")

    g
  }

  test("finds all simple paths between two nodes", () => {
    let g = createTestGraph()
    let paths = g->G.SimplePath.allSimplePaths("A", "D", ())

    // Should find multiple paths from A to D
    let numPaths = paths->Array.length
    let allStartWithA = paths->Array.every(path => path->Array.getUnsafe(0) === "A")
    let allEndWithD = paths->Array.every(path => path->Array.getUnsafe(path->Array.length - 1) === "D")

    expect((numPaths > 1, allStartWithA, allEndWithD))->toEqual((true, true, true))
  })

  test("handles direct connection", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addEdge("A", "B")

    let paths = g->G.SimplePath.allSimplePaths("A", "B", ())
    let numPaths = paths->Array.length
    let firstPath = paths->Array.getUnsafe(0)
    expect((numPaths, firstPath))->toEqual((1, ["A", "B"]))
  })

  test("returns empty array for unreachable nodes", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addNode("C")
    g->G.addEdge("A", "B")
    // C is isolated

    let paths = g->G.SimplePath.allSimplePaths("A", "C", ())
    expect(paths->Array.length)->toBe(0)
  })

  test("handles graph with cycles", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addNode("C")

    // Create a cycle
    g->G.addEdge("A", "B")
    g->G.addEdge("B", "C")
    g->G.addEdge("C", "A")

    let paths = g->G.SimplePath.allSimplePaths("A", "C", ())

    // Should find paths without revisiting nodes
    let hasPath = paths->Array.length > 0
    let allSimple = paths->Array.every(path => {
      // No node should appear twice in a simple path
      let nodeSet = Set.fromArray(path)
      nodeSet->Set.size === path->Array.length
    })
    expect((hasPath, allSimple))->toEqual((true, true))
  })
})

describe("SimplePath - All Simple Edge Paths", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("finds all simple edge paths", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addNode("C")
    g->G.addEdgeWithKey("e1", "A", "B")
    g->G.addEdgeWithKey("e2", "B", "C")
    g->G.addEdgeWithKey("e3", "A", "C")

    let edgePaths = g->G.SimplePath.allSimpleEdgePaths("A", "C", ())

    expect(edgePaths->Array.length)->toBe(2)
    // One direct path (e3) and one path through B (e1, e2)
  })

  test("edge paths correspond to node paths", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addNode("C")
    g->G.addEdgeWithKey("e1", "A", "B")
    g->G.addEdgeWithKey("e2", "B", "C")

    let edgePaths = g->G.SimplePath.allSimpleEdgePaths("A", "C", ())
    let numPaths = edgePaths->Array.length
    let firstPath = edgePaths->Array.getUnsafe(0)
    expect((numPaths, firstPath))->toEqual((1, ["e1", "e2"]))
  })
})

describe("SimplePath - All Simple Edge Group Paths", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("finds all simple edge group paths", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addNode("C")
    g->G.addEdgeWithKey("e1", "A", "B")
    g->G.addEdgeWithKey("e2", "B", "C")
    g->G.addEdgeWithKey("e3", "A", "C")

    let edgeGroupPaths = g->G.SimplePath.allSimpleEdgeGroupPaths("A", "C", ())

    expect(edgeGroupPaths->Array.length)->toBe(2)
    // Each group represents node groups involved in a path
  })
})
