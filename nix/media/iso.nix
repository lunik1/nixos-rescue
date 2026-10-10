{
  lib,
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];

  isoImage = {
    edition = lib.mkForce "rescue";
    appendToMenuLabel = " Rescue System";
  };

  boot.loader.grub.memtest86.enable = lib.mkForce pkgs.stdenv.hostPlatform.isx86;
}
