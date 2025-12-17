{
description = "Multiflake";


inputs = {
nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";


zen-browser = {
url = "github:youwen5/zen-browser-flake";
inputs.nixpkgs.follows = "nixpkgs";
};


sls-steam = {
url = "github:AceSLS/SLSsteam";
inputs.nixpkgs.follows = "nixpkgs";
};
};


outputs = { self, nixpkgs, zen-browser, sls-steam }:
let
system = "x86_64-linux";
pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
in {


nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
inherit system;


specialArgs = {
inherit pkgs system zen-browser sls-steam;
};


modules = [
./configuration.nix


# zen-browser module
({ config, pkgs, system, zen-browser, ... }: {
environment.systemPackages = [
(zen-browser.packages.${system}.default)
];
})


# steam + SLSsteam
({ config, pkgs, system, sls-steam, ... }: {
programs.steam = {
enable = true;
package = pkgs.steam.override {
extraEnv = {
LD_AUDIT = "${sls-steam.packages.${system}.sls-steam}/SLSsteam.so";
};
};
};
})
];
};
};
}
