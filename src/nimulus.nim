import scheduler
import tools/devices

let parentProcess = process(pid: 1, label: "rootp", niceToKnow: "Father of all processes", tag: SYSTEM)

processes.add(parentProcess)

var connectedDevices: seq[Device]

proc boot() =
    echo "work in progress..."



boot()