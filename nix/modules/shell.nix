{ lib, pkgs, ... }:
{
  users.users.root = {
    shell = pkgs.zsh; # like grml
    initialHashedPassword = lib.mkForce null;
  };

  programs.zsh = {
    enable = true;

    # use grml's config
    promptInit = "";
    enableGlobalCompInit = false;
    enableLsColors = false;
    interactiveShellInit = ''
      source ${pkgs.grml-zsh-config}/etc/zsh/zshrc
    '';
  };

  services.getty = {
    autologinUser = lib.mkForce "root";
    helpLine = lib.mkForce ''
      88888b   d888b  888b  88 8P 888888    88888b    888     888b  88 88  d888b 88
      88   88 88   88 88`8b 88 "    88      88   88  88 88    88`8b 88 88 88   ` 88
      88   88 88   88 88 88 88      88      88888P  88   88   88 88 88 88 88     88
      88   88 88   88 88 `8b88      88      88     d8888888b  88 `8b88 88 88   , ""
      88888P   `888P  88  `888      88      88     88     `8b 88  `888 88  `888P 88

      The root account is logged in automatically and has no password.

      Use `nmtui` to configure the network. `nixos-enter /mnt` enters
      an installed NixOS system.
    '';
  };
}
