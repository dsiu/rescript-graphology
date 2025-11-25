open Jest
open Expect
open Graphology

describe("GEXF - Write/Export", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("exports graph to GEXF string", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addEdge("A", "B")

    let gexfStr = g->G.GEXF.write

    let hasLength = gexfStr->String.length > 0
    let hasXml = gexfStr->String.includes("<?xml")
    let hasGexf = gexfStr->String.includes("gexf")
    expect((hasLength, hasXml, hasGexf))->toEqual((true, true, true))
  })

  test("exports with version option", () => {
    let g = G.makeGraph()
    g->G.addNode("A")

    let gexfStr = g->G.GEXF.write(~options={version: "1.3"})

    expect(gexfStr->String.includes("1.3"))->toBe(true)
  })

  test("exports with custom node formatter", () => {
    let g = G.makeGraph()
    g->G.addNode("A", ~attr={"name": "Alice", "age": 30})

    let gexfStr = g->G.GEXF.write(
      ~options={
        version: "1.3",
        formatNode: (key, attributes) => {
          {
            "label": key,
            "attributes": {
              "name": attributes["name"],
            },
          }
        },
      },
    )

    expect(gexfStr->String.includes("Alice"))->toBe(true)
  })

  test("exports with custom edge formatter", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addEdge("A", "B", ~attr={"weight": 5})

    let gexfStr = g->G.GEXF.write(
      ~options={
        version: "1.3",
        formatEdge: (_key, attributes) => {
          {
            "weight": attributes["weight"],
          }
        },
      },
    )

    expect(gexfStr->String.length)->toBeGreaterThan(0)
  })

  test("exports empty graph", () => {
    let g = G.makeGraph()

    let gexfStr = g->G.GEXF.write

    let hasXml = gexfStr->String.includes("<?xml")
    let hasGexf = gexfStr->String.includes("gexf")
    expect((hasXml, hasGexf))->toEqual((true, true))
  })

  test("exports graph with attributes", () => {
    let g = G.makeGraph()
    g->G.setAttribute("name", "TestGraph")
    g->G.addNode("A")
    g->G.addNode("B")

    let gexfStr = g->G.GEXF.write

    expect(gexfStr->String.length)->toBeGreaterThan(0)
  })

  test("exports multi-graph", () => {
    let g = G.makeGraph(~options={multi: true})
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addEdgeWithKey("e1", "A", "B")
    g->G.addEdgeWithKey("e2", "A", "B")

    let gexfStr = g->G.GEXF.write

    expect(gexfStr->String.length)->toBeGreaterThan(0)
  })

  test("handles directed graph", () => {
    let g = G.makeDirectedGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addEdge("A", "B")

    let gexfStr = g->G.GEXF.write

    expect(gexfStr->String.includes("directed"))->toBe(true)
  })

  test("handles undirected graph", () => {
    let g = G.makeUndirectedGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addEdge("A", "B")

    let gexfStr = g->G.GEXF.write

    expect(gexfStr->String.includes("undirected"))->toBe(true)
  })

  test("handles graph with only nodes", () => {
    let g = G.makeGraph()
    g->G.addNode("A")
    g->G.addNode("B")
    g->G.addNode("C")

    let gexfStr = g->G.GEXF.write
    let hasNodes = gexfStr->String.includes("<nodes")
    let hasEdges = gexfStr->String.includes("<edges")

    expect((hasNodes, hasEdges))->toEqual((true, true))
  })
})
