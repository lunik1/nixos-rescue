{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./boot.nix
    ./firmware.nix
    ./programs.nix
    ./services.nix
    ./settings.nix
    ./shell.nix
    ./ssh.nix
  ];
}
