# Slimbox BT

_This is a work in progress._

This repository contains code for wireless game controller firmware meant to run on Nordic's nRF52840 chip.

Pre-built binaries are provided for the following devices:

* [Slimbox BT](https://www.printables.com/model/923690-slimbox-bt): [slimbox-bt.uf2](https://github.com/jfedor2/slimbox-bt/releases/latest/download/slimbox-bt.uf2)
* [Flatbox rev7](https://github.com/jfedor2/flatbox/tree/master/hardware-rev7): [flatbox-rev7.uf2](https://github.com/jfedor2/slimbox-bt/releases/latest/download/flatbox-rev7.uf2)

The `slimbox-bt.uf2` firmware will also work with any handwired controller that uses the [Adafruit Feather nRF52840 Express](https://www.adafruit.com/product/4062) board.

## How to use

The controller will go to sleep after 10 minutes of inactivity when connected and after 1 minute when not connected. To wake it up press the "start" button.

To put the controller in pairing mode, press the "start" button for 3 seconds.

The controller can be paired with one device at a time.

To put the controller in firmware flashing mode (if that's a thing on the board you're using), press the "start" button for 10 seconds.

## How to flash the firmware

Assuming you're using one of the devices for which pre-built binaries are provided, to flash the firmware connect the device to your computer with a USB cable, then press the RESET button twice quickly. A USB drive should appear on your computer. The name of the drive will depend on what device you're using, on the Adafruit Feather nRF52840 Express, the drive is named "FTHR840BOOT". Download the appropriate UF2 file from the releases section (`slimbox-bt.uf2` for the Adafruit Feather nRF52840 Express) and copy it to the drive that appeared.

If you already have some previous version of this firmware on your board, instead of pressing the RESET button twice you can hold the "start" button for 10 seconds to enter firmware flashing mode.

## Pinout

If you're using the `slimbox-bt.uf2` firmware with an Adafruit Feather nRF52840 Express board, wire the buttons to pins on the board as follows:

pin | button
--- | ------
A5 | cross
A4 | circle
D2 | square
MI | triangle
10 | left
6 | right
A0 | up
9 | down
SCK | L1
MO | R1
A2 | L2
A3 | R2
12 | L3
13 | R3
SDA | select
11 | start
SCL | home
5 | capture

## How to compile

The easiest way to compile the firmware is to let GitHub do it for you. This repository has GitHub Actions that build the firmware, so you can just fork, make your changes, wait for the job to complete, and look for the binaries in the artifacts produced.

To compile it yourself, you can either follow [Nordic's setup instructions](https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/installation.html) and then `west build -b adafruit_feather_nrf52840` to compile the firmware, or you can use Docker with a command like this (start from the top level of the repository or adjust the path accordingly):

```
docker run --rm -v $(pwd):/workdir/project -w /workdir/project nordicplayground/nrfconnect-sdk:v2.6-branch west build -b adafruit_feather_nrf52840
```

(Replace "adafruit\_feather\_nrf52840" with the board you're compiling for.)

## TODO

* wired operation when connected over USB
* battery level reporting
* measure and optimize power consumption
* analog inputs for sticks and triggers
* version for nRF52832 boards
* LEDs as status indicators
* split board configurations into device-specific overlays
* compatibility with other platforms
* figure out why directed advertising doesn't seem to work

## License

The software in this repository is licensed under the [MIT License](LICENSE).
