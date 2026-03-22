{
  description = "Multiflake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    opforjellyfin = {
    url = "github:nahieluniversal/opforjellyfin";
    inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, zen-browser, opforjellyfin, nix-cachyos-kernel, ... }:
    let
      system = "x86_64-linux";
      
      mkHost = hostName: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit system zen-browser opforjellyfin nix-cachyos-kernel;
        };
        modules = [
          ({ config, ... }: {
            nixpkgs.overlays = [
              nix-cachyos-kernel.overlays.default
            ];
          })
          ./modules/hosts/${hostName}/configuration.nix
        ];
      };
    in {
      nixosConfigurations = {
        laptop = mkHost "laptop";
#       server = mkHost "server";
      };
    };
}
