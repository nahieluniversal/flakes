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
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae = {
      url = "github:vicinaehq/vicinae";
    };
  };

  outputs = { self, nixpkgs, millennium, zen-browser, opforjellyfin, nix-cachyos-kernel, vicinae, ... }:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit system millennium zen-browser opforjellyfin nix-cachyos-kernel vicinae;
        };
        modules = [
          ({ config, ... }: {
            nixpkgs.overlays = [
              nix-cachyos-kernel.overlays.default
            ];
          })
          ./modules/hv/module.nix
          ./laptop/configuration.nix
        ];
      };
    };
  };
}