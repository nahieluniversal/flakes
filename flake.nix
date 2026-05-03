{
  description = "Multiflake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    opforjellyfin = {
    url = "github:nahieluniversal/opforjellyfin";
    inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    jovian = {
      url = "github:Jovian-Experiments/Jovian-NixOS/development";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae = {
      url = "github:vicinaehq/vicinae";
    };
  };

  outputs = { self, nixpkgs, millennium, zen-browser, opforjellyfin, nix-cachyos-kernel, jovian, vicinae, ... }:
    let
      system = "x86_64-linux";

      mkHost = hostName: extraModules: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit system millennium zen-browser opforjellyfin nix-cachyos-kernel jovian vicinae;
        };
        modules = [
          ({ config, ... }: {
            nixpkgs.overlays = [
              nix-cachyos-kernel.overlays.default
            ];
          })
        ] ++ extraModules ++ [
          ./modules/hosts/${hostName}/configuration.nix
        ];
      };
    in {
      nixosConfigurations = {
        laptop = mkHost "laptop" [];
        legionGo = mkHost "legos" [
          jovian.nixosModules.default
        ];
        server = mkHost "server" [];
      };
    };
}
