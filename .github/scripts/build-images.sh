#!/usr/bin/env bash
set -Eeuo pipefail

system="${1:?usage: build-images.sh <system>}"

packages=(.#iso .#netbootRamdisk .#netbootIpxeScript .#kexecTarball)
if [ "$system" = "aarch64-linux" ]; then
	packages+=(.#sdImage)
fi

nix build -L "${packages[@]}"
