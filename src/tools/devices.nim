
type
    DeviceDataDirection* = enum
        INPUT, OUTPUT, HYBRID


    Device* = object
        style*: DeviceDataDirection
        deviceId*: uint8
        devIdentifier*: array[2, char]


proc scanDevices*(): seq[Device] =
    # Here implement finding devices...
    echo "Not done... Yet"
        

proc initDevices*(): bool =
    echo "Not done!"
    false