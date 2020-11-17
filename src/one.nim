# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.
#
import json

type
  Element = object
    name: string
    atomicNumber: int

let jsonObj = parseJson("""{"name": "Carbon", "atomicNumber": 6}""")
let element = to(jsonObj, Element)

when isMainModule:
  echo("Hello, World!")
  echo("This is a test")
  echo(element.name)
  echo(element.atomicNumber)
