{
  lib,
  ...
}:
{
  nixpkgs.overlays = [
    (final: prev: {
      # trim some firmware we don't need to reduce ISO size
      linux-firmware =
        let
          excluded = [
            "mellanox" # mlxsw switch ASIC
            "mrvl/prestera" # Marvell Prestera switch ASIC firmware
          ]
          # qcom ARM SoC firmware not needed on x86_64
          ++ lib.optional prev.stdenv.hostPlatform.isx86 "qcom";
        in
        prev.linux-firmware.overrideAttrs (old: {
          postInstall = (old.postInstall or "") + ''
            cd $out/lib/firmware
            rm -rf ${lib.concatStringsSep " " excluded}
            find $out -xtype l -delete
          '';
        });
    })
  ];
}
