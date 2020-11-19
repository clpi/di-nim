from types import Status
from item import Item
from tag import Tag

type
  Record* = object
    name*: string
    status*: Status
    items*: array[0, ref Item]
    tags*: array[0, ref Tag]
