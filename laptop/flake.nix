{
  description = "Multiflake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    millennium.url = "github:SteamClientHomebrew/Millennium/next?dir=packages/nix";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    opforjellyfin = {
      url = "github:nahieluniversal/opforjellyfin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae = {
      url = "github:vicinaehq/vicinae";
    };
    twintaillauncher = {
      url = "github:axioncs/twintaillauncher-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, millennium, zen-browser, opforjellyfin, vicinae, twintaillauncher, ... }:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit system millennium zen-browser opforjellyfin vicinae twintaillauncher;
        };
        modules = [
          ./laptop/configuration.nix
          {
            specialisation."hypervisor".configuration = {
              imports = [
                ./modules/hv/module.nix
              ];
            };
            specialisation."no-hv".configuration = {
            };
          }
        ];
      };
    };
  };
}