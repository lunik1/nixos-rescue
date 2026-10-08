{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    # support a wide number of filesystems
    supportedFilesystems = [
      "bcachefs"
      "btrfs"
      "cifs"
      "exfat"
      "ext2"
      "ext3"
      "ext4"
      "f2fs"
      "jfs"
      "nilfs2"
      "ntfs"
      "udf"
      "vfat"
      "xfs"
    ]
    ++ lib.optionals (lib.meta.availableOn pkgs.stdenv.hostPlatform config.boot.zfs.package) [ "zfs" ];
  };

  hardware.enableAllFirmware = true;

  virtualisation = {
    hypervGuest.enable = true;
    vmware.guest.enable = pkgs.stdenv.hostPlatform.isx86;
  };
}
