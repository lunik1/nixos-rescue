{ config, ... }:
{
  system.stateVersion = config.system.nixos.release; # rolling stateVersion is fine

  networking = {
    hostName = "rescue";
    hostId = "8425e349"; # for zfs
    firewall.enable = false;
  };

  time.timeZone = "Europe/London";

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    supportedLocales = [
      "en_GB.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
  };

  console = {
    keyMap = "uk";
    font = "Lat2-Terminus16";
  };
}
