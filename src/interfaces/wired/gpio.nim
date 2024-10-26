import system

type GpioJob* = enum
    INPUT, OUTPUT, CUSTOM

const
    GPIO_BASE* = 0xFE200000'u32
    GPIO_FSEL_OFFSET* = 0x00'u32
    GPIO_SET_OFFSET* = 0x1C'u32
    GPIO_CLR_OFFSET* = 0x28'u32
    GPIO_PULLUPDN_OFFSET* = 0xE4'u32

    


proc write32*(address: ptr uint32, value: uint32) =
    address[] = value

proc read32*(address: ptr uint32): uint32 =
    address[]


proc setTask*(pin: uint32, work: GpioJob): uint32 =

    let gpIndex = pin div 10
    let gpShift = (pin mod 10) * 3
    let gpAddr =  cast[ptr uint32](GPIO_BASE + GPIO_FSEL_OFFSET + gpIndex * 4)
    var iselValue = read32(gpAddr)
    
    case work
        of INPUT:
            # This is an input (wow):
            iselValue = iselValue and not (0b111'u32 shl gpShift)
            write32(gpAddr, iselValue)

            
        of OUTPUT:
            # And this is an output (wowsers):
            iselValue = iselValue and not (0b111'u32 shl ((pin mod 10) * 3))
            iselValue = iselValue or (0b001'u32 shl ((pin mod 10) * 3))
            write32(gpAddr, iselValue)

        of CUSTOM:
            # And now, this is kinda same like you see as PIO in Raspberry Pi Picos
            echo "Is NOT yet implemented!"



proc gpioSetHigh*(pin: uint32) =
    let gpsetAddr = cast[ptr uint32](GPIO_BASE + GPIO_SET_OFFSET + (pin div 32) * 4)
    write32(gpsetAddr, 1'u32 shl (pin mod 32))

proc gpioSetLow*(pin: uint32) =
    let gpclrAddr = cast[ptr uint32](GPIO_BASE + GPIO_CLR_OFFSET + (pin div 32) * 4)

    write32(gpclrAddr, 1'u32 shl (pin mod 32))

proc gpioReadPin*(pin: uint32): bool =
    let gpgetAddr = cast[ptr uint32](GPIO_BASE + GPIO_SET_OFFSET + (pin div 32) * 4)

    let value: uint32 = read32(gpgetAddr)

    return (value and (1'u32 shl (pin mod 32))) != 0