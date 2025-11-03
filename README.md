# Slimbox BT

_This is a work in progress._

This repository contains code for wireless game controller firmware meant to run on Nordic's nRF52840 and nRF54L15 chips.

The following pre-built binaries are provided:

* [slimbox-bt.uf2](https://github.com/jfedor2/slimbox-bt/releases/latest/download/slimbox-bt.uf2): for the [Slimbox BT](https://www.printables.com/model/923690-slimbox-bt) or any other handwired controller using the [Adafruit Feather nRF52840 Express](https://www.adafruit.com/product/4062) board
* [flatbox-rev7.uf2](https://github.com/jfedor2/slimbox-bt/releases/latest/download/flatbox-rev7.uf2): for the [Flatbox rev7](https://github.com/jfedor2/flatbox/tree/master/hardware-rev7) with a [Seeed Studio Xiao nRF52840](https://www.seeedstudio.com/Seeed-XIAO-BLE-nRF52840-p-5201.html) board
* [flatbox-rev7-nrf54l15.hex](https://github.com/jfedor2/slimbox-bt/releases/latest/download/flatbox-rev7-nrf54l15.hex): for the [Flatbox rev7](https://github.com/jfedor2/flatbox/tree/master/hardware-rev7) with a [Seeed Studio Xiao nRF54L15](https://www.seeedstudio.com/XIAO-nRF54L15-p-6493.html) board
* [slimbox-bt-xiao_nrf52840.uf2](https://github.com/jfedor2/slimbox-bt/releases/latest/download/slimbox-bt-xiao_nrf52840.uf2): for a handwired controller using a [Seeed Studio Xiao nRF52840](https://www.seeedstudio.com/Seeed-XIAO-BLE-nRF52840-p-5201.html) board
* [slimbox-bt-xiao_nrf54l15.hex](https://github.com/jfedor2/slimbox-bt/releases/latest/download/slimbox-bt-xiao_nrf54l15.hex): for a handwired controller using a [Seeed Studio Xiao nRF54L15](https://www.seeedstudio.com/XIAO-nRF54L15-p-6493.html) board

## How to use

The controller will go to sleep after 10 minutes of inactivity when connected and after 1 minute when not connected. To wake it up press the "start" button (the one in the top left corner on the Flatbox rev7 and wherever you wired it on handwired devices).

To put the controller in pairing mode, press the "start" button for 3 seconds.

The controller can be paired with one device at a time.

To put the controller in firmware flashing mode (if that's a thing on the board you're using), press the "start" button for 10 seconds.

## How to flash the firmware

Assuming you're using one of the devices that come with a UF2 bootloader and for which pre-built binaries are provided, to flash the firmware connect the device to your computer with a USB cable, then press the RESET button twice quickly. A USB drive should appear on your computer. The name of the drive will depend on what device you're using, on the Adafruit Feather nRF52840 Express, the drive is named "FTHR840BOOT". Download the appropriate UF2 file from the releases section (`slimbox-bt.uf2` for the Adafruit Feather nRF52840 Express) and copy it to the drive that appeared.

If you already have some previous version of this firmware on your board, instead of pressing the RESET button twice you can hold the "start" button for 10 seconds to enter firmware flashing mode.

For devices using the nRF54L15 chip that don't come with a UF2 bootloader, you will have to use OpenOCD or some other software to flash the firmware, it probably won't be as easy as copying a file to a USB drive.

## Pinout

If you're using the `slimbox-bt.uf2` firmware with an Adafruit Feather nRF52840 Express board, wire the buttons to pins on the board as follows:

pin | button
--- | ------
A5 | south
A4 | east
D2 | west
MI | north
10 | D-pad left
6 | D-pad right
A0 | D-pad up
9 | D-pad down
SCK | L1
MO | R1
A2 | L2
A3 | R2
12 | L3
13 | R3
SDA | select
11 | start
SCL | home
5 | button 14

If you're using one of the standalone Xiao builds (not as part of Flatbox rev7), wire the buttons to pins on the board as follows:

pin | button
--- | ------
D0 | start
D1 | select
D2 | home
D3 | south
D4 | east
D5 | west
D6 | north
D7 | D-pad left
D8 | D-pad right
D9 | D-pad up
D10 | D-pad down

## How to compile

The easiest way to compile the firmware is to let GitHub do it for you. This repository has GitHub Actions that build the firmware, so you can just fork, enable Actions, make your changes, wait for the job to complete, and look for the binaries in the artifacts produced.

To compile it on your own machine, you can either follow [Nordic's setup instructions](https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/installation.html) to prepare the build environment, or you can use Docker. Either way take a look at the [build.sh](build.sh) script. With Docker a command like this builds all existing variants (start from the top level of the repository or adjust the path accordingly):

```
docker run --rm -v $(pwd):/workspace/project -w /workspace/project ghcr.io/zephyrproject-rtos/ci:v0.28.4 ./build.sh vatican-cameos
```

## TODO

* wired operation when connected over USB
* battery level reporting
* measure and optimize power consumption
* analog inputs for sticks and triggers
* version for nRF52832 boards
* LEDs as status indicators
* compatibility with other platforms
* figure out why directed advertising doesn't seem to work

## License

The software in this repository is licensed under the [MIT License](LICENSE).
