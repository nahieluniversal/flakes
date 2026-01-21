{ pkgs, system, compose2nix, ... }:

{
  environment.systemPackages = [
    compose2nix.packages.${system}.default
  ];
}
