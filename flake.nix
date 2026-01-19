{
  description = "Multiflake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, zen-browser }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      
      mkHost = hostName: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit pkgs system zen-browser;
        };
        modules = [
          ./modules/hosts/${hostName}/configuration.nix
        ];
      };
    in {
      nixosConfigurations = {
        laptop = mkHost "laptop";
      };
    };
}
