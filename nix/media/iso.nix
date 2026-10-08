{ lib, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];

  isoImage = {
    edition = lib.mkForce "rescue";
    appendToMenuLabel = " Rescue System";
  };
}
