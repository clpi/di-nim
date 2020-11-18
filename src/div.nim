import os, parseopt, math, Terminal,  tables, logging
import strutils, parseutils, sequtils, re

if logging.getHandlers().len == 0:
  var logger = logging.newConsoleLogger()
  setLogFilter(lvlNotice)

var
  verbose, pretty, deubug: bool = false
  tokens: seq[string] = @[]
  item, record, field: string = ""
  tag: string = ""

proc initData =
  case existsOrCreateDir("~/.config/di"):
  of true:
    echo "Created dir"
  of false:
    echo "Dir exists"

proc readItems =
  echo "Reading items..."

proc readFields =
  echo "Reading items..."

proc readRecords =
  echo "Reading items..."

proc listItem() =
  setForegroundColor(fgMagenta)
  echo "Items:"
proc listRecord() =
  setForegroundColor(fgBlue)
  echo "Records:"
proc listField() =
  setForegroundColor(fgGreen)
  echo "Fields:"

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
  echo("Processing...")
  var config: string = ""
  var cmdArgs = newSeq[string](0)
  let version = "div 0.0.1"
  let info = """
  Usage:
    div [record|item|field] [name] [value] [tag] [options]

  Arguments:
    [record|item|field]  The object to assign a value to
    [value]              The value assigned to the object
    [tag]                Optional tag to assign to pairing
  Options:
    -h, --help           Output this help message
    -v, --version        Prints the version of div
    -c, --config         Opens configuration in default editor
    -l, --list           List all objects of all types with values
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
        of "item":
          listItem()
        of "record":
          listRecord()
        of "field":
          listField()
      of 2:
        case paramStr(1):
        of "item":
          processItem()
        of "record":
          processRecord()
        of "field":
          processField()
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
