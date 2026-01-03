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

      # Cargar el paquete directamente desde tu GitHub (¡no como flake!)
      opforjellyfin = pkgs.callPackage (pkgs.fetchFromGitHub {
        owner = "nahieluniversal";
        repo = "opforjellyfin_nix";
        rev = "28e2a785b0088d27769c186879c8643615708201";
        sha256 = "sha256-1uODr4nVHj+nrnQx7GT3gJ6eY0GHJX0EuajdrM+1k6Q=";  # ← ¡ajusta este hash!
      }) { };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit pkgs system zen-browser ;
        };

        modules = [
          ./configuration.nix

          # zen-browser + opforjellyfin
          ({ pkgs, system, zen-browser, ... }: {
            environment.systemPackages = [
              (zen-browser.packages.${system}.default)
              opforjellyfin
            ];
          })
        ];
      };
    };
}
