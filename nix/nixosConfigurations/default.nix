_:
let
  mkRescue = system: media: {
    inherit system;
    modules = [
      ../modules
      (../media + "/${media}.nix")
      { rescue.authorizedKeys = import ../../keys.nix; }
    ];
  };
in
{
  iso-x86_64-linux = mkRescue "x86_64-linux" "iso";
  iso-aarch64-linux = mkRescue "aarch64-linux" "iso";
  sd-aarch64-linux = mkRescue "aarch64-linux" "sd";
  netboot-x86_64-linux = mkRescue "x86_64-linux" "netboot";
  netboot-aarch64-linux = mkRescue "aarch64-linux" "netboot";
}
