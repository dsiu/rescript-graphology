open Jest
open Expect
open Graphology

describe("Generators - Classic Graphs", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("creates complete graph with correct edges", () => {
    let g = G.Generators.complete(UndirectedGraph, 5)
    let order = g->G.order
    let size = g->G.size

    // Complete graph K_n has n nodes and n*(n-1)/2 edges
    expect((order, size))->toEqual((5, 10))
  })

  test("creates empty graph with no edges", () => {
    let g = G.Generators.empty(Graph, 5)
    let order = g->G.order
    let size = g->G.size

    expect((order, size))->toEqual((5, 0))
  })

  test("creates ladder graph", () => {
    let g = G.Generators.ladder(UndirectedGraph, 4)
    let order = g->G.order

    // Ladder graph with length n has 2n nodes
    expect(order)->toBe(8)
  })

  test("creates path graph", () => {
    let g = G.Generators.path(UndirectedGraph, 5)
    let order = g->G.order
    let size = g->G.size

    // Path with n nodes has n-1 edges
    expect((order, size))->toEqual((5, 4))
  })

  test("creates directed complete graph", () => {
    let g = G.Generators.complete(DirectedGraph, 4)
    let order = g->G.order
    let type_ = g->G.type_

    expect((order, type_))->toEqual((4, "directed"))
  })

  test("creates multi graph", () => {
    let g = G.Generators.complete(MultiGraph, 3)
    let isMulti = g->G.multi

    expect(isMulti)->toBe(true)
  })
})

describe("Generators - Community Graphs", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("creates caveman graph", () => {
    // l cliques of k nodes each
    let g = G.Generators.caveman(UndirectedGraph, 3, 4)
    let order = g->G.order

    // Should have l * k nodes
    expect(order)->toBe(12)
  })

  test("creates connected caveman graph", () => {
    let g = G.Generators.connectedCaveman(UndirectedGraph, 3, 4)
    let order = g->G.order

    // Should have l * k nodes
    expect(order)->toBe(12)
  })

  test("caveman graph has correct structure", () => {
    let g = G.Generators.caveman(UndirectedGraph, 2, 3)
    let order = g->G.order
    let size = g->G.size

    // 2 cliques of 3 nodes: 6 nodes total
    // Each clique K_3 has 3 edges, so 2 * 3 = 6 edges
    expect((order, size))->toEqual((6, 6))
  })
})

describe("Generators - Random Graphs", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("creates clusters graph", () => {
    let g = G.Generators.clusters(UndirectedGraph, {
      order: 20,
      size: 30,
      clusters: 3,
    })
    let order = g->G.order
    let size = g->G.size

    // Clusters generator produces approximate size, so check order is exact and size is reasonable
    let sizeIsReasonable = size >= 20 && size <= 40
    expect((order, sizeIsReasonable))->toEqual((20, true))
  })

  test("creates clusters with custom density", () => {
    let g = G.Generators.clusters(UndirectedGraph, {
      order: 15,
      size: 20,
      clusters: 2,
      clusterDensity: 0.7,
    })
    let order = g->G.order

    expect(order)->toBe(15)
  })

  test("creates Erdos-Renyi graph", () => {
    let g = G.Generators.erdosRenyi(UndirectedGraph, {
      order: 10,
      probability: 0.3,
      approximateSize: 0,
    })
    let order = g->G.order

    expect(order)->toBe(10)
  })

  test("creates Girvan-Newman graph", () => {
    let g = G.Generators.girvanNewman(UndirectedGraph, {
      zOut: 5,
    })
    let order = g->G.order

    // Girvan-Newman creates 4 communities of 32 nodes each
    expect(order)->toBe(128)
  })

  test("random graphs respect graph type", () => {
    let g = G.Generators.erdosRenyi(DirectedGraph, {
      order: 10,
      probability: 0.2,
      approximateSize: 0,
    })
    let type_ = g->G.type_

    expect(type_)->toBe("directed")
  })
})

describe("Generators - Small Graphs", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("creates Krackhardt Kite graph", () => {
    let g = G.Generators.krackhardtKite(UndirectedGraph)
    let order = g->G.order
    let size = g->G.size

    // Krackhardt Kite has 10 nodes and 18 edges
    expect((order, size))->toEqual((10, 18))
  })

  test("Krackhardt Kite respects graph type", () => {
    let g = G.Generators.krackhardtKite(DirectedGraph)
    let type_ = g->G.type_

    expect(type_)->toBe("directed")
  })
})

describe("Generators - Social Graphs", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("creates Florentine Families graph", () => {
    let g = G.Generators.florentineFamilies(UndirectedGraph)
    let order = g->G.order
    let size = g->G.size

    // Florentine Families has 15 nodes and 20 edges
    expect((order, size))->toEqual((15, 20))
  })

  test("creates Karate Club graph", () => {
    let g = G.Generators.karateClub(UndirectedGraph)
    let order = g->G.order
    let size = g->G.size

    // Karate Club has 34 nodes and 78 edges
    expect((order, size))->toEqual((34, 78))
  })

  test("social graphs respect graph type", () => {
    let g = G.Generators.karateClub(DirectedGraph)
    let type_ = g->G.type_

    expect(type_)->toBe("directed")
  })
})

describe("Generators - Integration Tests", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("generated graph can be traversed", () => {
    let g = G.Generators.complete(UndirectedGraph, 5)
    let visited = []

    g->G.Traversal.bfs((node, _attr, _depth) => {
      visited->Array.push(node)
    })

    expect(visited->Array.length)->toBe(5)
  })

  test("generated graph can have layout applied", () => {
    let g = G.Generators.path(UndirectedGraph, 4)
    G.Layout.Circular.assign(g)

    let hasX = g->G.NodesIter.everyNode((node, _attr) => {
      g->G.hasNodeAttribute(node, "x")
    })
    let hasY = g->G.NodesIter.everyNode((node, _attr) => {
      g->G.hasNodeAttribute(node, "y")
    })

    expect((hasX, hasY))->toEqual((true, true))
  })

  test("generated graph can calculate shortest path", () => {
    let g = G.Generators.path(UndirectedGraph, 5)

    // Get the first and last nodes from the path
    let nodes = g->G.NodesIter.nodes
    let firstNode = nodes->Array.getUnsafe(0)
    let lastNode = nodes->Array.getUnsafe(nodes->Array.length - 1)

    let path = g->G.ShortestPath.Unweighted.bidirectional(firstNode, lastNode)

    // Path length should be equal to the number of nodes in a path graph
    expect(path->Array.length)->toBe(5)
  })

  test("can combine multiple generator outputs", () => {
    let g1 = G.Generators.path(UndirectedGraph, 3)
    let g2 = G.Generators.complete(UndirectedGraph, 2)

    let order1 = g1->G.order
    let order2 = g2->G.order

    expect((order1, order2))->toEqual((3, 2))
  })
})
