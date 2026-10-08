{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./boot.nix
    ./programs.nix
    ./services.nix
    ./settings.nix
    ./shell.nix
    ./ssh.nix
  ];
}
