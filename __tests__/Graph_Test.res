open Jest
open Expect
open Graphology

describe("Graph - Core Operations", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  describe("Graph Creation", () => {
    test("creates an empty graph", () => {
      let g = G.makeGraph()
      expect(g->G.order)->toBe(0)
    })

    test("creates a directed graph", () => {
      let g = G.makeDirectedGraph()
      expect(g->G.type_)->toBe("directed")
    })

    test("creates an undirected graph", () => {
      let g = G.makeUndirectedGraph()
      expect(g->G.type_)->toBe("undirected")
    })

    test("creates a multi graph", () => {
      let g = G.makeMultiGraph()
      expect(g->G.multi)->toBe(true)
    })

    test("creates graph with options", () => {
      let g = G.makeGraph(~options={multi: true, allowSelfLoops: false, type_: #directed})
      expect(g->G.multi)->toBe(true)
    })
  })

  describe("Node Operations", () => {
    test("adds a node", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      expect(g->G.hasNode("Alice"))->toBe(true)
    })

    test("adds node with attributes", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"age": 30, "city": "NYC"})
      let attr = g->G.getNodeAttributes("Alice")
      expect(attr["age"])->toEqual(30)
    })

    test("counts nodes correctly", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      g->G.addNode("Charlie")
      expect(g->G.order)->toBe(3)
    })

    test("merges node returns correct tuple", () => {
      let g = G.makeGraph()
      let (node1, isNew1) = g->G.mergeNode("Alice")
      let (_node2, isNew2) = g->G.mergeNode("Alice")
      expect((node1, isNew1, isNew2))->toEqual(("Alice", true, false))
    })

    test("drops a node", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.dropNode("Alice")
      expect(g->G.hasNode("Alice"))->toBe(false)
    })

    test("clears all nodes", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      g->G.clear
      expect(g->G.order)->toBe(0)
    })
  })

  describe("Edge Operations", () => {
    test("adds an edge", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      g->G.addEdge("Alice", "Bob")
      expect(g->G.size)->toBe(1)
    })

    test("adds edge with attributes", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      g->G.addEdge("Alice", "Bob", ~attr={"weight": 5})
      let edge = g->G.edge("Alice", "Bob")
      let attr = g->G.getEdgeAttributes(edge)
      expect(attr["weight"])->toEqual(5)
    })

    test("adds edge with key", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      g->G.addEdgeWithKey("e1", "Alice", "Bob")
      expect(g->G.hasEdge("e1"))->toBe(true)
    })

    test("gets edge source and target", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      g->G.addEdgeWithKey("e1", "Alice", "Bob")
      let source = g->G.source("e1")
      let target = g->G.target("e1")
      expect((source, target))->toEqual(("Alice", "Bob"))
    })

    test("gets edge extremities", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      g->G.addEdgeWithKey("e1", "Alice", "Bob")
      let extremities = g->G.extremities("e1")
      expect(extremities)->toEqual(["Alice", "Bob"])
    })

    test("checks if nodes are neighbors", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      g->G.addEdge("Alice", "Bob")
      expect(g->G.areNeighbors("Alice", "Bob"))->toBe(true)
    })

    test("drops an edge", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      g->G.addEdgeWithKey("e1", "Alice", "Bob")
      g->G.dropEdge("e1")
      expect(g->G.hasEdge("e1"))->toBe(false)
    })

    test("clears all edges", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      g->G.addNode("Charlie")
      g->G.addEdge("Alice", "Bob")
      g->G.addEdge("Bob", "Charlie")
      g->G.clearEdges
      expect((g->G.size, g->G.order))->toEqual((0, 3))
    })
  })

  describe("Node Attributes", () => {
    test("sets and gets node attribute", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.setNodeAttribute("Alice", "age", 30)
      expect(g->G.getNodeAttribute("Alice", "age"))->toEqual(30)
    })

    test("checks if node has attribute", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"age": 30})
      let hasAge = g->G.hasNodeAttribute("Alice", "age")
      let hasCity = g->G.hasNodeAttribute("Alice", "city")
      expect((hasAge, hasCity))->toEqual((true, false))
    })

    test("removes node attribute", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"age": 30})
      g->G.removeNodeAttribute("Alice", "age")
      expect(g->G.hasNodeAttribute("Alice", "age"))->toBe(false)
    })

    test("replaces node attributes", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"age": 30, "city": "NYC"})
      g->G.replaceNodeAttributes("Alice", {"name": "Alice"})
      let hasAge = g->G.hasNodeAttribute("Alice", "age")
      let hasName = g->G.hasNodeAttribute("Alice", "name")
      expect((hasAge, hasName))->toEqual((false, true))
    })

    test("merges node attributes", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice", ~attr={"age": 30})
      g->G.mergeNodeAttributes("Alice", {"city": "NYC"})
      let hasAge = g->G.hasNodeAttribute("Alice", "age")
      let hasCity = g->G.hasNodeAttribute("Alice", "city")
      expect((hasAge, hasCity))->toEqual((true, true))
    })
  })

  describe("Edge Attributes", () => {
    test("sets and gets edge attribute", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      g->G.addEdgeWithKey("e1", "Alice", "Bob")
      g->G.setEdgeAttribute("e1", "weight", 5)
      expect(g->G.getEdgeAttribute("e1", "weight"))->toEqual(5)
    })

    test("checks if edge has attribute", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      g->G.addEdgeWithKey("e1", "Alice", "Bob", ~attr={"weight": 5})
      let hasWeight = g->G.hasEdgeAttribute("e1", "weight")
      let hasColor = g->G.hasEdgeAttribute("e1", "color")
      expect((hasWeight, hasColor))->toEqual((true, false))
    })

    test("removes edge attribute", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      g->G.addEdgeWithKey("e1", "Alice", "Bob", ~attr={"weight": 5})
      g->G.removeEdgeAttribute("e1", "weight")
      expect(g->G.hasEdgeAttribute("e1", "weight"))->toBe(false)
    })
  })

  describe("Graph Attributes", () => {
    test("sets and gets graph attribute", () => {
      let g = G.makeGraph()
      g->G.setAttribute("name", "MyGraph")
      expect(g->G.getAttribute("name"))->toEqual("MyGraph")
    })

    test("checks if graph has attribute", () => {
      let g = G.makeGraph()
      g->G.setAttribute("name", "MyGraph")
      let hasName = g->G.hasAttribute("name")
      let hasDesc = g->G.hasAttribute("description")
      expect((hasName, hasDesc))->toEqual((true, false))
    })

    test("removes graph attribute", () => {
      let g = G.makeGraph()
      g->G.setAttribute("name", "MyGraph")
      g->G.removeAttribute("name")
      expect(g->G.hasAttribute("name"))->toBe(false)
    })
  })

  describe("Degree Operations", () => {
    test("calculates node degree", () => {
      let g = G.makeGraph()
      g->G.addNode("Alice")
      g->G.addNode("Bob")
      g->G.addNode("Charlie")
      g->G.addEdge("Alice", "Bob")
      g->G.addEdge("Alice", "Charlie")
      expect(g->G.degree("Alice"))->toBe(2)
    })

    test("handles self-loops in degree", () => {
      let g = G.makeGraph(~options={allowSelfLoops: true})
      g->G.addNode("Alice")
      g->G.addEdge("Alice", "Alice")
      let withLoops = g->G.degree("Alice")
      let withoutLoops = g->G.degreeWithoutSelfLoops("Alice")
      expect((withLoops, withoutLoops))->toEqual((2, 0))
    })
  })
})

