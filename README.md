# Slimbox BT

_This is a work in progress._

This repository contains code for wireless game controller firmware meant to run on Nordic's nRF52840 and nRF54L15 chips.

The following pre-built binaries are provided:

* [slimbox-bt.uf2](https://github.com/jfedor2/slimbox-bt/releases/latest/download/slimbox-bt.uf2): for the [Slimbox BT](https://www.printables.com/model/923690-slimbox-bt) or any other handwired controller using the [Adafruit Feather nRF52840 Express](https://www.adafruit.com/product/4062) board
* [flatbox-rev7.uf2](https://github.com/jfedor2/slimbox-bt/releases/latest/download/flatbox-rev7.uf2): for the [Flatbox rev7](https://github.com/jfedor2/flatbox/tree/master/hardware-rev7) with a [Seeed Studio Xiao nRF52840](https://www.seeedstudio.com/Seeed-XIAO-BLE-nRF52840-p-5201.html) board
* [flatbox-rev7-nrf54l15.hex](https://github.com/jfedor2/slimbox-bt/releases/latest/download/flatbox-rev7-nrf54l15.hex): for the [Flatbox rev7](https://github.com/jfedor2/flatbox/tree/master/hardware-rev7) with a [Seeed Studio Xiao nRF54L15](https://www.seeedstudio.com/XIAO-nRF54L15-p-6493.html) board
* [slimbox-bt-xiao_nrf52840.uf2](https://github.com/jfedor2/slimbox-bt/releases/latest/download/slimbox-bt-xiao_nrf52840.uf2): for a handwired controller using a [Seeed Studio Xiao nRF52840](https://www.seeedstudio.com/Seeed-XIAO-BLE-nRF52840-p-5201.html) board
* [slimbox-bt-xiao_nrf54l15.hex](https://github.com/jfedor2/slimbox-bt/releases/latest/download/slimbox-bt-xiao_nrf54l15.hex): for a handwired controller using a [Seeed Studio Xiao nRF54L15](https://www.seeedstudio.com/XIAO-nRF54L15-p-6493.html) board
* [slimbox-bt-nice_nano.uf2](https://github.com/jfedor2/slimbox-bt/releases/latest/download/slimbox-bt-nice_nano.uf2): for a handwired controller using a [nice!nano](https://nicekeyboards.com/nice-nano/) board or one of its many clones

## How to use

One of the buttons is designated as the "system button". Currently on all the provided builds it is the `start` button. If you make a custom build you can change it to any other button or even have a dedicated system button that isn't shared with any of the gamepad buttons. On the Flatbox rev7 the `start` button (and therefore the system button) is the button in the top left corner.

Wired operation is supported on platforms with USB hardware (currently nRF52840). When the controller is connected over USB, the Bluetooth connection is disabled.

When the controller is not connected over USB, it will go to sleep after 10 minutes of inactivity when connected over Bluetooth and after 1 minute when not connected. To wake it up press the system button.

When connected over USB, to put the controller in firmware flashing mode (if that's a thing on the board you're using), press the system button for 10 seconds.

When not connected over USB, to turn the controller off press the system button for 3 seconds, and to put the controller in pairing mode press the system button for 10 seconds.

The controller can be paired with one device at a time.

## How to flash the firmware

Assuming you're using one of the devices that come with a UF2 bootloader and for which pre-built binaries are provided, to flash the firmware connect the device to your computer with a USB cable, then press the RESET button twice quickly. A USB drive should appear on your computer. The name of the drive will depend on what device you're using, on the Adafruit Feather nRF52840 Express, the drive is named "FTHR840BOOT". Download the appropriate UF2 file from the releases section (`slimbox-bt.uf2` for the Adafruit Feather nRF52840 Express) and copy it to the drive that appeared.

If you already have some previous version of this firmware on your board, instead of pressing the RESET button twice you can hold the "start" button for 10 seconds to enter firmware flashing mode.

For devices using the nRF54L15 chip that don't come with a UF2 bootloader, you will have to use OpenOCD or some other software to flash the firmware, it probably won't be as easy as copying a file to a USB drive.

## Pinout

<details>
<summary>Adafruit Feather nRF52840 Express</summary>

If you're using an Adafruit Feather nRF52840 Express board, wire the buttons to pins on the board as follows:

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
</details>

<details>
<summary>Seeed Xiao</summary>

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
</details>

<details>
<summary>nice!nano and clones</summary>

If you're using a nice!nano board or one of its many clones, wire the buttons to pins on the board as follows:

pin | button
--- | ------
006 | start
008 | select
017 | D-pad left
020 | D-pad right
022 | D-pad up
024 | D-pad down
100 | south
011 | east
104 | west
106 | north
009 | L1
010 | R1
111 | L2
113 | R2
115 | L3
002 | R3
029 | home
031 | button 14
</details>

## How to compile

The easiest way to compile the firmware is to let GitHub do it for you. This repository has GitHub Actions that build the firmware, so you can just fork, enable Actions, make your changes, wait for the job to complete, and look for the binaries in the artifacts produced.

To compile it on your own machine, you can either follow [Nordic's setup instructions](https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/installation.html) to prepare the build environment, or you can use Docker. Either way take a look at the [build.sh](build.sh) script. With Docker a command like this builds all existing variants (start from the top level of the repository or adjust the path accordingly):

```
docker run --rm -v $(pwd):/workspace/project -w /workspace/project ghcr.io/zephyrproject-rtos/ci:v0.28.4 ./build.sh vatican-cameos
```

## TODO

* battery level reporting
* measure and optimize power consumption
* analog inputs for sticks and triggers
* version for nRF52832 boards
* compatibility with other platforms
* figure out why directed advertising doesn't seem to work

## License

The software in this repository is licensed under the [MIT License](LICENSE).
