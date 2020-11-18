import os, parseopt, math, Terminal,  tables, logging
import strutils, parseutils, sequtils, re
import
  models/item,
  models/record,
  models/field,
  lexer

if logging.getHandlers().len == 0:
  var logger = logging.newConsoleLogger()
  setLogFilter(lvlNotice)

var
  verbose, pretty, deubug: bool = false
  tokens: seq[string] = @[]
  citem, crecord, cfield: string = ""
  tag: string = ""

type
  FieldKind = enum
    int, str, date
  Status = enum
    active, inactive

var itemList, recordList, fieldList: array[0, string]

proc initData =
  case existsOrCreateDir("~/.config/di"):
  of true:
    echo "Created dir"
  of false:
    echo "Dir exists"

proc readItems =
  setForegroundColor(fgMagenta)
  echo "Reading items..."

proc readRecords =
  setForegroundColor(fgBlue)
  echo "Reading records..."

proc readFields =
  setForegroundColor(fgGreen)
  echo "Reading fields..."

proc createItem =
  setForegroundColor(fgMagenta)
  echo "Creating item: ", paramStr(3)

proc createRecord =
  setForegroundColor(fgBlue)
  echo "Creating record: ", paramStr(3)

proc createField =
  setForegroundColor(fgGreen)
  echo "Creating field: ", paramStr(3)

proc listItem() =
  setForegroundColor(fgMagenta)
  echo "Items:"
  for item in itemList:
    echo item

proc listRecord() =
  setForegroundColor(fgBlue)
  echo "Records:"
  for record in recordList:
    echo record

proc listField() =
  setForegroundColor(fgGreen)
  echo "Fields:"
  for field in fieldList:
    echo field

proc processItem() =
  var name: string = paramStr(2)
  setForegroundColor(fgMagenta)
  echo "Item received: ", name

proc processRecord() =
  var name: string = paramStr(2)
  setForegroundColor(fgBlue)
  echo "Record received: ", name

proc processField() =
  var name: string = paramStr(2)
  setForegroundColor(fgGreen)
  echo "Field received: ", name

proc process()  =
  setForegroundColor(fgYellow)
  var config: string = ""
  var cmdArgs = newSeq[string](0)
  let version = "div 0.0.1"
  let info = """
  Usage:
    div [options] <record|item|field> [name] [value] [tag] [params]

  Subcomands:
  Arguments:
    [record|item|field]  The object to assign a value to
    [value]              The value assigned to the object
    [tag]                Optional tag to assign to pairing
  Options:
    -h, --help           Output this help message
    -v, --version        Prints the version of div
    -c, --config         Opens configuration in default editor
    -l, --list           List all objects of all types with values
  Parameters:

  """
  for kind, key, val in getopt():
    case kind:
    of cmdArgument:
      case paramCount():
      of 0:
        setForegroundColor(fgRed)
        echo "No params provided"
      of 1:
        case paramStr(1):
        of "item": listItem()
        of "record": listRecord()
        of "field": listField()
      of 2:
        case paramStr(1):
        of "item":
          processItem()
          break
        of "record":
          processRecord()
          break
        of "field":
          processField()
          break
        of "new":
          break
      of 3:
        case paramStr(1):
        of "new":
          case paramStr(2):
          of "item":
            createItem()
            break
          of "record":
            createRecord()
            break
          of "field":
            createField()
            break
        else: discard
      else:
        cmdArgs.add key
        echo info
    of cmdLongOption, cmdShortOption:
      case key:
      of "help", "h": echo info
      of "version", "v": echo version
      of "list", "l": echo info
      of "config", "c": echo info
      else: discard
    else: discard
  resetAttributes()

when isMainModule:
  process()
