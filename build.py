#!/usr/bin/env python3

import json
import sys

with open(sys.argv[1], "r") as f:
    builds = json.load(f)

print(
    """#!/bin/bash

if [[ $# -eq 0 || "$1" != "vatican-cameos" ]]; then
    echo "This script clobbers the parent directory. It's mostly meant to be used from inside a GitHub workflow. If you're sure you know what you're doing, run it with a 'vatican-cameos' parameter." >&2
    exit 1
fi

set -x -e -u -o pipefail

west init -l .
west update -o=--depth=1 -n

mkdir artifacts
"""
)

for b in builds:
    prefix = "#" if b.get("disabled", False) else ""
    extra_params = " ".join(f'-D{param}="{" ".join(values)}"' for param, values in b['extra_params'].items())
    print(
        f'{prefix}west build -d build-{b["name"]} -b {b["board"]} app -- -DBOARD_ROOT=${{PWD}}/app {extra_params}'
    )
    print(
        f'{prefix}cp build-{b["name"]}/{b["artifact_built_name"]} artifacts/{b["artifact_final_name"]}'
    )
    print()
