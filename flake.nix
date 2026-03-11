{
  description = "Multiflake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    compose2nix = {
    url = "github:aksiksi/compose2nix";
    inputs.nixpkgs.follows = "nixpkgs";
    };
    opforjellyfin = {
    url = "github:nahieluniversal/opforjellyfin";
    inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, zen-browser, compose2nix, opforjellyfin, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      
      mkHost = hostName: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit pkgs system zen-browser compose2nix opforjellyfin;
        };
        modules = [
          ./modules/hosts/${hostName}/configuration.nix
        ];
      };
    in {
      nixosConfigurations = {
        laptop = mkHost "laptop";
        server = mkHost "server";
      };
    };
}
