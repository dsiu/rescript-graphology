module type T = {
  type t
  type node
  type edge
  type graphAttr<'a> = {..} as 'a
  type nodeAttr<'a> = {..} as 'a
  type edgeAttr<'a> = {..} as 'a
}

type graphOptions = {
  allowSelfLoops?: bool,
  multi?: bool,
  @as("type") type_?: [#mixed | #undirected | #directed],
}
