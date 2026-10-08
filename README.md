# nixos-rescue

GRML-y NixOS recovery and maintenance images.

## Build

Default target is the x86_64 iso. There are also sd images, netboot, and kexec trees.

```console
nix build .#iso
nix build .#packages.aarch64-linux.iso
nix build .#packages.aarch64-linux.sdImage
nix build .#netbootRamdisk .#netbootIpxeScript
nix build .#kexecTarball
```
