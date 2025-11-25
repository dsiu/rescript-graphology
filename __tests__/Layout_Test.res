open Jest
open Expect
open Graphology

describe("Layout - Circular", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("generates circular layout positions", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addNode("C")
    g->G.addNode("D")

    let positions = g->G.Layout.Circular.circular
    let keys = positions->Dict.keysToArray

    expect(keys->Array.length)->toBe(4)
    // Each node should have x and y coordinates
  })

  test("assigns circular layout to graph", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addNode("C")

    G.Layout.Circular.assign(g)

    // Nodes should now have x and y attributes
    let hasX = g->G.hasNodeAttribute("A", "x")
    let hasY = g->G.hasNodeAttribute("A", "y")
    expect((hasX, hasY))->toEqual((true, true))
  })

  test("respects layout options", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")

    G.Layout.Circular.assign(g, ~options={center: 0.0, scale: 10.0})

    // Nodes should have positions
    let xA = g->G.getNodeAttribute("A", "x")
    let yA = g->G.getNodeAttribute("A", "y")

    expect((xA != Nullable.undefined, yA != Nullable.undefined))->toEqual((true, true))
  })

  test("handles single node", () => {
    let g = G.makeGraph()
    g->G.addNode("A")

    let positions = g->G.Layout.Circular.circular
    expect(positions->Dict.keysToArray->Array.length)->toBe(1)
  })
})

describe("Layout - CirclePack", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("generates circle pack layout", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addNode("C")

    let positions = G.Layout.CirclePack.circlePack(g)
    let keys = positions->Dict.keysToArray

    expect(keys->Array.length)->toBe(3)
  })

  test("assigns circle pack layout", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")

    G.Layout.CirclePack.assign(g)

    let hasX = g->G.hasNodeAttribute("A", "x")
    let hasY = g->G.hasNodeAttribute("A", "y")
    expect((hasX, hasY))->toEqual((true, true))
  })
})

describe("Layout - Rotation", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("rotates layout by angle", () => {
    let g = G.makeGraph()
    g->G.addNode("A", ~attr={"x": 1.0, "y": 0.0})
    g->G.addNode("B", ~attr={"x": 0.0, "y": 1.0})

    let originalX = g->G.getNodeAttribute("A", "x")

    // Rotate by 90 degrees (Math.PI / 2)
    G.Layout.Rotation.assign(g, 3.14159 /. 2.0)

    let newX = g->G.getNodeAttribute("A", "x")

    // After 90 degree rotation, coordinates should change
    expect(newX != originalX)->toBe(true)
  })

  test("handles zero rotation", () => {
    let g = G.makeGraph()
    g->G.addNode("A", ~attr={"x": 1.0, "y": 0.0})

    let originalX = g->G.getNodeAttribute("A", "x")
    let originalY = g->G.getNodeAttribute("A", "y")

    G.Layout.Rotation.assign(g, 0.0)

    let newX = g->G.getNodeAttribute("A", "x")
    let newY = g->G.getNodeAttribute("A", "y")

    // Coordinates should remain the same (with small floating point tolerance)
    let xDiff = Math.abs(newX -. originalX)
    let yDiff = Math.abs(newY -. originalY)
    expect((xDiff < 0.0001, yDiff < 0.0001))->toEqual((true, true))
  })
})

describe("Layout - Utils", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("collects layout as dictionary", () => {
    let g = G.makeGraph()
    g->G.addNode("A", ~attr={"x": 1.0, "y": 2.0})
    g->G.addNode("B", ~attr={"x": 3.0, "y": 4.0})

    let layout = g->G.Layout.Utils.collectLayout

    let posA = layout->Dict.get("A")
    let posB = layout->Dict.get("B")
    expect((posA, posB))->toEqual((Some({x: 1.0, y: 2.0}), Some({x: 3.0, y: 4.0})))
  })

  test("collects layout as flat array", () => {
    let g = G.makeGraph()
    g->G.addNode("A", ~attr={"x": 1.0, "y": 2.0})
    g->G.addNode("B", ~attr={"x": 3.0, "y": 4.0})

    let flatLayout = g->G.Layout.Utils.collectLayoutAsFlatArray

    // Should be [1.0, 2.0, 3.0, 4.0] or similar
    expect(flatLayout->Array.length)->toBe(4)
  })

  test("handles graph with missing coordinates", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B", ~attr={"x": 1.0, "y": 2.0})

    // Should handle nodes without x, y coordinates gracefully
    let layout = g->G.Layout.Utils.collectLayout
    expect(layout->Dict.keysToArray->Array.length)->toBeGreaterThan(0)
  })
})

describe("Layout - Integration", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("can chain different layouts", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addNode("C")

    // Apply circular layout
    G.Layout.Circular.assign(g)

    // Then rotate
    G.Layout.Rotation.assign(g, 1.5708) // 90 degrees

    // Should still have valid coordinates
    let hasX = g->G.hasNodeAttribute("A", "x")
    let hasY = g->G.hasNodeAttribute("A", "y")
    expect((hasX, hasY))->toEqual((true, true))
  })

  test("layout works with graph structure", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addNode("C")
    g->G.addEdge("A", "B")
    g->G.addEdge("B", "C")

    G.Layout.Circular.assign(g)

    let layout = g->G.Layout.Utils.collectLayout

    // All nodes should have layout
    expect(layout->Dict.keysToArray->Array.length)->toBe(3)
  })
})
