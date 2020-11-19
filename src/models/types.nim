type
  Status* = enum
    Active, Inactive

  Unit* = ref object of RootObj
    name: string

  TimeUnitKind* = enum
    Ms, S, H, D, W, M, Y

