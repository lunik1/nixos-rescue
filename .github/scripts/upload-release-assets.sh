#!/usr/bin/env bash
set -Eeuo pipefail

system="${1:?usage: upload-release-assets.sh <system> <tag>}"
tag="${2:?usage: upload-release-assets.sh <system> <tag>}"

mkdir -p assets
cp "$(nix eval --raw .#iso.outPath)"/iso/*.iso assets/
cp "$(nix eval --raw .#netbootRamdisk.outPath)"/initrd.zst \
	"assets/netboot-initrd-${system}.zst"
cp "$(nix eval --raw .#netbootIpxeScript.outPath)"/netboot.ipxe \
	"assets/netboot-${system}.ipxe"
cp "$(nix eval --raw .#kexecTarball.outPath)"/tarball/*.tar.xz assets/
if [ "$system" = "aarch64-linux" ]; then
	find "$(nix eval --raw .#sdImage.outPath)"/sd-image -name '*.img.zst' -exec cp {} assets/ \;
fi

ls -lh assets
gh release upload "$tag" assets/* --clobber
