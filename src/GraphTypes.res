module type T = {
  type t
  type node
  type edge
  type nodeAttr<'a> = {..} as 'a
  type edgeAttr<'a> = {..} as 'a
}
