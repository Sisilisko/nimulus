

# Main definitions/variables/structures for processes:
type
    genres* = enum
        SYSTEM, SENSORS, OUTPUT, INPUT, PROGRAM

    process* = object
        pid*: uint16
        label*: string
        niceToKnow*: string
        tag*: genres

# Then Process handling procedures:
var processes*: seq[process]


# Here are 2 macros (only 2 designed for now, none yet developed): `job` and `task`. 
# They may seem the same, but:
    # Macro `task` is for things that are important like system processes and critical things
    # Macro `job` is for things that are just... Nice. Like UI (if ever implemented), and firewall and most user processes.
# You can make your own user or unimportant process to task, but its only recommended for certain uses and vice versa.