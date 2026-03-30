#!/bin/bash

if [[ $# -eq 0 || "$1" != "vatican-cameos" ]]; then
    echo "This script clobbers the parent directory. It's mostly meant to be used from inside a GitHub workflow. If you're sure you know what you're doing, run it with a 'vatican-cameos' parameter." >&2
    exit 1
fi

set -x -e -u -o pipefail

west init -l .
west update -o=--depth=1 -n

mkdir artifacts

west build -b adafruit_feather_nrf52840/nrf52840/uf2 -d build-adafruit_feather_nrf52840 app -- -DEXTRA_CONF_FILE=boards/usb.conf -DEXTRA_DTC_OVERLAY_FILE="boards/hid_dev.overlay boards/feather_mapping.overlay"
mv build-adafruit_feather_nrf52840/app/zephyr/slimbox-bt.uf2 artifacts/

west build -b xiao_ble -d build-flatbox-rev7-nrf52840 app -- -DEXTRA_CONF_FILE="boards/flatbox_rev7.conf boards/usb.conf" -DEXTRA_DTC_OVERLAY_FILE="boards/xiao_ble_i2c_pullup.overlay boards/flatbox_rev7.overlay boards/hid_dev.overlay"
mv build-flatbox-rev7-nrf52840/app/zephyr/flatbox-rev7.uf2 artifacts/

west build -b xiao_nrf54l15/nrf54l15/cpuapp -d build-flatbox-rev7-nrf54l15 app -- -DBOARD_ROOT=`pwd`/app -DEXTRA_CONF_FILE=boards/flatbox_rev7.conf -DEXTRA_DTC_OVERLAY_FILE="boards/xiao_nrf54l15_i2c_pullup.overlay boards/flatbox_rev7.overlay"
mv build-flatbox-rev7-nrf54l15/merged.hex artifacts/flatbox-rev7-nrf54l15.hex

west build -b xiao_ble -d build-seeed_xiao_nrf52840 app -- -DEXTRA_CONF_FILE="boards/usb.conf" -DEXTRA_DTC_OVERLAY_FILE="boards/hid_dev.overlay boards/xiao_mapping.overlay"
mv build-seeed_xiao_nrf52840/app/zephyr/slimbox-bt.uf2 artifacts/slimbox-bt-xiao_nrf52840.uf2

west build -b xiao_nrf54l15/nrf54l15/cpuapp -d build-seeed_xiao_nrf54l15 app -- -DBOARD_ROOT=`pwd`/app -DEXTRA_DTC_OVERLAY_FILE=boards/xiao_mapping.overlay
mv build-seeed_xiao_nrf54l15/merged.hex artifacts/slimbox-bt-xiao_nrf54l15.hex

#west build -b xiao_nrf54l15/nrf54l15/cpuapp -d build-seeed_xiao_nrf54l15-otadfu app -- -DEXTRA_CONF_FILE="boards/ota_dfu.conf" -DBOARD_ROOT=`pwd`/app -DEXTRA_DTC_OVERLAY_FILE=boards/xiao_mapping.overlay -DSB_CONF_FILE=sysbuild_boards/enable_mcuboot.conf -Dmcuboot_EXTRA_DTC_OVERLAY_FILE=${PWD}/app/sysbuild_boards/mcuboot_nrf54l.overlay

west build -b nice_nano -d build-nice_nano app -- -DBOARD_ROOT=`pwd`/app -DEXTRA_CONF_FILE=boards/usb.conf -DEXTRA_DTC_OVERLAY_FILE="boards/hid_dev.overlay boards/pro_micro_mapping.overlay"
mv build-nice_nano/app/zephyr/slimbox-bt.uf2 artifacts/slimbox-bt-nice_nano.uf2

west build -b holyiot_25008/nrf54l15/cpuapp -d build-holyiot_25008 app -- -DBOARD_ROOT=`pwd`/app -DEXTRA_DTC_OVERLAY_FILE=boards/holyiot_25008_mapping.overlay
mv build-holyiot_25008/merged.hex artifacts/slimbox-bt-holyiot_25008.hex

#west build -b holyiot_25008/nrf54l15/cpuapp -d build-holyiot_25008-otadfu app -- -DEXTRA_CONF_FILE="boards/ota_dfu.conf" -DBOARD_ROOT=`pwd`/app -DEXTRA_DTC_OVERLAY_FILE=boards/holyiot_25008_mapping.overlay -DSB_CONF_FILE=sysbuild_boards/enable_mcuboot.conf -Dmcuboot_EXTRA_DTC_OVERLAY_FILE=${PWD}/app/sysbuild_boards/mcuboot_nrf54l.overlay

west build -b holyiot_25055/nrf54l05/cpuapp -d build-holyiot_25055 app -- -DBOARD_ROOT=`pwd`/app -DEXTRA_DTC_OVERLAY_FILE=boards/holyiot_25055_mapping.overlay
mv build-holyiot_25055/merged.hex artifacts/slimbox-bt-holyiot_25055.hex

#west build -b holyiot_25055/nrf54l05/cpuapp -d build-holyiot_25055-otadfu app -- -DEXTRA_CONF_FILE="boards/ota_dfu.conf" -DBOARD_ROOT=`pwd`/app -DEXTRA_DTC_OVERLAY_FILE=boards/holyiot_25055_mapping.overlay -DSB_CONF_FILE=sysbuild_boards/enable_mcuboot.conf -Dmcuboot_EXTRA_DTC_OVERLAY_FILE=${PWD}/app/sysbuild_boards/mcuboot_nrf54l.overlay

west build -b nrf52dk/nrf52832 -d build-nrf52dk app -- -DEXTRA_DTC_OVERLAY_FILE="boards/nrf52dk_mapping.overlay"
mv build-nrf52dk/merged.hex artifacts/slimbox-bt-nrf52dk.hex
