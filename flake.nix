{
  description = "GRML-style NixOS recovery and maintenance images";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flakelight = {
      url = "github:nix-community/flakelight";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs =
    { flakelight, ... }:
    flakelight ./. (
      { lib, ... }:
      {
        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];

        # firmware blobs and unrar are unfree
        nixpkgs.config.allowUnfree = true;

        # the shared rescue system, reusable from other flakes
        nixosModules.rescue = ./nix/modules;

        checks = {
          pre-commit-check =
            pkgs:
            pkgs.inputs'.pre-commit-hooks.lib.run {
              src = ./.;
              hooks = {
                nixfmt.enable = true;
                shellcheck = {
                  enable = true;
                  excludes = [
                    ".envrc"
                    ".zshrc"
                  ];
                };
                statix.enable = true;
              };
            };
        };

        formatters =
          pkgs: with pkgs; {
            "*.nix" = "${nixfmt}/bin/nixfmt";
          };

        outputs =
          { config, lib, ... }:
          let
            cfgs = config.outputs.nixosConfigurations;
          in
          {
            packages =
              lib.genAttrs
                [
                  "x86_64-linux"
                  "aarch64-linux"
                ]
                (
                  system:
                  {
                    default = cfgs."iso-${system}".config.system.build.isoImage;
                    iso = cfgs."iso-${system}".config.system.build.isoImage;
                    netbootRamdisk = cfgs."netboot-${system}".config.system.build.netbootRamdisk;
                    netbootIpxeScript = cfgs."netboot-${system}".config.system.build.netbootIpxeScript;
                    kexecTarball = cfgs."netboot-${system}".config.system.build.kexecTarball;
                  }
                  // lib.optionalAttrs (system == "aarch64-linux") {
                    sdImage = cfgs."sd-${system}".config.system.build.sdImage;
                  }
                );
          };
      }
    );
}