describe("Graph - Node Iteration", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("iterates over nodes", () => {
    let g = G.makeGraph()
    g->G.addNode("Alice")
    g->G.addNode("Bob")
    g->G.addNode("Charlie")

    let nodes = g->G.NodesIter.nodes
    expect(nodes->Array.length)->toBe(3)
  })

  test("forEach over nodes", () => {
    let g = G.makeGraph()
    g->G.addNode("Alice", ~attr={"age": 30})
    g->G.addNode("Bob", ~attr={"age": 25})

    let sum = ref(0)
    g->G.NodesIter.forEachNode((_, attr) => {
      sum := sum.contents + attr["age"]
    })
    expect(sum.contents)->toBe(55)
  })

  test("maps nodes", () => {
    let g = G.makeGraph()
    g->G.addNode("Alice", ~attr={"age": 30})
    g->G.addNode("Bob", ~attr={"age": 25})

    let ages = g->G.NodesIter.mapNodes((_, attr) => attr["age"])
    expect(ages)->toEqual([30, 25])
  })

  test("filters nodes", () => {
    let g = G.makeGraph()
    g->G.addNode("Alice", ~attr={"age": 30})
    g->G.addNode("Bob", ~attr={"age": 25})
    g->G.addNode("Charlie", ~attr={"age": 35})

    let filtered = g->G.NodesIter.filterNodes((_, attr) => attr["age"] > 28)
    expect(filtered->Array.length)->toBe(2)
  })

  test("finds a node", () => {
    let g = G.makeGraph()
    g->G.addNode("Alice", ~attr={"age": 30})
    g->G.addNode("Bob", ~attr={"age": 25})

    let found = g->G.NodesIter.findNode((_, attr) => attr["age"] === 25)
    expect(found)->toBe("Bob")
  })

  test("checks if some node matches predicate", () => {
    let g = G.makeGraph()
    g->G.addNode("Alice", ~attr={"age": 30})
    g->G.addNode("Bob", ~attr={"age": 25})

    let someOver28 = g->G.NodesIter.someNode((_, attr) => attr["age"] > 28)
    let someOver40 = g->G.NodesIter.someNode((_, attr) => attr["age"] > 40)
    expect((someOver28, someOver40))->toEqual((true, false))
  })

  test("checks if every node matches predicate", () => {
    let g = G.makeGraph()
    g->G.addNode("Alice", ~attr={"age": 30})
    g->G.addNode("Bob", ~attr={"age": 25})

    let everyOver20 = g->G.NodesIter.everyNode((_, attr) => attr["age"] > 20)
    let everyOver28 = g->G.NodesIter.everyNode((_, attr) => attr["age"] > 28)
    expect((everyOver20, everyOver28))->toEqual((true, false))
  })
})

