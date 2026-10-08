{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/netboot/netboot.nix")
    (modulesPath + "/profiles/installation-device.nix")
  ];
}
