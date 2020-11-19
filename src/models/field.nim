from types import Status

type
  FieldKind* = enum
    int, str, date

type
  Field* = object
    name*: string
    status*: Status # TODO should be status object
    kind*: FieldKind


