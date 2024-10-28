

type
  ModuleMetadata* = object
    name*: string
    label*: string


proc checkModules*(): seq[ModuleMetadata] =
  echo "not done"
