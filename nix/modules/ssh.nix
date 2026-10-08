{ config, lib, ... }:
let
  cfg = config.rescue;
in
{
  options.rescue.authorizedKeys = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = "Public SSH keys allowed to log in as root.";
  };

  config = {
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = lib.mkForce "yes"; # requires a root password to actually log in
        PasswordAuthentication = true;
      };
    };

    users.users.root.openssh.authorizedKeys.keys = lib.mkIf (
      cfg.authorizedKeys != [ ]
    ) cfg.authorizedKeys;
  };
}
