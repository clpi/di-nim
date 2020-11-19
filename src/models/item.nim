from types import Status
from field import Field, FieldKind
from tag import Tag

type ItemKind = enum
  Person, Place, Thing, Time, Event

type
  Item* = ref object of RootObj
    name*: string
    status*: Status
    fields*: array[0, ref Field]
    tags*: array[0, ref Tag]

  PersonItem = ref object of Item
    email*: int
    phoneNumber*: string
    firstName*: string
    lastName*: string


