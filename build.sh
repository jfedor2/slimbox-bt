#!/bin/bash

if [[ $# -eq 0 || "$1" != "vatican-cameos" ]]; then
    echo "This script clobbers the parent directory. It's mostly meant to be used from inside a GitHub workflow. If you're sure you know what you're doing, run it with a 'vatican-cameos' parameter." >&2
    exit 1
fi

set -x -e -u -o pipefail

west init -l .
west update -o=--depth=1 -n

mkdir artifacts

west build -b adafruit_feather_nrf52840/nrf52840/uf2 -d build-adafruit_feather_nrf52840 app
mv build-adafruit_feather_nrf52840/app/zephyr/slimbox-bt.uf2 artifacts/

west build -b xiao_ble -d build-seeed_xiao_nrf52840 app
mv build-seeed_xiao_nrf52840/app/zephyr/flatbox-rev7.uf2 artifacts/

west build -b xiao_nrf54l15/nrf54l15/cpuapp -d build-seeed_xiao_nrf54l15 app -- -DBOARD_ROOT=`pwd`/app
mv build-seeed_xiao_nrf54l15/merged.hex artifacts/flatbox-rev7-nrf54l15.hex