describe("Graph - Edge Iteration", () => {
  module G = Graph.MakeGraph({
    type node = string
    type edge = string
  })

  test("iterates over all edges", () => {
    let g = G.makeGraph()
    g->G.addNode("Alice")
    g->G.addNode("Bob")
    g->G.addNode("Charlie")
    g->G.addEdgeWithKey("e1", "Alice", "Bob")
    g->G.addEdgeWithKey("e2", "Bob", "Charlie")

    let edges = g->G.EdgesIter.edges(All)
    expect(edges->Array.length)->toBe(2)
  })

  test("iterates over edges of a node", () => {
    let g = G.makeGraph()
    g->G.addNode("Alice")
    g->G.addNode("Bob")
    g->G.addNode("Charlie")
    g->G.addEdge("Alice", "Bob")
    g->G.addEdge("Alice", "Charlie")
    g->G.addEdge("Bob", "Charlie")

    let edges = g->G.EdgesIter.edges(Node("Alice"))
    expect(edges->Array.length)->toBe(2)
  })

  test("iterates over edges between two nodes", () => {
    let g = G.makeGraph(~options={multi: true})
    g->G.addNode("Alice")
    g->G.addNode("Bob")
    g->G.addEdgeWithKey("e1", "Alice", "Bob")
    g->G.addEdgeWithKey("e2", "Alice", "Bob")

    let edges = g->G.EdgesIter.edges(FromTo("Alice", "Bob"))
    expect(edges->Array.length)->toBe(2)
  })
})
