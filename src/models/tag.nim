type Tag* = ref object of RootObj
  name*: string

type KVTag = ref object of Tag
  value*: string
