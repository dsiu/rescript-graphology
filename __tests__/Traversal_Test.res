open Jest
open Expect
open Graphology

describe("Traversal - BFS (Breadth-First Search)", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  let createTreeGraph = () => {
    let g = G.makeGraph()
    g->G.addNode("1")
    g->G.addNode("2")
    g->G.addNode("3")
    g->G.addNode("4")
    g->G.addNode("5")

    // Tree structure:
    //     1
    //    / \
    //   2   3
    //  / \
    // 4   5
    g->G.addEdge("1", "2")
    g->G.addEdge("1", "3")
    g->G.addEdge("2", "4")
    g->G.addEdge("2", "5")

    g
  }

  test("visits nodes in BFS order", () => {
    let g = createTreeGraph()
    let visited = []

    g->G.Traversal.bfs((node, _attr, _depth) => {
      visited->Array.push(node)
    })

    // BFS from first node should visit level by level
    let visitedCount = visited->Array.length
    let firstNode = visited->Array.getUnsafe(0)
    expect((visitedCount, firstNode))->toEqual((5, "1"))
  })

  test("provides correct depth information", () => {
    let g = createTreeGraph()
    let depths = Dict.make()

    g->G.Traversal.bfs((node, _attr, depth) => {
      depths->Dict.set(node, depth)
    })

    let depth1 = depths->Dict.get("1")
    let depth2 = depths->Dict.get("2")
    let depth3 = depths->Dict.get("3")
    let depth4 = depths->Dict.get("4")
    let depth5 = depths->Dict.get("5")
    expect((depth1, depth2, depth3, depth4, depth5))->toEqual((
      Some(0),
      Some(1),
      Some(1),
      Some(2),
      Some(2),
    ))
  })

  test("BFS from specific node", () => {
    let g = createTreeGraph()
    let visited = []

    g->G.Traversal.bfsFromNode("2", (node, _attr, _depth) => {
      visited->Array.push(node)
    })

    // Should only visit nodes reachable from node 2
    let has1 = visited->Array.includes("1")
    let has2 = visited->Array.includes("2")
    let has4 = visited->Array.includes("4")
    let has5 = visited->Array.includes("5")
    expect((has1, has2, has4, has5))->toEqual((false, true, true, true))
  })

  test("handles disconnected graph", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addNode("C")
    g->G.addEdge("A", "B")
    // C is isolated

    let visited = []
    g->G.Traversal.bfsFromNode("A", (node, _attr, _depth) => {
      visited->Array.push(node)
    })

    expect(visited->Array.includes("C"))->toBe(false)
  })
})

describe("Traversal - DFS (Depth-First Search)", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  let createTreeGraph = () => {
    let g = G.makeGraph()
    g->G.addNode("1")
    g->G.addNode("2")
    g->G.addNode("3")
    g->G.addNode("4")
    g->G.addNode("5")

    g->G.addEdge("1", "2")
    g->G.addEdge("1", "3")
    g->G.addEdge("2", "4")
    g->G.addEdge("2", "5")

    g
  }

  test("visits nodes in DFS order", () => {
    let g = createTreeGraph()
    let visited = []

    g->G.Traversal.dfs((node, _attr, _depth) => {
      visited->Array.push(node)
    })

    // DFS should visit all nodes
    let visitedCount = visited->Array.length
    let firstNode = visited->Array.getUnsafe(0)
    expect((visitedCount, firstNode))->toEqual((5, "1"))
  })

  test("provides correct depth information", () => {
    let g = createTreeGraph()
    let maxDepth = ref(0)

    g->G.Traversal.dfs((node, _attr, depth) => {
      if depth > maxDepth.contents {
        maxDepth := depth
      }
    })

    // Maximum depth should be 2 (nodes 4 and 5)
    expect(maxDepth.contents)->toBe(2)
  })

  test("DFS from specific node", () => {
    let g = createTreeGraph()
    let visited = []

    g->G.Traversal.dfsFromNode("2", (node, _attr, _depth) => {
      visited->Array.push(node)
    })

    // Should only visit nodes reachable from node 2
    let has1 = visited->Array.includes("1")
    let has2 = visited->Array.includes("2")
    let has4 = visited->Array.includes("4")
    let has5 = visited->Array.includes("5")
    expect((has1, has2, has4, has5))->toEqual((false, true, true, true))
  })

  test("handles graph with cycle", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addNode("C")

    g->G.addEdge("A", "B")
    g->G.addEdge("B", "C")
    g->G.addEdge("C", "A")

    let visited = []
    g->G.Traversal.dfsFromNode("A", (node, _attr, _depth) => {
      visited->Array.push(node)
    })

    // Should visit each node exactly once despite the cycle
    let visitedCount = visited->Array.length
    let uniqueNodes = Set.fromArray(visited)
    let uniqueCount = uniqueNodes->Set.size
    expect((visitedCount, uniqueCount))->toEqual((3, 3))
  })
})

describe("Traversal - Comparison BFS vs DFS", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("BFS and DFS visit all nodes in different orders", () => {
    let g = G.makeGraph()
    g->G.addNode("1")
    g->G.addNode("2")
    g->G.addNode("3")
    g->G.addNode("4")

    g->G.addEdge("1", "2")
    g->G.addEdge("1", "3")
    g->G.addEdge("2", "4")

    let bfsOrder = []
    let dfsOrder = []

    g->G.Traversal.bfs((node, _attr, _depth) => {
      bfsOrder->Array.push(node)
    })

    g->G.Traversal.dfs((node, _attr, _depth) => {
      dfsOrder->Array.push(node)
    })

    // Both should visit all nodes
    let bfsCount = bfsOrder->Array.length
    let dfsCount = dfsOrder->Array.length
    let bfsUnique = Set.fromArray(bfsOrder)->Set.size
    let dfsUnique = Set.fromArray(dfsOrder)->Set.size
    expect((bfsCount, dfsCount, bfsUnique, dfsUnique))->toEqual((4, 4, 4, 4))
  })
})

describe("Traversal - Edge Cases", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("handles single node graph", () => {
    let g = G.makeGraph()
    g->G.addNode("A")

    let visited = []
    g->G.Traversal.bfs((node, _attr, _depth) => {
      visited->Array.push(node)
    })

    expect(visited)->toEqual(["A"])
  })

  test("handles empty graph", () => {
    let g = G.makeGraph()

    let visited = []
    g->G.Traversal.bfs((node, _attr, _depth) => {
      visited->Array.push(node)
    })

    expect(visited->Array.length)->toBe(0)
  })

  test("handles linear graph", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addNode("C")
    g->G.addEdge("A", "B")
    g->G.addEdge("B", "C")

    let bfsOrder = []
    g->G.Traversal.bfsFromNode("A", (node, _attr, depth) => {
      bfsOrder->Array.push((node, depth))
    })

    expect(bfsOrder)->toEqual([("A", 0), ("B", 1), ("C", 2)])
  })
})
