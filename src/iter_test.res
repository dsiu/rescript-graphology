open Graphology

let log = Console.log
let log2 = Console.log2

module H = Graph.MakeGraph({
  type node = string
  type edge = string
})
let h = H.makeGraph()


type myNodeAttr = {"lastName": string, "age": int}

h->H.addNode("John", ~attr={"lastName": "Doe", "age": 30})
h->H.addNode("Peter", ~attr={"lastName": "Choi", "age": 21})
h->H.addNode("Mary")


type myEdgeAttr = {"dist":int}
h->H.addEdge("John", "Peter", ~attr={"dist": 23})
h->H.addEdge("Peter", "Mary", ~attr={"dist": 12})

//h->H.inspect->log2("inspect", _)
//h->H.getNodeAttribute("John", "lastName")->log
//h->H.getNodeAttribute("Peter", "age")->log
let nodeIter: Iterator.t<H.NodesIter.nodeIterValue<myNodeAttr>> = h->H.NodesIter.nodeEntries

let nodeArr = Array.fromIterator(nodeIter)
nodeArr->log2("arr", _)

let edgeIter: Iterator.t<H.EdgesIter.edgeIterValue<myEdgeAttr, myNodeAttr>> = h->H.EdgesIter.directedEdgeEntries(H.EdgesIter.Node("John"))
let edgeArr = Array.fromIterator(edgeIter)
edgeArr->log2("edgeArr", _)

//  iter->(log2("iter", _))
//iter->Iterator.forEach(v => {
//  v->log2("v:", _)
//})
//
//  let arr = iter->Iterator.toArray
//  arr->(log2("arr", _))
//  let arr2 = arr->Array.map(({node, attributes}) => {
//    node->log
//    attributes->log
//    node ++ " - " ++ attributes["lastName"]
//  })
//
//  arr2->log
