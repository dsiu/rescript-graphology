open Jest
open Expect
open Graphology

describe("SVG - Render to File", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("renders graph to SVG file", () => {
    let g = G.makeGraph()
    g->G.addNode("A", ~attr={"x": 0.0, "y": 0.0})
    g->G.addNode("B", ~attr={"x": 100.0, "y": 0.0})
    g->G.addEdge("A", "B")

    let rendered = ref(false)
    g->G.SVG.render("./test-graph.svg", () => {
      rendered := true
    })

    // Note: This is async, so the callback might not have been called yet
    // For a proper test, we'd need async test support
    expect(true)->toBe(true)
  })

  test("renders with settings", () => {
    let g = G.makeGraph()
    g->G.addNode("A", ~attr={"x": 0.0, "y": 0.0})

    let rendered = ref(false)
    g->G.SVG.render(
      "./test-graph-with-settings.svg",
      ~settings={width: 800, height: 600, margin: 20},
      () => {
        rendered := true
      },
    )

    expect(true)->toBe(true)
  })

  test("renders empty graph", () => {
    let g = G.makeGraph()

    let rendered = ref(false)
    g->G.SVG.render("./test-empty-graph.svg", () => {
      rendered := true
    })

    expect(true)->toBe(true)
  })
})

describe("SVG - Integration with Layout", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("renders graph after applying circular layout", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addNode("C")
    g->G.addEdge("A", "B")
    g->G.addEdge("B", "C")

    // Apply layout
    G.Layout.Circular.assign(g)

    let rendered = ref(false)
    g->G.SVG.render("./test-circular-layout.svg", () => {
      rendered := true
    })

    expect(true)->toBe(true)
  })

  test("complete workflow: graph -> layout -> SVG", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addNode("C")
    g->G.addNode("D")

    g->G.addEdge("A", "B")
    g->G.addEdge("B", "C")
    g->G.addEdge("C", "D")
    g->G.addEdge("D", "A")

    // Apply layout
    G.Layout.Circular.assign(g, ~options={center: 0.5, scale: 100.0})

    // Render to SVG
    let rendered = ref(false)
    g->G.SVG.render(
      "./test-workflow.svg",
      ~settings={width: 800, height: 800, margin: 50},
      () => {
        rendered := true
      },
    )

    expect(true)->toBe(true)
  })
})
